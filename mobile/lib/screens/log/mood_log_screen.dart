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

final _allMoodLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.moodColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _moodLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.moodColumn,
    date,
    date.add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _moodWeekDatesProvider =
    FutureProvider.autoDispose.family<Set<DateTime>, DateTime>((
  ref,
  date,
) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.moodColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

class MoodLogScreen extends ConsumerStatefulWidget {
  const MoodLogScreen({super.key});

  @override
  ConsumerState<MoodLogScreen> createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends ConsumerState<MoodLogScreen> {
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
      builder: (_) => _MoodInputSheet(
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
        ref.watch(_moodWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allMoodLogsProvider(0));

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
                            context.l10n.moodLogTitle,
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
                          child: _LoggedMoodSection(
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
                          data: (entries) => _MoodLogListSection(
                            entries: entries,
                            onEditEntry: (entry) => _openSheet(entry: entry),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_successLabel case final label?)
                Positioned.fill(child: _SuccessOverlay(label: label)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoodInputSheet extends ConsumerStatefulWidget {
  const _MoodInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
  });

  final Map<String, dynamic>? existingEntry;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_MoodInputSheet> createState() => _MoodInputSheetState();
}

class _MoodInputSheetState extends ConsumerState<_MoodInputSheet> {
  late final TextEditingController _notesController;
  late String? _feeling;
  bool _isSubmitting = false;
  bool _isNotesExpanded = false;

  List<_FeelingOption> _feelingOptions(BuildContext context) => [
        _FeelingOption(
          value: 'bad',
          label: context.l10n.moodBad,
          icon: Icons.sentiment_dissatisfied_rounded,
          tint: const Color(0xFFE57E6D),
        ),
        _FeelingOption(
          value: 'okay',
          label: context.l10n.moodOkay,
          icon: Icons.sentiment_neutral_rounded,
          tint: const Color(0xFFF2B54B),
        ),
        _FeelingOption(
          value: 'good',
          label: context.l10n.moodGood,
          icon: Icons.sentiment_satisfied_rounded,
          tint: const Color(0xFF46B96C),
        ),
        _FeelingOption(
          value: 'great',
          label: context.l10n.moodGreat,
          icon: Icons.sentiment_very_satisfied_rounded,
          tint: const Color(0xFF1FA84A),
        ),
      ];

  bool get _isEditing => widget.existingEntry != null;
  bool get _isValid => _feeling != null;

  String _friendlyDate(BuildContext context, DateTime date) {
    return formatFriendlyLogDate(context, date);
  }

  @override
  void initState() {
    super.initState();
    final entry = widget.existingEntry;
    _notesController =
        TextEditingController(text: entry?['notes'] as String? ?? '');
    _feeling = entry?['feeling'] as String? ?? 'okay';
    if (_notesController.text.isNotEmpty) _isNotesExpanded = true;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  String _resolvedLoggedAt() {
    final existingLoggedAt = widget.existingEntry?['logged_at'] as String?;
    if (existingLoggedAt != null && existingLoggedAt.trim().isNotEmpty) {
      return existingLoggedAt;
    }

    final now = DateTime.now();
    final selected = widget.selectedDate;
    final isToday = selected.year == now.year &&
        selected.month == now.month &&
        selected.day == now.day;
    return formatIsoWithTimezone(isToday ? now : selected);
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_isValid) return;

    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final notes = _notesController.text.trim();
    final payload = {
      'logged_at': _resolvedLoggedAt(),
      'feeling': _feeling,
      'notes': notes.isEmpty ? null : notes,
    };

    try {
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
          RecordService.moodColumn,
          existingId,
          payload,
        );
      } else {
        await service.updateRecord(RecordService.moodColumn, payload);
      }
      ref.invalidate(_moodLogsProvider(widget.selectedDate));
      ref.invalidate(_moodWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allMoodLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.moodLogged);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.moodCouldNotSave),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  Future<void> _deleteEntry() async {
    final entryId = widget.existingEntry?['id'] as String?;
    if (!_isEditing || _isSubmitting || entryId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.moodDeleteTitle),
        content: Text(context.l10n.moodDeleteMessage),
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
          .deleteRecordEntry(RecordService.moodColumn, entryId);
      ref.invalidate(_moodLogsProvider(widget.selectedDate));
      ref.invalidate(_moodWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allMoodLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.moodDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.moodCouldNotDelete),
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
                          ? context.l10n.moodEditTitle
                          : context.l10n.moodLogTitle,
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
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 24 + viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(label: context.l10n.moodHowYouFeel),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      for (var i = 0; i < _feelingOptions(context).length; i++) ...[
                        Expanded(
                          child: _FeelingCard(
                            option: _feelingOptions(context)[i],
                            isSelected: _feeling == _feelingOptions(context)[i].value,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(
                                () => _feeling = _feelingOptions(context)[i].value,
                              );
                            },
                          ),
                        ),
                        if (i != _feelingOptions(context).length - 1)
                          const SizedBox(width: 8),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  _DetailsCard(
                    notesController: _notesController,
                    isNotesExpanded: _isNotesExpanded,
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
                        label: Text(context.l10n.moodDeleteLog),
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
                      onPressed: _isSubmitting || !_isValid ? null : _submit,
                      child: Text(
                        _isSubmitting
                            ? context.l10n.moodSaving
                            : _isEditing
                                ? context.l10n.commonSave
                                : context.l10n.moodAddMoodLog,
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

class _LoggedMoodSection extends ConsumerWidget {
  const _LoggedMoodSection({
    required this.date,
    required this.onEditEntry,
  });

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_moodLogsProvider(date));

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
            ...entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _LoggedMoodCard(
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

class _MoodLogListSection extends StatelessWidget {
  const _MoodLogListSection({
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
                child: _LoggedMoodCard(
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

class _LoggedMoodCard extends StatelessWidget {
  const _LoggedMoodCard({required this.entry, required this.onTap});

  final Map<String, dynamic> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final feeling = (entry['feeling'] as String?) ?? 'okay';
    final notes = (entry['notes'] as String?)?.trim();
    final hasNotes = notes != null && notes.isNotEmpty;

    final icon = switch (feeling) {
      'great' => Icons.sentiment_very_satisfied_rounded,
      'good' => Icons.sentiment_satisfied_rounded,
      'bad' => Icons.sentiment_dissatisfied_rounded,
      _ => Icons.sentiment_neutral_rounded,
    };
    final tint = switch (feeling) {
      'great' => const Color(0xFF1FA84A),
      'good' => const Color(0xFF46B96C),
      'bad' => const Color(0xFFE57E6D),
      _ => const Color(0xFFF2B54B),
    };

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

    final title = '${feeling[0].toUpperCase()}${feeling.substring(1)}';

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
                color: tint.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: tint),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
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

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({
    required this.notesController,
    required this.isNotesExpanded,
    required this.onNotesTap,
  });

  final TextEditingController notesController;
  final bool isNotesExpanded;
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    context.l10n.moodNotes,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 7,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InlineNotesTrigger(
                      value: notesController.text.trim(),
                      isExpanded: isNotesExpanded,
                      onTap: onNotesTap,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isNotesExpanded) ...[
            const SizedBox(height: 2),
            ExpandedNotesField(
              controller: notesController,
              hintText: context.l10n.moodAnythingWorthRemembering,
            ),
          ],
        ],
      ),
    );
  }
}

class _FeelingCard extends StatelessWidget {
  const _FeelingCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _FeelingOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final background = isSelected ? option.tint : colors.surface;
    final foreground = isSelected ? colors.surface : colors.textPrimary;
    final iconColor = isSelected ? colors.surface : option.tint;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          height: 100,
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
              Icon(option.icon, size: 24, color: iconColor),
              const SizedBox(height: 10),
              Text(
                option.label,
                style: theme.textTheme.bodyMedium?.copyWith(
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
      ),
    );
  }
}

class _FeelingOption {
  const _FeelingOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.tint,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color tint;
}

class _SuccessOverlay extends StatelessWidget {
  const _SuccessOverlay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LogSuccessOverlay(
      title: label,
      subtitle: context.l10n.moodAddedToMoodLog,
      icons: [
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_very_satisfied_rounded,
          color: colors.accentMint,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_satisfied_rounded,
          color: colors.heroEnd,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_neutral_rounded,
          color: colors.accentButter,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_dissatisfied_rounded,
          color: colors.accentPeach,
        ),
      ],
      rippleColor: colors.accentLilac,
      badgeColor: colors.softSurface,
    );
  }
}
