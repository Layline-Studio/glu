import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/app_refresh_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';
import '../../widgets/expandable_notes.dart';
import '../../widgets/log_note_indicator.dart';
import '../../widgets/log_success_overlay.dart';
import '../../widgets/log_week_day_selector.dart';
import 'swipe_back_detector.dart';

final _allExerciseLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.exerciseColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _exerciseLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.exerciseColumn,
    date,
    date.add(const Duration(days: 1)),
  );
  results.sort(
      (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String));
  return results;
});

final _exerciseWeekDatesProvider =
    FutureProvider.autoDispose.family<Set<DateTime>, DateTime>((
  ref,
  date,
) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.exerciseColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

// ── Background screen ─────────────────────────────────────────────────────────

class ExerciseLogScreen extends ConsumerStatefulWidget {
  const ExerciseLogScreen({super.key});

  @override
  ConsumerState<ExerciseLogScreen> createState() => _ExerciseLogScreenState();
}

class _ExerciseLogScreenState extends ConsumerState<ExerciseLogScreen> {
  late DateTime _selectedDate = _today;
  String? _successLabel;
  bool _isListView = true;

  static DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openSheet());
  }

  Future<void> _openSheet({Map<String, dynamic>? entry}) async {
    final label = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ExerciseInputSheet(
        existingEntry: entry,
        selectedDate: _selectedDate,
        onSaved: (savedDate) {
          if (mounted) setState(() => _selectedDate = savedDate);
        },
      ),
    );
    if (label != null && mounted) {
      setState(() => _successLabel = label);
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final highlightedDates =
        ref.watch(_exerciseWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allExerciseLogsProvider(0));

    return SwipeBackDetector(
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: _successLabel != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nav bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Row(
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
                            context.l10n.exerciseLogTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkResponse(
                                onTap: () =>
                                    setState(() => _isListView = !_isListView),
                                radius: 20,
                                child: Icon(
                                  _isListView
                                      ? Icons.view_week_rounded
                                      : Icons.view_agenda_rounded,
                                  size: 22,
                                  color: colors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkResponse(
                                onTap: () => _openSheet(),
                                radius: 20,
                                child: Icon(
                                  Icons.add_rounded,
                                  size: 22,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (!_isListView) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LogWeekDaySelector(
                          highlightedDates: highlightedDates,
                          selected: _selectedDate,
                          onSelect: (date) =>
                              setState(() => _selectedDate = date),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                          child: _LoggedExerciseSection(
                            date: _selectedDate,
                            onEditEntry: (entry) => _openSheet(entry: entry),
                          ),
                        ),
                      ),
                    ] else
                      Expanded(
                        child: allEntries.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, _) => Center(child: Text('$error')),
                          data: (entries) => _ExerciseLogListSection(
                            entries: entries,
                            onEditEntry: (entry) => _openSheet(entry: entry),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_successLabel case final label?)
                Positioned.fill(
                  child: _ExerciseLogSuccessOverlay(label: label),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Input sheet ───────────────────────────────────────────────────────────────

class _ExerciseInputSheet extends ConsumerStatefulWidget {
  const _ExerciseInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
  });

  final Map<String, dynamic>? existingEntry;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_ExerciseInputSheet> createState() =>
      _ExerciseInputSheetState();
}

class _ExerciseInputSheetState extends ConsumerState<_ExerciseInputSheet> {
  static const double _activityCardWidth = 106;
  static const double _activityCardSpacing = 10;
  static const List<String> _activityValues = [
    'walking',
    'running',
    'cycling',
    'strength',
    'yoga',
    'swimming',
    'hiit',
    'custom',
  ];

  late final TextEditingController _notesController;
  late final TextEditingController _customActivityController;
  late final ScrollController _activityScrollController;

  late String? _activityType;
  late String? _durationMinutes;
  late String? _intensity;
  bool _isSubmitting = false;
  bool _isNotesExpanded = false;
  bool _isCustomActivityExpanded = false;
  int _visibleActivityIndex = 0;

  List<_ActivityOption> _activityOptions(BuildContext context) => [
        _ActivityOption(
            value: 'walking',
            label: context.l10n.exerciseLogWalking,
            icon: Icons.directions_walk_rounded),
        _ActivityOption(
            value: 'running',
            label: context.l10n.exerciseLogRunning,
            icon: Icons.directions_run_rounded),
        _ActivityOption(
            value: 'cycling',
            label: context.l10n.exerciseLogCycling,
            icon: Icons.pedal_bike_rounded),
        _ActivityOption(
            value: 'strength',
            label: context.l10n.exerciseLogStrength,
            icon: Icons.fitness_center_rounded),
        _ActivityOption(
            value: 'yoga',
            label: context.l10n.exerciseLogYoga,
            icon: Icons.self_improvement_rounded),
        _ActivityOption(
            value: 'swimming',
            label: context.l10n.exerciseLogSwim,
            icon: Icons.waves_rounded),
        _ActivityOption(
            value: 'hiit', label: context.l10n.exerciseLogHiit, icon: Icons.bolt_rounded),
        _ActivityOption(
            value: 'custom',
            label: context.l10n.exerciseLogCustomActivity,
            icon: Icons.edit_rounded),
      ];

  static const _durationOptions = <String>[
    '15',
    '30',
    '45',
    '60',
    '75',
    '90',
    '105',
    '120',
  ];

  bool get _isEditing => widget.existingEntry != null;

  int? get _parsedDurationMinutes => int.tryParse(_durationMinutes ?? '');

  String? get _resolvedActivityType {
    if (_activityType == null) return null;
    if (_activityType != 'custom') return _activityType;
    final custom = _customActivityController.text.trim();
    return custom.isEmpty ? null : custom;
  }

  bool get _isValid =>
      _resolvedActivityType != null &&
      (_parsedDurationMinutes ?? 0) > 0 &&
      _intensity != null;

  String _friendlyDate(BuildContext context, DateTime date) {
    return formatFriendlyLogDate(context, date);
  }

  /// Snaps [value] to the nearest option in [_durationOptions].
  static String _snapDuration(int value) {
    return _durationOptions.reduce((a, b) {
      final da = (int.parse(a) - value).abs();
      final db = (int.parse(b) - value).abs();
      return da <= db ? a : b;
    });
  }

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _customActivityController = TextEditingController();
    _activityScrollController = ScrollController();
    _activityScrollController.addListener(_handleActivityScroll);

    final entry = widget.existingEntry;
    if (entry != null) {
      // Pre-fill from existing entry
      final storedActivity = entry['activity_type'] as String?;
      final knownIndex = _activityValues.indexWhere(
        (value) => value == storedActivity && value != 'custom',
      );
      if (knownIndex >= 0) {
        _activityType = storedActivity;
        _visibleActivityIndex = knownIndex;
      } else if (storedActivity != null) {
        _activityType = 'custom';
        _customActivityController.text = storedActivity;
        _isCustomActivityExpanded = true;
        _visibleActivityIndex = _activityValues.length - 1;
      }

      final storedDuration = (entry['duration_minutes'] as num?)?.toInt();
      _durationMinutes =
          storedDuration != null ? _snapDuration(storedDuration) : '60';

      _intensity = entry['intensity'] as String? ?? 'moderate';
      _notesController.text = entry['notes'] as String? ?? '';
      if (_notesController.text.isNotEmpty) _isNotesExpanded = true;
    } else {
      _activityType = null;
      _durationMinutes = '60';
      _intensity = 'moderate';
    }

    for (final c in [_notesController, _customActivityController]) {
      c.addListener(_rebuild);
    }

    // Scroll carousel to initial selection after first frame
    if (_visibleActivityIndex > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final itemExtent = _activityCardWidth + _activityCardSpacing;
        _activityScrollController.jumpTo(
          (_visibleActivityIndex * itemExtent).clamp(
            0,
            _activityScrollController.position.maxScrollExtent,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _activityScrollController
      ..removeListener(_handleActivityScroll)
      ..dispose();
    for (final c in [_notesController, _customActivityController]) {
      c
        ..removeListener(_rebuild)
        ..dispose();
    }
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _handleActivityScroll() {
    final itemExtent = _activityCardWidth + _activityCardSpacing;
    final nextIndex = (_activityScrollController.offset / itemExtent)
        .round()
        .clamp(0, _activityValues.length - 1);
    if (nextIndex != _visibleActivityIndex && mounted) {
      setState(() => _visibleActivityIndex = nextIndex);
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_isValid) return;

    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final activityType = _resolvedActivityType!;
    final durationMinutes = _parsedDurationMinutes!;
    final notes = _notesController.text.trim();
    final loggedAt = _buildLoggedAt();

    final payload = {
      'logged_at': formatIsoWithTimezone(loggedAt),
      'activity_type': activityType,
      'duration_minutes': durationMinutes,
      'intensity': _intensity,
      'notes': notes.isEmpty ? null : notes,
    };

    try {
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
            RecordService.exerciseColumn, existingId, payload);
      } else {
        await service.updateRecord(RecordService.exerciseColumn, payload);
      }
      ref.invalidate(_exerciseLogsProvider(widget.selectedDate));
      ref.invalidate(_exerciseWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allExerciseLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context)
          .pop(context.l10n.exerciseLogDurationLogged(durationMinutes));
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.exerciseLogCouldNotSave),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  DateTime _buildLoggedAt() {
    final existingLoggedAt = widget.existingEntry?['logged_at'] as String?;
    final parsedExisting = existingLoggedAt == null
        ? null
        : DateTime.tryParse(existingLoggedAt)?.toLocal();
    if (parsedExisting != null) {
      return parsedExisting;
    }

    final now = DateTime.now();
    final selectedDate = widget.selectedDate;
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
  }

  Future<void> _deleteEntry() async {
    final entryId = widget.existingEntry?['id'] as String?;
    if (!_isEditing || _isSubmitting || entryId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.exerciseLogDeleteTitle),
        content: Text(context.l10n.exerciseLogDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    try {
      await ref
          .read(recordServiceProvider)
          .deleteRecordEntry(RecordService.exerciseColumn, entryId);
      ref.invalidate(_exerciseLogsProvider(widget.selectedDate));
      ref.invalidate(_exerciseWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allExerciseLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.exerciseLogDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.exerciseLogCouldNotDelete),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.lineSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Sheet title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isEditing
                          ? context.l10n.exerciseLogEditTitle
                          : context.l10n.exerciseLogLogTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _friendlyDate(context, widget.selectedDate),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkResponse(
                  onTap: () => Navigator.of(context).pop(),
                  radius: 18,
                  child: Icon(Icons.close_rounded,
                      size: 20, color: colors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Form content
          Flexible(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 24 + viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity type label
                  Text(
                    context.l10n.exerciseLogActivityType,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Activity carousel
                  SizedBox(
                    height: 114,
                    child: ListView.separated(
                      controller: _activityScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: _activityOptions(context).length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: _activityCardSpacing),
                      itemBuilder: (context, index) {
                        final option = _activityOptions(context)[index];
                        return _ActivityCard(
                          option: option,
                          isSelected: _activityType == option.value,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _activityType = option.value;
                              _visibleActivityIndex = index;
                              _isCustomActivityExpanded =
                                  option.value == 'custom';
                              if (option.value != 'custom') {
                                _customActivityController.clear();
                              }
                            });
                            final itemExtent =
                                _activityCardWidth + _activityCardSpacing;
                            _activityScrollController.animateTo(
                              index * itemExtent,
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _HorizontalPagerIndicator(
                    itemCount: _activityOptions(context).length,
                    selectedIndex: _visibleActivityIndex,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    child: _isCustomActivityExpanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: _CustomActivityField(
                              controller: _customActivityController,
                              onCancel: () {
                                HapticFeedback.selectionClick();
                                setState(() {
                                  _customActivityController.clear();
                                  _activityType = null;
                                  _isCustomActivityExpanded = false;
                                });
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 14),
                  _ExerciseDetailsCard(
                    durationMinutes: _durationMinutes,
                    intensity: _intensity,
                    notesController: _notesController,
                    isNotesExpanded: _isNotesExpanded,
                    onDurationChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _durationMinutes = value);
                    },
                    onIntensityChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _intensity = value);
                    },
                    onNotesTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _isNotesExpanded = !_isNotesExpanded);
                    },
                  ),
                  const SizedBox(height: 24),
                  if (_isEditing) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _isSubmitting ? null : _deleteEntry,
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: Text(context.l10n.exerciseLogDeleteLog),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: (_isSubmitting || !_isValid) ? null : _submit,
                      child: Text(
                        _isSubmitting
                            ? context.l10n.exerciseLogSaving
                            : _isEditing
                                ? context.l10n.exerciseLogSaveChanges
                                : context.l10n.exerciseLogAddExercise,
                      ),
                    ),
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

// ── Logged exercise list ──────────────────────────────────────────────────────

class _LoggedExerciseSection extends ConsumerWidget {
  const _LoggedExerciseSection({required this.date, required this.onEditEntry});

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_exerciseLogsProvider(date));

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (entries) {
        if (entries.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formatLoggedSectionDate(context, date),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.softSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${entries.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _LoggedExerciseCard(
                    entry: entry,
                    onTap: () => onEditEntry(entry),
                  ),
                )),
          ],
        );
      },
    );
  }
}

class _ExerciseLogListSection extends StatelessWidget {
  const _ExerciseLogListSection({
    required this.entries,
    required this.onEditEntry,
  });

  final List<Map<String, dynamic>> entries;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    if (entries.isEmpty) {
      return Center(
        child: Text(
          context.l10n.progressNoLogsYet,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      );
    }

    final grouped = <DateTime, List<Map<String, dynamic>>>{};
    for (final entry in entries) {
      final loggedAt = DateTime.tryParse(entry['logged_at'] as String? ?? '');
      if (loggedAt == null) continue;
      final day = dateOnly(loggedAt.toLocal());
      grouped.putIfAbsent(day, () => <Map<String, dynamic>>[]).add(entry);
    }

    final days = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: days.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final day = days[index];
        final dayEntries = grouped[day]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formatLoggedSectionDate(context, day),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.softSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${dayEntries.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...dayEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _LoggedExerciseCard(
                  entry: entry,
                  onTap: () => onEditEntry(entry),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoggedExerciseCard extends StatelessWidget {
  const _LoggedExerciseCard({required this.entry, required this.onTap});

  final Map<String, dynamic> entry;
  final VoidCallback onTap;

  static IconData _iconForActivity(String? activityType) {
    return switch (activityType) {
      'walking' => Icons.directions_walk_rounded,
      'running' => Icons.directions_run_rounded,
      'cycling' => Icons.pedal_bike_rounded,
      'strength' => Icons.fitness_center_rounded,
      'yoga' => Icons.self_improvement_rounded,
      'swimming' => Icons.waves_rounded,
      'hiit' => Icons.bolt_rounded,
      _ => Icons.edit_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final activityType = entry['activity_type'] as String?;
    final duration = (entry['duration_minutes'] as num?)?.toInt() ?? 0;
    final intensity = entry['intensity'] as String?;
    final notes = (entry['notes'] as String?)?.trim();
    final hasNotes = notes != null && notes.isNotEmpty;

    final loggedAt = entry['logged_at'] as String?;
    String timeLabel = '';
    if (loggedAt != null) {
      final parsed = DateTime.tryParse(loggedAt)?.toLocal();
      if (parsed != null) {
        final h = parsed.hour.toString().padLeft(2, '0');
        final m = parsed.minute.toString().padLeft(2, '0');
        timeLabel = '$h:$m';
      }
    }

    final activityLabel = activityType != null
        ? activityType[0].toUpperCase() + activityType.substring(1)
        : context.l10n.exerciseLogTitle;
    final durationLabel = _formatDurationLabel(duration.toString());
    final intensityLabel = intensity != null
        ? intensity[0].toUpperCase() + intensity.substring(1)
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.lineSubtle),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1FA84A).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _iconForActivity(activityType),
                size: 18,
                color: const Color(0xFF1FA84A),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activityLabel,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasNotes) ...[
                        const SizedBox(width: 8),
                        LogNoteIndicator(color: colors.textSecondary),
                      ],
                      if (timeLabel.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          timeLabel,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    intensityLabel.isNotEmpty
                        ? '$durationLabel · $intensityLabel'
                        : durationLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: colors.textSecondary.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Success overlay ───────────────────────────────────────────────────────────

class _ExerciseLogSuccessOverlay extends StatelessWidget {
  const _ExerciseLogSuccessOverlay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LogSuccessOverlay(
      title: label,
      subtitle: context.l10n.exerciseLogAddedToExerciseLog,
      icons: List.generate(
        5,
        (index) => SuccessOverlayIconSpec(
          icon: Icons.directions_run_rounded,
          color: index.isEven ? colors.accentMint : colors.heroEnd,
        ),
      ),
      rippleColor: colors.accentMint,
    );
  }
}

// ── Week day selector ─────────────────────────────────────────────────────────

// ── Form widgets ──────────────────────────────────────────────────────────────

class _ExerciseDetailsCard extends StatelessWidget {
  const _ExerciseDetailsCard({
    required this.durationMinutes,
    required this.intensity,
    required this.notesController,
    required this.isNotesExpanded,
    required this.onDurationChanged,
    required this.onIntensityChanged,
    required this.onNotesTap,
  });

  final String? durationMinutes;
  final String? intensity;
  final TextEditingController notesController;
  final bool isNotesExpanded;
  final ValueChanged<String> onDurationChanged;
  final ValueChanged<String> onIntensityChanged;
  final VoidCallback onNotesTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        children: [
          _SelectorRow(
            label: context.l10n.exerciseLogDuration,
            child: _MenuSelector(
              value: durationMinutes,
              placeholder: context.l10n.commonSelect,
              items: _ExerciseInputSheetState._durationOptions,
              width: 220,
              itemLabelBuilder: _formatDurationLabel,
              onSelected: (value) {
                if (value != null) onDurationChanged(value);
              },
            ),
          ),
          const _RowDivider(),
          _SelectorRow(
            label: context.l10n.exerciseLogIntensity,
            child: _MenuSelector(
              value: intensity,
              placeholder: context.l10n.commonSelect,
              items: const ['light', 'moderate', 'intense'],
              width: 220,
              itemLabelBuilder: (value) => switch (value) {
                'light' => context.l10n.exerciseLogLight,
                'moderate' => context.l10n.exerciseLogModerate,
                'intense' => context.l10n.exerciseLogIntense,
                _ => value,
              },
              onSelected: (value) {
                if (value != null) onIntensityChanged(value);
              },
            ),
          ),
          const _RowDivider(),
          _SelectorRow(
            label: context.l10n.exerciseLogNotes,
            child: InlineNotesTrigger(
              value: notesController.text.trim(),
              isExpanded: isNotesExpanded,
              onTap: onNotesTap,
            ),
          ),
          if (isNotesExpanded) ...[
            const SizedBox(height: 2),
            ExpandedNotesField(
              controller: notesController,
              hintText: context.l10n.exerciseLogAnythingWorthRemembering,
            ),
          ],
        ],
      ),
    );
  }
}

String _formatDurationLabel(String value) {
  final minutes = int.tryParse(value);
  if (minutes == null) return value;
  if (minutes < 60) return '$minutes min';
  if (minutes == 60) return '1 h';
  final hours = minutes ~/ 60;
  final remaining = minutes % 60;
  return remaining == 0 ? '$hours h' : '$hours h $remaining min';
}

class _SelectorRow extends StatelessWidget {
  const _SelectorRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: Align(alignment: Alignment.centerRight, child: child),
          ),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Divider(height: 1, thickness: 1, color: colors.lineSubtle);
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _ActivityOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final background = isSelected ? const Color(0xFF1FA84A) : colors.surface;
    final foreground = isSelected ? colors.surface : colors.textPrimary;
    final iconColor = isSelected ? colors.surface : colors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          width: 106,
          height: 114,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: isSelected ? background : colors.lineSubtle,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon, size: 28, color: iconColor),
              const SizedBox(height: 12),
              Text(
                option.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomActivityField extends StatelessWidget {
  const _CustomActivityField({
    required this.controller,
    required this.onCancel,
  });

  final TextEditingController controller;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.l10n.exerciseLogCustomActivity,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onCancel,
                child: Text(
                  context.l10n.commonCancel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: colors.softSurface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: colors.lineSubtle),
            ),
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isCollapsed: true,
                filled: false,
                hintText: context.l10n.exerciseLogTypeActivity,
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuSelector extends StatelessWidget {
  const _MenuSelector({
    required this.value,
    required this.placeholder,
    required this.items,
    required this.onSelected,
    required this.width,
    this.itemLabelBuilder,
  });

  final String? value;
  final String placeholder;
  final List<String> items;
  final ValueChanged<String?> onSelected;
  final double width;
  final String Function(String value)? itemLabelBuilder;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final label =
        value == null ? placeholder : itemLabelBuilder?.call(value!) ?? value!;

    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) => items
          .map((item) => PopupMenuItem<String>(
                value: item,
                child: Text(itemLabelBuilder?.call(item) ?? item),
              ))
          .toList(),
      child: SizedBox(
        width: width,
        child: Container(
          constraints: const BoxConstraints(minHeight: 42),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: colors.softSurface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: colors.lineSubtle),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: value == null
                        ? colors.textSecondary
                        : colors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: colors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

class _HorizontalPagerIndicator extends StatelessWidget {
  const _HorizontalPagerIndicator({
    required this.itemCount,
    required this.selectedIndex,
  });

  final int itemCount;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: index == selectedIndex ? 18 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color:
                index == selectedIndex ? colors.textPrimary : colors.lineSubtle,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _ActivityOption {
  const _ActivityOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}
