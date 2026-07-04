import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/app_profile.dart';
import '../../l10n/l10n.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../log/weight_log_screen.dart';
import 'empty/weight_progress_empty_state.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _weightProgressProvider =
    FutureProvider<_WeightProgressSnapshot>((ref) async {
  final service = ref.read(recordServiceProvider);
  // Keep the profile lookup non-reactive here and refresh explicitly after
  // settings/profile changes to avoid Riverpod paused-subscription issues.
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
  return _WeightProgressSnapshot(
    profile: profile,
    records: List<Map<String, dynamic>>.from(results[0] as List),
    doses: List<Map<String, dynamic>>.from(results[1] as List),
  );
});

class WeightProgressScreen extends ConsumerStatefulWidget {
  const WeightProgressScreen({super.key});

  @override
  ConsumerState<WeightProgressScreen> createState() =>
      _WeightProgressScreenState();
}

class _WeightProgressScreenState extends ConsumerState<WeightProgressScreen> {
  ProgressRange? _range;
  int _mode = 1;

  Future<void> _openWeightLog() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const WeightLogScreen(),
      ),
    );
    ref.invalidate(_weightProgressProvider);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_weightProgressProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (snapshot) {
            if (snapshot.records.isEmpty) {
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
                        context.l10n.progressWeightProgressTitle,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  WeightProgressEmptyState(
                    onLogWeight: _openWeightLog,
                  ),
                ],
              );
            }

            final availableRanges = availableProgressRanges(snapshot.records);
            final allRanges = ProgressRange.values;
            final effectiveRange =
                resolvedProgressRangeForRecords(snapshot.records, _range);
            final goal = snapshot.profile?.goals.weight.current;
            final unit = goal?.targetUnit ?? _latestUnit(snapshot.records);
            final values = latestValueSeriesSparse(
              snapshot.records,
              effectiveRange,
              valueOf: (record) {
                final quantity = record['quantity'] as num?;
                if (quantity == null) return null;
                final kg = convertWeightToKg(
                  quantity.toDouble(),
                  recordWeightUnit(record),
                );
                return convertKgToWeight(kg, unit);
              },
            );
            final latest = _latestValue(snapshot.records, unit);
            final previous = _previousValue(snapshot.records, unit);
            final target =
                goal == null ? null : convertKgToWeight(goal.targetKg, unit);
            final gap =
                latest == null || target == null ? null : target - latest;
            final annotated = buildDoseAnnotatedWeightSeries(
              snapshot.records,
              snapshot.doses,
              effectiveRange,
              unit: unit,
              l10n: context.l10n,
            );
            final activeValues = _mode == 0 ? values : annotated.values;
            final scale = buildWeightChartScale(
              activeValues,
              unit,
              referenceValue: target,
            );
            final xAxisLabels = buildWeightXAxisLabels(
              effectiveRange,
              records: snapshot.records,
              l10n: context.l10n,
            );

            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
              children: [
                Row(
                  children: [
                    ProgressBackButton(
                        onTap: () => Navigator.of(context).pop()),
                    const SizedBox(width: 12),
                      Text(
                        context.l10n.progressWeightProgressTitle,
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
                CompactModeToggle(
                  labels: [
                    context.l10n.progressTrend,
                    context.l10n.progressByDose,
                  ],
                  selectedIndex: _mode,
                  onSelected: (index) => setState(() => _mode = index),
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
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _mode == 0
                            ? (latest == null
                                ? context.l10n.progressLogWeightToStartTrend
                                : _summary(
                                    context.l10n,
                                    latest,
                                    previous,
                                    gap,
                                    unit,
                                  ))
                            : (annotated.pointCount == 0
                                ? context.l10n.progressLogWeightAndDoseToCompareChange
                                : context.l10n.progressEachPointColoredByLatestDose),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 288,
                        child: _mode == 0
                            ? MiniLineChart(
                                values: values,
                                tint: const Color(0xFF6F8DBA),
                                referenceValue: target,
                                minValue: scale.min,
                                maxValue: scale.max,
                                xAxisLabels: xAxisLabels,
                                yAxisLabels: scale.labels,
                                yAxisLabelFontSize: 10,
                                yAxisLabelScaleDown: true,
                              )
                            : MiniDoseLineChart(
                                values: annotated.values,
                                pointColors: annotated.pointColors,
                                legendItems: annotated.legendItems,
                                tint: const Color(0xFF6F8DBA),
                                referenceValue: target,
                                minValue: scale.min,
                                maxValue: scale.max,
                                xAxisLabels: xAxisLabels,
                                yAxisLabels: scale.labels,
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

  double? _previousValue(List<Map<String, dynamic>> records, String unit) {
    if (records.length < 2) return null;
    final previous = records[records.length - 2];
    final quantity = previous['quantity'] as num?;
    if (quantity == null) return null;
    return convertKgToWeight(
      convertWeightToKg(quantity.toDouble(), recordWeightUnit(previous)),
      unit,
    );
  }

  String _summary(
    AppLocalizations l10n,
    double? latest,
    double? previous,
    double? gap,
    String unit,
  ) {
    if (previous == null) {
      return gap == null
          ? l10n.progressLatestLoggedWeightReadyToTrack
          : l10n.progressAboutGapFromTarget(
              gap.abs().toStringAsFixed(unit == 'lb' ? 0 : 1),
              unit,
            );
    }
    if (latest != null) {
      final delta = latest - previous;
      final deltaText =
          '${delta > 0 ? '+' : ''}${delta.toStringAsFixed(unit == 'lb' ? 0 : 1)} $unit';
      if (gap == null) {
        return l10n.progressDeltaVsPreviousLog(deltaText);
      }
      return l10n.progressDeltaVsPreviousLogAndGap(
        deltaText,
        gap.abs().toStringAsFixed(unit == 'lb' ? 0 : 1),
        unit,
      );
    }
    if (gap == null) {
      return l10n.progressComparedWithPreviousLogTrendVisible;
    }
    return l10n.progressAboutGapFromTarget(
      gap.abs().toStringAsFixed(unit == 'lb' ? 0 : 1),
      unit,
    );
  }
}

class _WeightProgressSnapshot {
  const _WeightProgressSnapshot({
    required this.profile,
    required this.records,
    required this.doses,
  });

  final AppProfile? profile;
  final List<Map<String, dynamic>> records;
  final List<Map<String, dynamic>> doses;
}
