import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/app_profile.dart';
import '../../l10n/l10n.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _weightChangeProgressProvider =
    FutureProvider<_WeightChangeProgressSnapshot>((ref) async {
  final service = ref.read(recordServiceProvider);
  final profile = await ref.read(profileBootstrapProvider.future);
  final results = await Future.wait<Object?>([
    service.loadTimeseries(
      RecordService.weightColumn,
      progressRangeStart(ProgressRange.allTime),
      progressRangeEndExclusive(),
    ),
    service.loadTimeseries(
      RecordService.dosesColumn,
      progressRangeStart(ProgressRange.allTime),
      progressRangeEndExclusive(),
    ),
  ]);
  return _WeightChangeProgressSnapshot(
    profile: profile,
    weight: List<Map<String, dynamic>>.from(results[0] as List),
    doses: List<Map<String, dynamic>>.from(results[1] as List),
  );
});

class WeightChangeProgressScreen extends ConsumerStatefulWidget {
  const WeightChangeProgressScreen({super.key});

  @override
  ConsumerState<WeightChangeProgressScreen> createState() =>
      _WeightChangeProgressScreenState();
}

class _WeightChangeProgressScreenState
    extends ConsumerState<WeightChangeProgressScreen> {
  ProgressRange? _range;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_weightChangeProgressProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (snapshot) {
            final availableRanges = availableProgressRanges(snapshot.weight);
            final allRanges = ProgressRange.values;
            final effectiveRange =
                resolvedProgressRangeForRecords(snapshot.weight, _range);
            final goal = snapshot.profile?.goals.weight.current;
            final unit = goal?.targetUnit ?? _latestUnit(snapshot.weight);
            final annotated = buildDoseAnnotatedWeightSeries(
              snapshot.weight,
              snapshot.doses,
              effectiveRange,
              unit: unit,
              l10n: context.l10n,
            );
            final latest = _latestValue(snapshot.weight, unit);
            final scale = buildWeightChartScale(
              annotated.values,
              unit,
              referenceValue:
                  goal == null ? null : convertKgToWeight(goal.targetKg, unit),
            );

            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
              children: [
                Row(
                  children: [
                    ProgressBackButton(
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      context.l10n.progressWeightChangeTitle,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ProgressRangePicker(
                  labels: allRanges
                      .map((range) => progressRangeLabel(context.l10n, range))
                      .toList(),
                  selectedIndex: allRanges.indexOf(effectiveRange),
                  disabledIndices: {
                    for (var i = 0; i < allRanges.length; i++)
                      if (!availableRanges.contains(allRanges[i])) i,
                  },
                  onSelected: (index) {
                    setState(() => _range = allRanges[index]);
                  },
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colors.lineSubtle),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        latest == null
                            ? context.l10n.progressNoWeightLogsYet
                            : '${latest.toStringAsFixed(unit == 'lb' ? 0 : 1)} $unit',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        annotated.pointCount == 0
                            ? context.l10n.progressLogWeightAndDoseToCompareChange
                            : context.l10n.progressEachPointColoredByLatestDose,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 288,
                        child: MiniDoseLineChart(
                          values: annotated.values,
                          pointColors: annotated.pointColors,
                          legendItems: annotated.legendItems,
                          tint: const Color(0xFF6F8DBA),
                          xAxisLabels: buildWeightXAxisLabels(
                            effectiveRange,
                            records: snapshot.weight,
                            l10n: context.l10n,
                          ),
                          yAxisLabels: scale.labels,
                          minValue: scale.min,
                          maxValue: scale.max,
                          pinnedPointIndices: annotated.pinnedCalloutIndices,
                          pointPrimaryLabels: annotated.pointPrimaryLabels,
                          pointSecondaryLabels: annotated.pointSecondaryLabels,
                          yAxisLabelFontSize: 10,
                          yAxisLabelScaleDown: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _latestUnit(List<Map<String, dynamic>> records) {
    if (records.isEmpty) return 'kg';
    return recordWeightUnit(records.last);
  }

  double? _latestValue(List<Map<String, dynamic>> records, String unit) {
    if (records.isEmpty) return null;
    final latest = records.last;
    final quantity = latest['quantity'] as num?;
    if (quantity == null) return null;
    return convertKgToWeight(
      convertWeightToKg(quantity.toDouble(), recordWeightUnit(latest)),
      unit,
    );
  }
}

class _WeightChangeProgressSnapshot {
  const _WeightChangeProgressSnapshot({
    required this.profile,
    required this.weight,
    required this.doses,
  });

  final AppProfile? profile;
  final List<Map<String, dynamic>> weight;
  final List<Map<String, dynamic>> doses;
}
