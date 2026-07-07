import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/app_profile.dart';
import '../../l10n/l10n.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/doctor_report_flow.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../log/weight_log_screen.dart';
import 'empty/progress_weight_empty_state.dart';
import 'cravings_progress_screen.dart';
import 'dose_progress_screen.dart';
import 'exercise_progress_screen.dart';
import 'meals_progress_screen.dart';
import 'mood_progress_screen.dart';
import 'progress_support.dart';
import 'symptoms_progress_screen.dart';
import 'water_progress_screen.dart';
import 'weight_progress_screen.dart';
import 'insights_progress_screen.dart';
import 'widgets/progress_charts.dart';

class _AnimationTriggerNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}

final progressAnimationTriggerProvider =
    NotifierProvider<_AnimationTriggerNotifier, int>(
  _AnimationTriggerNotifier.new,
);

const _progressTrendBlue = Color(0xFF4E84E6);
const _healthyBmiBand = Color(0xFFE6F4EC);
const _healthyBmiGreen = Color(0xFF58B773);
const _weightHeroRanges = <ProgressRange>[
  ProgressRange.thirtyDays,
  ProgressRange.ninetyDays,
  ProgressRange.sixMonths,
  ProgressRange.allTime,
];
List<String> _weightHeroRangeLabels(AppLocalizations l10n) => [
      l10n.progressRange1Month,
      l10n.progressRange3Months,
      l10n.progressRange6Months,
      l10n.progressRangeAllTime,
    ];

final progressOverviewProvider = FutureProvider<_ProgressOverviewSnapshot>(
  (ref) async {
    final service = ref.read(recordServiceProvider);
    // Avoid a reactive Future subscription here. This provider is manually
    // invalidated when profile-affecting settings change, and watching the
    // profile future directly can trip Riverpod's paused-subscription assert.
    final profile = await ref.read(profileBootstrapProvider.future);
    final start = progressRangeStart(ProgressRange.allTime);
    final end = progressRangeEndExclusive();

    final results = await Future.wait<Object?>([
      service.loadTimeseries(RecordService.weightColumn, start, end),
      service.loadTimeseries(RecordService.waterColumn, start, end),
      service.loadTimeseries(RecordService.exerciseColumn, start, end),
      service.loadTimeseries(RecordService.dosesColumn, start, end),
      service.loadTimeseries(RecordService.mealsColumn, start, end),
      service.loadTimeseries(RecordService.moodColumn, start, end),
      service.loadTimeseries(RecordService.symptomsColumn, start, end),
      service.loadTimeseries(RecordService.cravingsColumn, start, end),
    ]);

    return _ProgressOverviewSnapshot(
      profile: profile,
      weight: _recordsList(results[0]),
      water: _recordsList(results[1]),
      exercise: _recordsList(results[2]),
      doses: _recordsList(results[3]),
      meals: _recordsList(results[4]),
      mood: _recordsList(results[5]),
      symptoms: _recordsList(results[6]),
      cravings: _recordsList(results[7]),
    );
  },
);

List<Map<String, dynamic>> _recordsList(Object? raw) {
  if (raw is! List) {
    return const <Map<String, dynamic>>[];
  }
  return List<Map<String, dynamic>>.from(
    raw.map((entry) => Map<String, dynamic>.from(entry as Map)),
  );
}

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class AllProgressScreen extends ConsumerStatefulWidget {
  const AllProgressScreen({super.key});

  @override
  ConsumerState<AllProgressScreen> createState() => _AllProgressScreenState();
}

abstract class _BaseProgressScreenState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  ProgressRange? _range;
  bool _showBmiBand = true;
  static const double _overviewGridGap = 1;
  static const int _overviewGridWeekColumns = 53;
  static const double _overviewGridXAxisHeight = 18;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.invalidate(progressOverviewProvider);
    });
  }

  double _overviewGridChartHeight(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    const pageHorizontalPadding = 18.0 * 2;
    const cardHorizontalPadding = 18.0 * 2;
    final availableWidth =
        math.max(0.0, screenWidth - pageHorizontalPadding - cardHorizontalPadding);
    final cellSize = _overviewGridWeekColumns <= 0
        ? 0.0
        : (availableWidth -
                ((_overviewGridWeekColumns - 1) * _overviewGridGap)) /
            _overviewGridWeekColumns;
    final gridHeight = (cellSize * 7) + (_overviewGridGap * 6);
    return gridHeight + _overviewGridXAxisHeight;
  }

  Widget _buildWeightCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFF6F8DBA);
    final goalEntry = snapshot.profile?.goals.weight.current;
    final unit = goalEntry?.targetUnit ?? _latestWeightUnit(snapshot.weight);
    final values = latestValueSeriesSparse(
      snapshot.weight,
      range,
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
    final targetLine =
        goalEntry == null ? null : convertKgToWeight(goalEntry.targetKg, unit);
    final scale = buildWeightChartScale(
      values,
      unit,
      referenceValue: targetLine,
    );
    final xAxisLabels = buildWeightXAxisLabels(
      range,
      records: snapshot.weight,
      l10n: context.l10n,
    );

    return ProgressCard(
      title: context.l10n.progressWeightTitle,
      tint: tint,
      chartHeight: 112,
      chart: MiniLineChart(
        values: values,
        tint: tint,
        referenceValue: targetLine,
        minValue: scale.min,
        maxValue: scale.max,
        xAxisLabels: xAxisLabels,
        yAxisLabels: scale.labels,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const WeightProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildWeightHeroCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range, {
    int animationTrigger = 0,
  }) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final tint = _progressTrendBlue;
    final goalEntry = snapshot.profile?.goals.weight.current;
    final unit = goalEntry?.targetUnit ?? _latestWeightUnit(snapshot.weight);
    final targetLine =
        goalEntry == null ? null : convertKgToWeight(goalEntry.targetKg, unit);
    final annotated = buildDoseAnnotatedWeightSeries(
      snapshot.weight,
      snapshot.doses,
      range,
      unit: unit,
      l10n: context.l10n,
    );
    final heightMeters = _profileHeightMeters(snapshot.profile);
    final healthyRange = heightMeters == null
        ? null
        : _healthyWeightRangeForHeight(
            unit: unit,
            heightMeters: heightMeters,
          );
    final scale = buildWeightChartScale(
      annotated.values,
      unit,
      referenceValue: targetLine,
    );
    final xAxisLabels = buildWeightXAxisLabels(
      range,
      records: snapshot.weight,
      l10n: context.l10n,
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context.l10n.progressWeightLabel,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: context.l10n.progressWeightUnit(unit),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _WeightChartLegend(
                trendColor: tint,
                targetColor: tint.withValues(alpha: 0.7),
                showBmiToggle: healthyRange != null,
                isBmiEnabled: _showBmiBand,
                onToggleBmi: () {
                  setState(() => _showBmiBand = !_showBmiBand);
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: MiniDoseLineChart(
              key: ValueKey(animationTrigger),
              values: annotated.values,
              pointColors: annotated.pointColors,
              legendItems: const [],
              tint: tint,
              referenceValue: targetLine,
              minValue: scale.min,
              maxValue: scale.max,
              xAxisLabels: xAxisLabels,
              yAxisLabels: scale.labels,
              highlightRangeMin: _showBmiBand ? healthyRange?.$1 : null,
              highlightRangeMax: _showBmiBand ? healthyRange?.$2 : null,
              highlightColor: _healthyBmiBand,
              highlightRangeLabel: !_showBmiBand || healthyRange == null
                  ? null
                  : context.l10n.progressHealthyBmi,
              highlightRangeLabelColor: _healthyBmiGreen,
              rightRangeIndicatorLabel: null,
              showForecasting: false,
              pinnedPointIndices: annotated.pinnedCalloutIndices,
              pointPrimaryLabels: annotated.pointPrimaryLabels,
              pointSecondaryLabels: annotated.pointSecondaryLabels,
              yAxisWidth: 24,
            ),
          ),
          if (annotated.legendItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            _WeightDoseLegend(items: annotated.legendItems),
          ],
        ],
      ),
    );
  }

  Widget _buildWeightHeroSummary(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final colors = context.appColors;
    final goalEntry = snapshot.profile?.goals.weight.current;
    final unit = goalEntry?.targetUnit ?? _latestWeightUnit(snapshot.weight);
    final rangedRecords = _weightRecordsInRange(snapshot.weight, range);
    final firstValue = rangedRecords.isEmpty
        ? null
        : _weightRecordValueInUnit(rangedRecords.first, unit);
    final lastValue = rangedRecords.isEmpty
        ? null
        : _weightRecordValueInUnit(rangedRecords.last, unit);
    final totalChange =
        firstValue == null || lastValue == null ? null : lastValue - firstValue;
    final percentChange =
        totalChange == null || firstValue == null || firstValue == 0
            ? null
            : (totalChange / firstValue) * 100;
    final weeks = math.max(1.0, range.days / 7);
    final weeklyAverage = totalChange == null ? null : totalChange / weeks;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Row(
        children: [
          Expanded(
            child: _WeightChangeIndicatorCard(
              label: context.l10n.progressTotal,
              value: totalChange == null ? '--' : _formatChangeValue(totalChange, unit),
              unit: totalChange == null ? null : unit,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 28,
            color: colors.lineSubtle,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _WeightChangeIndicatorCard(
              label: context.l10n.progressPercent,
              value: percentChange == null
                  ? '--'
                  : '${percentChange > 0 ? '+' : ''}${percentChange.toStringAsFixed(1)}%',
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 28,
            color: colors.lineSubtle,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _WeightChangeIndicatorCard(
              label: context.l10n.progressWeeklyAvg,
              value: weeklyAverage == null
                  ? '--'
                  : _formatWeeklyAverageValue(weeklyAverage, unit),
              unit: weeklyAverage == null ? null : '$unit/week',
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _weightRecordsInRange(
    List<Map<String, dynamic>> records,
    ProgressRange range,
  ) {
    final start = progressRangeStart(range);
    final end = progressRangeEndExclusive();
    final filtered = records.where((record) {
      final loggedAt = parseLoggedAt(record);
      if (loggedAt == null) return false;
      return !loggedAt.isBefore(start) && loggedAt.isBefore(end);
    }).toList();
    filtered.sort((a, b) {
      final aDate = parseLoggedAt(a);
      final bDate = parseLoggedAt(b);
      if (aDate == null || bDate == null) return 0;
      return aDate.compareTo(bDate);
    });
    return filtered;
  }

  double? _weightRecordValueInUnit(Map<String, dynamic> record, String unit) {
    final quantity = record['quantity'] as num?;
    if (quantity == null) return null;
    return convertKgToWeight(
      convertWeightToKg(quantity.toDouble(), recordWeightUnit(record)),
      unit,
    );
  }

  String _formatChangeValue(double value, String unit) {
    final precision = unit == 'lb' ? 1 : 2;
    return _formatSignedNumber(value, precision);
  }

  String _formatWeeklyAverageValue(double value, String unit) {
    return _formatSignedNumber(value, unit == 'lb' ? 1 : 2);
  }

  String _formatSignedNumber(double value, int precision) {
    final rounded = value.toStringAsFixed(precision);
    return value > 0 ? '+$rounded' : rounded;
  }

  double? _profileHeightMeters(AppProfile? profile) {
    final value = profile?.settings['height'];
    if (value is! Map) return null;
    final map = Map<String, dynamic>.from(value);
    final unit = map['unit']?.toString();
    if (unit == 'metric') {
      final cm = double.tryParse(map['primary']?.toString() ?? '');
      return cm == null || cm <= 0 ? null : cm / 100;
    }
    if (unit == 'imperial') {
      final feet = double.tryParse(map['primary']?.toString() ?? '');
      final inches = double.tryParse(map['secondary']?.toString() ?? '') ?? 0;
      if (feet == null || feet <= 0) return null;
      return ((feet * 12) + inches) * 0.0254;
    }
    return null;
  }

  (double, double) _healthyWeightRangeForHeight({
    required String unit,
    required double heightMeters,
  }) {
    final minKg = 18.5 * heightMeters * heightMeters;
    final maxKg = 24.9 * heightMeters * heightMeters;
    return (
      convertKgToWeight(minKg, unit),
      convertKgToWeight(maxKg, unit),
    );
  }

  Widget _buildWaterCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = context.appColors.accentSky;
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.water,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.water,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (record) => ((record['quantity'] as num?) ?? 0).toDouble(),
    );

    return ProgressCard(
      title: context.l10n.progressWaterTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.water,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoHydrationYet,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const WaterProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFF6BCB81);
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.exercise,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.exercise,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (record) =>
          ((record['duration_minutes'] as num?) ?? 0).toDouble(),
    );

    return ProgressCard(
      title: context.l10n.progressExerciseTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.exercise,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoMovementYet,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ExerciseProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildDoseCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFF7A8CFF);
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.doses,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.doses,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (_) => 1,
    );

    return ProgressCard(
      title: context.l10n.progressDoseTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.doses,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoDoseLogsYet,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const DoseProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildMealsCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFFFFAA5B);
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.meals,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.meals,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (_) => 1,
    );

    return ProgressCard(
      title: context.l10n.progressMealsTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.meals,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoMealsLoggedYet,
        binary: true,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const MealsProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildSymptomsCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFFFF5A8F);
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.symptoms,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.symptoms,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (_) => 1,
    );

    return ProgressCard(
      title: context.l10n.progressSymptomsTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.symptoms,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoSymptomsLoggedYet,
        binary: true,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const SymptomsProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildMoodCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFF7A74F5);
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.mood,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.mood,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (_) => 1,
    );

    return ProgressCard(
      title: context.l10n.progressMoodTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.mood,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoMoodLogsYet,
        binary: true,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const MoodProgressScreen(),
          ),
        );
      },
    );
  }

  Widget _buildCravingsCard(
    BuildContext context,
    _ProgressOverviewSnapshot snapshot,
    ProgressRange range,
  ) {
    final tint = const Color(0xFFE96FA0);
    final chartHeight = _overviewGridChartHeight(context);
    final buckets = dailyBuckets(
      ProgressRange.oneYear,
      records: snapshot.cravings,
    );
    final values = sumByDayWithinDisplayRange(
      snapshot.cravings,
      displayRange: ProgressRange.oneYear,
      activeRange: range,
      valueOf: (_) => 1,
    );

    return ProgressCard(
      title: context.l10n.progressCravingsTitle,
      tint: tint,
      chartHeight: chartHeight,
      chart: MiniFrequencyGridChart(
        dates: buckets,
        values: values,
        tint: tint,
        xAxisLabels: buildTimeXAxisLabels(
          ProgressRange.oneYear,
          records: snapshot.cravings,
          l10n: context.l10n,
        ),
        emptyLabel: context.l10n.progressNoCravingsLoggedYet,
        binary: true,
      ),
      onSeeMore: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const CravingsProgressScreen(),
          ),
        );
      },
    );
  }

  String _latestWeightUnit(List<Map<String, dynamic>> records) {
    if (records.isEmpty) return 'kg';
    return recordWeightUnit(records.last);
  }
}

class _ProgressScreenState extends _BaseProgressScreenState<ProgressScreen> {
  Future<void> _openWeightLog() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const WeightLogScreen(),
      ),
    );
    ref.invalidate(progressOverviewProvider);
  }

  Future<void> _createDoctorReport() async {
    await requestDoctorReport(
      context: context,
      ref: ref,
      analyticsSource: 'progress',
      proAccessSource: 'progress_doctor_report',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final animationTrigger = ref.watch(progressAnimationTriggerProvider);
    final state = ref.watch(progressOverviewProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (snapshot) {
            final availableRanges = availableProgressRanges(snapshot.weight);
            final allRanges = _weightHeroRanges;
            final effectiveRange =
                resolvedProgressRangeForRecords(snapshot.weight, _range);

            if (snapshot.weight.isEmpty) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProgressHeader(
                      title: context.l10n.progressTitle,
                      onViewAllInsights: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const InsightsProgressScreen(),
                          ),
                        );
                      },
                      onViewAllCharts: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const AllProgressScreen(),
                          ),
                        );
                      },
                      onCreateDoctorReport: _createDoctorReport,
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: ProgressWeightEmptyState(
                        onLogWeight: _openWeightLog,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProgressHeader(
                    title: context.l10n.progressTitle,
                    onViewAllInsights: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const InsightsProgressScreen(),
                        ),
                      );
                    },
                    onViewAllCharts: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AllProgressScreen(),
                        ),
                      );
                    },
                    onCreateDoctorReport: _createDoctorReport,
                  ),
                  const SizedBox(height: 18),
                  ProgressRangePicker(
                    labels: _weightHeroRangeLabels(context.l10n),
                    selectedIndex: allRanges.indexOf(effectiveRange),
                    compact: true,
                    expand: true,
                    disabledIndices: {
                      for (var i = 0; i < allRanges.length; i++)
                        if (!availableRanges.contains(allRanges[i])) i,
                    },
                    onSelected: (index) {
                      setState(() => _range = allRanges[index]);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildWeightHeroSummary(
                    context,
                    snapshot,
                    effectiveRange,
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: _buildWeightHeroCard(
                      context,
                      snapshot,
                      effectiveRange,
                      animationTrigger: animationTrigger,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AllProgressScreenState
    extends _BaseProgressScreenState<AllProgressScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final state = ref.watch(progressOverviewProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (snapshot) {
            final records = [
              ...snapshot.weight,
              ...snapshot.water,
              ...snapshot.exercise,
              ...snapshot.doses,
              ...snapshot.meals,
              ...snapshot.mood,
              ...snapshot.symptoms,
              ...snapshot.cravings,
            ];
            final availableRanges = availableProgressRanges(records);
            final allRanges = _weightHeroRanges;
            final effectiveRange =
                resolvedProgressRangeForRecords(records, _range);

            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
              children: [
                Row(
                  children: [
                    InkResponse(
                      onTap: () => Navigator.of(context).pop(),
                      radius: 20,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: colors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      context.l10n.progressAllProgressTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 18),
                ProgressRangePicker(
                  labels: _weightHeroRangeLabels(context.l10n),
                  selectedIndex: allRanges.indexOf(effectiveRange),
                  compact: true,
                  expand: true,
                  disabledIndices: {
                    for (var i = 0; i < allRanges.length; i++)
                      if (!availableRanges.contains(allRanges[i])) i,
                  },
                  onSelected: (index) {
                    setState(() => _range = allRanges[index]);
                  },
                ),
                const SizedBox(height: 18),
                _buildWeightCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildWaterCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildExerciseCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildDoseCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildMealsCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildMoodCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildSymptomsCard(context, snapshot, effectiveRange),
                const SizedBox(height: 12),
                _buildCravingsCard(context, snapshot, effectiveRange),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.title,
    required this.onViewAllInsights,
    required this.onViewAllCharts,
    required this.onCreateDoctorReport,
  });

  final String title;
  final VoidCallback onViewAllInsights;
  final VoidCallback onViewAllCharts;
  final VoidCallback onCreateDoctorReport;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Row(
      children: [
        const SizedBox(width: 42),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        _buildMenuButton(context, colors),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context, AppColors colors) {
    final menu = PopupMenuButton<_ProgressMenuAction>(
      icon: Icon(
        Icons.menu_rounded,
        color: colors.textPrimary,
      ),
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onSelected: (action) {
        switch (action) {
          case _ProgressMenuAction.insights:
            onViewAllInsights();
          case _ProgressMenuAction.charts:
            onViewAllCharts();
          case _ProgressMenuAction.doctorReport:
            onCreateDoctorReport();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _ProgressMenuAction.insights,
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_rounded,
                size: 18,
                color: colors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(context.l10n.progressMenuViewAllInsights),
            ],
          ),
        ),
        PopupMenuItem(
          value: _ProgressMenuAction.charts,
          child: Row(
            children: [
              Icon(
                Icons.show_chart_rounded,
                size: 18,
                color: colors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(context.l10n.progressMenuViewAllCharts),
            ],
          ),
        ),
        PopupMenuItem(
          value: _ProgressMenuAction.doctorReport,
          child: Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 18,
                color: colors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(context.l10n.progressMenuCreateDoctorReport),
            ],
          ),
        ),
      ],
    );

    return menu;
  }
}

enum _ProgressMenuAction {
  insights,
  charts,
  doctorReport,
}

class _WeightChartLegend extends StatelessWidget {
  const _WeightChartLegend({
    required this.trendColor,
    required this.targetColor,
    required this.showBmiToggle,
    required this.isBmiEnabled,
    required this.onToggleBmi,
  });

  final Color trendColor;
  final Color targetColor;
  final bool showBmiToggle;
  final bool isBmiEnabled;
  final VoidCallback onToggleBmi;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    Widget legendItem({
      required String label,
      required Widget marker,
    }) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          marker,
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    Widget bmiToggleItem() {
      return GestureDetector(
        onTap: onToggleBmi,
        behavior: HitTestBehavior.opaque,
        child: Opacity(
          opacity: isBmiEnabled ? 1 : 0.55,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: 28,
                height: 16,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isBmiEnabled
                      ? _healthyBmiBand
                      : colors.lineSubtle.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isBmiEnabled
                        ? _healthyBmiGreen.withValues(alpha: 0.8)
                        : colors.lineSubtle,
                  ),
                ),
                child: Align(
                  alignment: isBmiEnabled
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isBmiEnabled
                          ? _healthyBmiGreen
                          : colors.textSecondary.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'BMI',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 18,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        legendItem(
          label: context.l10n.progressTrend,
          marker: Container(
            width: 28,
            height: 3,
            decoration: BoxDecoration(
              color: trendColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        legendItem(
          label: context.l10n.progressTarget,
          marker: SizedBox(
            width: 28,
            height: 3,
            child: CustomPaint(
              painter: _DashedLegendLinePainter(color: targetColor),
            ),
          ),
        ),
        if (showBmiToggle) bmiToggleItem(),
      ],
    );
  }
}

class _WeightDoseLegend extends StatelessWidget {
  const _WeightDoseLegend({required this.items});

  final List<DoseLegendItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        for (final item in items)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _DashedLegendLinePainter extends CustomPainter {
  const _DashedLegendLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const gapWidth = 4.0;
    var startX = 0.0;
    final centerY = size.height / 2;

    while (startX < size.width) {
      final endX = (startX + dashWidth).clamp(0.0, size.width);
      canvas.drawLine(Offset(startX, centerY), Offset(endX, centerY), paint);
      startX += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLegendLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _WeightChangeIndicatorCard extends StatelessWidget {
  const _WeightChangeIndicatorCard({
    required this.label,
    required this.value,
    this.unit,
  });

  final String label;
  final String value;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: theme.textTheme.titleSmall?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
              children: [
                TextSpan(text: value),
                if (unit != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: unit,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressOverviewSnapshot {
  const _ProgressOverviewSnapshot({
    required this.profile,
    required this.weight,
    required this.water,
    required this.exercise,
    required this.doses,
    required this.meals,
    required this.mood,
    required this.symptoms,
    required this.cravings,
  });

  final AppProfile? profile;
  final List<Map<String, dynamic>> weight;
  final List<Map<String, dynamic>> water;
  final List<Map<String, dynamic>> exercise;
  final List<Map<String, dynamic>> doses;
  final List<Map<String, dynamic>> meals;
  final List<Map<String, dynamic>> mood;
  final List<Map<String, dynamic>> symptoms;
  final List<Map<String, dynamic>> cravings;
}
