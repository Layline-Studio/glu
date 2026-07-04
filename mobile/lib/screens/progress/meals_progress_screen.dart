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

final _mealsProgressProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(recordServiceProvider).loadTimeseries(
        RecordService.mealsColumn,
        progressRangeStart(ProgressRange.allTime),
        progressRangeEndExclusive(),
      );
});

double _mealConsumedFactor(Map<String, dynamic> record) {
  return ((record['consumed'] as num?)?.toDouble() ?? 1.0).clamp(0.25, 1.0);
}

class MealsProgressScreen extends ConsumerStatefulWidget {
  const MealsProgressScreen({super.key});

  @override
  ConsumerState<MealsProgressScreen> createState() =>
      _MealsProgressScreenState();
}

class _MealsProgressScreenState extends ConsumerState<MealsProgressScreen> {
  ProgressRange? _range;
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(_mealsProgressProvider);
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
            final goalMode =
                profile?.goals.meals.current?.mode ?? MealsGoalMode.meals;
            final dailyMeals =
                sumByDay(records, effectiveRange, valueOf: (_) => 1);
            final dailyCalories = sumByDay(
              records,
              effectiveRange,
              valueOf: (record) =>
                  (((record['calories'] as num?) ?? 0).toDouble()) *
                  _mealConsumedFactor(record),
            );
            final totalMeals =
                dailyMeals.fold<double>(0, (sum, value) => sum + value);
            final totalCalories =
                dailyCalories.fold<double>(0, (sum, value) => sum + value);
            final mealsScale = buildNumericChartScale(
              dailyMeals,
              formatter: formatCountAxisValue,
            );
            final caloriesScale = buildNumericChartScale(
              dailyCalories,
              formatter: formatCaloriesAxisValue,
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
                      context.l10n.progressMealsProgressTitle,
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
                    context.l10n.goalsMeals,
                    context.l10n.progressCalories,
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
                        (_mode == 1 || goalMode == MealsGoalMode.calories)
                            ? '${totalCalories.round()} cal'
                            : '${totalMeals.round()} ${context.l10n.progressLogged.toLowerCase()}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nutrition logs across ${progressRangeLabel(context.l10n, effectiveRange).toLowerCase()}.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 240,
                        child: _mode == 0
                            ? MiniBarChart(
                                values: dailyMeals,
                                tint: const Color(0xFFFFAA5B),
                                minValue: mealsScale.min,
                                maxValue: mealsScale.max,
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: mealsScale.labels,
                              )
                            : MiniBarChart(
                                values: dailyCalories,
                                tint: const Color(0xFFFFAA5B),
                                minValue: caloriesScale.min,
                                maxValue: caloriesScale.max,
                                xAxisLabels: buildTimeXAxisLabels(
                                  effectiveRange,
                                  records: records,
                                  l10n: context.l10n,
                                ),
                                yAxisLabels: caloriesScale.labels,
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
