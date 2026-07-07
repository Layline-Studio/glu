import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _cravingsProgressProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(recordServiceProvider).loadTimeseries(
        RecordService.cravingsColumn,
        progressRangeStart(ProgressRange.allTime),
        progressRangeEndExclusive(),
      );
});

class CravingsProgressScreen extends ConsumerStatefulWidget {
  const CravingsProgressScreen({super.key});

  @override
  ConsumerState<CravingsProgressScreen> createState() =>
      _CravingsProgressScreenState();
}

class _CravingsProgressScreenState
    extends ConsumerState<CravingsProgressScreen> {
  ProgressRange? _range;
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_cravingsProgressProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (records) {
            final availableRanges = availableProgressRanges(records);
            final allRanges = ProgressRange.values;
            final effectiveRange =
                resolvedProgressRangeForRecords(records, _range);
            final counts = sumByDay(
              records,
              effectiveRange,
              valueOf: (_) => 1.0,
            );
            final intensity = sumByDay(
              records,
              effectiveRange,
              valueOf: (record) {
                final raw = (record['intensity'] as String?) ?? '';
                return switch (raw) {
                  'mild' => 1.0,
                  'moderate' => 2.0,
                  'strong' => 3.0,
                  _ => 0.0,
                };
              },
            );
            final withOutcome = records
                .where((record) => record['outcome'] != null)
                .toList(growable: false);
            final resistedRate = averageByDay(
              withOutcome,
              effectiveRange,
              valueOf: (record) =>
                  record['outcome'] == 'resisted' ? 1.0 : 0.0,
            );
            final total = counts.fold<double>(0, (sum, value) => sum + value);
            final resistedCount = withOutcome
                .where((record) => record['outcome'] == 'resisted')
                .length;
            final countsScale = buildNumericChartScale(
              counts,
              formatter: formatCountAxisValue,
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
                      context.l10n.progressCravingsProgressTitle,
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
                  onSelected: (index) =>
                      setState(() => _range = allRanges[index]),
                ),
                const SizedBox(height: 16),
                CompactModeToggle(
                  labels: [
                    context.l10n.progressFreq,
                    context.l10n.progressIntensity,
                    context.l10n.progressResisted,
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
                        _mode == 2
                            ? (withOutcome.isEmpty
                                ? context.l10n.progressAllClear
                                : '${((resistedCount / withOutcome.length) * 100).round()}%')
                            : total == 0
                                ? context.l10n.progressAllClear
                                : '${total.round()} ${context.l10n.progressLogged.toLowerCase()}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _mode == 2
                            ? context.l10n.progressCravingsResistedSubtitle
                            : 'Cravings across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 240,
                        child: switch (_mode) {
                          0 => MiniBarChart(
                              values: counts,
                              tint: const Color(0xFFE96FA0),
                              minValue: countsScale.min,
                              maxValue: countsScale.max,
                              xAxisLabels: buildTimeXAxisLabels(
                                effectiveRange,
                                records: records,
                                l10n: context.l10n,
                              ),
                              yAxisLabels: countsScale.labels,
                            ),
                          1 => MiniSeverityChart(
                              values: intensity,
                              tint: const Color(0xFFE96FA0),
                              xAxisLabels: buildTimeXAxisLabels(
                                effectiveRange,
                                records: records,
                                l10n: context.l10n,
                              ),
                              yAxisLabels: buildSeverityYAxisLabels(context.l10n),
                            ),
                          _ => MiniLineChart(
                              values: resistedRate,
                              tint: const Color(0xFFE96FA0),
                              minValue: 0,
                              maxValue: 1,
                              xAxisLabels: buildTimeXAxisLabels(
                                effectiveRange,
                                records: withOutcome,
                                l10n: context.l10n,
                              ),
                              yAxisLabels: buildPercentageYAxisLabels(),
                            ),
                        },
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
}
