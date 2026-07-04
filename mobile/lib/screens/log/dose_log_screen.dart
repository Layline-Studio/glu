import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../models/injection_site_catalog.dart';
import '../../models/medication_catalog.dart';
import '../../providers/app_refresh_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';
import '../../widgets/custom_dose_slider.dart';
import '../../widgets/expandable_notes.dart';
import '../../widgets/log_note_indicator.dart';
import '../../widgets/log_success_overlay.dart';
import '../../widgets/log_week_day_selector.dart';
import 'swipe_back_detector.dart';

final _allDoseLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.dosesColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _doseLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.dosesColumn,
    date,
    date.add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _doseWeekDatesProvider =
    FutureProvider.autoDispose.family<Set<DateTime>, DateTime>((
  ref,
  date,
) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.dosesColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

class DoseLogScreen extends ConsumerStatefulWidget {
  const DoseLogScreen({super.key});

  @override
  ConsumerState<DoseLogScreen> createState() => _DoseLogScreenState();
}

class _DoseLogScreenState extends ConsumerState<DoseLogScreen> {
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

  Future<Map<String, dynamic>?> _firstEntryForSelectedDate() async {
    return ref.read(_doseLogsProvider(_selectedDate).future).then(
          (entries) => entries.isEmpty ? null : entries.first,
        );
  }

  Future<void> _openSheet({Map<String, dynamic>? entry}) async {
    final existingForDay = entry ?? await _firstEntryForSelectedDate();
    if (!mounted) return;
    final label = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DoseInputSheet(
        existingEntry: existingForDay,
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
        ref.watch(_doseWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allDoseLogsProvider(0));

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
                            context.l10n.doseLogTitle,
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
                          child: _LoggedDoseSection(
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
                          data: (entries) => _DoseLogListSection(
                            entries: entries,
                            onEditEntry: (entry) => _openSheet(entry: entry),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_successLabel case final label?)
                Positioned.fill(child: _DoseLogSuccessOverlay(label: label)),
            ],
          ),
        ),
      ),
      );
    }
  }

class _DoseInputSheet extends ConsumerStatefulWidget {
  const _DoseInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
  });

  final Map<String, dynamic>? existingEntry;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_DoseInputSheet> createState() => _DoseInputSheetState();
}

class _DoseInputSheetState extends ConsumerState<_DoseInputSheet> {
  static const _customDoseMenuValue = '__custom_dose__';
  late final TextEditingController _notesController;

  late String _method;
  String? _selectedMedication;
  String? _selectedDose;
  String? _injectionSite;
  bool _isSubmitting = false;
  bool _didSeedProfile = false;
  bool _isNotesExpanded = false;

  bool get _isEditing => widget.existingEntry != null;

  bool get _isValid {
    if (_selectedMedication == null || _selectedDose == null) return false;
    if (_method == 'injection' && _injectionSite == null) return false;
    return true;
  }

  String _ctaLabel(BuildContext context) {
    final dose = _selectedDose;
    if (_isEditing) return context.l10n.doseLogSaveChanges;
    return dose == null
        ? context.l10n.doseLogAddDose
        : '${context.l10n.doseLogAddDose} (${MedicationCatalog.formatDoseLabel(dose)})';
  }

  String _friendlyDate(BuildContext context, DateTime date) {
    return formatFriendlyLogDate(context, date);
  }

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _notesController.addListener(_handleTextChanged);

    final entry = widget.existingEntry;
    if (entry != null) {
      _method = (entry['method'] as String?) == 'pill' ? 'pill' : 'injection';
      final medicationOptions = MedicationCatalog.medicationsForMethod(_method);
      final medication = entry['medication']?.toString().trim();
      _selectedMedication = medicationOptions.contains(medication)
          ? medication
          : (medicationOptions.isEmpty ? null : medicationOptions.first);
      final doseRaw = entry['dose'];
      _selectedDose = MedicationCatalog.normalizeDoseValue(
            doseRaw,
            medication: _selectedMedication,
          ) ??
          MedicationCatalog.coerceDoseValue(doseRaw);
      final site = entry['injection_site'] as String?;
      _injectionSite = _method == 'injection' &&
              site != null &&
              InjectionSiteCatalog.values.contains(site)
          ? site
          : null;
      _notesController.text = entry['notes'] as String? ?? '';
      if (_notesController.text.isNotEmpty) _isNotesExpanded = true;
      _didSeedProfile = true;
    } else {
      _method = 'injection';
      _seedFromProfileIfNeeded();
    }
  }

  @override
  void dispose() {
    _notesController
      ..removeListener(_handleTextChanged)
      ..dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    if (mounted) setState(() {});
  }

  void _seedFromProfileIfNeeded() {
    if (_didSeedProfile) return;
    final profile = ref.read(profileBootstrapProvider).asData?.value;
    final settings = profile?.settings ?? const <String, dynamic>{};
    final nextDoseItem = profile?.reminders.dose.items.isNotEmpty == true
        ? profile!.reminders.dose.items.first
        : null;
    final nextDoseMetadata =
        nextDoseItem?.metadata ?? const <String, dynamic>{};
    final currentMethod = settings['medication_method'] as String?;
    final currentMedication = settings['medication_name']?.toString().trim();
    final currentDoseRaw = settings['current_dose_mg'];
    final nextDoseMethod = nextDoseMetadata['format'] as String?;
    final nextDoseMedication =
        nextDoseMetadata['medication']?.toString().trim();
    final nextDoseRaw = nextDoseMetadata['dose'];
    final nextDoseSite = nextDoseMetadata['injection_site'] as String?;

    _method = nextDoseMethod == 'pill'
        ? 'pill'
        : (currentMethod == 'pill' ? 'pill' : 'injection');
    final medicationOptions = MedicationCatalog.medicationsForMethod(_method);
    _selectedMedication = medicationOptions.contains(nextDoseMedication)
        ? nextDoseMedication
        : medicationOptions.contains(currentMedication)
            ? currentMedication
            : (medicationOptions.isEmpty ? null : medicationOptions.first);

    final nextDose = MedicationCatalog.normalizeDoseValue(
          nextDoseRaw,
          medication: _selectedMedication,
        ) ??
        MedicationCatalog.coerceDoseValue(nextDoseRaw);
    final currentDose = MedicationCatalog.normalizeDoseValue(
          currentDoseRaw,
          medication: _selectedMedication,
        ) ??
        MedicationCatalog.coerceDoseValue(currentDoseRaw);
    _selectedDose = nextDose ??
        currentDose ??
        (() {
          final doseOptions =
              MedicationCatalog.dosesForMedication(_selectedMedication);
          return doseOptions.isEmpty ? null : doseOptions.first;
        })();
    _injectionSite = _method == 'injection' &&
            nextDoseSite != null &&
            InjectionSiteCatalog.values.contains(nextDoseSite)
        ? nextDoseSite
        : null;
    _didSeedProfile = true;
  }

  List<String> _doseMenuItems() {
    final options = [
      ...MedicationCatalog.dosesForMedication(_selectedMedication)
    ];
    final custom = MedicationCatalog.coerceDoseValue(_selectedDose);
    if (custom != null && !options.contains(custom)) {
      options.add(custom);
    }
    options.add(_customDoseMenuValue);
    return options;
  }

  DateTime _buildLoggedAt() {
    final now = DateTime.now();
    return DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
  }

  Future<void> _pickCustomDose() async {
    final range =
        MedicationCatalog.customDoseRangeForMedication(_selectedMedication);
    var draft = double.tryParse(
          MedicationCatalog.coerceDoseValue(_selectedDose) ??
              MedicationCatalog.customInitialDoseForMedication(
                _selectedMedication,
              ),
        ) ??
        range.min;

    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final colors = context.appColors;
        final theme = Theme.of(context);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.lineSubtle,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    context.l10n.doseLogCustomDose,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l10n.doseLogCustomDoseBody,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomDoseSlider(
                    value: draft,
                    min: range.min,
                    max: range.max,
                    step: range.step,
                    onChanged: (value) {
                      setModalState(() {
                        draft = double.tryParse(value) ?? range.min;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(context.l10n.commonCancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            final normalized =
                                MedicationCatalog.coerceDoseValue(draft) ??
                                    draft.toString();
                            Navigator.of(context).pop(normalized);
                          },
                          child: Text(context.l10n.doseLogUseThisDose),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    final normalized = MedicationCatalog.coerceDoseValue(result);
    if (!mounted || normalized == null) return;
    HapticFeedback.selectionClick();
    setState(() {
      _selectedDose = normalized;
    });
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_isValid) return;
    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final now = DateTime.now();
    final loggedAt = _buildLoggedAt();
    final medication = _selectedMedication!;
    final dose = MedicationCatalog.formatDoseLabel(_selectedDose!);
    final notes = _notesController.text.trim();
    final existingCreatedAt = widget.existingEntry?['created_at'] as String?;
    final payload = {
      'logged_at': formatIsoWithTimezone(loggedAt),
      'created_at': existingCreatedAt ?? formatIsoWithTimezone(now),
      'method': _method,
      'medication': medication,
      'dose': dose,
      'injection_site': _method == 'injection' ? _injectionSite : null,
      'notes': notes.isEmpty ? null : notes,
    };

    try {
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
          RecordService.dosesColumn,
          existingId,
          payload,
        );
      } else {
        final dayEntries = await ref.read(
          _doseLogsProvider(widget.selectedDate).future,
        );
        if (dayEntries.isNotEmpty) {
          final entryId = dayEntries.first['id'] as String?;
          if (entryId != null) {
            final dayCreatedAt = dayEntries.first['created_at'] as String?;
            await service.updateRecordEntry(
              RecordService.dosesColumn,
              entryId,
              {
                ...payload,
                'created_at': dayCreatedAt ?? payload['created_at'],
              },
            );
          } else {
            await service.updateRecord(RecordService.dosesColumn, payload);
          }
        } else {
          await service.updateRecord(RecordService.dosesColumn, payload);
        }
      }
      ref.invalidate(_doseLogsProvider(widget.selectedDate));
      ref.invalidate(_doseWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allDoseLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(dose);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.doseLogCouldNotSave),
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
        title: Text(context.l10n.doseLogDeleteTitle),
        content: Text(context.l10n.doseLogDeleteMessage),
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
          .deleteRecordEntry(RecordService.dosesColumn, entryId);
      ref.invalidate(_doseLogsProvider(widget.selectedDate));
      ref.invalidate(_doseWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allDoseLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.doseLogDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.doseLogCouldNotDelete),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEditing) _seedFromProfileIfNeeded();
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
                          ? context.l10n.doseLogEditTitle
                          : context.l10n.doseLogLogTitle,
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
                  _DoseDetailsCard(
                    method: _method,
                    selectedMedication: _selectedMedication,
                    selectedDose: _selectedDose,
                    doseItems: _doseMenuItems(),
                    injectionSite: _injectionSite,
                    notesController: _notesController,
                    isNotesExpanded: _isNotesExpanded,
                    onMethodChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _method = value;
                        final medicationOptions =
                            MedicationCatalog.medicationsForMethod(value);
                        if (!medicationOptions.contains(_selectedMedication)) {
                          _selectedMedication = medicationOptions.isEmpty
                              ? null
                              : medicationOptions.first;
                        }
                        final doseOptions =
                            MedicationCatalog.dosesForMedication(
                          _selectedMedication,
                        );
                        if (!doseOptions.contains(_selectedDose)) {
                          _selectedDose =
                              doseOptions.isEmpty ? null : doseOptions.first;
                        }
                        if (value == 'pill') {
                          _injectionSite = null;
                        }
                      });
                    },
                    onMedicationChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedMedication = value;
                        final doseOptions =
                            MedicationCatalog.dosesForMedication(value);
                        if (!doseOptions.contains(_selectedDose)) {
                          _selectedDose =
                              doseOptions.isEmpty ? null : doseOptions.first;
                        }
                      });
                    },
                    onDoseChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedDose = value);
                    },
                    onCustomDoseTap: _pickCustomDose,
                    onInjectionSiteChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _injectionSite = value);
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
                        label: Text(context.l10n.doseLogDeleteLog),
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
                            ? context.l10n.doseLogSaving
                            : _ctaLabel(context),
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

class _LoggedDoseSection extends ConsumerWidget {
  const _LoggedDoseSection({
    required this.date,
    required this.onEditEntry,
  });

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_doseLogsProvider(date));

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (entries) {
        if (entries.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'No dose logged for this day yet.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          );
        }
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
                child: _LoggedDoseCard(
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

class _DoseLogListSection extends StatelessWidget {
  const _DoseLogListSection({
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
          'No dose logs yet.',
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

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: grouped.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final day = grouped.keys.elementAt(index);
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
                child: _LoggedDoseCard(
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

class _LoggedDoseCard extends StatelessWidget {
  const _LoggedDoseCard({required this.entry, required this.onTap});

  final Map<String, dynamic> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final method = (entry['method'] as String?) ?? 'injection';
    final medication = entry['medication']?.toString().trim();
    final dose = entry['dose']?.toString().trim();
    final site = entry['injection_site'] as String?;
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

    final subtitleParts = <String>[
      if (dose != null && dose.isNotEmpty) dose,
      method == 'pill'
          ? context.l10n.doseReminderPill
          : context.l10n.doseReminderInjection,
      if (method == 'injection' && site != null && site.isNotEmpty)
        InjectionSiteCatalog.labelFor(context, site),
    ];

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
                color: colors.accentLilac.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                method == 'pill'
                    ? Icons.medication_rounded
                    : Icons.vaccines_outlined,
                size: 18,
                color: colors.heroEnd.withValues(alpha: 0.85),
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
                          medication?.isNotEmpty == true
                              ? medication!
                              : context.l10n.doseLogTitle,
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
                    subtitleParts.join(' · '),
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

class _DoseDetailsCard extends StatelessWidget {
  const _DoseDetailsCard({
    required this.method,
    required this.selectedMedication,
    required this.selectedDose,
    required this.doseItems,
    required this.injectionSite,
    required this.notesController,
    required this.isNotesExpanded,
    required this.onMethodChanged,
    required this.onMedicationChanged,
    required this.onDoseChanged,
    required this.onCustomDoseTap,
    required this.onInjectionSiteChanged,
    required this.onNotesTap,
  });

  final String method;
  final String? selectedMedication;
  final String? selectedDose;
  final List<String> doseItems;
  final String? injectionSite;
  final TextEditingController notesController;
  final bool isNotesExpanded;
  final ValueChanged<String> onMethodChanged;
  final ValueChanged<String?> onMedicationChanged;
  final ValueChanged<String?> onDoseChanged;
  final Future<void> Function() onCustomDoseTap;
  final ValueChanged<String> onInjectionSiteChanged;
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
            label: context.l10n.doseReminderFormat,
            child: _MenuSelector(
              value: method,
              placeholder: context.l10n.commonSelect,
              items: const ['injection', 'pill'],
              itemLabelBuilder: (value) => switch (value) {
                'injection' => context.l10n.doseReminderInjection,
                'pill' => context.l10n.doseReminderPill,
                _ => value,
              },
              onSelected: (value) {
                if (value != null) onMethodChanged(value);
              },
            ),
          ),
          _RowDivider(),
          _SelectorRow(
            label: context.l10n.doseLogMedication,
            child: _MenuSelector(
              value: selectedMedication,
              placeholder: context.l10n.commonSelect,
              items: MedicationCatalog.medicationsForMethod(method),
              onSelected: onMedicationChanged,
            ),
          ),
          _RowDivider(),
          _SelectorRow(
            label: context.l10n.doseLogDoseLabel,
            child: _MenuSelector(
              value: selectedDose,
              placeholder: context.l10n.commonSelect,
              items: doseItems,
              itemLabelBuilder: (value) =>
                  value == _DoseInputSheetState._customDoseMenuValue
                      ? context.l10n.doseLogCustomDose
                      : MedicationCatalog.formatDoseLabel(value),
              onSelected: (value) async {
                if (value == _DoseInputSheetState._customDoseMenuValue) {
                  await onCustomDoseTap();
                  return;
                }
                onDoseChanged(value);
              },
            ),
          ),
          if (method == 'injection') ...[
            _RowDivider(),
            _SelectorRow(
              label: context.l10n.doseLogInjectionSite,
              child: _MenuSelector(
                value: injectionSite,
                placeholder: context.l10n.commonSelect,
                items: InjectionSiteCatalog.values,
                itemLabelBuilder: (value) =>
                    InjectionSiteCatalog.labelFor(context, value),
                groupedOptions: InjectionSiteCatalog.optionsForValues(
                  context,
                  InjectionSiteCatalog.values,
                ),
                onSelected: (value) {
                  if (value != null) onInjectionSiteChanged(value);
                },
              ),
            ),
          ],
          _RowDivider(),
          _SelectorRow(
            label: context.l10n.doseLogNotes,
            child: InlineNotesTrigger(
              value: notesController.text.trim(),
              isExpanded: isNotesExpanded,
              onTap: onNotesTap,
              maxWidth: 170,
            ),
          ),
          if (isNotesExpanded) ...[
            const SizedBox(height: 2),
            ExpandedNotesField(
              controller: notesController,
              hintText: context.l10n.doseLogAnythingWorthRemembering,
            ),
          ],
        ],
      ),
    );
  }
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
  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Divider(height: 1, thickness: 1, color: colors.lineSubtle);
  }
}

class _MenuSelector extends StatelessWidget {
  const _MenuSelector({
    required this.value,
    required this.placeholder,
    required this.items,
    required this.onSelected,
    this.itemLabelBuilder,
    this.groupedOptions,
  });

  final String? value;
  final String placeholder;
  final List<String> items;
  final ValueChanged<String?> onSelected;
  final String Function(String value)? itemLabelBuilder;
  final List<InjectionSiteOption>? groupedOptions;
  static const double _selectorWidth = 200;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final label =
        value == null ? placeholder : itemLabelBuilder?.call(value!) ?? value!;

    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        if (groupedOptions != null) {
          final entries = <PopupMenuEntry<String>>[];
          String? currentGroup;
          for (final option in groupedOptions!) {
            if (option.groupLabel != currentGroup) {
              currentGroup = option.groupLabel;
              entries.add(
                PopupMenuItem<String>(
                  enabled: false,
                  height: 34,
                  child: Text(
                    currentGroup,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: context.appColors.textSecondary,
                        ),
                  ),
                ),
              );
            }
            entries.add(
              PopupMenuItem<String>(
                value: option.value,
                child: Text(option.label),
              ),
            );
          }
          return entries;
        }
        return items
            .map(
              (item) => PopupMenuItem<String>(
                value: item,
                child: Text(itemLabelBuilder?.call(item) ?? item),
              ),
            )
            .toList();
      },
      child: SizedBox(
        width: _selectorWidth,
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
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoseLogSuccessOverlay extends StatelessWidget {
  const _DoseLogSuccessOverlay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LogSuccessOverlay(
      title: label,
      subtitle: context.l10n.doseLogAddedToDoseLog,
      icons: List.generate(
        5,
        (index) => SuccessOverlayIconSpec(
          icon:
              index.isEven ? Icons.vaccines_outlined : Icons.medication_rounded,
          color: index.isEven ? colors.heroEnd : colors.accentLilac,
        ),
      ),
      rippleColor: colors.heroEnd,
    );
  }
}
