// ignore_for_file: unused_element, unused_element_parameter

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';

import '../config/app_config.dart';
import '../models/app_profile.dart';
import '../models/goals.dart';
import '../models/injection_site_catalog.dart';
import '../models/medication_catalog.dart';
import '../l10n/l10n.dart';
import '../providers/analytics_provider.dart';
import '../providers/ai_request_service_provider.dart';
import '../providers/generate_insights_service_provider.dart';
import '../providers/goals_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/today_meals_provider.dart';
import '../providers/profile_service_provider.dart';
import '../providers/record_service_provider.dart';
import '../providers/subscription_provider.dart';
import '../services/record_service.dart';
import '../widgets/estimated_medication_levels_card.dart';
import '../widgets/pro_gate.dart';
import 'progress/insights_progress_screen.dart';
import 'goals_screen.dart';
import 'shortcuts/glow_up_screen.dart';
import 'shortcuts/portion_check_screen.dart';
import '../widgets/bmi_indicator.dart';
import 'settings/dose_reminder_screen.dart';
import 'settings/supplement_reminder_screen.dart';
import '../theme/app_colors.dart';

final homeStatsProvider = FutureProvider<_HomeStatsSnapshot>((ref) async {
  final service = ref.read(recordServiceProvider);
  final start = DateUtils.dateOnly(DateTime.now());
  final end = start.add(const Duration(days: 1));
  final weekStart = _startOfWeek(start);

  final results = await Future.wait<Object?>([
    service.loadTimeseries(RecordService.waterColumn, start, end),
    service.loadTimeseries(RecordService.exerciseColumn, start, end),
    service.loadTimeseries(RecordService.weightColumn, start, end),
    ref.watch(todayMealsProvider.future), // shared — no duplicate fetch
    service.loadTimeseries(RecordService.moodColumn, start, end),
    service.loadTimeseries(RecordService.symptomsColumn, start, end),
    service.loadTimeseries(RecordService.waterColumn, weekStart, end),
    service.loadTimeseries(RecordService.exerciseColumn, weekStart, end),
    service.loadTimeseries(RecordService.mealsColumn, weekStart, end),
    service.loadLatestRecord(RecordService.weightColumn),
    service.loadTimeseries(RecordService.dosesColumn, start, end),
  ]);

  return _HomeStatsSnapshot(
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

final homeStreakProvider = FutureProvider<int>((ref) async {
  final service = ref.read(recordServiceProvider);
  final today = DateUtils.dateOnly(DateTime.now());
  const lookbackDays = 60;
  final start = today.subtract(const Duration(days: lookbackDays - 1));
  final end = today.add(const Duration(days: 1));

  final results = await Future.wait<List<Map<String, dynamic>>>([
    service.loadTimeseries(RecordService.waterColumn, start, end),
    service.loadTimeseries(RecordService.exerciseColumn, start, end),
    service.loadTimeseries(RecordService.weightColumn, start, end),
    service.loadTimeseries(RecordService.mealsColumn, start, end),
    service.loadTimeseries(RecordService.moodColumn, start, end),
    service.loadTimeseries(RecordService.symptomsColumn, start, end),
    service.loadTimeseries(RecordService.dosesColumn, start, end),
    service.loadTimeseries(RecordService.supplementsColumn, start, end),
  ]);

  final loggedDays = <String>{};
  for (final entries in results) {
    for (final entry in entries) {
      final rawLoggedAt = entry['logged_at'];
      if (rawLoggedAt is! String) continue;
      final parsed = DateTime.tryParse(rawLoggedAt);
      if (parsed == null) continue;
      loggedDays.add(_streakDayKey(parsed));
    }
  }

  var streak = 0;
  var cursor = today;
  while (!cursor.isBefore(start)) {
    if (!loggedDays.contains(_streakDayKey(cursor))) {
      break;
    }
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }

  return streak;
});

final homeMedicationDoseLogsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final service = ref.read(recordServiceProvider);
  const lookbackDays = 90;
  final start = DateUtils.dateOnly(DateTime.now())
      .subtract(const Duration(days: lookbackDays));
  final end = DateTime.now().add(const Duration(days: 1));
  final results = await service.loadTimeseries(
    RecordService.dosesColumn,
    start,
    end,
  );
  results.sort(
    (a, b) => (a['logged_at'] as String).compareTo(b['logged_at'] as String),
  );
  return results;
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.config,
    required this.supabaseReady,
    this.isActive = true,
  });

  final AppConfig config;
  final bool supabaseReady;
  final bool isActive;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _remindersShowcaseSeenKey = 'showcase_reminders_seen';

  final GlobalKey _remindersShowcaseKey = GlobalKey();
  bool _didAttemptRemindersShowcase = false;
  int _nutritionTileRotationIndex = 0;
  late final int _todayInsightVariantIndex;
  Timer? _nutritionTileRotationTimer;
  // bool _tracksSupplements = false;

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
  void dispose() {
    _nutritionTileRotationTimer?.cancel();
    super.dispose();
  }

  // void _toggleSupplementsTracking() {
  //   HapticFeedback.selectionClick();
  //   setState(() {
  //     _tracksSupplements = !_tracksSupplements;
  //   });
  // }

  void _invalidateHomeData() {
    ref.invalidate(homeStatsProvider);
    ref.invalidate(homeStreakProvider);
    ref.invalidate(homeMedicationDoseLogsProvider);
  }

  List<_HomeGoalStatusItem> _buildGoalStatusItems(
    AppColors colors,
    _HomeStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    if (profile == null) {
      return const [];
    }
    final goals = profile.goals;
    final waterTint = Color.lerp(colors.accentSky, colors.heroEnd, 0.58)!;
    final waterLoggedChipColor = HSLColor.fromColor(waterTint)
        .withLightness(0.46)
        .toColor()
        .withValues(alpha: 0.8);
    final todayMealEntries = stats?.meals ?? const <Map<String, dynamic>>[];
    final todayWaterEntries = stats?.water ?? const <Map<String, dynamic>>[];
    final todayExerciseEntries =
        stats?.exercise ?? const <Map<String, dynamic>>[];

    double consumed(Map<String, dynamic> entry) =>
        ((entry['consumed'] as num?)?.toDouble() ?? 1.0).clamp(0.0, 1.0);

    final waterGoalEntry = goals.water.current;
    final waterTotalMl = todayWaterEntries.fold<double>(
      0,
      (sum, entry) => sum + (((entry['quantity'] as num?) ?? 0).toDouble()),
    );
    final waterProgress = goals.water.enabled &&
            waterGoalEntry != null &&
            waterGoalEntry.targetMl > 0
        ? (waterGoalEntry.timeframe == GoalTimeframe.weekly
                ? waterTotalMl / (waterGoalEntry.targetMl / 7)
                : waterTotalMl / waterGoalEntry.targetMl)
            .clamp(0, 1)
            .toDouble()
        : 0.0;

    final exerciseGoalEntry = goals.exercise.current;
    final exerciseMinutes = todayExerciseEntries.fold<int>(
      0,
      (sum, entry) =>
          sum + (((entry['duration_minutes'] as num?) ?? 0).toInt()),
    );
    final exerciseProgress = goals.exercise.enabled &&
            exerciseGoalEntry != null &&
            exerciseGoalEntry.targetMinutes > 0
        ? (exerciseGoalEntry.timeframe == GoalTimeframe.weekly
                ? exerciseMinutes / (exerciseGoalEntry.targetMinutes / 6)
                : exerciseMinutes / exerciseGoalEntry.targetMinutes)
            .clamp(0, 1)
            .toDouble()
        : 0.0;

    final mealsGoalEntry = goals.meals.current;
    final todayCalories = todayMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (((entry['calories'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final mealsCount = todayMealEntries.length.toDouble();
    final mealsProgress = goals.meals.enabled &&
            mealsGoalEntry != null &&
            mealsGoalEntry.targetValue > 0
        ? (mealsGoalEntry.mode == MealsGoalMode.calories
                ? todayCalories / (mealsGoalEntry.targetValue / 7)
                : mealsCount / (mealsGoalEntry.targetValue / 7))
            .clamp(0, 1)
            .toDouble()
        : 0.0;

    final proteinGoalEntry = goals.protein.current;
    final todayProtein = todayMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum +
          (((entry['proteins'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final proteinProgress = goals.protein.enabled &&
            proteinGoalEntry != null &&
            proteinGoalEntry.targetGrams > 0
        ? (todayProtein / (proteinGoalEntry.targetGrams / 7))
            .clamp(0, 1)
            .toDouble()
        : 0.0;

    final fiberGoalEntry = goals.fiber.current;
    final todayFiber = todayMealEntries.fold<double>(
      0,
      (sum, entry) =>
          sum + (((entry['fiber'] as num?) ?? 0).toDouble() * consumed(entry)),
    );
    final fiberProgress = goals.fiber.enabled &&
            fiberGoalEntry != null &&
            fiberGoalEntry.targetGrams > 0
        ? (todayFiber / (fiberGoalEntry.targetGrams / 7)).clamp(0, 1).toDouble()
        : 0.0;

    final items = [
      _HomeGoalStatusItem(
        label: l10n.homeWaterTitle,
        progress: waterProgress,
        icon: Icons.water_drop_rounded,
        tint: waterTint,
        iconBackgroundColor: waterLoggedChipColor,
        progressColor: waterLoggedChipColor,
        isEnabled: goals.water.enabled,
        statusLabel:
            '${((goals.water.enabled ? waterProgress : 0.0) * 100).round()}%',
      ),
      _HomeGoalStatusItem(
        label: l10n.homeExerciseTitle,
        progress: exerciseProgress,
        icon: Icons.directions_run_rounded,
        tint: const Color(0xFF6BCB81),
        iconBackgroundColor: const Color(0xFF6BCB81),
        progressColor: const Color(0xFF6BCB81),
        isEnabled: goals.exercise.enabled,
        statusLabel:
            '${((goals.exercise.enabled ? exerciseProgress : 0.0) * 100).round()}%',
      ),
      _HomeGoalStatusItem(
        label: mealsGoalEntry?.mode == MealsGoalMode.calories
            ? l10n.homeCaloriesTitle
            : l10n.homeMealsTitle,
        progress: mealsProgress,
        icon: mealsGoalEntry?.mode == MealsGoalMode.calories
            ? Icons.local_fire_department_rounded
            : Icons.restaurant_menu_rounded,
        tint: const Color(0xFFFFAA5B),
        iconBackgroundColor: const Color(0xFFFFAA5B),
        progressColor: const Color(0xFFFFAA5B),
        isEnabled: goals.meals.enabled,
        statusLabel:
            '${((goals.meals.enabled ? mealsProgress : 0.0) * 100).round()}%',
      ),
      _HomeGoalStatusItem(
        label: l10n.homeProteinsTitle,
        progress: proteinProgress,
        icon: Icons.fitness_center_rounded,
        tint: colors.protein,
        iconBackgroundColor: colors.protein,
        progressColor: colors.protein,
        isEnabled: goals.protein.enabled,
        statusLabel:
            '${((goals.protein.enabled ? proteinProgress : 0.0) * 100).round()}%',
      ),
      _HomeGoalStatusItem(
        label: l10n.homeFibersTitle,
        progress: fiberProgress,
        icon: Icons.eco_rounded,
        tint: colors.fiber,
        iconBackgroundColor: colors.fiber,
        progressColor: colors.fiber,
        isEnabled: goals.fiber.enabled,
        statusLabel:
            '${((goals.fiber.enabled ? fiberProgress : 0.0) * 100).round()}%',
      ),
    ];

    return items.where((item) => item.isEnabled).toList();
  }

  Future<void> _openPortionCheckShortcut() async {
    HapticFeedback.selectionClick();
    if (!ref.read(isProProvider)) {
      openProAccessScreen(context, ref, source: 'home_portion_check');
      return;
    }

    final goals = await ref.read(goalsProvider.future);
    final hasCalorieGoal = goals.meals.enabled &&
        goals.meals.current?.mode == MealsGoalMode.calories;

    if (!mounted) return;

    if (!hasCalorieGoal) {
      await _showCalorieGoalRequiredDialog();
      return;
    }

    ref.read(analyticsServiceProvider).capture(
      eventName: 'home_shortcut_opened',
      properties: {
        'shortcut': 'portion_check',
      },
    );
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const PortionCheckScreen(),
      ),
    );
  }

  Future<void> _showCalorieGoalRequiredDialog() async {
    final goToGoals = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.homeCalorieGoalRequiredTitle),
        content: Text(context.l10n.homeCalorieGoalRequiredBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonNotNow),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.homeSetGoal),
          ),
        ],
      ),
    );

    if (goToGoals == true && mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const HabitGoalsScreen()),
      );
    }
  }

  Future<void> _openGlowUpShortcut() async {
    HapticFeedback.selectionClick();
    ref.read(analyticsServiceProvider).capture(
      eventName: 'home_shortcut_opened',
      properties: {
        'shortcut': 'glow_up',
      },
    );
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const GlowUpScreen()),
    );
  }

  Future<void> _markShowcaseSeen(String key) async {
    await ref.read(profileServiceProvider).updateSettings({key: true});
    Future<void>(() {
      if (mounted) {
        ref.invalidate(profileBootstrapProvider);
      }
    });
  }

  void _maybeStartRemindersShowcase(
    AppProfile? profile, {
    required bool heroVisible,
  }) {
    if (_didAttemptRemindersShowcase || profile == null) {
      return;
    }
    if (!heroVisible || !widget.isActive) {
      return;
    }
    final settings = profile.settings;
    final alreadySeen = (settings[_remindersShowcaseSeenKey] as bool?) ?? false;
    if (alreadySeen) {
      _didAttemptRemindersShowcase = true;
      return;
    }

    _didAttemptRemindersShowcase = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      ShowcaseView.get().startShowCase([
        _remindersShowcaseKey,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final l10n = context.l10n;
    final today = DateFormat('EEEE, MMM d').format(DateTime.now());
    final profile = ref.watch(profileBootstrapProvider).asData?.value;
    final isPro = ref.watch(isProProvider);
    final stats = ref.watch(homeStatsProvider).asData?.value;
    final streakCount = ref.watch(homeStreakProvider).asData?.value;
    final name = (profile?.settings['preferred_name'] as String?)?.trim();
    final greetingName = (name == null || name.isEmpty) ? 'there' : name;
    final isDoseDismissed =
        (profile?.settings['next_dose_reminder_dismissed'] as bool?) ?? false;
    final nextDoseScheduledAt = profile?.reminders.dose.items.isNotEmpty == true
        ? profile!.reminders.dose.items.first.schedule.scheduledAt
        : null;
    final hasScheduledDose =
        nextDoseScheduledAt != null && nextDoseScheduledAt.trim().isNotEmpty;
    final showDosePage = !isDoseDismissed || hasScheduledDose;

    final hasSupplements =
        profile?.reminders.supplement.items.isNotEmpty == true;
    final isSupplementDismissed =
        (profile?.settings['supplement_reminders_dismissed'] as bool?) ?? false;
    final showSupplementPage = hasSupplements || !isSupplementDismissed;
    final goalWeight = profile?.goals.weight.current;
    final goalStatusItems = _buildGoalStatusItems(colors, stats, profile, l10n);
    final showGoalStatusCard = goalStatusItems.isNotEmpty;
    final medicationLevelLogs = ref.watch(homeMedicationDoseLogsProvider);
    final hasMedicationLevelLogs =
        medicationLevelLogs.asData?.value.isNotEmpty == true;

    final showCarousel = showDosePage || showSupplementPage;

    // TODO(eug): Restore the reminder rail data when `_DailyPromptSection` is
    // reintroduced with a production-ready layout.

    return Scaffold(
      backgroundColor: colors.canvas,
      body: Builder(
        builder: (context) {
          _maybeStartRemindersShowcase(
            profile,
            heroVisible: showCarousel,
          );
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greetingName.isEmpty
                                ? l10n.homeGreetingAnonymous
                                : l10n.homeGreetingWithName(greetingName),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            today,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _StreakBadge(streakCount: streakCount),
                  ],
                ),
                const SizedBox(height: 20),
                if (showCarousel) ...[
                  Showcase(
                    key: _remindersShowcaseKey,
                    title: l10n.homeRemindersShowcaseTitle,
                    description: l10n.homeRemindersShowcaseDescription,
                    tooltipBackgroundColor: colors.surface,
                    tooltipBorderRadius: BorderRadius.circular(24),
                    tooltipPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    titlePadding: const EdgeInsets.only(bottom: 8),
                    titleAlignment: Alignment.centerLeft,
                    descriptionAlignment: Alignment.centerLeft,
                    titleTextAlign: TextAlign.left,
                    descriptionTextAlign: TextAlign.left,
                    titleTextStyle: theme.textTheme.titleSmall?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                    descTextStyle: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textPrimary.withValues(alpha: 0.72),
                      height: 1.35,
                    ),
                    overlayOpacity: 0.58,
                    disableMovingAnimation: true,
                    disableScaleAnimation: true,
                    showArrow: false,
                    toolTipMargin: 10,
                    targetPadding: EdgeInsets.zero,
                    targetBorderRadius: BorderRadius.circular(24),
                    onBarrierClick: () async {
                      try {
                        await _markShowcaseSeen(_remindersShowcaseSeenKey);
                      } catch (_) {}
                    },
                    onToolTipClick: () async {
                      try {
                        await _markShowcaseSeen(_remindersShowcaseSeenKey);
                      } catch (_) {}
                    },
                    onTargetClick: () async {
                      try {
                        await _markShowcaseSeen(_remindersShowcaseSeenKey);
                      } catch (_) {}
                    },
                    disposeOnTap: true,
                    child: _NextDoseHero(
                      profile: profile,
                      isPro: isPro,
                      showDosePage: showDosePage,
                      showSupplementPage: showSupplementPage,
                      onOpenSupplements: () {
                        if (!isPro) {
                          openProAccessScreen(
                            context,
                            ref,
                            source: 'home_supplements',
                          );
                          return;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const SupplementReminderScreen(),
                          ),
                        );
                      },
                      onDismissed: () async {
                        try {
                          await ref
                              .read(profileServiceProvider)
                              .updateSettings({
                            'next_dose_reminder_dismissed': true,
                          });
                        } catch (_) {}
                        if (mounted) ref.invalidate(profileBootstrapProvider);
                      },
                      onSupplementDismissed: () async {
                        try {
                          await ref
                              .read(profileServiceProvider)
                              .updateSettings({
                            'supplement_reminders_dismissed': true,
                          });
                        } catch (_) {}
                        if (mounted) ref.invalidate(profileBootstrapProvider);
                      },
                      onOpenReminder: () {
                        final hasScheduledNextDose =
                            profile?.reminders.dose.items.isNotEmpty == true &&
                                profile!.reminders.dose.items.first.schedule
                                        .scheduledAt !=
                                    null;
                        if (!isPro) {
                          ref.read(analyticsServiceProvider).capture(
                            eventName: 'next_dose_reminder_opened',
                            properties: {
                              'source': 'home',
                              'has_scheduled_next_dose': hasScheduledNextDose,
                              'subscription_status': 'free',
                            },
                          );
                          openProAccessScreen(
                            context,
                            ref,
                            source: 'home_next_dose',
                          );
                          return;
                        }
                        ref.read(analyticsServiceProvider).capture(
                          eventName: 'next_dose_reminder_opened',
                          properties: {
                            'source': 'home',
                            'has_scheduled_next_dose': hasScheduledNextDose,
                            'subscription_status': 'pro',
                          },
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const DoseReminderScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                ],
                if (hasMedicationLevelLogs ||
                    medicationLevelLogs.isLoading) ...[
                  EstimatedMedicationLevelsCard(
                    doseLogs: medicationLevelLogs.asData?.value ??
                        const <Map<String, dynamic>>[],
                    isLoading: medicationLevelLogs.isLoading,
                  ),
                  const SizedBox(height: 22),
                ],
                _HomeShortcutsSection(
                  items: [
                    _ShortcutItem(
                      title: l10n.homePortionCheckTitle,
                      description: l10n.homePortionCheckBody,
                      icon: Icons.qr_code_scanner_rounded,
                      iconBuilder: (_) => const _ScanFrameMealIcon(
                        tint: Color(0xFF32BE88),
                      ),
                      tint: const Color(0xFF32BE88),
                      backgroundTopColor: const Color(0xFFEAF8EE),
                      backgroundBottomColor: const Color(0xFFDFF2E5),
                      onTap: _openPortionCheckShortcut,
                    ),
                    _ShortcutItem(
                      title: l10n.homeGlowUpTitle,
                      description: l10n.homeGlowUpBody,
                      icon: Icons.auto_awesome_rounded,
                      tint: const Color(0xFFEF8E3A),
                      onTap: _openGlowUpShortcut,
                      backgroundTopColor: const Color(0xFFFAECE2),
                      backgroundBottomColor: const Color(0xFFFAECE2),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                if (showGoalStatusCard) ...[
                  _HomeGoalsStatusCard(
                    title: l10n.homeGoalsStatusTitle,
                    actionLabel: l10n.homeGoalsStatusViewAll,
                    onActionTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const HabitGoalsScreen(),
                        ),
                      );
                    },
                    items: goalStatusItems,
                  ),
                  const SizedBox(height: 22),
                ],
                if (profile != null) ...[
                  BmiIndicator(
                    age: (profile.settings['age'] as num?)?.toInt(),
                    heightValue: profile.settings['height'],
                    weightValue: () {
                      final latest = stats?.latestWeight;
                      final quantity =
                          (latest?['quantity'] as num?)?.toDouble();
                      if (quantity != null) {
                        final unit =
                            (latest?['unit'] as String?) == 'lb' ? 'lb' : 'kg';
                        return {'primary': quantity, 'unit': unit};
                      }
                      return profile.settings['weight'];
                    }(),
                    targetWeightValue: goalWeight == null
                        ? null
                        : {
                            'primary': goalWeight.targetKg,
                            'unit': 'kg',
                          },
                  ),
                  const SizedBox(height: 22),
                ],
                // if (!_tracksSupplements)
                //   _SupplementsOptInCard(onEnable: _toggleSupplementsTracking),
                // if (_tracksSupplements)
                //   _SupplementsEnabledCard(onDisable: _toggleSupplementsTracking),
                const SizedBox(height: 18),
              ],
            ),
          );
        },
      ),
    );
  }

  _HomeMetricTileData _buildWaterTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
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

      return _HomeMetricTileData(
        title: l10n.homeWaterTitle,
        value: todayMl > 0 ? _formatWaterValue(todayMl) : '',
        caption: todayWaterEntries.isNotEmpty
            ? context.l10n
                .homePercentOfDailyGoal((completionProgress * 100).round())
            : l10n.homeStartHydration,
        icon: Icons.water_drop_rounded,
        tint: waterTint,
        progress: overallProgress,
        isDailyGoalReached: completionProgress >= 1,
        state: todayWaterEntries.isEmpty
            ? _TileState.empty
            : overallProgress >= 1
                ? _TileState.complete
                : _TileState.partial,
      );
    }

    final waterEntries = stats?.water ?? const <Map<String, dynamic>>[];
    final totalMl = waterEntries.fold<double>(
      0,
      (sum, entry) => sum + (((entry['quantity'] as num?) ?? 0).toDouble()),
    );
    final progress = (totalMl / 2000).clamp(0, 1).toDouble();

    return _HomeMetricTileData(
      title: l10n.homeWaterTitle,
      value: totalMl > 0 ? _formatWaterValue(totalMl) : '',
      caption: waterEntries.isNotEmpty ? '' : l10n.homeStartHydration,
      icon: Icons.water_drop_rounded,
      tint: waterTint,
      progress: progress,
      isDailyGoalReached: waterEntries.isNotEmpty,
      state: waterEntries.isEmpty ? _TileState.empty : _TileState.complete,
    );
  }

  _HomeMetricTileData _buildExerciseTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
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

      return _HomeMetricTileData(
        title: l10n.homeExerciseTitle,
        value: todayMinutes > 0 ? '${todayMinutes.round()} min' : '',
        caption: todayExerciseEntries.isEmpty
            ? l10n.homeLogFirstSession
            : context.l10n
                .homePercentOfDailyGoal((completionProgress * 100).round()),
        icon: Icons.directions_run_rounded,
        tint: const Color(0xFF6BCB81),
        progress: overallProgress,
        isDailyGoalReached: completionProgress >= 1,
        state: todayExerciseEntries.isEmpty
            ? _TileState.empty
            : overallProgress >= 1
                ? _TileState.complete
                : _TileState.partial,
      );
    }

    final exerciseEntries = stats?.exercise ?? const <Map<String, dynamic>>[];
    final totalMinutes = exerciseEntries.fold<int>(
      0,
      (sum, entry) =>
          sum + (((entry['duration_minutes'] as num?) ?? 0).toInt()),
    );
    final progress = (totalMinutes / 30).clamp(0, 1).toDouble();

    return _HomeMetricTileData(
      title: l10n.homeExerciseTitle,
      value: totalMinutes > 0 ? '${totalMinutes.round()} min' : '',
      caption: exerciseEntries.isEmpty ? l10n.homeLogFirstSession : '',
      icon: Icons.directions_run_rounded,
      tint: const Color(0xFF6BCB81),
      progress: progress,
      isDailyGoalReached: exerciseEntries.isNotEmpty,
      state: exerciseEntries.isEmpty ? _TileState.empty : _TileState.complete,
    );
  }

  _HomeMetricTileData _buildWeightTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
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

      return _HomeMetricTileData(
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
            ? _TileState.empty
            : absGap < _weightTolerance(unit)
                ? _TileState.complete
                : _TileState.partial,
      );
    } else {
      final todayWeightEntries =
          stats?.weight ?? const <Map<String, dynamic>>[];
      final latest =
          todayWeightEntries.isEmpty ? null : todayWeightEntries.last;
      final quantity = (latest?['quantity'] as num?)?.toDouble();
      final unit = _loggedWeightUnit(latest);
      return _HomeMetricTileData(
        title: l10n.homeWeightTitle,
        value: quantity == null ? '' : _formatLoggedWeight(quantity, unit),
        caption: todayWeightEntries.isEmpty ? l10n.homeLogTodayWeight : '',
        icon: Icons.monitor_weight_rounded,
        tint: const Color(0xFF6F8DBA),
        isDailyGoalReached: quantity != null,
        state:
            todayWeightEntries.isEmpty ? _TileState.empty : _TileState.complete,
      );
    }
  }

  _HomeMetricTileData _buildNutritionTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
    AppProfile? profile,
    AppLocalizations l10n,
  ) {
    final nutritionTiles =
        _buildNutritionTileStates(colors, stats, profile, l10n);
    if (nutritionTiles.isEmpty) {
      return _HomeMetricTileData(
        title: l10n.homeMealsTitle,
        value: '',
        caption: l10n.homeLogFirstMeal,
        icon: Icons.restaurant_menu_rounded,
        tint: const Color(0xFFFFAA5B),
        state: _TileState.empty,
      );
    }
    final activeIndex = _nutritionTileRotationIndex % nutritionTiles.length;
    final activeTile = nutritionTiles[activeIndex];
    return _HomeMetricTileData(
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

  List<_HomeMetricTileData> _buildNutritionTileStates(
    AppColors colors,
    _HomeStatsSnapshot? stats,
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

    final tiles = <_HomeMetricTileData>[];

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
        _HomeMetricTileData(
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
              : context.l10n
                  .homePercentOfDailyGoal((completionProgress * 100).round()),
          icon: isCalories
              ? Icons.local_fire_department_rounded
              : Icons.restaurant_menu_rounded,
          tint: const Color(0xFFFFAA5B),
          progress: overallProgress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: completionProgress > 1,
          state: todayMealEntries.isEmpty
              ? _TileState.empty
              : overallProgress >= 1
                  ? _TileState.complete
                  : _TileState.partial,
        ),
      );
    } else {
      final completionProgress = todayMealEntries.length / 3;
      final progress = completionProgress.clamp(0, 1).toDouble();
      tiles.add(
        _HomeMetricTileData(
          title: l10n.homeMealsTitle,
          value: todayMealEntries.isEmpty
              ? ''
              : '${todayMealEntries.length} logged',
          caption: todayMealEntries.isEmpty
              ? l10n.homeLogFirstMeal
              : context.l10n
                  .homePercentOfDailyGoal((completionProgress * 100).round()),
          icon: Icons.restaurant_menu_rounded,
          tint: const Color(0xFFFFAA5B),
          progress: progress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: completionProgress > 1,
          state: todayMealEntries.isEmpty
              ? _TileState.empty
              : progress >= 1
                  ? _TileState.complete
                  : _TileState.partial,
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
        _HomeMetricTileData(
          title: l10n.homeProteinsTitle,
          value: todayProtein > 0
              ? '${todayProtein.round()} g'
              : (hasMealsToday ? '0 g' : ''),
          caption: hasMealsToday
              ? context.l10n
                  .homePercentOfDailyGoal((completionProgress * 100).round())
              : l10n.homeTrackProteinFromMeals,
          icon: Icons.fitness_center_rounded,
          tint: colors.protein,
          progress: overallProgress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: hasMealsToday && completionProgress > 1,
          state: hasMealsToday
              ? (overallProgress >= 1
                  ? _TileState.complete
                  : _TileState.partial)
              : _TileState.empty,
        ),
      );
    }

    if (fiberGoal?.enabled == true && fiberGoalEntry != null) {
      final completionProgress = todayFiber / (fiberGoalEntry.targetGrams / 7);
      final overallProgress =
          (totalFiber / fiberGoalEntry.targetGrams).clamp(0, 1).toDouble();
      final hasMealsToday = todayMealEntries.isNotEmpty;
      tiles.add(
        _HomeMetricTileData(
          title: l10n.homeFibersTitle,
          value: todayFiber > 0
              ? '${todayFiber.round()} g'
              : (hasMealsToday ? '0 g' : ''),
          caption: hasMealsToday
              ? context.l10n
                  .homePercentOfDailyGoal((completionProgress * 100).round())
              : l10n.homeTrackFiberFromMeals,
          icon: Icons.eco_rounded,
          tint: colors.fiber,
          progress: overallProgress,
          isDailyGoalReached: completionProgress >= 1,
          isOverDailyGoal: hasMealsToday && completionProgress > 1,
          state: hasMealsToday
              ? (overallProgress >= 1
                  ? _TileState.complete
                  : _TileState.partial)
              : _TileState.empty,
        ),
      );
    }

    return tiles;
  }

  _HomeMetricTileData _buildSymptomsTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
    AppLocalizations l10n,
  ) {
    final symptomEntries = stats?.symptoms ?? const <Map<String, dynamic>>[];
    final totalSymptoms = symptomEntries.fold<int>(
      0,
      (sum, entry) => sum + ((entry['symptoms'] as List?)?.length ?? 0),
    );
    return _HomeMetricTileData(
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
      state: symptomEntries.isEmpty ? _TileState.empty : _TileState.complete,
    );
  }

  _HomeMetricTileData _buildMoodTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
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

    return _HomeMetricTileData(
      title: l10n.homeMoodTitle,
      value: value,
      caption: moodEntries.isEmpty
          ? l10n.homeLogHowYouFeel
          : '${moodEntries.length} check-in${moodEntries.length == 1 ? '' : 's'}',
      icon: Icons.mood_rounded,
      tint: const Color(0xFF7A74F5),
      isDailyGoalReached: moodEntries.isNotEmpty,
      state: moodEntries.isEmpty ? _TileState.empty : _TileState.complete,
    );
  }

  _HomeMetricTileData _buildDoseTile(
    AppColors colors,
    _HomeStatsSnapshot? stats,
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
      return _HomeMetricTileData(
        title: l10n.homeDoseTitle,
        value: '',
        caption: l10n.homeLogTodaysDose,
        icon: icon,
        tint: doseTint,
        state: _TileState.empty,
      );
    }

    final latest = doseEntries.last;
    final medication = (latest['medication'] as String?)?.trim();
    final dose = (latest['dose'] as String?)?.trim();
    final valueLabel = [
      if (medication != null && medication.isNotEmpty) medication,
      if (dose != null && dose.isNotEmpty) dose,
    ].join(' ');

    return _HomeMetricTileData(
      title: l10n.homeDoseTitle,
      value: valueLabel.isEmpty ? l10n.homeTaken : valueLabel,
      caption: '',
      icon: icon,
      tint: doseTint,
      isDailyGoalReached: true,
      state: _TileState.complete,
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
    return '${quantity.toStringAsFixed(0)} $unit';
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

  bool _hasLogsToday(_HomeStatsSnapshot? stats) {
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

  String todayInsightCardTitle(bool hasLogsToday, AppLocalizations l10n) {
    if (hasLogsToday) {
      return switch (_todayInsightVariantIndex) {
        0 => l10n.homeInsightMoreLogsVariant1Title,
        1 => l10n.homeInsightMoreLogsVariant2Title,
        _ => l10n.homeInsightMoreLogsVariant3Title,
      };
    }
    return l10n.homeInsightLogTodayTitle;
  }

  String todayInsightCardCopy(bool hasLogsToday, AppLocalizations l10n) {
    if (hasLogsToday) {
      return switch (_todayInsightVariantIndex) {
        0 => l10n.homeInsightMoreLogsVariant1Body,
        1 => l10n.homeInsightMoreLogsVariant2Body,
        _ => l10n.homeInsightMoreLogsVariant3Body,
      };
    }
    return l10n.homeInsightLogTodayBodyNoLogs;
  }

  bool _shouldShowDailyInsightCard() {
    return true;
  }
}

class _HomeStatsSnapshot {
  const _HomeStatsSnapshot({
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

class _StreakBadge extends StatelessWidget {
  const _StreakBadge({
    this.streakCount,
  });

  final int? streakCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final label = streakCount == null
        ? 'Streak'
        : streakCount == 1
            ? '1-day'
            : '${streakCount!}-day';

    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: colors.lineSubtle),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBFC8D7).withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            size: 16,
            color: Color(0xFFE07A2F),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

String _streakDayKey(DateTime value) {
  return DateFormat('yyyyMMdd').format(value.toLocal());
}

class TodayInsightCard extends ConsumerStatefulWidget {
  const TodayInsightCard({
    super.key,
    required this.hasLogsToday,
    required this.title,
    required this.copy,
    required this.insightCardMode,
    required this.isPro,
    this.analyticsSource = 'home',
    this.proAccessSource = 'home_daily_insight',
  });

  final bool hasLogsToday;
  final String title;
  final String copy;
  final String? insightCardMode;
  final bool isPro;
  final String analyticsSource;
  final String proAccessSource;

  @override
  ConsumerState<TodayInsightCard> createState() => _TodayInsightCardState();
}

class _TodayInsightCardState extends ConsumerState<TodayInsightCard>
    with SingleTickerProviderStateMixin {
  _TodayInsightCardLoadState _loadState = _TodayInsightCardLoadState.idle;
  String? _statusMessage;
  String? _summary;
  String? _errorMessage;
  String? _requestId;
  String? _feedbackValue;
  String? _feedbackReason;
  bool _isSavingFeedback = false;
  bool _isExpanded = false;
  bool _showReasonInput = false;
  bool _showFeedbackAcknowledgement = false;
  Timer? _feedbackAcknowledgementTimer;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void didUpdateWidget(covariant TodayInsightCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasLogsToday == widget.hasLogsToday) {
      if (oldWidget.isPro == widget.isPro || widget.isPro) {
        return;
      }
    }
    if (!widget.hasLogsToday) {
      _resetState();
      return;
    }
    if (!widget.isPro) {
      _resetState();
    }
  }

  void _resetState() {
    _loadState = _TodayInsightCardLoadState.idle;
    _statusMessage = null;
    _summary = null;
    _errorMessage = null;
    _requestId = null;
    _feedbackValue = null;
    _feedbackReason = null;
    _isSavingFeedback = false;
    _isExpanded = false;
    _showReasonInput = false;
    _showFeedbackAcknowledgement = false;
    _feedbackAcknowledgementTimer?.cancel();
    _feedbackAcknowledgementTimer = null;
    _reasonController.clear();
  }

  Future<void> _handleTap() async {
    final isArrowInteractive =
        switch (widget.insightCardMode?.trim().toLowerCase()) {
      'on' => true,
      'off' => false,
      'auto' => DateTime.now().hour >= 19,
      _ => DateTime.now().hour >= 19,
    };
    if (!isArrowInteractive) {
      return;
    }

    if (!widget.isPro) {
      unawaited(
        openProAccessScreen(
          context,
          ref,
          source: widget.proAccessSource,
        ),
      );
      return;
    }

    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
      });
      return;
    }

    setState(() {
      _isExpanded = true;
    });

    if (_loadState == _TodayInsightCardLoadState.idle ||
        (_loadState == _TodayInsightCardLoadState.error && _summary == null)) {
      await _loadInsight();
    }
  }

  Future<void> _loadInsight() async {
    if (!widget.isPro) {
      return;
    }
    if (_loadState == _TodayInsightCardLoadState.loading) {
      return;
    }
    if (_loadState == _TodayInsightCardLoadState.ready &&
        _summary != null &&
        _summary!.trim().isNotEmpty) {
      return;
    }

    setState(() {
      _loadState = _TodayInsightCardLoadState.loading;
      _statusMessage = context.l10n.homeInsightChecking;
      _errorMessage = null;
    });

    ref.read(analyticsServiceProvider).capture(
      eventName: '${widget.analyticsSource}_insight_card_opened',
      properties: {
        'source': widget.analyticsSource,
        'has_logs_today': true,
      },
    );

    try {
      final result =
          await ref.read(generateInsightsServiceProvider).loadTodayInsight(
                currentTimestamp: DateTime.now(),
                onStatusChanged: (status) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    _statusMessage = status;
                  });
                },
              );
      if (!mounted) {
        return;
      }
      setState(() {
        _loadState = _TodayInsightCardLoadState.ready;
        _requestId = result.requestId;
        _summary = result.summary;
        _feedbackValue = result.feedbackValue;
        _feedbackReason = result.feedbackReason;
        _showReasonInput = result.feedbackValue == 'negative' &&
            (result.feedbackReason == null ||
                result.feedbackReason!.trim().isEmpty);
        if (!_showReasonInput) {
          _reasonController.clear();
        }
        _statusMessage = null;
        _errorMessage = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loadState = _TodayInsightCardLoadState.error;
        _errorMessage = _friendlyErrorMessage(error);
        _statusMessage = null;
      });
    }
  }

  String _friendlyErrorMessage(Object error) {
    final message = error is Exception ? error.toString() : '$error';
    return message.replaceFirst('Exception: ', '').trim();
  }

  void _openAllInsights() {
    ref.read(analyticsServiceProvider).capture(
      eventName: '${widget.analyticsSource}_all_insights_opened',
      properties: {
        'source': widget.analyticsSource,
      },
    );
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const InsightsProgressScreen(),
      ),
    );
  }

  Future<void> _saveFeedback(String value) async {
    final requestId = _requestId;
    if (requestId == null ||
        requestId.trim().isEmpty ||
        _feedbackValue != null ||
        _isSavingFeedback) {
      return;
    }

    setState(() {
      _isSavingFeedback = true;
    });

    try {
      await ref.read(aiRequestServiceProvider).saveFeedback(requestId, value);
      if (!mounted) return;
      setState(() {
        _feedbackValue = value;
        _feedbackReason = null;
        _showReasonInput = value == 'negative';
        _isSavingFeedback = false;
      });
      if (value == 'positive') {
        _showAcknowledgement(value);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSavingFeedback = false;
      });
    }
  }

  Future<void> _submitFeedbackReason() async {
    final requestId = _requestId;
    if (requestId == null ||
        requestId.trim().isEmpty ||
        !_showReasonInput ||
        _isSavingFeedback) {
      return;
    }

    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      setState(() {
        _showReasonInput = false;
      });
      _showAcknowledgement('negative');
      return;
    }

    setState(() {
      _isSavingFeedback = true;
    });

    try {
      await ref
          .read(aiRequestServiceProvider)
          .saveFeedback(requestId, 'negative', reason: reason);
      if (!mounted) return;
      setState(() {
        _feedbackValue = 'negative';
        _feedbackReason = reason;
        _showReasonInput = false;
        _isSavingFeedback = false;
        _reasonController.clear();
      });
      _showAcknowledgement('negative');
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSavingFeedback = false;
      });
    }
  }

  void _showAcknowledgement(String value) {
    _feedbackAcknowledgementTimer?.cancel();
    setState(() {
      _showFeedbackAcknowledgement = true;
    });
    _feedbackAcknowledgementTimer =
        Timer(const Duration(milliseconds: 1700), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _showFeedbackAcknowledgement = false;
      });
    });
  }

  @override
  void dispose() {
    _feedbackAcknowledgementTimer?.cancel();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final highlight = const Color(0xFF7A63DB);
    final bodyColor = const Color(0xFF5F7190);
    final l10n = context.l10n;
    final isLoading = _loadState == _TodayInsightCardLoadState.loading;
    final hasSummary = _summary != null && _summary!.trim().isNotEmpty;
    final showArrow = widget.hasLogsToday;
    final iconChipBackground = Colors.white.withValues(alpha: 0.92);
    final isArrowInteractive = widget.hasLogsToday &&
        switch (widget.insightCardMode?.trim().toLowerCase()) {
          'on' => true,
          'off' => false,
          'auto' => DateTime.now().hour >= 19,
          _ => DateTime.now().hour >= 19,
        };
    final headerTitle =
        _isExpanded ? l10n.homeInsightExpandedTitle : widget.title;
    final headerCopy = _isExpanded ? l10n.homeInsightExpandedBody : widget.copy;
    final showFeedbackPrompt =
        _showReasonInput && _feedbackValue == 'negative' && !_isSavingFeedback;
    final showFeedbackAcknowledgement =
        _showFeedbackAcknowledgement && _feedbackValue != null;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5EFFF),
              Color(0xFFF7F3FF),
              Color(0xFFE9E0FF),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withValues(alpha: 0.72)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: isArrowInteractive ? _handleTap : null,
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: iconChipBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.lightbulb_rounded,
                          size: 24,
                          color: highlight,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              headerTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF20324A),
                                fontWeight: FontWeight.w800,
                                fontSize: 15.5,
                                height: 1.08,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              headerCopy,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: bodyColor,
                                fontSize: 12.5,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (showArrow) ...[
                        const SizedBox(width: 10),
                        AnimatedRotation(
                          turns: _isExpanded ? 0.25 : 0.0,
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isArrowInteractive
                                  ? highlight.withValues(alpha: 0.88)
                                  : highlight.withValues(alpha: 0.26),
                            ),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 16,
                              color: isArrowInteractive
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 460),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: _isExpanded
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: _buildExpandedBody(
                            context: context,
                            colors: colors,
                            highlight: highlight,
                            l10n: l10n,
                            isLoading: isLoading,
                            hasSummary: hasSummary,
                            showFeedbackPrompt: showFeedbackPrompt,
                            showFeedbackAcknowledgement:
                                showFeedbackAcknowledgement,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedBody({
    required BuildContext context,
    required AppColors colors,
    required Color highlight,
    required AppLocalizations l10n,
    required bool isLoading,
    required bool hasSummary,
    required bool showFeedbackPrompt,
    required bool showFeedbackAcknowledgement,
  }) {
    if (isLoading) {
      return _InsightStatusRow(
        message: _statusMessage ?? l10n.homeInsightGenerating,
      );
    }
    if (_loadState == _TodayInsightCardLoadState.error &&
        _errorMessage != null) {
      return _InsightErrorRow(
        message: _errorMessage!,
        onRetry: _loadInsight,
      );
    }
    if (hasSummary) {
      return _InsightSummaryCard(
        summary: _summary!,
        accent: highlight,
        colors: colors,
        onSeeAllInsights: _openAllInsights,
        feedbackValue: _feedbackValue,
        feedbackReason: _feedbackReason,
        showFeedbackActions: _feedbackValue == null && !_isSavingFeedback,
        showFeedbackPrompt: showFeedbackPrompt,
        showFeedbackAcknowledgement: showFeedbackAcknowledgement,
        reasonController: _reasonController,
        onSubmitReason: _submitFeedbackReason,
        onThumbsDown: () => _saveFeedback('negative'),
        onThumbsUp: () => _saveFeedback('positive'),
      );
    }
    return const SizedBox.shrink();
  }
}

class _InsightStatusRow extends StatelessWidget {
  const _InsightStatusRow({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      children: [
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _InsightErrorRow extends StatelessWidget {
  const _InsightErrorRow({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: onRetry,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF6146B8),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(l10n.homeInsightTryAgain),
        ),
      ],
    );
  }
}

class _InsightSummaryCard extends StatelessWidget {
  const _InsightSummaryCard({
    required this.summary,
    required this.accent,
    required this.colors,
    required this.onSeeAllInsights,
    required this.feedbackValue,
    required this.feedbackReason,
    required this.showFeedbackActions,
    required this.showFeedbackPrompt,
    required this.showFeedbackAcknowledgement,
    required this.reasonController,
    required this.onSubmitReason,
    required this.onThumbsDown,
    required this.onThumbsUp,
  });

  final String summary;
  final Color accent;
  final AppColors colors;
  final VoidCallback onSeeAllInsights;
  final String? feedbackValue;
  final String? feedbackReason;
  final bool showFeedbackActions;
  final bool showFeedbackPrompt;
  final bool showFeedbackAcknowledgement;
  final TextEditingController reasonController;
  final VoidCallback onSubmitReason;
  final VoidCallback onThumbsDown;
  final VoidCallback onThumbsUp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final markdownTheme = MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: theme.textTheme.bodySmall?.copyWith(
        color: colors.textPrimary,
        fontSize: 12.5,
        height: 1.35,
      ),
      strong: theme.textTheme.bodySmall?.copyWith(
        color: colors.textPrimary,
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        height: 1.35,
      ),
      em: theme.textTheme.bodySmall?.copyWith(
        color: colors.textPrimary,
        fontSize: 12.5,
        fontStyle: FontStyle.italic,
        height: 1.35,
      ),
      listBullet: theme.textTheme.bodySmall?.copyWith(
        color: colors.textPrimary,
        fontSize: 12.5,
        height: 1.35,
      ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: summary,
            styleSheet: markdownTheme,
            selectable: false,
            shrinkWrap: true,
            softLineBreak: true,
            fitContent: true,
            onTapLink: (_, __, ___) {},
          ),
          const SizedBox(height: 10),
          if (showFeedbackActions) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkResponse(
                  onTap: onThumbsDown,
                  radius: 18,
                  child: Icon(
                    feedbackValue == 'negative'
                        ? Icons.thumb_down_alt
                        : Icons.thumb_down_alt_outlined,
                    size: 18,
                    color: feedbackValue == 'negative'
                        ? accent
                        : accent.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(width: 10),
                InkResponse(
                  onTap: onThumbsUp,
                  radius: 18,
                  child: Icon(
                    feedbackValue == 'positive'
                        ? Icons.thumb_up_alt
                        : Icons.thumb_up_alt_outlined,
                    size: 18,
                    color: feedbackValue == 'positive'
                        ? accent
                        : accent.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 520),
            reverseDuration: const Duration(milliseconds: 360),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              final offset = Tween<Offset>(
                begin: const Offset(0, -0.12),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: offset,
                  child: child,
                ),
              );
            },
            child: showFeedbackPrompt
                ? Column(
                    key: const ValueKey('feedback-prompt'),
                    children: [
                      TextField(
                        controller: reasonController,
                        autofocus: true,
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: l10n.homeInsightReasonHint,
                          isDense: true,
                          filled: true,
                          fillColor: colors.canvas,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: accent.withValues(alpha: 0.16),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: accent.withValues(alpha: 0.35),
                            ),
                          ),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textPrimary,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: onSubmitReason,
                          style: TextButton.styleFrom(
                            foregroundColor: accent,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(l10n.homeInsightReasonSubmit),
                        ),
                      ),
                    ],
                  )
                : showFeedbackAcknowledgement
                    ? _FeedbackAcknowledgementChip(
                        key: const ValueKey('feedback-ack'),
                        accent: accent,
                        colors: colors,
                        message: l10n.homeInsightLearningMessage,
                        isPositive: feedbackValue == 'positive',
                      )
                    : const SizedBox.shrink(key: ValueKey('feedback-empty')),
          ),
          if (showFeedbackPrompt || showFeedbackAcknowledgement) ...[
            const SizedBox(height: 10),
          ],
          Divider(
            height: 1,
            thickness: 1,
            color: accent.withValues(alpha: 0.14),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: onSeeAllInsights,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.homeSeeAllInsights,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: accent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackAcknowledgementChip extends StatelessWidget {
  const _FeedbackAcknowledgementChip({
    super.key,
    required this.accent,
    required this.colors,
    required this.message,
    required this.isPositive,
  });

  final Color accent;
  final AppColors colors;
  final String message;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final icon =
        isPositive ? Icons.thumb_up_alt_rounded : Icons.auto_awesome_rounded;
    final iconColor = isPositive ? accent : accent.withValues(alpha: 0.92);
    final scaleAnimation = TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: isPositive ? 0.88 : 0.94, end: 1),
      duration: Duration(milliseconds: isPositive ? 520 : 360),
      curve: isPositive ? Curves.easeOutBack : Curves.easeOutCubic,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colors.canvas.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withValues(alpha: 0.14)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );

    return scaleAnimation;
  }
}

enum _TodayInsightCardLoadState {
  idle,
  loading,
  ready,
  error,
}

DateTime _startOfWeek(DateTime date) {
  final normalized = DateUtils.dateOnly(date);
  return normalized.subtract(
    Duration(days: normalized.weekday - DateTime.monday),
  );
}

class _NextDoseHero extends StatefulWidget {
  const _NextDoseHero({
    required this.profile,
    required this.isPro,
    required this.showDosePage,
    required this.showSupplementPage,
    required this.onOpenReminder,
    required this.onOpenSupplements,
    required this.onDismissed,
    required this.onSupplementDismissed,
  });

  final AppProfile? profile;
  final bool isPro;
  final bool showDosePage;
  final bool showSupplementPage;
  final VoidCallback onOpenReminder;
  final VoidCallback onOpenSupplements;
  final VoidCallback onDismissed;
  final VoidCallback onSupplementDismissed;

  @override
  State<_NextDoseHero> createState() => _NextDoseHeroState();
}

class _NextDoseHeroState extends State<_NextDoseHero> {
  bool _dismissing = false;
  late final PageController _pageController;
  int _currentPage = 0;
  int _autoSwipeVersion = 0;
  int _pageCount = 2;

  static const _autoSwipeInterval = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scheduleAutoSwipe();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _NextDoseHero oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _scheduleAutoSwipe() {
    final version = ++_autoSwipeVersion;
    Future<void>.delayed(_autoSwipeInterval, () {
      if (!mounted || version != _autoSwipeVersion) return;
      final next = (_currentPage + 1) % _pageCount;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _scheduleAutoSwipe();
    });
  }

  Future<void> _handleNotNow() async {
    if (_dismissing) return;
    HapticFeedback.selectionClick();
    setState(() => _dismissing = true);
    await Future<void>.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    widget.onDismissed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final settings = widget.profile?.settings ?? const <String, dynamic>{};
    final nextDoseReminder =
        widget.profile?.reminders.dose.items.isNotEmpty == true
            ? widget.profile!.reminders.dose.items.first
            : null;
    final reminderMetadata =
        nextDoseReminder?.metadata ?? const <String, dynamic>{};

    final format =
        (reminderMetadata['format'] as String?)?.trim().isNotEmpty == true
            ? (reminderMetadata['format'] as String).trim()
            : ((settings['medication_method'] as String?)?.trim() ?? 'dose');
    final medication =
        (reminderMetadata['medication'] as String?)?.trim().isNotEmpty == true
            ? (reminderMetadata['medication'] as String).trim()
            : ((settings['medication_name'] as String?)?.trim().isNotEmpty ==
                    true
                ? (settings['medication_name'] as String).trim()
                : null);
    final dose =
        (reminderMetadata['dose'] as String?)?.trim().isNotEmpty == true
            ? (reminderMetadata['dose'] as String).trim()
            : ((MedicationCatalog.coerceDoseValue(
                      settings['current_dose_mg'],
                    )) !=
                    null
                ? MedicationCatalog.formatDoseLabel(
                    MedicationCatalog.coerceDoseValue(
                      settings['current_dose_mg'],
                    )!,
                  )
                : null);
    final injectionSite = format == 'injection'
        ? reminderMetadata['injection_site'] as String?
        : null;
    final frequencyLabel = _frequencyLabel(settings);
    final scheduledAt =
        _parseScheduledAt(nextDoseReminder?.schedule.scheduledAt);
    final relativeLabel = _relativeDoseLabel(scheduledAt, context.l10n);
    final scheduledLabel = _scheduledDoseLabel(scheduledAt);
    final siteLabel = injectionSite == null
        ? null
        : InjectionSiteCatalog.labelFor(context, injectionSite);
    final formatIcon =
        format == 'pill' ? Icons.medication_outlined : Icons.vaccines_outlined;

    final scheduleMissing = scheduledAt == null;

    final showSupplementPage = widget.showSupplementPage;
    final pageCount =
        (widget.showDosePage ? 1 : 0) + (showSupplementPage ? 1 : 0);
    _pageCount = pageCount;

    // Clamp current page if a page was removed
    if (_currentPage >= pageCount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _currentPage = pageCount - 1);
        _pageController.jumpToPage(pageCount - 1);
      });
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xD9FFFFFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() {
                _currentPage = i;
                _scheduleAutoSwipe(); // reset timer after manual swipe
              }),
              children: [
                // Dose page (conditional)
                if (widget.showDosePage)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.l10n.homeDoseReminderTitle,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: widget.onOpenReminder,
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: colors.surface.withValues(alpha: 0.7),
                                shape: BoxShape.circle,
                                border: Border.all(color: colors.lineSubtle),
                              ),
                              child: Icon(
                                Icons.notifications_outlined,
                                size: 16,
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (scheduleMissing) ...[
                        Text(
                          context.l10n.homePickNextDoseDate,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (!_dismissing) ...[
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _handleNotNow,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    textStyle: theme.textTheme.labelMedium,
                                  ),
                                  child: Text(context.l10n.commonNotNow),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: FilledButton(
                                  onPressed: widget.onOpenReminder,
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    textStyle: theme.textTheme.labelMedium,
                                  ),
                                  child: Text(context.l10n.homeSetReminder),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ] else ...[
                        const SizedBox(height: 2),
                        Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 290),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (relativeLabel != null)
                                        Text(
                                          relativeLabel,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            color: colors.textSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      Text(
                                        scheduledLabel,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                          height: 1.05,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 1,
                                  height: 72,
                                  color:
                                      colors.lineSubtle.withValues(alpha: 0.8),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (frequencyLabel != null)
                                        _HeroInlineMeta(
                                          icon: Icons.event_repeat_outlined,
                                          label: frequencyLabel,
                                        ),
                                      if (medication != null ||
                                          dose != null) ...[
                                        if (frequencyLabel != null)
                                          const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(
                                              formatIcon,
                                              size: 14,
                                              color: colors.textSecondary,
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                [
                                                  if (medication != null)
                                                    medication,
                                                  if (dose != null) dose,
                                                ].join(' '),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary
                                                      .withValues(alpha: 0.9),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                      if (siteLabel != null) ...[
                                        if (frequencyLabel != null ||
                                            medication != null ||
                                            dose != null)
                                          const SizedBox(height: 10),
                                        _HeroInlineMeta(
                                          icon: Icons.gps_fixed,
                                          label: siteLabel,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                // Page 2: Supplement reminders (conditional)
                if (showSupplementPage)
                  _SupplementsCarouselPage(
                    profile: widget.profile,
                    onSetUp: widget.onOpenSupplements,
                    onDismissed: widget.onSupplementDismissed,
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < pageCount; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                _CarouselDot(active: _currentPage == i),
              ],
            ],
          ),
          const SizedBox(height: 8),
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  static DateTime? _parseScheduledAt(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    return DateTime.tryParse(raw)?.toLocal();
  }

  static String? _frequencyLabel(Map<String, dynamic> settings) {
    final frequency = settings['medication_frequency'] as String?;
    final days = settings['medication_frequency_days_between_doses'] as int?;
    return switch (frequency) {
      'daily' => 'Every day',
      'weekly' => 'Every week',
      'biweekly' => 'Every 2 weeks',
      'monthly' => 'Every month',
      'custom' when days != null && days > 0 => 'Every $days days',
      _ => null,
    };
  }

  static String? _relativeDoseLabel(
    DateTime? scheduledAt,
    AppLocalizations l10n,
  ) {
    if (scheduledAt == null) return null;
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final scheduledDay = DateUtils.dateOnly(scheduledAt);
    final deltaDays = scheduledDay.difference(today).inDays;

    if (deltaDays == 0) return l10n.commonToday;
    if (deltaDays == 1) return l10n.commonTomorrow;
    if (deltaDays == -1) return l10n.homeDoseReminderDueOneDayAgo;
    if (deltaDays < -1 && deltaDays >= -6) {
      return l10n.homeDoseReminderDueDaysAgo(deltaDays.abs());
    }
    if (deltaDays > 1 && deltaDays <= 6) {
      return l10n.homeDoseReminderInDays(deltaDays);
    }
    if (deltaDays > 6) {
      final weeks = (deltaDays / 7).floor();
      if (weeks >= 1) {
        return weeks == 1
            ? l10n.homeDoseReminderInOneWeek
            : l10n.homeDoseReminderInWeeks(weeks);
      }
      return DateFormat('EEE').format(scheduledAt);
    }
    if (deltaDays <= -7) {
      final weeks = (deltaDays.abs() / 7).floor();
      if (weeks >= 1) {
        return weeks == 1
            ? l10n.homeDoseReminderDueOneWeekAgo
            : l10n.homeDoseReminderDueWeeksAgo(weeks);
      }
    }
    return null;
  }

  static String _scheduledDoseLabel(DateTime? scheduledAt) {
    if (scheduledAt == null) return 'Schedule not set';
    final formatted = DateFormat('EEE, MMM d').format(scheduledAt);
    return formatted;
  }
}

// ---------------------------------------------------------------------------
// Supplements carousel page
// ---------------------------------------------------------------------------

class _SupplementsCarouselPage extends StatelessWidget {
  const _SupplementsCarouselPage({
    required this.profile,
    required this.onSetUp,
    required this.onDismissed,
  });

  final AppProfile? profile;
  final VoidCallback onSetUp;
  final VoidCallback onDismissed;

  static const _maxUpcomingRows = 3;

  List<Map<String, dynamic>> _reminders() {
    return profile?.reminders.supplement.toSupplementReminderJsonList() ??
        const <Map<String, dynamic>>[];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final reminders = _reminders();

    if (reminders.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width header row — matches dose card empty state
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.homeSupplementReminders,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: onSetUp,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.lineSubtle),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 16,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.homeSetUpYourSupplements,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDismissed,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: theme.textTheme.labelMedium,
                  ),
                  child: Text(context.l10n.commonNotNow),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: onSetUp,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: theme.textTheme.labelMedium,
                  ),
                  child: Text(context.l10n.homeSetUp),
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Compute next occurrence for each reminder and sort
    final now = DateTime.now();
    final withNext = reminders
        .map((r) => (r, nextSupplementOccurrence(r, from: now)))
        .where((pair) => pair.$2 != null)
        .toList()
      ..sort((a, b) => a.$2!.compareTo(b.$2!));

    if (withNext.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.homeSupplementReminders,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.homeNoUpcomingSupplements,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      );
    }

    final (nextReminder, nextOccurrence) = withNext.first;
    final nextName = (nextReminder['name'] as String?)?.trim() ??
        context.l10n.homeSupplementFallback;
    final relativeLabel =
        supplementRelativeLabelLocalized(nextOccurrence!, context.l10n);
    final dateLabel = DateFormat('EEE, MMM d').format(nextOccurrence);

    final upcomingRest = withNext.skip(1).toList();
    final showSeeMore = upcomingRest.length > _maxUpcomingRows;
    final upcomingSlice = upcomingRest.take(_maxUpcomingRows).toList();

    // Mirror dose card structure: full-width header row, then left/right split
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full-width header (label + icon) — matches dose card
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.homeSupplementReminders,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            InkWell(
              onTap: onSetUp,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.lineSubtle),
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  size: 16,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Left / right split — fixed layout, no Expanded (mirrors dose card)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: next supplement
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 92),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Small relative label (like "In 1 week" on dose)
                  Text(
                    relativeLabel,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Large bold date (like "Mon, Apr 27" on dose)
                  Text(
                    dateLabel,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.05,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Supplement name small below
                  Text(
                    nextName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Vertical divider — fixed height matching dose card
            Container(
              width: 1,
              height: 72,
              color: colors.lineSubtle.withValues(alpha: 0.8),
            ),
            const SizedBox(width: 16),
            // Right: upcoming list
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (upcomingSlice.isEmpty)
                    Text(
                      context.l10n.homeNoMoreUpcomingSupplements,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    )
                  else
                    for (final (rem, occ) in upcomingSlice) ...[
                      _UpcomingSupplementRow(
                        name: (rem['name'] as String?)?.trim() ?? 'Supplement',
                        date: DateFormat('EEE, MMM d').format(occ!),
                      ),
                      if ((rem, occ) != upcomingSlice.last)
                        const SizedBox(height: 4),
                    ],
                  if (showSeeMore) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: onSetUp,
                      child: Text(
                        'See more',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UpcomingSupplementRow extends StatelessWidget {
  const _UpcomingSupplementRow({required this.name, required this.date});
  final String name;
  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    return Row(
      children: [
        Icon(
          Icons.medication_liquid_outlined,
          size: 14,
          color: colors.textSecondary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            name,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            date,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _CarouselDot extends StatelessWidget {
  const _CarouselDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: active ? 16 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? colors.textSecondary : colors.lineSubtle,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _HeroInlineMeta extends StatelessWidget {
  const _HeroInlineMeta({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: colors.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.textSecondary.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _ShortcutItem {
  const _ShortcutItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.tint,
    required this.onTap,
    this.iconBuilder,
    this.backgroundTopColor = const Color(0xFFEDF5F6),
    this.backgroundBottomColor = const Color(0xFFBFDDDE),
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget Function(BuildContext context)? iconBuilder;
  final Color tint;
  final VoidCallback onTap;
  final Color backgroundTopColor;
  final Color backgroundBottomColor;
}

class _ScanFrameMealIcon extends StatelessWidget {
  const _ScanFrameMealIcon({
    required this.tint,
  });

  final Color tint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 23,
      height: 23,
      child: CustomPaint(
        painter: _ScanFramePainter(color: tint),
        child: Center(
          child: Icon(
            Icons.restaurant_rounded,
            size: 10.5,
            color: tint,
          ),
        ),
      ),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  const _ScanFramePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const segment = 4.5;
    const radius = 1.8;
    final rect = Rect.fromLTWH(0.75, 0.75, size.width - 1.5, size.height - 1.5);
    final topLeft = Path()
      ..moveTo(rect.left, rect.top + segment)
      ..lineTo(rect.left, rect.top + radius)
      ..quadraticBezierTo(
        rect.left,
        rect.top,
        rect.left + radius,
        rect.top,
      )
      ..lineTo(rect.left + segment, rect.top);
    final topRight = Path()
      ..moveTo(rect.right - segment, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..quadraticBezierTo(
        rect.right,
        rect.top,
        rect.right,
        rect.top + radius,
      )
      ..lineTo(rect.right, rect.top + segment);
    final bottomLeft = Path()
      ..moveTo(rect.left, rect.bottom - segment)
      ..lineTo(rect.left, rect.bottom - radius)
      ..quadraticBezierTo(
        rect.left,
        rect.bottom,
        rect.left + radius,
        rect.bottom,
      )
      ..lineTo(rect.left + segment, rect.bottom);
    final bottomRight = Path()
      ..moveTo(rect.right - segment, rect.bottom)
      ..lineTo(rect.right - radius, rect.bottom)
      ..quadraticBezierTo(
        rect.right,
        rect.bottom,
        rect.right,
        rect.bottom - radius,
      )
      ..lineTo(rect.right, rect.bottom - segment);

    canvas.drawPath(topLeft, paint);
    canvas.drawPath(topRight, paint);
    canvas.drawPath(bottomLeft, paint);
    canvas.drawPath(bottomRight, paint);
  }

  @override
  bool shouldRepaint(covariant _ScanFramePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _HomeGoalsStatusCard extends StatelessWidget {
  const _HomeGoalsStatusCard({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
    required this.items,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;
  final List<_HomeGoalStatusItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.lineSubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF20324A),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        height: 1,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onActionTap,
                    borderRadius: BorderRadius.circular(999),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Text(
                        actionLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: colors.textSecondary.withValues(alpha: 0.85),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < items.length; i++) ...[
                _HomeGoalStatusRow(item: items[i]),
                if (i < items.length - 1) const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeGoalStatusRow extends StatelessWidget {
  const _HomeGoalStatusRow({required this.item});

  final _HomeGoalStatusItem item;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final rowColor = item.isEnabled
        ? const Color(0xFF20324A)
        : colors.textSecondary.withValues(alpha: 0.7);
    final trackColor = item.isEnabled
        ? item.progressColor.withValues(alpha: 0.14)
        : colors.lineSubtle.withValues(alpha: 0.55);
    final fillColor = item.isEnabled ? item.progressColor : colors.lineSubtle;

    return Opacity(
      opacity: item.isEnabled ? 1 : 0.55,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: item.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 11,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: rowColor,
                fontWeight: FontWeight.w400,
                fontSize: 13,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: item.progress,
                minHeight: 7,
                backgroundColor: trackColor,
                valueColor: AlwaysStoppedAnimation<Color>(fillColor),
              ),
            ),
          ),
          const SizedBox(width: 14),
          SizedBox(
            width: 46,
            child: Text(
              item.statusLabel,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                color: rowColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeGoalStatusItem {
  const _HomeGoalStatusItem({
    required this.label,
    required this.progress,
    required this.icon,
    required this.tint,
    required this.iconBackgroundColor,
    required this.progressColor,
    required this.isEnabled,
    required this.statusLabel,
  });

  final String label;
  final double progress;
  final IconData icon;
  final Color tint;
  final Color iconBackgroundColor;
  final Color progressColor;
  final bool isEnabled;
  final String statusLabel;
}

class _HomeShortcutsSection extends StatelessWidget {
  const _HomeShortcutsSection({
    required this.items,
  });

  final List<_ShortcutItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final item in items)
              SizedBox(
                width: (MediaQuery.sizeOf(context).width - 52) / 2,
                child: _ShortcutCard(item: item),
              ),
          ],
        ),
      ],
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({
    required this.item,
  });

  final _ShortcutItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyColor = const Color(0xFF6B7F97);
    final iconChipBackground = Color.lerp(
      item.tint,
      Colors.white,
      0.78,
    )!;
    final arrowBorderColor = item.tint.withValues(alpha: 0.22);
    final arrowBackgroundColor = Colors.white.withValues(alpha: 0.92);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.backgroundTopColor,
                item.backgroundBottomColor,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: iconChipBackground,
                          shape: BoxShape.circle,
                        ),
                        child: item.iconBuilder != null
                            ? Center(
                                child: item.iconBuilder!(context),
                              )
                            : Icon(
                                item.icon,
                                size: 18,
                                color: item.tint,
                              ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF20324A),
                            fontSize: 15,
                            height: 1.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: bodyColor,
                            fontSize: 12.5,
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: arrowBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: arrowBorderColor),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: item.tint,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DailyTrackingSection extends StatefulWidget {
  const _DailyTrackingSection({
    required this.tiles,
    required this.onTileTap,
    required this.sectionTitle,
    required this.sectionSubtitle,
    required this.showcaseTitle,
    required this.showcaseDescription,
    this.emptyTileShowcaseKey,
    this.showcaseTileTitle,
  });

  final List<_HomeMetricTileData> tiles;
  final ValueChanged<_HomeMetricTileData> onTileTap;
  final String sectionTitle;
  final String sectionSubtitle;
  final String showcaseTitle;
  final String showcaseDescription;
  final GlobalKey? emptyTileShowcaseKey;
  final String? showcaseTileTitle;

  @override
  State<_DailyTrackingSection> createState() => _DailyTrackingSectionState();
}

class _DailyTrackingSectionState extends State<_DailyTrackingSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 22000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Returns progress + opacity for the tile at [index], or null if the
  // particle is fully outside this tile's window (including fade zones).
  ({double progress, double opacity})? _particleData(int index) {
    if (widget.tiles[index].state != _TileState.empty) return null;

    final emptyIndices = [
      for (var i = 0; i < widget.tiles.length; i++)
        if (widget.tiles[i].state == _TileState.empty) i,
    ];
    if (emptyIndices.isEmpty) return null;

    final slot = emptyIndices.indexOf(index);
    final slotSize = 1.0 / emptyIndices.length;
    final slotStart = slot * slotSize;
    final slotEnd = slotStart + slotSize;
    final v = _controller.value;

    // Each tile fades over 10% of its own slot at both ends.
    final fade = slotSize * 0.10;
    final windowStart = slotStart - fade;
    final windowEnd = slotEnd + fade;

    if (v < windowStart || v >= windowEnd) return null;

    final opacity = v < slotStart
        ? (v - windowStart) / fade // fading in
        : v >= slotEnd
            ? 1.0 - (v - slotEnd) / fade // fading out
            : 1.0;

    final progress = ((v - slotStart) / slotSize).clamp(0.0, 1.0);
    return (progress: progress, opacity: opacity.clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: widget.sectionTitle,
          subtitle: widget.sectionSubtitle,
        ),
        const SizedBox(height: 14),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _buildTileGridChildren(context),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildTileGridChildren(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final gridWidth = MediaQuery.sizeOf(context).width - 40;
    final halfWidth = (gridWidth - 12) / 2;
    final isOdd = widget.tiles.length.isOdd;

    return [
      for (var index = 0; index < widget.tiles.length; index++)
        SizedBox(
          width:
              isOdd && index == widget.tiles.length - 1 ? gridWidth : halfWidth,
          height: 160,
          child: _buildShowcasedTile(
            context,
            index,
            theme,
            colors,
            isOdd,
          ),
        ),
    ];
  }

  Widget _buildShowcasedTile(
    BuildContext context,
    int index,
    ThemeData theme,
    AppColors colors,
    bool isOdd,
  ) {
    final tile = widget.tiles[index];
    final card = _MetricTile(
      tile: tile,
      onTap: () => widget.onTileTap(tile),
      isFullWidth: isOdd && index == widget.tiles.length - 1,
      particleData: _particleData(index),
    );

    final shouldShowcase = widget.emptyTileShowcaseKey != null &&
        widget.showcaseTileTitle != null &&
        tile.title == widget.showcaseTileTitle;

    if (shouldShowcase) {
      return Showcase(
        key: widget.emptyTileShowcaseKey!,
        title: widget.showcaseTitle,
        description: widget.showcaseDescription,
        tooltipBackgroundColor: colors.surface,
        tooltipBorderRadius: BorderRadius.circular(24),
        tooltipPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        titlePadding: const EdgeInsets.only(bottom: 8),
        titleAlignment: Alignment.centerLeft,
        descriptionAlignment: Alignment.centerLeft,
        titleTextAlign: TextAlign.left,
        descriptionTextAlign: TextAlign.left,
        titleTextStyle: theme.textTheme.titleSmall?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
        descTextStyle: theme.textTheme.bodySmall?.copyWith(
          color: colors.textPrimary.withValues(alpha: 0.72),
          height: 1.35,
        ),
        overlayOpacity: 0.58,
        disableMovingAnimation: true,
        disableScaleAnimation: true,
        showArrow: false,
        disposeOnTap: true,
        onTargetClick: () {},
        onToolTipClick: () {},
        targetBorderRadius: BorderRadius.circular(24),
        child: card,
      );
    }

    return card;
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.tile,
    required this.onTap,
    this.isFullWidth = false,
    this.particleData,
  });

  final _HomeMetricTileData tile;
  final VoidCallback onTap;
  final bool isFullWidth;
  final ({double progress, double opacity})? particleData;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final tileBackgroundColor = tile.isDailyGoalReached
        ? Color.alphaBlend(tile.tint.withValues(alpha: 0.22), Colors.white)
        : colors.surface;

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x140C1118),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: tileBackgroundColor,
          child: InkWell(
            onTap: onTap,
            child: _TileContent(
              tile: tile,
              isFullWidth: isFullWidth,
              particleData: particleData,
            ),
          ),
        ),
      ),
    );
    return card;
  }
}

class _TileContent extends StatelessWidget {
  const _TileContent({
    required this.tile,
    this.isFullWidth = false,
    this.particleData,
  });

  final _HomeMetricTileData tile;
  final bool isFullWidth;
  final ({double progress, double opacity})? particleData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final tileTextColor = HSLColor.fromColor(colors.textSecondary)
        .withLightness(
          (HSLColor.fromColor(colors.textSecondary).lightness - 0.16)
              .clamp(0.0, 1.0),
        )
        .toColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── top row: icon circle + checkmark (complete only) ─────
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TileIconCircle(
                icon: tile.icon,
                tint: tile.tint,
                state: tile.state,
                particleData: particleData,
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
        // ── title ─────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            tile.title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: 16,
              color: tileTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        // ── value / caption ──────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              switch (tile.state) {
                _TileState.empty => Text(
                    tile.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: colors.textSecondary.withValues(alpha: 0.70),
                    ),
                  ),
                _TileState.partial => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tile.value,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                          color: tileTextColor,
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
                _TileState.complete => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tile.value,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                          color: tileTextColor,
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
                  child: _CarouselIndicator(
                    count: tile.carouselCount,
                    activeIndex: tile.carouselIndex,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Spacer(),
        const SizedBox(height: 5),
      ],
    );
  }
}

// Simple white circle with drop shadow — mirrors the reference card style.
// Empty state uses a muted tint circle instead of white.
class _TileIconCircle extends StatelessWidget {
  const _TileIconCircle({
    required this.icon,
    required this.tint,
    required this.state,
    this.particleData,
  });

  final IconData icon;
  final Color tint;
  final _TileState state;
  final ({double progress, double opacity})? particleData;

  @override
  Widget build(BuildContext context) {
    // Icon colour is always derived from the tint — muted for empty,
    // deep/saturated for partial and complete.
    final iconColor = HSLColor.fromColor(tint)
        .withLightness(state == _TileState.empty ? 0.64 : 0.46)
        .toColor()
        .withValues(alpha: state == _TileState.empty ? 0.72 : 0.8);

    final circle = Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: state == _TileState.empty ? 0.78 : 0.86,
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

    if (state == _TileState.empty && particleData != null) {
      return _IconBorderParticleOverlay(
        tint: tint,
        progress: particleData!.progress,
        opacity: particleData!.opacity,
        child: circle,
      );
    }
    return circle;
  }
}

class _CarouselIndicator extends StatelessWidget {
  const _CarouselIndicator({
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: i == activeIndex ? 12 : 4,
            height: 4,
            decoration: BoxDecoration(
              color: i == activeIndex
                  ? colors.textSecondary.withValues(alpha: 0.45)
                  : colors.lineSubtle.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          if (i < count - 1) const SizedBox(width: 4),
        ],
      ],
    );
  }
}

// ── Icon border particle animation ────────────────────────────────────────────

class _IconBorderParticleOverlay extends StatelessWidget {
  const _IconBorderParticleOverlay({
    required this.tint,
    required this.progress,
    required this.opacity,
    required this.child,
  });

  final Color tint;
  final double progress;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _IconBorderParticlePainter(
                progress: progress,
                tint: tint,
                opacity: opacity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IconBorderParticlePainter extends CustomPainter {
  _IconBorderParticlePainter({
    required this.progress,
    required this.tint,
    required this.opacity,
  });

  final double progress;
  final Color tint;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= 0) return;

    final path = Path()
      ..addOval(
        Rect.fromLTWH(0.75, 0.75, size.width - 1.5, size.height - 1.5),
      );

    final metrics = path.computeMetrics().first;
    final tangent = metrics.getTangentForOffset(metrics.length * progress);
    if (tangent == null) return;

    final pos = tangent.position;
    final color = HSLColor.fromColor(tint).withLightness(0.46).toColor();

    // Soft glow halo
    canvas.drawCircle(
      pos,
      4.5,
      Paint()
        ..color = color.withValues(alpha: 0.08 * opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5),
    );

    // Core dot
    canvas.drawCircle(
      pos,
      1.5,
      Paint()..color = color.withValues(alpha: 0.30 * opacity),
    );
  }

  @override
  bool shouldRepaint(_IconBorderParticlePainter old) =>
      old.progress != progress || old.tint != tint || old.opacity != opacity;
}

// class _SupplementsOptInCard extends StatelessWidget {
//   const _SupplementsOptInCard({required this.onEnable});
//
//   final VoidCallback onEnable;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = context.appColors;
//
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: colors.surface,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: colors.lineSubtle),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Track supplements too',
//                   style: theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   'Keep this optional until the user wants one more routine to manage.',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: colors.textSecondary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//           OutlinedButton(
//             onPressed: onEnable,
//             child: const Text('Enable'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SupplementsEnabledCard extends StatelessWidget {
//   const _SupplementsEnabledCard({required this.onDisable});
//
//   final VoidCallback onDisable;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = context.appColors;
//
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: colors.surface,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: colors.lineSubtle),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               'Supplements are visible in the grid for users who want to track them.',
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: colors.textSecondary,
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: onDisable,
//             child: const Text('Hide'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // TODO(eug): Restore `_ReminderCard` when `_DailyPromptSection` comes back.
// // class _ReminderCard extends StatelessWidget {
// //   const _ReminderCard({
// //     required this.data,
// //     required this.onTap,
// //   });
// //
// //   final _ReminderCardData data;
// //   final VoidCallback onTap;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final colors = context.appColors;
// //
// //     return Material(
// //       color: Colors.transparent,
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(26),
// //         child: Ink(
// //           padding: const EdgeInsets.all(18),
// //           decoration: BoxDecoration(
// //             color: colors.surface,
// //             borderRadius: BorderRadius.circular(26),
// //             boxShadow: const [
// //               BoxShadow(
// //                 color: Color(0x0D0C1118),
// //                 blurRadius: 22,
// //                 offset: Offset(0, 12),
// //               ),
// //             ],
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Row(
// //                 children: [
// //                   Container(
// //                     width: 40,
// //                     height: 40,
// //                     decoration: BoxDecoration(
// //                       color: data.tone.withValues(alpha: 0.22),
// //                       borderRadius: BorderRadius.circular(14),
// //                     ),
// //                     child:
// //                         Icon(data.icon, size: 20, color: colors.textPrimary),
// //                   ),
// //                   const Spacer(),
// //                   Icon(
// //                     Icons.arrow_forward_rounded,
// //                     size: 18,
// //                     color: colors.textSecondary,
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 data.title,
// //                 maxLines: 1,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: theme.textTheme.titleSmall?.copyWith(
// //                   fontWeight: FontWeight.w800,
// //                 ),
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 data.detail,
// //                 maxLines: 2,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: theme.textTheme.bodySmall?.copyWith(
// //                   color: colors.textSecondary,
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 data.action,
// //                 style: theme.textTheme.labelMedium?.copyWith(
// //                   color: colors.textPrimary,
// //                   fontWeight: FontWeight.w700,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // TODO(eug): Bring back `_DailyPromptSection` after the carousel layout is
// // redesigned. The previous version was intentionally disabled to keep the home
// // screen stable while the rest of the page evolves.
// // class _DailyPromptSection extends StatelessWidget {
// //   const _DailyPromptSection({
// //     super.key,
// //     required this.reminders,
// //     required this.onDoseTap,
// //     required this.onPromptTap,
// //   });
// //
// //   final List<_ReminderCardData> reminders;
// //   final VoidCallback onDoseTap;
// //   final ValueChanged<_ReminderCardData> onPromptTap;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 188,
// //       child: ListView.separated(
// //         scrollDirection: Axis.horizontal,
// //         itemCount: reminders.length,
// //         padding: EdgeInsets.zero,
// //         separatorBuilder: (context, index) => const SizedBox(width: 12),
// //         itemBuilder: (context, index) {
// //           final reminder = reminders[index];
// //           return SizedBox(
// //             width: 228,
// //             child: _ReminderCard(
// //               data: reminder,
// //               onTap:
// //                   reminder.action == 'Log dose'
// //                       ? onDoseTap
// //                       : () => onPromptTap(reminder),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
class _HomeMetricTileData {
  const _HomeMetricTileData({
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
  final _TileState state;
  final double? progress;
  final bool isDailyGoalReached;
  final bool isOverDailyGoal;
  final int carouselIndex;
  final int carouselCount;
}

enum _TileState {
  empty,
  partial,
  complete,
}
//
// // TODO(eug): Restore `_ReminderCardData` with the reminder rail.
// // class _ReminderCardData {
// //   const _ReminderCardData({
// //     required this.icon,
// //     required this.title,
// //     required this.detail,
// //     required this.tone,
// //     required this.action,
// //   });
// //
// //   final IconData icon;
// //   final String title;
// //   final String detail;
// //   final Color tone;
// //   final String action;
// // }
