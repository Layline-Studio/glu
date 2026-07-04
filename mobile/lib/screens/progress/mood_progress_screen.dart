import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import 'progress_support.dart';
import 'widgets/progress_back_button.dart';
import 'widgets/progress_charts.dart';

final _moodProgressProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(recordServiceProvider).loadTimeseries(
        RecordService.moodColumn,
        progressRangeStart(ProgressRange.allTime),
        progressRangeEndExclusive(),
      );
});

class MoodProgressScreen extends ConsumerStatefulWidget {
  const MoodProgressScreen({super.key});

  @override
  ConsumerState<MoodProgressScreen> createState() => _MoodProgressScreenState();
}

class _MoodProgressScreenState extends ConsumerState<MoodProgressScreen> {
  ProgressRange? _range;
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_moodProgressProvider);

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
              valueOf: (_) => 1,
            );
            final moodAverage = averageByDay(
              records,
              effectiveRange,
              valueOf: (record) => moodFeelingScore(
                (record['feeling'] as String?) ?? 'okay',
              ),
            );
            final total = counts.fold<double>(0, (sum, value) => sum + value);
            final average = averageValue(
              records,
              valueOf: (record) => moodFeelingScore(
                (record['feeling'] as String?) ?? 'okay',
              ),
            );
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
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      context.l10n.progressMoodProgressTitle,
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
                    context.l10n.progressAverage,
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
                        _mode == 0
                            ? '${total.round()} ${context.l10n.progressLogged.toLowerCase()}'
                            : average == null
                                ? context.l10n.progressNoLogsYet
                                : moodLabelForScore(average, context.l10n),
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
                            ? 'Mood check-ins across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.'
                            : 'Average mood across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 240,
                        child: _mode == 0
                            ? MiniBarChart(
                                values: counts,
                                tint: const Color(0xFF7A74F5),
                                minValue: countsScale.min,
                                maxValue: countsScale.max,
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                ),
                                yAxisLabels: countsScale.labels,
                              )
                            : MiniSeverityChart(
                                values: moodAverage,
                                tint: const Color(0xFF7A74F5),
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: buildMoodYAxisLabels(context.l10n),
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
