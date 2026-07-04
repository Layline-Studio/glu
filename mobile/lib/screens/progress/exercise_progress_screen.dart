import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _exerciseProgressProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(recordServiceProvider).loadTimeseries(
        RecordService.exerciseColumn,
        progressRangeStart(ProgressRange.allTime),
        progressRangeEndExclusive(),
      );
});

class ExerciseProgressScreen extends ConsumerStatefulWidget {
  const ExerciseProgressScreen({super.key});

  @override
  ConsumerState<ExerciseProgressScreen> createState() =>
      _ExerciseProgressScreenState();
}

class _ExerciseProgressScreenState
    extends ConsumerState<ExerciseProgressScreen> {
  ProgressRange? _range;
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_exerciseProgressProvider);

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
            final dailyMinutes = sumByDay(
              records,
              effectiveRange,
              valueOf: (record) =>
                  ((record['duration_minutes'] as num?) ?? 0).toDouble(),
            );
            final intensity = sumByDay(
              records,
              effectiveRange,
              valueOf: (record) {
                final raw = (record['intensity'] as String?) ?? '';
                return switch (raw) {
                  'light' => 1.0,
                  'moderate' => 2.0,
                  'intense' => 3.0,
                  _ => 0.0,
                };
              },
            );
            final total =
                dailyMinutes.fold<double>(0, (sum, value) => sum + value);
            final minutesScale = buildNumericChartScale(
              dailyMinutes,
              formatter: formatMinutesAxisValue,
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
                      context.l10n.progressExerciseProgressTitle,
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
                    context.l10n.progressMinutes,
                    context.l10n.progressIntensity,
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
                        '${total.round()} ${context.l10n.progressMinutes.toLowerCase()}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Movement across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 240,
                        child: _mode == 0
                            ? MiniBarChart(
                                values: dailyMinutes,
                                tint: const Color(0xFF6BCB81),
                                minValue: minutesScale.min,
                                maxValue: minutesScale.max,
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: minutesScale.labels,
                              )
                            : MiniSeverityChart(
                                values: intensity,
                                tint: const Color(0xFF6BCB81),
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: buildSeverityYAxisLabels(context.l10n),
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
}
