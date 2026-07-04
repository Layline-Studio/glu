import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../l10n/l10n.dart';
import '../../models/app_profile.dart';
import '../../models/goals.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../providers/today_meals_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../home_screen.dart';
import 'dose_log_screen.dart';
import 'exercise_log_screen.dart';
import 'meals_log_screen.dart';
import 'mood_log_screen.dart';
import 'symptoms_log_screen.dart';
import 'swipe_back_detector.dart';
import 'water_log_screen.dart';
import 'weight_log_screen.dart';

final logStatsProvider = FutureProvider<_LogStatsSnapshot>((ref) async {
  final service = ref.read(recordServiceProvider);
  final start = DateUtils.dateOnly(DateTime.now());
  final end = start.add(const Duration(days: 1));
  final weekStart = _startOfWeek(start);

  final results = await Future.wait<Object?>([
    service.loadTimeseries(RecordService.waterColumn, start, end),
    service.loadTimeseries(RecordService.exerciseColumn, start, end),
    service.loadTimeseries(RecordService.weightColumn, start, end),
    ref.watch(todayMealsProvider.future),
    service.loadTimeseries(RecordService.moodColumn, start, end),
    service.loadTimeseries(RecordService.symptomsColumn, start, end),
    service.loadTimeseries(RecordService.waterColumn, weekStart, end),
    service.loadTimeseries(RecordService.exerciseColumn, weekStart, end),
    service.loadTimeseries(RecordService.mealsColumn, weekStart, end),
    service.loadLatestRecord(RecordService.weightColumn),
    service.loadTimeseries(RecordService.dosesColumn, start, end),
  ]);

  return _LogStatsSnapshot(
    water: List<Map<String, dynamic>>.from(results[0] as List),
    exercise: List<Map<String, dynamic>>.from(results[1] as List),
    weight: List<Map<String, dynamic>>.from(results[2] as List),
    meals: List<Map<String, dynamic>>.from(results[3] as List),
    mood: List<Map<String, dynamic>>.from(results[4] as List),
    symptoms: List<Map<String, dynamic>>.from(results[5] as List),
    waterWeek: List<Map<String, dynamic>>.from(results[6] as List),
    exerciseWeek: List<Map<String, dynamic>>.from(results[7] as List),
    mealsWeek: List<Map<String, dynamic>>.from(results[8] as List),
    latestWeight: results[9] as Map<String, dynamic>?,
    doses: List<Map<String, dynamic>>.from(results[10] as List),
  );
});

class LogScreen extends ConsumerStatefulWidget {
  const LogScreen({
    super.key,
    this.waterShowcaseKey,
    this.showWaterShowcase = false,
    this.onWaterShowcaseInteracted,
    this.isActive = true,
  });

  final GlobalKey? waterShowcaseKey;
  final bool showWaterShowcase;
  final VoidCallback? onWaterShowcaseInteracted;
  final bool isActive;

  @override
  ConsumerState<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends ConsumerState<LogScreen> {
  int _nutritionTileRotationIndex = 0;
  Timer? _nutritionTileRotationTimer;
  bool _didAttemptWaterShowcase = false;
  late final int _todayInsightVariantIndex;

  @override
  void initState() {
    super.initState();
    _todayInsightVariantIndex = math.Random().nextInt(3);
    _nutritionTileRotationTimer =
        Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      setState(() => _nutritionTileRotationIndex++);
    });
  }

  @override
  void didUpdateWidget(covariant LogScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((!oldWidget.showWaterShowcase && widget.showWaterShowcase) ||
        (!oldWidget.isActive && widget.isActive)) {
      _didAttemptWaterShowcase = false;
    }
  }

  @override
  void dispose() {
    _nutritionTileRotationTimer?.cancel();
    super.dispose();
  }

  void _maybeStartWaterShowcase(AppProfile? profile) {
    if (_didAttemptWaterShowcase ||
        profile == null ||
        !widget.showWaterShowcase ||
        !widget.isActive ||
        widget.waterShowcaseKey == null) {
      return;
    }

    _didAttemptWaterShowcase = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ShowcaseView.get().startShowCase([widget.waterShowcaseKey!]);
    });
  }

  Future<void> _openWaterLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const WaterLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  Future<void> _openWeightLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const WeightLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  Future<void> _openDoseLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => const DoseLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  Future<void> _openMealsLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MealsLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  Future<void> _openExerciseLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ExerciseLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  Future<void> _openSymptomsLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SymptomsLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  Future<void> _openMoodLog() async {
    HapticFeedback.selectionClick();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MoodLogScreen(),
      ),
    );
    _invalidateLogData();
  }

  void _invalidateLogData() {
    ref.invalidate(logStatsProvider);
  }

  bool _hasLogsToday(_LogStatsSnapshot? stats) {
    if (stats == null) {
      return false;
    }
    return [
      stats.water,
      stats.exercise,
      stats.weight,
      stats.meals,
      stats.mood,
      stats.symptoms,
      stats.doses,
    ].any((entries) => entries.isNotEmpty);
  }

  String _todayInsightCardTitle(bool hasLogsToday, AppLocalizations l10n) {
    if (hasLogsToday) {
      return switch (_todayInsightVariantIndex) {
        0 => l10n.homeInsightMoreLogsVariant1Title,
        1 => l10n.homeInsightMoreLogsVariant2Title,
        _ => l10n.homeInsightMoreLogsVariant3Title,
      };
    }
    return l10n.homeInsightLogTodayTitle;
  }

  String _todayInsightCardCopy(bool hasLogsToday, AppLocalizations l10n) {
    if (hasLogsToday) {
      return switch (_todayInsightVariantIndex) {
        0 => l10n.homeInsightMoreLogsVariant1Body,
        1 => l10n.homeInsightMoreLogsVariant2Body,
        _ => l10n.homeInsightMoreLogsVariant3Body,
      };
    }
    return l10n.homeInsightLogTodayBodyNoLogs;
  }

  void _trackLogTileOpened({
    required String tile,
    required String destination,
  }) {
    ref.read(analyticsServiceProvider).capture(
      eventName: 'log_track_tile_opened',
      properties: {
        'source': 'log_screen',
        'tile': tile,
        'destination': destination,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final l10n = context.l10n;
    final stats = ref.watch(logStatsProvider).asData?.value;
    final profile = ref.watch(profileBootstrapProvider).asData?.value;
    final isPro = ref.watch(isProProvider);
    _maybeStartWaterShowcase(profile);
    final hasLogsToday = _hasLogsToday(stats);
    final insightCardMode =
        (profile?.settings['debug_insight_card_mode'] as String?)
            ?.trim()
            .toLowerCase();

    final tiles = <_LogMetricTileData>[
      _buildNutritionTile(colors, stats, profile, l10n),
      _buildWaterTile(colors, stats, profile, l10n),
      _buildExerciseTile(colors, stats, profile, l10n),
      _buildWeightTile(colors, stats, profile, l10n),
      _buildMoodTile(colors, stats, l10n),
      _buildSymptomsTile(colors, stats, l10n),
      _buildDoseTile(colors, stats, profile, l10n),
    ];

    return SwipeBackDetector(
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              Center(
                child: Text(
                  l10n.mainShellLog,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TodayInsightCard(
                hasLogsToday: hasLogsToday,
                title: _todayInsightCardTitle(hasLogsToday, l10n),
                copy: _todayInsightCardCopy(hasLogsToday, l10n),
                insightCardMode: insightCardMode,
                isPro: isPro,
                analyticsSource: 'log',
                proAccessSource: 'log_daily_insight',
              ),
              const SizedBox(height: 18),
              _LogTrackingSection(
                tiles: tiles,
                waterShowcaseKey: widget.waterShowcaseKey,
                showWaterShowcase: widget.showWaterShowcase,
                waterShowcaseTitle: l10n.logWaterShowcaseTitle,
                waterShowcaseDescription: l10n.logWaterShowcaseDescription,
                onWaterShowcaseInteracted: widget.onWaterShowcaseInteracted,
                onTileTap: (tile) {
                  if (tile.title == l10n.homeWaterTitle) {
                    _trackLogTileOpened(
                      tile: 'water',
                      destination: 'water_log',
                    );
                    _openWaterLog();
                    return;
                  }
                  if (tile.title == l10n.homeWeightTitle) {
                    _trackLogTileOpened(
                      tile: 'weight',
                      destination: 'weight_log',
                    );
                    _openWeightLog();
                    return;
                  }
                  if (tile.title == l10n.homeExerciseTitle) {
                    _trackLogTileOpened(
                      tile: 'exercise',
                      destination: 'exercise_log',
                    );
                    _openExerciseLog();
                    return;
                  }
                  if (tile.title == l10n.homeMealsTitle) {
                    _trackLogTileOpened(
                      tile: 'meals',
                      destination: 'meals_log',
                    );
                    _openMealsLog();
                    return;
                  }
                  if (tile.title == l10n.homeCaloriesTitle) {
                    _trackLogTileOpened(
                      tile: 'calories',
                      destination: 'meals_log',
                    );
                    _openMealsLog();
                    return;
                  }
                  if (tile.title == l10n.homeProteinsTitle) {
                    _trackLogTileOpened(
                      tile: 'protein',
                      destination: 'meals_log',
                    );
                    _openMealsLog();
                    return;
                  }
                  if (tile.title == l10n.homeFibersTitle) {
                    _trackLogTileOpened(
                      tile: 'fiber',
                      destination: 'meals_log',
                    );
                    _openMealsLog();
                    return;
                  }
                  if (tile.title == l10n.homeSymptomsTitle) {
                    _trackLogTileOpened(
                      tile: 'symptoms',
                      destination: 'symptoms_log',
                    );
                    _openSymptomsLog();
                    return;
                  }
                  if (tile.title == l10n.homeMoodTitle) {
                    _trackLogTileOpened(
                      tile: 'mood',
                      destination: 'mood_log',
                    );
                    _openMoodLog();
                    return;
                  }
                  if (tile.title == l10n.homeDoseTitle) {
                    _trackLogTileOpened(
                      tile: 'dose',
                      destination: 'dose_log',
                    );
                    _openDoseLog();
                    return;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _LogMetricTileData _buildWaterTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final waterTint = Color.lerp(colors.accentSky, colors.heroEnd, 0.58)!;
    final goal = profile?.goals.water;
    final goalEntry = goal?.current;
    if (goal?.enabled == true && goalEntry != null) {
      final todayWaterEntries = stats?.water ?? const <Map<String, dynamic>>[];
      final waterEntries = goalEntry.timeframe == GoalTimeframe.weekly
          ? (stats?.waterWeek ?? const <Map<String, dynamic>>[])
          : todayWaterEntries;
      final totalMl = waterEntries.fold<double>(
        0,
        (sum, entry) => sum + (((entry['quantity'] as num?) ?? 0).toDouble()),
      );
      final todayMl = todayWaterEntries.fold<double>(
        0,
        (sum, entry) => sum + (((entry['quantity'] as num?) ?? 0).toDouble()),
      );
      final completionProgress = goalEntry.timeframe == GoalTimeframe.weekly
          ? (todayMl / (goalEntry.targetMl / 7)).clamp(0, 1).toDouble()
          : (todayMl / goalEntry.targetMl).clamp(0, 1).toDouble();
      final overallProgress = goalEntry.targetMl <= 0
          ? 0.0
          : (totalMl / goalEntry.targetMl).clamp(0, 1).toDouble();

      return _LogMetricTileData(
        title: l10n.homeWaterTitle,
        value: todayMl > 0 ? _formatWaterValue(todayMl) : '',
        caption: todayWaterEntries.isNotEmpty
            ? l10n.homePercentOfDailyGoal(
                (completionProgress * 100).round(),
              )
            : l10n.homeStartHydration,
        icon: Icons.water_drop_rounded,
        tint: waterTint,
        progress: overallProgress,
        isDailyGoalReached: completionProgress >= 1,
        state: todayWaterEntries.isEmpty
            ? _LogTileState.empty
            : overallProgress >= 1
                ? _LogTileState.complete
                : _LogTileState.partial,
      );
    }

    final waterEntries = stats?.water ?? const <Map<String, dynamic>>[];
    final totalMl = waterEntries.fold<double>(
      0,
      (sum, entry) => sum + (((entry['quantity'] as num?) ?? 0).toDouble()),
    );
    final progress = (totalMl / 2000).clamp(0, 1).toDouble();

    return _LogMetricTileData(
      title: l10n.homeWaterTitle,
      value: totalMl > 0 ? _formatWaterValue(totalMl) : '',
      caption: waterEntries.isEmpty ? l10n.homeStartHydration : '',
      icon: Icons.water_drop_rounded,
      tint: waterTint,
      progress: progress,
      isDailyGoalReached: waterEntries.isNotEmpty,
      state:
          waterEntries.isEmpty ? _LogTileState.empty : _LogTileState.complete,
    );
  }

  _LogMetricTileData _buildExerciseTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final goal = profile?.goals.exercise;
    final goalEntry = goal?.current;
    if (goal?.enabled == true && goalEntry != null) {
      final todayExerciseEntries =
          stats?.exercise ?? const <Map<String, dynamic>>[];
      final exerciseEntries = goalEntry.timeframe == GoalTimeframe.weekly
          ? (stats?.exerciseWeek ?? const <Map<String, dynamic>>[])
          : todayExerciseEntries;
      final totalMinutes = exerciseEntries.fold<int>(
        0,
        (sum, entry) =>
            sum + (((entry['duration_minutes'] as num?) ?? 0).toInt()),
      );
      final todayMinutes = todayExerciseEntries.fold<int>(
        0,
        (sum, entry) =>
            sum + (((entry['duration_minutes'] as num?) ?? 0).toInt()),
      );
      final completionProgress = goalEntry.timeframe == GoalTimeframe.weekly
          ? (todayMinutes / (goalEntry.targetMinutes / 6))
              .clamp(0, 1)
              .toDouble()
          : (todayMinutes / goalEntry.targetMinutes).clamp(0, 1).toDouble();
      final overallProgress = goalEntry.targetMinutes <= 0
          ? 0.0
          : (totalMinutes / goalEntry.targetMinutes).clamp(0, 1).toDouble();

      return _LogMetricTileData(
        title: l10n.homeExerciseTitle,
        value: todayMinutes > 0 ? '${todayMinutes.round()} min' : '',
        caption: todayExerciseEntries.isEmpty
            ? l10n.homeLogFirstSession
            : '${(completionProgress * 100).round()}% of daily goal',
        icon: Icons.directions_run_rounded,
        tint: const Color(0xFF6BCB81),
        progress: overallProgress,
        isDailyGoalReached: completionProgress >= 1,
        state: todayExerciseEntries.isEmpty
            ? _LogTileState.empty
            : overallProgress >= 1
                ? _LogTileState.complete
                : _LogTileState.partial,
      );
    }

    final exerciseEntries = stats?.exercise ?? const <Map<String, dynamic>>[];
    final totalMinutes = exerciseEntries.fold<int>(
      0,
      (sum, entry) =>
          sum + (((entry['duration_minutes'] as num?) ?? 0).toInt()),
    );
    final progress = (totalMinutes / 30).clamp(0, 1).toDouble();

    return _LogMetricTileData(
      title: l10n.homeExerciseTitle,
      value: totalMinutes > 0 ? '${totalMinutes.round()} min' : '',
      caption: exerciseEntries.isEmpty ? l10n.homeLogFirstSession : '',
      icon: Icons.directions_run_rounded,
      tint: const Color(0xFF6BCB81),
      progress: progress,
      isDailyGoalReached: exerciseEntries.isNotEmpty,
      state: exerciseEntries.isEmpty
          ? _LogTileState.empty
          : _LogTileState.complete,
    );
  }

  _LogMetricTileData _buildWeightTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final goal = profile?.goals.weight;
    final goalEntry = goal?.current;
    if (goal?.enabled == true && goalEntry != null) {
      final todayWeightEntries =
          stats?.weight ?? const <Map<String, dynamic>>[];
      final latest =
          todayWeightEntries.isEmpty ? null : todayWeightEntries.last;
      final latestQuantity = (latest?['quantity'] as num?)?.toDouble();
      final latestUnit = _loggedWeightUnit(latest);
      final quantityKg = latestQuantity == null
          ? null
          : _convertWeightToKg(latestQuantity, latestUnit);
      final unit = goalEntry.targetUnit;
      final latestValue =
          quantityKg == null ? null : _convertKgToUnit(quantityKg, unit);
      final targetValue = _convertKgToUnit(goalEntry.targetKg, unit);
      final gap = latestValue == null ? null : targetValue - latestValue;
      final absGap = gap?.abs() ?? 0.0;
      final weeklyPace =
          goalEntry.timeframe == GoalTimeframe.weekly ? absGap : absGap / 4.0;
      final progress = latestValue == null
          ? null
          : (1 - (absGap / targetValue.abs().clamp(1, double.infinity)))
              .clamp(0, 1)
              .toDouble();

      return _LogMetricTileData(
        title: l10n.homeWeightTitle,
        value: latestValue == null
            ? ''
            : '${latestValue.toStringAsFixed(unit == 'lb' ? 0 : 1)} $unit',
        caption: latestValue == null
            ? l10n.homeLogTodayWeight
            : absGap < _weightTolerance(unit)
                ? l10n.homeAtYourTarget
                : l10n.goalsWeightPerWeekToTarget(
                    _formatAmount(weeklyPace, unit),
                    unit,
                  ),
        icon: Icons.monitor_weight_rounded,
        tint: const Color(0xFF6F8DBA),
        progress: progress,
        isDailyGoalReached: latestValue != null,
        state: latestValue == null
            ? _LogTileState.empty
            : absGap < _weightTolerance(unit)
                ? _LogTileState.complete
                : _LogTileState.partial,
      );
    } else {
      final todayWeightEntries =
          stats?.weight ?? const <Map<String, dynamic>>[];
      final latest =
          todayWeightEntries.isEmpty ? null : todayWeightEntries.last;
      final quantity = (latest?['quantity'] as num?)?.toDouble();
      final unit = _loggedWeightUnit(latest);
      return _LogMetricTileData(
        title: l10n.homeWeightTitle,
        value: quantity == null ? '' : _formatLoggedWeight(quantity, unit),
        caption: todayWeightEntries.isEmpty ? l10n.homeLogTodayWeight : '',
        icon: Icons.monitor_weight_rounded,
        tint: const Color(0xFF6F8DBA),
        isDailyGoalReached: quantity != null,
        state: todayWeightEntries.isEmpty
            ? _LogTileState.empty
            : _LogTileState.complete,
      );
    }
  }

  _LogMetricTileData _buildNutritionTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final nutritionTiles =
        _buildNutritionTileStates(colors, stats, profile, l10n);
    if (nutritionTiles.isEmpty) {
      return _LogMetricTileData(
        title: l10n.homeMealsTitle,
        value: '',
        caption: l10n.homeLogFirstMeal,
        icon: Icons.restaurant_menu_rounded,
        tint: const Color(0xFFFFAA5B),
        state: _LogTileState.empty,
      );
    }
    final activeIndex = _nutritionTileRotationIndex % nutritionTiles.length;
    final activeTile = nutritionTiles[activeIndex];
    return _LogMetricTileData(
      title: activeTile.title,
      value: activeTile.value,
      caption: activeTile.caption,
      icon: activeTile.icon,
      tint: activeTile.tint,
      state: activeTile.state,
      progress: activeTile.progress,
      isDailyGoalReached: activeTile.isDailyGoalReached,
      isOverDailyGoal: activeTile.isOverDailyGoal,
      carouselIndex: activeIndex,
      carouselCount: nutritionTiles.length,
    );
  }

  List<_LogMetricTileData> _buildNutritionTileStates(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final todayMealEntries = stats?.meals ?? const <Map<String, dynamic>>[];
    final weeklyMealEntries =
        stats?.mealsWeek ?? const <Map<String, dynamic>>[];
    final mealGoal = profile?.goals.meals;
    final mealGoalEntry = mealGoal?.current;
    final proteinGoal = profile?.goals.protein;
    final proteinGoalEntry = proteinGoal?.current;
    final fiberGoal = profile?.goals.fiber;
    final fiberGoalEntry = fiberGoal?.current;

    double consumed(Map<String, dynamic> entry) =>
        ((entry['consumed'] as num?)?.toDouble() ?? 1.0).clamp(0.0, 1.0);

    final totalCalories = weeklyMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (((entry['calories'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final todayCalories = todayMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (((entry['calories'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final totalProtein = weeklyMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (((entry['proteins'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final todayProtein = todayMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (((entry['proteins'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final totalFiber = weeklyMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum + (((entry['fiber'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final todayFiber = todayMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum + (((entry['fiber'] as num?) ?? 0).toDouble() * consumed(entry)),
    );

    final tiles = <_LogMetricTileData>[];

    if (mealGoal?.enabled == true && mealGoalEntry != null) {
      final isCalories = mealGoalEntry.mode == MealsGoalMode.calories;
      final trackedValue =
          isCalories ? totalCalories : weeklyMealEntries.length.toDouble();
      final todayTrackedValue =
          isCalories ? todayCalories : todayMealEntries.length.toDouble();
      final completionProgress =
          todayTrackedValue / (mealGoalEntry.targetValue / 7);
      final overallProgress =
          (trackedValue / mealGoalEntry.targetValue).clamp(0, 1).toDouble();

      tiles.add(
        _LogMetricTileData(
          title: isCalories ? l10n.homeCaloriesTitle : l10n.homeMealsTitle,
          value: todayMealEntries.isEmpty
              ? ''
              : isCalories
                  ? '${todayCalories.round()} cal'
                  : '${todayMealEntries.length} logged',
          caption: todayMealEntries.isEmpty
              ? (isCalories
                  ? l10n.homeLogMealsToTrackCalories
                  : l10n.homeLogFirstMeal)
              : '${(completionProgress * 100).round()}% of daily goal',
          icon: isCalories
              ? Icons.local_fire_department_rounded
              : Icons.restaurant_menu_rounded,
          tint: const Color(0xFFFFAA5B),
          progress: overallProgress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: completionProgress > 1,
          state: todayMealEntries.isEmpty
              ? _LogTileState.empty
              : overallProgress >= 1
                  ? _LogTileState.complete
                  : _LogTileState.partial,
        ),
      );
    } else {
      final completionProgress = todayMealEntries.length / 3;
      final progress = completionProgress.clamp(0, 1).toDouble();
      tiles.add(
        _LogMetricTileData(
          title: l10n.homeMealsTitle,
          value: todayMealEntries.isEmpty
              ? ''
              : '${todayMealEntries.length} logged',
          caption: todayMealEntries.isEmpty
              ? l10n.homeLogFirstMeal
              : '${(completionProgress * 100).round()}% of daily goal',
          icon: Icons.restaurant_menu_rounded,
          tint: const Color(0xFFFFAA5B),
          progress: progress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: completionProgress > 1,
          state: todayMealEntries.isEmpty
              ? _LogTileState.empty
              : progress >= 1
                  ? _LogTileState.complete
                  : _LogTileState.partial,
        ),
      );
    }

    if (proteinGoal?.enabled == true && proteinGoalEntry != null) {
      final completionProgress =
          todayProtein / (proteinGoalEntry.targetGrams / 7);
      final overallProgress =
          (totalProtein / proteinGoalEntry.targetGrams).clamp(0, 1).toDouble();
      final hasMealsToday = todayMealEntries.isNotEmpty;
      tiles.add(
        _LogMetricTileData(
          title: l10n.homeProteinsTitle,
          value: todayProtein > 0
              ? '${todayProtein.round()} g'
              : (hasMealsToday ? '0 g' : ''),
          caption: hasMealsToday
              ? '${(completionProgress * 100).round()}% of daily goal'
              : l10n.homeTrackProteinFromMeals,
          icon: Icons.fitness_center_rounded,
          tint: colors.protein,
          progress: overallProgress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: hasMealsToday && completionProgress > 1,
          state: hasMealsToday
              ? (overallProgress >= 1
                  ? _LogTileState.complete
                  : _LogTileState.partial)
              : _LogTileState.empty,
        ),
      );
    }

    if (fiberGoal?.enabled == true && fiberGoalEntry != null) {
      final completionProgress = todayFiber / (fiberGoalEntry.targetGrams / 7);
      final overallProgress =
          (totalFiber / fiberGoalEntry.targetGrams).clamp(0, 1).toDouble();
      final hasMealsToday = todayMealEntries.isNotEmpty;
      tiles.add(
        _LogMetricTileData(
          title: l10n.homeFibersTitle,
          value: todayFiber > 0
              ? '${todayFiber.round()} g'
              : (hasMealsToday ? '0 g' : ''),
          caption: hasMealsToday
              ? '${(completionProgress * 100).round()}% of daily goal'
              : l10n.homeTrackFiberFromMeals,
          icon: Icons.eco_rounded,
          tint: colors.fiber,
          progress: overallProgress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: hasMealsToday && completionProgress > 1,
          state: hasMealsToday
              ? (overallProgress >= 1
                  ? _LogTileState.complete
                  : _LogTileState.partial)
              : _LogTileState.empty,
        ),
      );
    }

    return tiles;
  }

  _LogMetricTileData _buildSymptomsTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppLocalizations l10n,
  ) {
    final symptomEntries = stats?.symptoms ?? const <Map<String, dynamic>>[];
    final totalSymptoms = symptomEntries.fold<int>(
      0,
      (sum, entry) => sum + ((entry['symptoms'] as List?)?.length ?? 0),
    );
    return _LogMetricTileData(
      title: l10n.homeSymptomsTitle,
      value: symptomEntries.isEmpty
          ? ''
          : totalSymptoms == 0
              ? l10n.homeAllClear
              : '$totalSymptoms logged',
      caption: symptomEntries.isEmpty ? l10n.homeTrackSymptoms : '',
      icon: Icons.favorite_rounded,
      tint: const Color(0xFFEA87A8),
      isDailyGoalReached: symptomEntries.isNotEmpty,
      state:
          symptomEntries.isEmpty ? _LogTileState.empty : _LogTileState.complete,
    );
  }

  _LogMetricTileData _buildMoodTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppLocalizations l10n,
  ) {
    final moodEntries = stats?.mood ?? const <Map<String, dynamic>>[];
    final latest = moodEntries.isEmpty ? null : moodEntries.last;
    final feeling = (latest?['feeling'] as String?)?.trim();
    final value = switch (feeling) {
      'great' => l10n.homeGreat,
      'good' => l10n.homeGood,
      'bad' => l10n.homeBad,
      'okay' => l10n.homeOkay,
      _ => '',
    };

    return _LogMetricTileData(
      title: l10n.homeMoodTitle,
      value: value,
      caption: moodEntries.isEmpty
          ? l10n.homeLogHowYouFeel
          : '${moodEntries.length} check-in${moodEntries.length == 1 ? '' : 's'}',
      icon: Icons.mood_rounded,
      tint: const Color(0xFF7A74F5),
      isDailyGoalReached: moodEntries.isNotEmpty,
      state: moodEntries.isEmpty ? _LogTileState.empty : _LogTileState.complete,
    );
  }

  _LogMetricTileData _buildDoseTile(
    AppColors colors,
    _LogStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final settings = profile?.settings ?? const <String, dynamic>{};
    final format =
        (settings['medication_method'] as String?)?.trim() ?? 'injection';
    final icon =
        format == 'pill' ? Icons.medication_outlined : Icons.vaccines_outlined;
    const doseTint = Color(0xFFB47FE8);

    final doseEntries = stats?.doses ?? const <Map<String, dynamic>>[];
    if (doseEntries.isEmpty) {
      return _LogMetricTileData(
        title: l10n.homeDoseTitle,
        value: '',
        caption: l10n.homeLogTodaysDose,
        icon: icon,
        tint: doseTint,
        state: _LogTileState.empty,
      );
    }

    final latest = doseEntries.last;
    final medication = (latest['medication'] as String?)?.trim();
    final dose = (latest['dose'] as String?)?.trim();
    final valueLabel = [
      if (medication != null && medication.isNotEmpty) medication,
      if (dose != null && dose.isNotEmpty) dose,
    ].join(' ');

    return _LogMetricTileData(
      title: l10n.homeDoseTitle,
      value: valueLabel.isEmpty ? l10n.homeTaken : valueLabel,
      caption: '',
      icon: icon,
      tint: doseTint,
      isDailyGoalReached: true,
      state: _LogTileState.complete,
    );
  }

  String _formatWaterValue(num totalMl) {
    if (totalMl >= 1000) {
      final liters = totalMl / 1000;
      return '${liters.toStringAsFixed(liters % 1 == 0 ? 0 : 1)} L';
    }
    return '${totalMl.round()} ml';
  }

  String _formatLoggedWeight(double quantity, String unit) {
    return '${quantity.toStringAsFixed(unit == 'lb' ? 0 : 1)} $unit';
  }

  double _convertKgToUnit(double kg, String unit) {
    return unit == 'lb' ? kg * 2.2046226218 : kg;
  }

  double _convertWeightToKg(double value, String unit) {
    return unit == 'lb' ? value / 2.2046226218 : value;
  }

  double _weightTolerance(String unit) {
    return unit == 'lb' ? 2.0 : 1.0;
  }

  String _formatAmount(double value, String unit) {
    return '${value.toStringAsFixed(unit == 'lb' ? 0 : 1)} $unit';
  }

  String _loggedWeightUnit(Map<String, dynamic>? record) {
    final unit = record?['unit'] as String?;
    return unit == 'lb' ? 'lb' : 'kg';
  }
}

class _LogTrackingSection extends StatelessWidget {
  const _LogTrackingSection({
    required this.tiles,
    required this.onTileTap,
    this.waterShowcaseKey,
    this.showWaterShowcase = false,
    this.waterShowcaseTitle,
    this.waterShowcaseDescription,
    this.onWaterShowcaseInteracted,
  });

  final List<_LogMetricTileData> tiles;
  final ValueChanged<_LogMetricTileData> onTileTap;
  final GlobalKey? waterShowcaseKey;
  final bool showWaterShowcase;
  final String? waterShowcaseTitle;
  final String? waterShowcaseDescription;
  final VoidCallback? onWaterShowcaseInteracted;

  @override
  Widget build(BuildContext context) {
    final gridWidth = MediaQuery.sizeOf(context).width - 40;
    final halfWidth = (gridWidth - 12) / 2;
    final isOdd = tiles.length.isOdd;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (var index = 0; index < tiles.length; index++)
          SizedBox(
            width: isOdd && index == tiles.length - 1 ? gridWidth : halfWidth,
            height: 160,
            child: tiles[index].title == context.l10n.homeWaterTitle &&
                    showWaterShowcase &&
                    waterShowcaseKey != null
                ? Showcase(
                    key: waterShowcaseKey!,
                    title: waterShowcaseTitle ?? '',
                    description: waterShowcaseDescription ?? '',
                    tooltipBackgroundColor: context.appColors.surface,
                    tooltipBorderRadius: BorderRadius.circular(24),
                    tooltipPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    titlePadding: const EdgeInsets.only(bottom: 8),
                    titleAlignment: Alignment.centerLeft,
                    descriptionAlignment: Alignment.centerLeft,
                    titleTextAlign: TextAlign.left,
                    descriptionTextAlign: TextAlign.left,
                    titleTextStyle:
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: context.appColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                    descTextStyle:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.appColors.textPrimary
                                  .withValues(alpha: 0.72),
                              height: 1.35,
                            ),
                    overlayOpacity: 0.58,
                    disableMovingAnimation: true,
                    disableScaleAnimation: true,
                    showArrow: true,
                    toolTipMargin: 10,
                    targetPadding: const EdgeInsets.all(4),
                    targetBorderRadius: BorderRadius.circular(24),
                    onBarrierClick: onWaterShowcaseInteracted,
                    onToolTipClick: onWaterShowcaseInteracted,
                    onTargetClick: onWaterShowcaseInteracted,
                    disposeOnTap: true,
                    child: _LogMetricTile(
                      tile: tiles[index],
                      onTap: () => onTileTap(tiles[index]),
                      isFullWidth: isOdd && index == tiles.length - 1,
                    ),
                  )
                : _LogMetricTile(
                    tile: tiles[index],
                    onTap: () => onTileTap(tiles[index]),
                    isFullWidth: isOdd && index == tiles.length - 1,
                  ),
          ),
      ],
    );
  }
}

class _LogMetricTile extends StatelessWidget {
  const _LogMetricTile({
    required this.tile,
    required this.onTap,
    this.isFullWidth = false,
  });

  final _LogMetricTileData tile;
  final VoidCallback onTap;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final tileBackgroundColor = tile.isDailyGoalReached
        ? Color.alphaBlend(tile.tint.withValues(alpha: 0.22), Colors.white)
        : colors.surface;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Material(
        color: tileBackgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LogTileIconCircle(
                      icon: tile.icon,
                      tint: tile.tint,
                      state: tile.state,
                    ),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.lineSubtle),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 18,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  tile.title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 16,
                    color: HSLColor.fromColor(colors.textSecondary)
                        .withLightness(
                          (HSLColor.fromColor(colors.textSecondary).lightness -
                                  0.16)
                              .clamp(0.0, 1.0),
                        )
                        .toColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    switch (tile.state) {
                      _LogTileState.empty => Text(
                          tile.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: colors.textSecondary.withValues(alpha: 0.70),
                          ),
                        ),
                      _LogTileState.partial => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tile.value,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.0,
                                color: HSLColor.fromColor(colors.textSecondary)
                                    .withLightness(
                                      (HSLColor.fromColor(colors.textSecondary)
                                                  .lightness -
                                              0.16)
                                          .clamp(0.0, 1.0),
                                    )
                                    .toColor(),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              tile.caption,
                              maxLines: isFullWidth ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: tile.isOverDailyGoal
                                    ? const Color(0xFFCC8800)
                                    : colors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      _LogTileState.complete => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tile.value,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.0,
                                color: HSLColor.fromColor(colors.textSecondary)
                                    .withLightness(
                                      (HSLColor.fromColor(colors.textSecondary)
                                                  .lightness -
                                              0.16)
                                          .clamp(0.0, 1.0),
                                    )
                                    .toColor(),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              tile.caption,
                              maxLines: isFullWidth ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: tile.isOverDailyGoal
                                    ? const Color(0xFFCC8800)
                                    : colors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    },
                    if (tile.carouselCount > 1) ...[
                      const SizedBox(height: 8),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var i = 0; i < tile.carouselCount; i++) ...[
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: i == tile.carouselIndex ? 12 : 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: i == tile.carouselIndex
                                      ? colors.textSecondary.withValues(
                                          alpha: 0.45,
                                        )
                                      : colors.lineSubtle.withValues(
                                          alpha: 0.7,
                                        ),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                              if (i < tile.carouselCount - 1)
                                const SizedBox(width: 4),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogTileIconCircle extends StatelessWidget {
  const _LogTileIconCircle({
    required this.icon,
    required this.tint,
    required this.state,
  });

  final IconData icon;
  final Color tint;
  final _LogTileState state;

  @override
  Widget build(BuildContext context) {
    final iconColor = HSLColor.fromColor(tint)
        .withLightness(state == _LogTileState.empty ? 0.64 : 0.46)
        .toColor()
        .withValues(alpha: state == _LogTileState.empty ? 0.72 : 0.8);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: state == _LogTileState.empty ? 0.78 : 0.86,
        ),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, size: 22, color: iconColor),
    );
  }
}

class _LogStatsSnapshot {
  const _LogStatsSnapshot({
    required this.water,
    required this.exercise,
    required this.weight,
    required this.meals,
    required this.mood,
    required this.symptoms,
    required this.waterWeek,
    required this.exerciseWeek,
    required this.mealsWeek,
    required this.latestWeight,
    required this.doses,
  });

  final List<Map<String, dynamic>> water;
  final List<Map<String, dynamic>> exercise;
  final List<Map<String, dynamic>> weight;
  final List<Map<String, dynamic>> meals;
  final List<Map<String, dynamic>> mood;
  final List<Map<String, dynamic>> symptoms;
  final List<Map<String, dynamic>> waterWeek;
  final List<Map<String, dynamic>> exerciseWeek;
  final List<Map<String, dynamic>> mealsWeek;
  final Map<String, dynamic>? latestWeight;
  final List<Map<String, dynamic>> doses;
}

class _LogMetricTileData {
  const _LogMetricTileData({
    required this.title,
    required this.value,
    required this.caption,
    required this.icon,
    required this.tint,
    required this.state,
    this.progress,
    this.isDailyGoalReached = false,
    this.isOverDailyGoal = false,
    this.carouselIndex = 0,
    this.carouselCount = 1,
  });

  final String title;
  final String value;
  final String caption;
  final IconData icon;
  final Color tint;
  final _LogTileState state;
  final double? progress;
  final bool isDailyGoalReached;
  final bool isOverDailyGoal;
  final int carouselIndex;
  final int carouselCount;
}

enum _LogTileState {
  empty,
  partial,
  complete,
}

DateTime _startOfWeek(DateTime date) {
  final normalized = DateUtils.dateOnly(date);
  return normalized.subtract(
    Duration(days: normalized.weekday - DateTime.monday),
  );
}
