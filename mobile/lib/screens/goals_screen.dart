import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/app_profile.dart';
import '../models/goals.dart';
import '../l10n/l10n.dart';
import '../providers/app_refresh_provider.dart';
import '../providers/goals_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/profile_service_provider.dart';
import '../providers/record_service_provider.dart';
import '../services/record_service.dart';
import '../theme/app_colors.dart';
import 'main_shell.dart';

class HabitGoalsEditorSession {
  const HabitGoalsEditorSession({
    this.isDirty = false,
    this.saveAction,
    this.discardAction,
  });

  final bool isDirty;
  final Future<bool> Function()? saveAction;
  final VoidCallback? discardAction;

  HabitGoalsEditorSession copyWith({
    bool? isDirty,
    Future<bool> Function()? saveAction,
    VoidCallback? discardAction,
    bool clearSaveAction = false,
    bool clearDiscardAction = false,
  }) {
    return HabitGoalsEditorSession(
      isDirty: isDirty ?? this.isDirty,
      saveAction: clearSaveAction ? null : (saveAction ?? this.saveAction),
      discardAction:
          clearDiscardAction ? null : (discardAction ?? this.discardAction),
    );
  }
}

class HabitGoalsEditorSessionNotifier
    extends Notifier<HabitGoalsEditorSession> {
  @override
  HabitGoalsEditorSession build() => const HabitGoalsEditorSession();

  void setDirty(bool value) {
    state = state.copyWith(isDirty: value);
  }

  void setSaveAction(Future<bool> Function()? action) {
    state = state.copyWith(saveAction: action);
  }

  void setDiscardAction(VoidCallback? action) {
    state = state.copyWith(discardAction: action);
  }

  void clear() {
    state = const HabitGoalsEditorSession();
  }
}

final habitGoalsEditorSessionProvider =
    NotifierProvider<HabitGoalsEditorSessionNotifier, HabitGoalsEditorSession>(
  HabitGoalsEditorSessionNotifier.new,
);

final _latestWeightRecordProvider =
    FutureProvider<Map<String, dynamic>?>((ref) {
  return ref
      .read(recordServiceProvider)
      .loadLatestRecord(RecordService.weightColumn);
});

class HabitGoalsScreen extends ConsumerWidget {
  const HabitGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalsProvider);
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (goals) => _HabitGoalsBody(
            initial: goals,
            profile: ref.watch(profileBootstrapProvider).asData?.value,
            latestWeightRecord:
                ref.watch(_latestWeightRecordProvider).asData?.value,
          ),
        ),
      ),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _HabitGoalsBody extends ConsumerStatefulWidget {
  const _HabitGoalsBody({
    required this.initial,
    required this.profile,
    required this.latestWeightRecord,
  });

  final AppGoals initial;
  final AppProfile? profile;
  final Map<String, dynamic>? latestWeightRecord;

  @override
  ConsumerState<_HabitGoalsBody> createState() => _HabitGoalsBodyState();
}

class _HabitGoalsBodyState extends ConsumerState<_HabitGoalsBody> {
  late AppGoals _habitGoals;
  late AppGoals _baselineHabitGoals;
  late final HabitGoalsEditorSessionNotifier _editorSessionNotifier;
  bool _saving = false;
  bool _syncQueued = false;

  bool get _hasChanges =>
      jsonEncode(_habitGoals.toJson()) !=
      jsonEncode(_baselineHabitGoals.toJson());

  @override
  void initState() {
    super.initState();
    _habitGoals = widget.initial;
    _baselineHabitGoals = widget.initial;
    _editorSessionNotifier =
        ref.read(habitGoalsEditorSessionProvider.notifier);
  }

  @override
  void didUpdateWidget(covariant _HabitGoalsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (jsonEncode(oldWidget.initial.toJson()) !=
        jsonEncode(widget.initial.toJson())) {
      _baselineHabitGoals = widget.initial;
      _habitGoals = widget.initial;
    }
  }

  @override
  void dispose() {
    Future<void>(_editorSessionNotifier.clear);
    super.dispose();
  }

  Future<bool> _save() async {
    if (_saving) {
      return false;
    }
    setState(() => _saving = true);
    try {
      await ref.read(profileServiceProvider).updateGoals(_habitGoals);
      _baselineHabitGoals = _habitGoals;
      _editorSessionNotifier.setDirty(false);
      ref.invalidate(goalsProvider);
      ref.read(appRefreshProvider).goalsChanged();
      return true;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _discardChanges() {
    if (!mounted) {
      return;
    }
    setState(() {
      _habitGoals = _baselineHabitGoals;
    });
    _editorSessionNotifier.setDirty(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final saveAction = _saving ? null : _save;
    _queueEditorSessionSync(saveAction);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        unawaited(() async {
          final canLeave = await _confirmLeaveIfNeeded();
          if (canLeave && context.mounted) {
            Navigator.of(context).pop();
          }
        }());
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 14, 10),
              child: Row(
                children: [
                  InkResponse(
                    onTap: () async {
                      final canLeave = await _confirmLeaveIfNeeded();
                      if (canLeave && context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    radius: 20,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: colors.textPrimary,
                    ),
                  ),
                    Expanded(
                      child: Center(
                        child: Text(
                        context.l10n.habitGoalsTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ),
                  TextButton(
                    onPressed: _saving || !_hasChanges ? null : _save,
                    style: TextButton.styleFrom(
                      foregroundColor: colors.textPrimary,
                      textStyle: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(context.l10n.commonSave),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _WaterGoalCard(
                  goal: _habitGoals.water,
                  profile: widget.profile,
                  onChanged: (g) => setState(
                    () => _habitGoals = _habitGoals.copyWith(water: g),
                  ),
                ),
                const SizedBox(height: 8),
                _ExerciseGoalCard(
                  goal: _habitGoals.exercise,
                  profile: widget.profile,
                  onChanged: (g) => setState(
                    () => _habitGoals = _habitGoals.copyWith(exercise: g),
                  ),
                ),
                const SizedBox(height: 8),
                _MealsGoalCard(
                  goal: _habitGoals.meals,
                  profile: widget.profile,
                  onChanged: (g) => setState(
                    () => _habitGoals = _habitGoals.copyWith(meals: g),
                  ),
                ),
                const SizedBox(height: 8),
                _NutrientGoalCard(
                  goal: _habitGoals.protein,
                  profile: widget.profile,
                  label: context.l10n.goalsProteins,
                  icon: Icons.fitness_center_rounded,
                  tint: colors.protein,
                  defaultWeeklyTarget: _recommendedWeeklyProteinTarget,
                  dailySummaryBuilder: (weekly) =>
                      context.l10n.goalsGramsPerDay(
                        '${(weekly / 7).round()}',
                      ),
                  onChanged: (g) => setState(
                    () => _habitGoals = _habitGoals.copyWith(protein: g),
                  ),
                ),
                const SizedBox(height: 8),
                _NutrientGoalCard(
                  goal: _habitGoals.fiber,
                  profile: widget.profile,
                  label: context.l10n.goalsFibers,
                  icon: Icons.eco_rounded,
                  tint: colors.fiber,
                  defaultWeeklyTarget: _recommendedWeeklyFiberTarget,
                  dailySummaryBuilder: (weekly) =>
                      context.l10n.goalsGramsPerDay(
                        '${(weekly / 7).round()}',
                      ),
                  onChanged: (g) => setState(
                    () => _habitGoals = _habitGoals.copyWith(fiber: g),
                  ),
                ),
                const SizedBox(height: 8),
                _WeightGoalCard(
                  goal: _habitGoals.weight,
                  profile: widget.profile,
                  latestWeightRecord: widget.latestWeightRecord,
                  onChanged: (g) => setState(
                    () => _habitGoals = _habitGoals.copyWith(weight: g),
                  ),
                ),
                const SizedBox(height: 18),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmLeaveIfNeeded() async {
    if (!_hasChanges || _saving) {
      return true;
    }

    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.goalsSaveDialogTitle),
        content: Text(context.l10n.goalsSaveDialogMessage),
        actions: [
          TextButton(
            onPressed: () {
              _discardChanges();
              ref.read(shellTabRequestProvider.notifier).request(
                    shellSettingsTabIndex,
                  );
              Navigator.of(context).pop(true);
            },
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () async {
              final saved = await _save();
              if (context.mounted) {
                Navigator.of(context).pop(saved);
              }
            },
            child: Text(context.l10n.commonSave),
          ),
        ],
      ),
    );

    return shouldLeave ?? false;
  }

  void _queueEditorSessionSync(Future<bool> Function()? saveAction) {
    if (_syncQueued) {
      return;
    }
    _syncQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncQueued = false;
      if (!mounted) {
        return;
      }
      _editorSessionNotifier
        ..setDirty(_hasChanges)
        ..setSaveAction(saveAction)
        ..setDiscardAction(_discardChanges);
    });
  }
}

// ── Shared card shell ─────────────────────────────────────────────────────────

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.icon,
    required this.label,
    required this.tint,
    required this.enabled,
    required this.onToggle,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Color tint;
  final bool enabled;
  final ValueChanged<bool> onToggle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.55,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.lineSubtle),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: tint.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: tint),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: enabled,
                  onChanged: onToggle,
                  activeTrackColor: tint.withValues(alpha: 0.35),
                  activeThumbColor: tint,
                ),
              ],
            ),
            if (enabled) ...[
              const SizedBox(height: 10),
              child,
            ],
          ],
        ),
      ),
    );
  }
}

class _MealsModeRow extends StatelessWidget {
  const _MealsModeRow({
    required this.value,
    required this.onChanged,
  });

  final MealsGoalMode value;
  final ValueChanged<MealsGoalMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      children: [
        for (final mode in MealsGoalMode.values)
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(mode),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: EdgeInsets.only(
                  right: mode == MealsGoalMode.meals ? 6 : 0,
                  left: mode == MealsGoalMode.calories ? 6 : 0,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                      value == mode ? colors.textPrimary : colors.softSurface,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(
                  child: Text(
                    mode == MealsGoalMode.meals
                        ? context.l10n.goalsMeals
                        : context.l10n.goalsCalories,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color:
                          value == mode ? colors.surface : colors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Stepper row ───────────────────────────────────────────────────────────────

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.onDecrement,
    required this.onIncrement,
    this.value,
    this.valueWidget,
    this.valueSuffix,
  });

  final String? value;
  final Widget? valueWidget;
  final String label;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final String? valueSuffix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (valueWidget != null)
                    valueWidget!
                  else if (value != null)
                    Text(
                      value!,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  if (valueSuffix != null && valueSuffix!.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        valueSuffix!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(label,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: colors.textSecondary)),
            ],
          ),
        ),
        _StepButton(icon: Icons.remove, onTap: onDecrement),
        const SizedBox(width: 8),
        _StepButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }
}

class _EditableCaloriesValue extends StatelessWidget {
  const _EditableCaloriesValue({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.unitLabel,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final String unitLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, maxWidth: 132),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lineSubtle, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: colors.textSecondary.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              hintText: '0',
              hintStyle: theme.textTheme.headlineSmall?.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            unitLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _EditableWeightValue extends StatelessWidget {
  const _EditableWeightValue({
    required this.controller,
    required this.focusNode,
    required this.unit,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String unit;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, maxWidth: 132),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lineSubtle, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: colors.textSecondary.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              hintText: '0',
              hintStyle: theme.textTheme.headlineSmall?.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            unit,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _EditableGramValue extends StatelessWidget {
  const _EditableGramValue({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, maxWidth: 132),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lineSubtle, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: colors.textSecondary.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              hintText: '0',
              hintStyle: theme.textTheme.headlineSmall?.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            'g',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepButton extends StatefulWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_StepButton> createState() => _StepButtonState();
}

class _StepButtonState extends State<_StepButton> {
  Timer? _holdDelayTimer;
  Timer? _repeatTimer;

  @override
  void dispose() {
    _holdDelayTimer?.cancel();
    _repeatTimer?.cancel();
    super.dispose();
  }

  void _startHold() {
    widget.onTap();
    _holdDelayTimer?.cancel();
    _repeatTimer?.cancel();
    _holdDelayTimer = Timer(const Duration(milliseconds: 320), () {
      _repeatTimer = Timer.periodic(const Duration(milliseconds: 90), (_) {
        widget.onTap();
      });
    });
  }

  void _stopHold() {
    _holdDelayTimer?.cancel();
    _repeatTimer?.cancel();
    _holdDelayTimer = null;
    _repeatTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _startHold(),
      onTapUp: (_) => _stopHold(),
      onTapCancel: _stopHold,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: colors.softSurface,
          shape: BoxShape.circle,
          border: Border.all(color: colors.lineSubtle),
        ),
        child: Icon(widget.icon, size: 16, color: colors.textPrimary),
      ),
    );
  }
}

class _WeightInfoBadge extends StatelessWidget {
  const _WeightInfoBadge({required this.copy});

  final String copy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.softSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: colors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              copy,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Water ─────────────────────────────────────────────────────────────────────

class _WaterGoalCard extends StatefulWidget {
  const _WaterGoalCard({
    required this.goal,
    required this.profile,
    required this.onChanged,
  });

  final WaterGoal goal;
  final AppProfile? profile;
  final ValueChanged<WaterGoal> onChanged;

  @override
  State<_WaterGoalCard> createState() => _WaterGoalCardState();
}

class _WaterGoalCardState extends State<_WaterGoalCard> {
  late double _targetMl;

  static const _step = 250.0;
  static const _weeklyMin = 3500.0;
  static const _weeklyMax = 35000.0;

  @override
  void initState() {
    super.initState();
    final entry = widget.goal.current;
    _targetMl = entry == null
        ? _recommendedWeeklyWaterTargetMl(widget.profile)
        : (entry.timeframe == GoalTimeframe.daily
            ? entry.targetMl * 7
            : entry.targetMl);
  }

  @override
  void didUpdateWidget(covariant _WaterGoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal || oldWidget.profile != widget.profile) {
      final entry = widget.goal.current;
      _targetMl = entry == null
          ? _recommendedWeeklyWaterTargetMl(widget.profile)
          : (entry.timeframe == GoalTimeframe.daily
              ? entry.targetMl * 7
              : entry.targetMl);
    }
  }

  void _emit({bool? enabled}) {
    final entry = WaterGoalEntry(
      createdAt: goalToday(),
      timeframe: GoalTimeframe.weekly,
      targetMl: _targetMl,
    );
    widget.onChanged(
      widget.goal
          .withEntry(entry)
          .copyWith(enabled: enabled ?? widget.goal.enabled),
    );
  }

  @override
  Widget build(BuildContext context) {
    final liters = (_targetMl / 1000).toStringAsFixed(1);
    final dailyLiters = (_targetMl / 7 / 1000).toStringAsFixed(1);

    return _GoalCard(
      icon: Icons.water_drop_rounded,
      label: context.l10n.goalsWater,
      tint: const Color(0xFF5BB8F5),
      enabled: widget.goal.enabled,
      onToggle: (v) {
        if (v) {
          _emit(enabled: true);
          return;
        }
        widget.onChanged(widget.goal.copyWith(enabled: false));
      },
      child: Column(
        children: [
          _StepperRow(
            value: '${liters}L',
            valueSuffix: context.l10n.goalsPerWeekSuffix,
            label: context.l10n.goalsLitersPerDay(dailyLiters),
            onDecrement: _targetMl > _weeklyMin
                ? () {
                    setState(() => _targetMl -= _step);
                    _emit();
                  }
                : () {},
            onIncrement: _targetMl < _weeklyMax
                ? () {
                    setState(() => _targetMl += _step);
                    _emit();
                  }
                : () {},
          ),
        ],
      ),
    );
  }

  double _recommendedWeeklyWaterTargetMl(AppProfile? profile) {
    final weightKg = _profileWeightKg(profile);
    if (weightKg == null) return 2000.0 * 7;
    final daily = ((weightKg * 35) / 100).floor() * 100.0;
    return daily * 7;
  }
}

// ── Exercise ──────────────────────────────────────────────────────────────────

class _ExerciseGoalCard extends StatefulWidget {
  const _ExerciseGoalCard({
    required this.goal,
    required this.profile,
    required this.onChanged,
  });

  final ExerciseGoal goal;
  final AppProfile? profile;
  final ValueChanged<ExerciseGoal> onChanged;

  @override
  State<_ExerciseGoalCard> createState() => _ExerciseGoalCardState();
}

class _ExerciseGoalCardState extends State<_ExerciseGoalCard> {
  late int _targetMinutes;

  static const _weeklyStep = 30;
  static const _weeklyMin = 60;
  static const _weeklyMax = 1080;

  @override
  void initState() {
    super.initState();
    final entry = widget.goal.current;
    _targetMinutes = entry == null
        ? _recommendedWeeklyExerciseTarget(widget.profile)
        : (entry.timeframe == GoalTimeframe.daily
            ? entry.targetMinutes * 6
            : entry.targetMinutes);
  }

  @override
  void didUpdateWidget(covariant _ExerciseGoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal || oldWidget.profile != widget.profile) {
      final entry = widget.goal.current;
      _targetMinutes = entry == null
          ? _recommendedWeeklyExerciseTarget(widget.profile)
          : (entry.timeframe == GoalTimeframe.daily
              ? entry.targetMinutes * 6
              : entry.targetMinutes);
    }
  }

  void _emit({bool? enabled}) {
    final entry = ExerciseGoalEntry(
      createdAt: goalToday(),
      timeframe: GoalTimeframe.weekly,
      targetMinutes: _targetMinutes,
    );
    widget.onChanged(
      widget.goal
          .withEntry(entry)
          .copyWith(enabled: enabled ?? widget.goal.enabled),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = _targetMinutes >= 60
        ? '${(_targetMinutes / 60).toStringAsFixed(1)}h'
        : '${_targetMinutes}m';
    final dailyMinutes = (_targetMinutes / 6).round();

    return _GoalCard(
      icon: Icons.directions_run_rounded,
      label: context.l10n.goalsExercise,
      tint: const Color(0xFF6BCB81),
      enabled: widget.goal.enabled,
      onToggle: (v) {
        if (v) {
          _emit(enabled: true);
          return;
        }
        widget.onChanged(widget.goal.copyWith(enabled: false));
      },
      child: Column(
        children: [
          _StepperRow(
            value: hours,
            valueSuffix: context.l10n.goalsPerWeekSuffix,
            label: context.l10n.goalsMinutesPerDay(dailyMinutes.toString()),
            onDecrement: _targetMinutes > _weeklyMin
                ? () {
                    setState(() => _targetMinutes -= _weeklyStep);
                    _emit();
                  }
                : () {},
            onIncrement: _targetMinutes < _weeklyMax
                ? () {
                    setState(() => _targetMinutes += _weeklyStep);
                    _emit();
                  }
                : () {},
          ),
        ],
      ),
    );
  }

  int _recommendedWeeklyExerciseTarget(AppProfile? profile) {
    final age = _profileAge(profile);
    if (age != null && age < 18) {
      return 360;
    }
    return 150;
  }
}

// ── Meals ─────────────────────────────────────────────────────────────────────

class _MealsGoalCard extends StatefulWidget {
  const _MealsGoalCard({
    required this.goal,
    required this.profile,
    required this.onChanged,
  });

  final MealsGoal goal;
  final AppProfile? profile;
  final ValueChanged<MealsGoal> onChanged;

  @override
  State<_MealsGoalCard> createState() => _MealsGoalCardState();
}

class _MealsGoalCardState extends State<_MealsGoalCard> {
  static final NumberFormat _kcalFormat = NumberFormat.decimalPattern();

  late MealsGoalMode _mode;
  late int _targetValue;
  late final TextEditingController _caloriesController;
  late final FocusNode _caloriesFocusNode;

  static const _weeklyMealsMin = 7;
  static const _weeklyMealsMax = 42;
  static const _weeklyCaloriesStep = 100;
  static const _weeklyCaloriesMin = 3500;
  static const _weeklyCaloriesMax = 28000;

  @override
  void initState() {
    super.initState();
    _caloriesController = TextEditingController();
    _caloriesFocusNode = FocusNode();
    final entry = widget.goal.current;
    _mode = entry?.mode ?? MealsGoalMode.meals;
    _targetValue = entry == null
        ? _defaultTargetValue(widget.profile, _mode)
        : (entry.timeframe == GoalTimeframe.daily
            ? (entry.targetValue * 7)
            : entry.targetValue);
    _syncCaloriesController();
  }

  @override
  void didUpdateWidget(covariant _MealsGoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal || oldWidget.profile != widget.profile) {
      final entry = widget.goal.current;
      _mode = entry?.mode ?? MealsGoalMode.meals;
      _targetValue = entry == null
          ? _defaultTargetValue(widget.profile, _mode)
          : (entry.timeframe == GoalTimeframe.daily
              ? (entry.targetValue * 7)
              : entry.targetValue);
      _syncCaloriesController();
    }
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _caloriesFocusNode.dispose();
    super.dispose();
  }

  void _emit({bool? enabled}) {
    final entry = MealsGoalEntry(
      createdAt: goalToday(),
      timeframe: GoalTimeframe.weekly,
      mode: _mode,
      targetValue: _targetValue,
    );
    widget.onChanged(
      widget.goal.withEntry(entry).copyWith(
            enabled: enabled ?? widget.goal.enabled,
          ),
    );
  }

  void _syncCaloriesController() {
    if (_mode != MealsGoalMode.calories) return;
    _caloriesController.text = '$_targetValue';
    _caloriesController.selection = TextSelection.collapsed(
      offset: _caloriesController.text.length,
    );
  }

  void _onCaloriesChanged(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly != value) {
      _caloriesController.value = TextEditingValue(
        text: digitsOnly,
        selection: TextSelection.collapsed(offset: digitsOnly.length),
      );
    }
    final parsed = int.tryParse(digitsOnly);
    if (parsed == null) return;
    final clamped = parsed.clamp(_weeklyCaloriesMin, _weeklyCaloriesMax);
    if (clamped == _targetValue) return;
    setState(() => _targetValue = clamped);
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDailyCalories =
        _kcalFormat.format((_targetValue / 7).round());
    final dailySummary = _mode == MealsGoalMode.meals
        ? context.l10n.goalsMealsPerDay('${(_targetValue / 7).round()}')
        : context.l10n.goalsCaloriesPerDay(formattedDailyCalories);
    _syncCaloriesController();

    return _GoalCard(
      icon: Icons.restaurant_rounded,
      label: context.l10n.goalsMeals,
      tint: const Color(0xFFFFAA5B),
      enabled: widget.goal.enabled,
      onToggle: (v) {
        if (v) {
          _emit(enabled: true);
          return;
        }
        widget.onChanged(widget.goal.copyWith(enabled: false));
      },
      child: Column(
        children: [
          _MealsModeRow(
            value: _mode,
            onChanged: (mode) {
              setState(() {
                _mode = mode;
                _targetValue = _defaultTargetValue(widget.profile, mode);
              });
              _emit();
            },
          ),
          const SizedBox(height: 16),
          _StepperRow(
            value: _mode == MealsGoalMode.meals ? '$_targetValue' : null,
            valueWidget: _mode == MealsGoalMode.calories
                ? _EditableCaloriesValue(
                    controller: _caloriesController,
                    focusNode: _caloriesFocusNode,
                    onChanged: _onCaloriesChanged,
                    unitLabel: context.l10n.goalsKcalUnit,
                  )
                : null,
            valueSuffix: context.l10n.goalsPerWeekSuffix,
            label: dailySummary,
            onDecrement: _canDecreaseMealsTarget
                ? () {
                    setState(() => _targetValue -= _targetStep);
                    _syncCaloriesController();
                    _emit();
                  }
                : () {},
            onIncrement: _canIncreaseMealsTarget
                ? () {
                    setState(() => _targetValue += _targetStep);
                    _syncCaloriesController();
                    _emit();
                  }
                : () {},
          ),
        ],
      ),
    );
  }

  bool get _canDecreaseMealsTarget =>
      _targetValue > _minForCurrentModeAndTimeframe;

  bool get _canIncreaseMealsTarget =>
      _targetValue < _maxForCurrentModeAndTimeframe;

  int _defaultTargetValue(AppProfile? profile, MealsGoalMode mode) {
    if (mode == MealsGoalMode.meals) {
      return 21;
    }
    return _recommendedDailyCalories(profile) * 7;
  }

  int _recommendedDailyCalories(AppProfile? profile) {
    final age = _profileAge(profile);
    final gender = _profileGender(profile);
    if (age != null && age < 19) {
      return switch (gender) {
        'male' => 2800,
        'female' => 2200,
        _ => 2500,
      };
    }
    return switch (gender) {
      'male' => 2400,
      'female' => 2000,
      _ => 2200,
    };
  }

  int get _targetStep {
    if (_mode == MealsGoalMode.meals) {
      return 7;
    }
    return _weeklyCaloriesStep;
  }

  int get _minForCurrentModeAndTimeframe {
    if (_mode == MealsGoalMode.meals) {
      return _weeklyMealsMin;
    }
    return _weeklyCaloriesMin;
  }

  int get _maxForCurrentModeAndTimeframe {
    if (_mode == MealsGoalMode.meals) {
      return _weeklyMealsMax;
    }
    return _weeklyCaloriesMax;
  }
}

class _NutrientGoalCard extends StatefulWidget {
  const _NutrientGoalCard({
    required this.goal,
    required this.profile,
    required this.label,
    required this.icon,
    required this.tint,
    required this.defaultWeeklyTarget,
    required this.dailySummaryBuilder,
    required this.onChanged,
  });

  final NutrientGoal goal;
  final AppProfile? profile;
  final String label;
  final IconData icon;
  final Color tint;
  final int Function(AppProfile? profile) defaultWeeklyTarget;
  final String Function(int weeklyTarget) dailySummaryBuilder;
  final ValueChanged<NutrientGoal> onChanged;

  @override
  State<_NutrientGoalCard> createState() => _NutrientGoalCardState();
}

class _NutrientGoalCardState extends State<_NutrientGoalCard> {
  late int _targetGrams;
  late final TextEditingController _gramsController;
  late final FocusNode _gramsFocusNode;

  static const _weeklyStep = 5;
  static const _weeklyMin = 70;
  static const _weeklyMax = 1400;

  @override
  void initState() {
    super.initState();
    _gramsController = TextEditingController();
    _gramsFocusNode = FocusNode();
    _targetGrams = _targetFromGoal(widget.goal);
    _syncGramsController();
  }

  @override
  void didUpdateWidget(covariant _NutrientGoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal || oldWidget.profile != widget.profile) {
      _targetGrams = _targetFromGoal(widget.goal);
      _syncGramsController();
    }
  }

  @override
  void dispose() {
    _gramsController.dispose();
    _gramsFocusNode.dispose();
    super.dispose();
  }

  int _targetFromGoal(NutrientGoal goal) {
    final entry = goal.current;
    if (entry != null) {
      return _roundToNearestFive(entry.timeframe == GoalTimeframe.daily
          ? entry.targetGrams * 7
          : entry.targetGrams);
    }
    return widget.defaultWeeklyTarget(widget.profile);
  }

  void _emit({bool? enabled}) {
    final entry = NutrientGoalEntry(
      createdAt: goalToday(),
      timeframe: GoalTimeframe.weekly,
      targetGrams: _targetGrams,
    );
    widget.onChanged(
      widget.goal.withEntry(entry).copyWith(
            enabled: enabled ?? widget.goal.enabled,
          ),
    );
  }

  void _syncGramsController() {
    final text = '$_targetGrams';
    if (_gramsController.text == text) {
      return;
    }
    _gramsController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _onGramsChanged(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly != value) {
      _gramsController.value = TextEditingValue(
        text: digitsOnly,
        selection: TextSelection.collapsed(offset: digitsOnly.length),
      );
    }
    final parsed = int.tryParse(digitsOnly);
    if (parsed == null) return;
    final clamped = _roundToNearestFive(parsed.clamp(_weeklyMin, _weeklyMax));
    if (clamped == _targetGrams) return;
    setState(() => _targetGrams = clamped);
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    _syncGramsController();

    return _GoalCard(
      icon: widget.icon,
      label: widget.label,
      tint: widget.tint,
      enabled: widget.goal.enabled,
      onToggle: (v) {
        if (v) {
          _emit(enabled: true);
          return;
        }
        widget.onChanged(widget.goal.copyWith(enabled: false));
      },
      child: Column(
        children: [
          _StepperRow(
            valueWidget: _EditableGramValue(
              controller: _gramsController,
              focusNode: _gramsFocusNode,
              onChanged: _onGramsChanged,
            ),
            valueSuffix: context.l10n.goalsPerWeekSuffix,
            label: widget.dailySummaryBuilder(_targetGrams),
            onDecrement: _targetGrams > _weeklyMin
                ? () {
                    setState(() => _targetGrams -= _weeklyStep);
                    _syncGramsController();
                    _emit();
                  }
                : () {},
            onIncrement: _targetGrams < _weeklyMax
                ? () {
                    setState(() => _targetGrams += _weeklyStep);
                    _syncGramsController();
                    _emit();
                  }
                : () {},
          ),
        ],
      ),
    );
  }

  int _roundToNearestFive(int value) {
    final rounded = (value / 5).round() * 5;
    return rounded.clamp(_weeklyMin, _weeklyMax);
  }
}

// ── Weight ────────────────────────────────────────────────────────────────────

class _WeightGoalCard extends StatefulWidget {
  const _WeightGoalCard({
    required this.goal,
    required this.profile,
    required this.latestWeightRecord,
    required this.onChanged,
  });

  final WeightGoal goal;
  final AppProfile? profile;
  final Map<String, dynamic>? latestWeightRecord;
  final ValueChanged<WeightGoal> onChanged;

  @override
  State<_WeightGoalCard> createState() => _WeightGoalCardState();
}

class _WeightGoalCardState extends State<_WeightGoalCard> {
  late double _targetKg;
  late final TextEditingController _weightController;
  late final FocusNode _weightFocusNode;

  static const _kgStep = 0.25;
  static const _kgMin = 40.0;
  static const _kgMax = 180.0;
  static const _lbStep = 2.0;
  static const _lbMin = 88.0;
  static const _lbMax = 396.0;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _weightFocusNode = FocusNode();
    _targetKg = _targetKgFromGoal(widget.goal);
    _syncWeightController();
  }

  @override
  void didUpdateWidget(covariant _WeightGoalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal != widget.goal || oldWidget.profile != widget.profile) {
      _targetKg = _targetKgFromGoal(widget.goal);
      _syncWeightController();
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _weightFocusNode.dispose();
    super.dispose();
  }

  void _emit({bool? enabled}) {
    final entry = WeightGoalEntry(
      createdAt: goalToday(),
      timeframe: GoalTimeframe.weekly,
      targetKg: _targetKg,
      targetUnit: _displayUnit,
    );
    widget.onChanged(
      widget.goal.withEntry(entry).copyWith(
            enabled: enabled ?? widget.goal.enabled,
          ),
    );
  }

  void _syncWeightController() {
    final text = _formattedEditableWeightValue;
    if (_weightController.text == text) {
      return;
    }
    _weightController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _onWeightChanged(String value) {
    final sanitized = _sanitizeWeightInput(value);
    if (sanitized != value) {
      _weightController.value = TextEditingValue(
        text: sanitized,
        selection: TextSelection.collapsed(offset: sanitized.length),
      );
    }

    final parsed = double.tryParse(sanitized);
    if (parsed == null) {
      return;
    }

    final normalizedKg = _normalizeTypedWeightInKg(parsed, _displayUnit);
    if ((normalizedKg - _targetKg).abs() < 0.001) {
      return;
    }

    setState(() => _targetKg = normalizedKg);
    final normalizedDisplayValue =
        _displayUnit == 'lb' ? normalizedKg * 2.20462 : normalizedKg;
    if ((normalizedDisplayValue - parsed).abs() > 0.001) {
      _syncWeightController();
    }
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    final targetValue = _targetValueInDisplayUnit;
    final paceLabel = _paceLine;
    return _GoalCard(
      icon: Icons.monitor_weight_rounded,
      label: context.l10n.goalsWeight,
      tint: const Color(0xFF6F8DBA),
      enabled: widget.goal.enabled,
      onToggle: (v) {
        if (v) {
          _emit(enabled: true);
          return;
        }
        widget.onChanged(widget.goal.copyWith(enabled: false));
      },
      child: Column(
        children: [
          _StepperRow(
            valueWidget: _EditableWeightValue(
              controller: _weightController,
              focusNode: _weightFocusNode,
              unit: _displayUnit,
              onChanged: _onWeightChanged,
            ),
            label: paceLabel,
            onDecrement: _canDecreaseWeightTarget
                ? () {
                    setState(() {
                      final next = targetValue - _targetStep;
                      _targetKg = _normalizeWeightInKg(next, _displayUnit);
                    });
                    _syncWeightController();
                    _emit();
                  }
                : () {},
            onIncrement: _canIncreaseWeightTarget
                ? () {
                    setState(() {
                      final next = targetValue + _targetStep;
                      _targetKg = _normalizeWeightInKg(next, _displayUnit);
                    });
                    _syncWeightController();
                    _emit();
                  }
                : () {},
          ),
          const SizedBox(height: 12),
          _WeightInfoBadge(
            copy: context.l10n.goalsSetTargetForNextWeek,
          ),
        ],
      ),
    );
  }

  double _targetKgFromGoal(WeightGoal goal) {
    final entry = goal.current;
    if (entry != null) {
      return _normalizeWeightInKg(entry.targetKg, 'kg');
    }
    return 80;
  }

  String get _displayUnit =>
      widget.profile?.settings['measurement_unit']?.toString() == 'lb'
          ? 'lb'
          : 'kg';

  double get _targetValueInDisplayUnit =>
      _displayUnit == 'lb' ? _targetKg * 2.20462 : _targetKg;

  double get _targetStep => _displayUnit == 'lb' ? _lbStep : _kgStep;

  bool get _canDecreaseWeightTarget {
    return _targetValueInDisplayUnit > (_displayUnit == 'lb' ? _lbMin : _kgMin);
  }

  bool get _canIncreaseWeightTarget {
    return _targetValueInDisplayUnit < (_displayUnit == 'lb' ? _lbMax : _kgMax);
  }

  double? get _differenceKg {
    final latestQuantity = widget.latestWeightRecord?['quantity'];
    final latestUnit = widget.latestWeightRecord?['unit'] as String?;
    if (latestQuantity is! num) {
      return null;
    }
    final latestKg = (latestUnit ?? 'kg') == 'lb'
        ? latestQuantity.toDouble() / 2.20462
        : latestQuantity.toDouble();
    return latestKg - _targetKg;
  }

  double? get _differenceInSelectedUnit {
    final diffKg = _differenceKg;
    if (diffKg == null) {
      return null;
    }
    return _displayUnit == 'lb' ? diffKg * 2.20462 : diffKg;
  }

  String get _paceLine {
    final difference = _differenceInSelectedUnit;
    if (difference == null) {
      return context.l10n.goalsAddLoggedWeightToCalculatePace;
    }
    final amount = difference.abs();
    if (amount < (_displayUnit == 'lb' ? 1 : 0.125)) {
      return context.l10n.goalsAlreadyAtThisTarget;
    }
    return context.l10n.goalsWeightPerWeekToTarget(
      _formatWeightValue(amount),
      _displayUnit,
    );
  }

  double _normalizeWeightInKg(double value, String unit) {
    final min = unit == 'lb' ? _lbMin : _kgMin;
    final max = unit == 'lb' ? _lbMax : _kgMax;
    final clamped = value.clamp(min, max);
    final step = unit == 'lb' ? _lbStep : _kgStep;
    final rounded = (clamped / step).roundToDouble() * step;
    return unit == 'lb' ? rounded / 2.20462 : rounded;
  }

  double _normalizeTypedWeightInKg(double value, String unit) {
    final min = unit == 'lb' ? _lbMin : _kgMin;
    final max = unit == 'lb' ? _lbMax : _kgMax;
    final clamped = value.clamp(min, max);
    return unit == 'lb' ? clamped / 2.20462 : clamped;
  }

  String _formatWeightValue(double value) {
    if (_displayUnit == 'lb') {
      return value.round().toString();
    }
    final normalized = (value * 100).round() / 100;
    return normalized.toStringAsFixed(2);
  }

  String get _formattedEditableWeightValue {
    if (_displayUnit == 'lb') {
      return _targetValueInDisplayUnit.round().toString();
    }
    return _formatWeightValue(_targetValueInDisplayUnit);
  }

  String _sanitizeWeightInput(String value) {
    final normalized = value.replaceAll(',', '.');
    final buffer = StringBuffer();
    var hasDecimal = false;
    for (final rune in normalized.runes) {
      final char = String.fromCharCode(rune);
      final isDigit = char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
      if (isDigit) {
        buffer.write(char);
        continue;
      }
      if (_displayUnit == 'kg' && char == '.' && !hasDecimal) {
        buffer.write(char);
        hasDecimal = true;
      }
    }
    return buffer.toString();
  }
}

int? _profileAge(AppProfile? profile) {
  final age = profile?.settings['age'];
  return switch (age) {
    final int value => value,
    final num value => value.toInt(),
    final String value => int.tryParse(value),
    _ => null,
  };
}

String? _profileGender(AppProfile? profile) {
  final raw = profile?.settings['gender']?.toString().trim().toLowerCase();
  return switch (raw) {
    'male' => 'male',
    'female' => 'female',
    _ => null,
  };
}

double? _profileWeightKg(AppProfile? profile) {
  final value = profile?.settings['weight'];
  if (value is! Map) return null;
  final primary = double.tryParse(value['primary']?.toString() ?? '');
  if (primary == null) return null;
  final unit = value['unit']?.toString();
  return unit == 'lb' ? primary / 2.20462 : primary;
}

int _recommendedWeeklyProteinTarget(AppProfile? profile) {
  final weightKg = _profileWeightKg(profile);
  if (weightKg == null) {
    return _roundWeeklyNutrientTarget(56 * 7);
  }
  return _roundWeeklyNutrientTarget(((weightKg * 0.8) * 7).round());
}

int _recommendedWeeklyFiberTarget(AppProfile? profile) {
  final age = _profileAge(profile);
  final gender = _profileGender(profile);
  final daily = switch ((gender, age)) {
    ('male', final int a) when a >= 14 && a <= 18 => 38,
    ('male', final int a) when a >= 19 && a <= 50 => 38,
    ('male', final int a) when a >= 51 => 30,
    ('female', final int a) when a >= 14 && a <= 18 => 26,
    ('female', final int a) when a >= 19 && a <= 50 => 25,
    ('female', final int a) when a >= 51 => 21,
    _ => 25,
  };
  return _roundWeeklyNutrientTarget(daily * 7);
}

int _roundWeeklyNutrientTarget(int value) {
  return ((value / 5).round() * 5).clamp(70, 1400);
}
