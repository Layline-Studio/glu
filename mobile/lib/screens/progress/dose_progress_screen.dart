import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _doseProgressProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(recordServiceProvider).loadTimeseries(
        RecordService.dosesColumn,
        progressRangeStart(ProgressRange.allTime),
        progressRangeEndExclusive(),
      );
});

class DoseProgressScreen extends ConsumerStatefulWidget {
  const DoseProgressScreen({super.key});

  @override
  ConsumerState<DoseProgressScreen> createState() => _DoseProgressScreenState();
}

class _DoseProgressScreenState extends ConsumerState<DoseProgressScreen> {
  ProgressRange? _range;
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_doseProgressProvider);

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
            final dailyLogs = sumByDay(
              records,
              effectiveRange,
              valueOf: (_) => 1,
            );
            final weeklyLogs = _groupToWindow(dailyLogs, 7);
            final dailyScale = buildNumericChartScale(
              dailyLogs,
              formatter: formatCountAxisValue,
            );
            final weeklyScale = buildNumericChartScale(
              weeklyLogs,
              formatter: formatCountAxisValue,
            );
            final totalLogs =
                dailyLogs.fold<double>(0, (sum, value) => sum + value);

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
                      context.l10n.progressDoseProgressTitle,
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
                        '${totalLogs.round()} ${context.l10n.progressLogged.toLowerCase()}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Dose logs across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 240,
                        child: MiniBarChart(
                          values: _mode == 0 ? dailyLogs : weeklyLogs,
                          tint: const Color(0xFF7A8CFF),
                          minValue: _mode == 0 ? dailyScale.min : weeklyScale.min,
                          maxValue: _mode == 0 ? dailyScale.max : weeklyScale.max,
                          xAxisLabels: _mode == 0
                              ? buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                )
                              : buildGroupedTimeXAxisLabels(
                                  effectiveRange,
                                  weeklyLogs.length,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                          yAxisLabels:
                              _mode == 0 ? dailyScale.labels : weeklyScale.labels,
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
    if (values.isEmpty) return values;
    final grouped = <double>[];
    for (var i = 0; i < values.length; i += window) {
      final end = (i + window).clamp(0, values.length);
      grouped.add(
        values.sublist(i, end).fold<double>(0, (sum, value) => sum + value),
      );
    }
    return grouped;
  }
}
