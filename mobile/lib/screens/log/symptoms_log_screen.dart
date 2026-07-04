import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../models/symptom_catalog.dart';
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

final _allSymptomLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.symptomsColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _symptomLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.symptomsColumn,
    date,
    date.add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _symptomWeekDatesProvider =
    FutureProvider.autoDispose.family<Set<DateTime>, DateTime>((
  ref,
  date,
) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.symptomsColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

class SymptomsLogScreen extends ConsumerStatefulWidget {
  const SymptomsLogScreen({super.key});

  @override
  ConsumerState<SymptomsLogScreen> createState() => _SymptomsLogScreenState();
}

class _SymptomsLogScreenState extends ConsumerState<SymptomsLogScreen> {
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
      builder: (_) => _SymptomsInputSheet(
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
        ref.watch(_symptomWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allSymptomLogsProvider(0));

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
                            context.l10n.symptomsLogTitle,
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
                          child: _LoggedSymptomsSection(
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
                          data: (entries) => _SymptomLogListSection(
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

class _SymptomsInputSheet extends ConsumerStatefulWidget {
  const _SymptomsInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
  });

  final Map<String, dynamic>? existingEntry;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_SymptomsInputSheet> createState() =>
      _SymptomsInputSheetState();
}

class _SymptomsInputSheetState extends ConsumerState<_SymptomsInputSheet> {
  static const _noSymptomsValue = SymptomCatalog.noSymptoms;

  late final TextEditingController _notesController;
  late String? _severity;
  bool _isSubmitting = false;
  bool _isNotesExpanded = false;
  bool _isShowingOtherSymptoms = false;
  final List<String> _selectedSymptoms = [];

  List<_SeverityOption> _severityOptions(BuildContext context) => [
        _SeverityOption(
          value: 'mild',
          label: context.l10n.symptomsLogMild,
          icon: Icons.wb_sunny_outlined,
          tint: const Color(0xFF46B96C),
        ),
        _SeverityOption(
          value: 'moderate',
          label: context.l10n.symptomsLogModerate,
          icon: Icons.tonality_rounded,
          tint: const Color(0xFFF2B54B),
        ),
        _SeverityOption(
          value: 'severe',
          label: context.l10n.symptomsLogSevere,
          icon: Icons.warning_amber_rounded,
          tint: const Color(0xFFE57E6D),
        ),
      ];

  bool get _isEditing => widget.existingEntry != null;

  bool get _noSymptomsSelected => _selectedSymptoms.contains(_noSymptomsValue);

  bool get _hasSelectedSymptoms =>
      _selectedSymptoms.any((value) => value != _noSymptomsValue);

  bool get _isValid => _noSymptomsSelected || _severity != null;

  String _friendlyDate(BuildContext context, DateTime date) {
    return formatFriendlyLogDate(context, date);
  }

  @override
  void initState() {
    super.initState();
      final entry = widget.existingEntry;
      _notesController =
          TextEditingController(text: entry?['notes'] as String? ?? '');
    _severity = entry?['severity'] as String? ?? 'mild';
    final seededSymptoms = SymptomCatalog.normalizeValues(
      entry?['symptoms'] as List? ?? const [],
    );
    if (entry != null && seededSymptoms.isEmpty) {
      _selectedSymptoms.add(_noSymptomsValue);
    } else {
      _selectedSymptoms.addAll(seededSymptoms);
    }
    _isShowingOtherSymptoms = _selectedSymptoms.any(
      (value) =>
          SymptomCatalog.otherOptions(context)
              .any((option) => option.value == value),
    );
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
    final normalizedSymptoms = _selectedSymptoms.contains(_noSymptomsValue)
        ? const <String>[_noSymptomsValue]
        : List<String>.from(_selectedSymptoms);
    final payload = {
      'logged_at': _resolvedLoggedAt(),
      'symptoms': normalizedSymptoms,
      'severity': _severity,
      'notes': notes.isEmpty ? null : notes,
    };

    try {
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
          RecordService.symptomsColumn,
          existingId,
          payload,
        );
      } else {
        await service.updateRecord(RecordService.symptomsColumn, payload);
      }
      ref.invalidate(_symptomLogsProvider(widget.selectedDate));
      ref.invalidate(_symptomWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allSymptomLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      final label = normalizedSymptoms.isEmpty
          ? context.l10n.symptomsLogLogged
          : '${normalizedSymptoms.length} symptom${normalizedSymptoms.length == 1 ? '' : 's'} logged';
      Navigator.of(context).pop(label);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.symptomsLogCouldNotSave),
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
        title: Text(context.l10n.symptomsLogDeleteTitle),
        content: Text(context.l10n.symptomsLogDeleteMessage),
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
          .deleteRecordEntry(RecordService.symptomsColumn, entryId);
      ref.invalidate(_symptomLogsProvider(widget.selectedDate));
      ref.invalidate(_symptomWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allSymptomLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.symptomsLogDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.symptomsLogCouldNotDelete),
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
                          ? context.l10n.symptomsLogEditTitle
                          : context.l10n.symptomsLogLogTitle,
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
                  _SectionLabel(label: context.l10n.symptomsLogSymptomsExperienced),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.0,
                    children: [
                      _SymptomChip(
                        label: context.l10n.symptomsLogNoSymptoms,
                        isSelected:
                            _selectedSymptoms.contains(_noSymptomsValue),
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            if (_selectedSymptoms.contains(_noSymptomsValue)) {
                              _selectedSymptoms.remove(_noSymptomsValue);
                            } else {
                              _selectedSymptoms
                                ..clear()
                                ..add(_noSymptomsValue);
                            }
                          });
                        },
                      ),
                        ...SymptomCatalog.prioritizedOptions(context).map((option) {
                        final isSelected =
                            _selectedSymptoms.contains(option.value);
                        return _SymptomChip(
                          label: option.label,
                          isSelected: isSelected,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _selectedSymptoms.remove(_noSymptomsValue);
                              if (isSelected) {
                                _selectedSymptoms.remove(option.value);
                              } else {
                                _selectedSymptoms.add(option.value);
                              }
                            });
                          },
                        );
                      }),
                      if (!_isShowingOtherSymptoms)
                        _SymptomChip(
                          label: context.l10n.symptomsLogOther,
                          isSelected: false,
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _isShowingOtherSymptoms = true);
                          },
                        ),
                      if (_isShowingOtherSymptoms)
                        ...SymptomCatalog.otherOptions(context).map((option) {
                          final isSelected =
                              _selectedSymptoms.contains(option.value);
                          return _SymptomChip(
                            label: option.label,
                            isSelected: isSelected,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() {
                                _selectedSymptoms.remove(_noSymptomsValue);
                                if (isSelected) {
                                  _selectedSymptoms.remove(option.value);
                                } else {
                                  _selectedSymptoms.add(option.value);
                                }
                              });
                            },
                          );
                        }),
                    ],
                  ),
                  if (_hasSelectedSymptoms) ...[
                    const SizedBox(height: 16),
                    _SectionLabel(label: context.l10n.symptomsLogSeverityLevel),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        for (var i = 0; i < _severityOptions(context).length; i++) ...[
                          Expanded(
                            child: _SeverityCard(
                              option: _severityOptions(context)[i],
                              isSelected:
                                  _severity == _severityOptions(context)[i].value,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(
                                  () => _severity = _severityOptions(context)[i].value,
                                );
                              },
                            ),
                          ),
                          if (i != _severityOptions(context).length - 1)
                            const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ],
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
                        label: Text(context.l10n.symptomsLogDeleteLog),
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
                            ? context.l10n.symptomsLogSaving
                            : _isEditing
                                ? context.l10n.symptomsLogSaveChanges
                                : context.l10n.symptomsLogAddSymptoms,
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

class _LoggedSymptomsSection extends ConsumerWidget {
  const _LoggedSymptomsSection({
    required this.date,
    required this.onEditEntry,
  });

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_symptomLogsProvider(date));

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
                child: _LoggedSymptomCard(
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

class _SymptomLogListSection extends StatelessWidget {
  const _SymptomLogListSection({
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
          context.l10n.progressNoSymptomsLoggedYet,
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
                child: _LoggedSymptomCard(
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

class _LoggedSymptomCard extends StatelessWidget {
  const _LoggedSymptomCard({required this.entry, required this.onTap});

  final Map<String, dynamic> entry;
  final VoidCallback onTap;

  String _symptomSummary(BuildContext context, List<String> symptoms) {
    if (symptoms.isEmpty ||
        (symptoms.length == 1 && symptoms.first == SymptomCatalog.noSymptoms)) {
      return context.l10n.symptomsLogNoSymptomsToday;
    }
    if (symptoms.length == 1) return symptoms.first;
    return '${symptoms.first} +${symptoms.length - 1} more';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final severity = (entry['severity'] as String?) ?? 'mild';
    final notes = (entry['notes'] as String?)?.trim();
    final hasNotes = notes != null && notes.isNotEmpty;
    final symptoms =
        SymptomCatalog.normalizeValues(entry['symptoms'] as List? ?? []);
    final hasNoSymptoms = symptoms.isEmpty ||
        (symptoms.length == 1 && symptoms.first == SymptomCatalog.noSymptoms);
    final labels = symptoms
        .where((value) => value != SymptomCatalog.noSymptoms)
        .map((value) => SymptomCatalog.labelFor(context, value))
        .toList(growable: false);

    final icon = hasNoSymptoms
        ? Icons.favorite_border_rounded
        : Icons.medical_information_rounded;
    final tint = switch (severity) {
      'severe' => const Color(0xFFE57E6D),
      'moderate' => const Color(0xFFF2B54B),
      _ => const Color(0xFF46B96C),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _symptomSummary(context, labels),
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
                  const SizedBox(height: 4),
                  Text(
                    hasNoSymptoms
                        ? context.l10n.symptomsLogNoSymptoms
                        : '${severity[0].toUpperCase()}${severity.substring(1)}',
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
                    context.l10n.symptomsLogNotes,
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
              hintText: context.l10n.symptomsLogAnythingWorthRemembering,
            ),
          ],
        ],
      ),
    );
  }
}

class _SeverityCard extends StatelessWidget {
  const _SeverityCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _SeverityOption option;
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
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          height: 78,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? background : colors.lineSubtle,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon, size: 20, color: iconColor),
              const SizedBox(height: 6),
              Text(
                option.label,
                style: theme.textTheme.bodySmall?.copyWith(
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

class _SymptomChip extends StatelessWidget {
  const _SymptomChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? colors.accentButter : colors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? colors.heroEnd : colors.lineSubtle,
            ),
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: colors.textPrimary,
                fontSize: 12,
              ),
            ),
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

class _SeverityOption {
  const _SeverityOption({
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
      subtitle: context.l10n.symptomsLogAddedToSymptomsLog,
      icons: [
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_satisfied_alt_rounded,
          color: colors.accentMint,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_neutral_rounded,
          color: colors.accentButter,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.sentiment_dissatisfied_rounded,
          color: colors.accentPeach,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.medical_information_rounded,
          color: colors.heroEnd,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.favorite_border_rounded,
          color: colors.accentLilac,
        ),
      ],
      rippleColor: colors.accentPeach,
    );
  }
}
