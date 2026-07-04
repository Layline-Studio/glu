import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../models/goals.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _waterProgressProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(recordServiceProvider).loadTimeseries(
        RecordService.waterColumn,
        progressRangeStart(ProgressRange.allTime),
        progressRangeEndExclusive(),
      );
});

class WaterProgressScreen extends ConsumerStatefulWidget {
  const WaterProgressScreen({super.key});

  @override
  ConsumerState<WaterProgressScreen> createState() =>
      _WaterProgressScreenState();
}

class _WaterProgressScreenState extends ConsumerState<WaterProgressScreen> {
  ProgressRange? _range;
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_waterProgressProvider);
    final profile = ref.watch(profileBootstrapProvider).asData?.value;

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
            final goal = profile?.goals.water.current;
            final daily = sumByDay(
              records,
              effectiveRange,
              valueOf: (record) =>
                  ((record['quantity'] as num?) ?? 0).toDouble(),
            );
            final weekly = _groupToWindow(daily, 7);
            final total = daily.fold<double>(0, (sum, value) => sum + value);
            final dailyTarget = goal == null
                ? null
                : goal.timeframe == GoalTimeframe.weekly
                    ? goal.targetMl / 7
                    : goal.targetMl;
            final dailyScale = buildNumericChartScale(
              daily,
              referenceValue: dailyTarget,
              formatter: formatWaterAxisValue,
            );
            final weeklyScale = buildNumericChartScale(
              weekly,
              formatter: formatWaterAxisValue,
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
                      context.l10n.progressWaterProgressTitle,
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
                    context.l10n.progressDaily,
                    context.l10n.progressWeekly,
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
                        total >= 1000
                            ? '${(total / 1000).toStringAsFixed(1)} L'
                            : '${total.round()} ${context.l10n.waterLogMlUnit}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Hydration totals across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 240,
                        child: _mode == 0
                            ? MiniBarChart(
                                values: daily,
                                tint: colors.accentSky,
                                referenceValue: dailyTarget,
                                minValue: dailyScale.min,
                                maxValue: dailyScale.max,
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: dailyScale.labels,
                              )
                            : MiniBarChart(
                                values: weekly,
                                tint: colors.accentSky,
                                minValue: weeklyScale.min,
                                maxValue: weeklyScale.max,
                                xAxisLabels: buildGroupedTimeXAxisLabels(
                                  effectiveRange,
                                  weekly.length,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: weeklyScale.labels,
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

  List<double> _groupToWindow(List<double> values, int window) {
    final grouped = <double>[];
    for (var i = 0; i < values.length; i += window) {
      final end = (i + window).clamp(0, values.length);
      grouped.add(
          values.sublist(i, end).fold<double>(0, (sum, value) => sum + value));
    }
    return grouped;
  }
}
