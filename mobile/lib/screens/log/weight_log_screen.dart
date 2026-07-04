import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/app_refresh_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';
import '../../widgets/log_week_day_selector.dart';
import '../../widgets/log_success_overlay.dart';
import '../../widgets/weight_dial_selector.dart';
import 'swipe_back_detector.dart';

final _allWeightLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.weightColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _weightLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.weightColumn,
    date,
    date.add(const Duration(days: 1)),
  );
  results.sort(
    (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String),
  );
  return results;
});

final _weightWeekDatesProvider =
    FutureProvider.autoDispose.family<Set<DateTime>, DateTime>((
  ref,
  date,
) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.weightColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

class WeightLogScreen extends ConsumerStatefulWidget {
  const WeightLogScreen({super.key});

  @override
  ConsumerState<WeightLogScreen> createState() => _WeightLogScreenState();
}

class _WeightLogScreenState extends ConsumerState<WeightLogScreen> {
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
    final existingForDay = entry ?? await _firstEntryForSelectedDate();
    if (!mounted) return;
    final label = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WeightInputSheet(
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

  Future<Map<String, dynamic>?> _firstEntryForSelectedDate() async {
    return ref.read(_weightLogsProvider(_selectedDate).future).then(
          (entries) => entries.isEmpty ? null : entries.first,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final highlightedDates =
        ref.watch(_weightWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allWeightLogsProvider(0));

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
                            context.l10n.weightLogTitle,
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
                          child: _LoggedWeightSection(
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
                          data: (entries) => _WeightLogListSection(
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
                  child: _WeightLogSuccessOverlay(amountLabel: label),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeightInputSheet extends ConsumerStatefulWidget {
  const _WeightInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
  });

  final Map<String, dynamic>? existingEntry;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_WeightInputSheet> createState() => _WeightInputSheetState();
}

class _WeightInputSheetState extends ConsumerState<_WeightInputSheet> {
  static const _fallbackWeight = {
    'unit': 'kg',
    'primary': '82',
    'secondary': null
  };

  late Map<String, dynamic> _weight;
  bool _isSubmitting = false;
  bool _didUserChangeWeight = false;

  bool get _isEditing => widget.existingEntry != null;

  String _friendlyDate(BuildContext context, DateTime date) {
    return formatFriendlyLogDate(context, date);
  }

  String _resolvedLoggedAt() {
    final existingLoggedAt = widget.existingEntry?['logged_at'] as String?;
    if (existingLoggedAt != null && existingLoggedAt.trim().isNotEmpty) {
      return existingLoggedAt;
    }

    final now = DateTime.now();
    final selected = widget.selectedDate;
    return formatIsoWithTimezone(
      DateTime(
        selected.year,
        selected.month,
        selected.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      ),
    );
  }

  double get _quantity =>
      double.tryParse(_weight['primary']?.toString() ?? '') ?? 82;

  String get _displayLabel {
    final unit = (_weight['unit'] as String?) ?? 'kg';
    final raw = _quantity;
    return '${raw.round()} $unit';
  }

  @override
  void initState() {
    super.initState();
      final entry = widget.existingEntry;
    final quantity = (entry?['quantity'] as num?)?.toDouble();
    _weight = quantity == null
        ? Map<String, dynamic>.from(_fallbackWeight)
        : {
            'unit': (entry?['unit'] as String?) ?? 'kg',
            'primary': quantity == quantity.truncateToDouble()
                ? quantity.toInt().toString()
                : quantity.toString(),
            'secondary': null,
          };
    if (!_isEditing) {
      _loadLatestWeightDefault();
    }
  }

  Future<void> _loadLatestWeightDefault() async {
    final latest = await ref.read(recordServiceProvider).loadLatestRecord(
          RecordService.weightColumn,
        );
    if (!mounted || _didUserChangeWeight || latest == null) {
      return;
    }

    final quantity = (latest['quantity'] as num?)?.toDouble();
    if (quantity == null || _isEditing) {
      return;
    }

    setState(() {
      _weight = {
        'unit': (latest['unit'] as String?) ?? 'kg',
        'primary': quantity == quantity.truncateToDouble()
            ? quantity.toInt().toString()
            : quantity.toString(),
        'secondary': null,
      };
    });
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final payload = {
      'logged_at': _resolvedLoggedAt(),
      'quantity': double.parse(_quantity.toStringAsFixed(2)),
      'unit': (_weight['unit'] as String?) ?? 'kg',
    };

    try {
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
          RecordService.weightColumn,
          existingId,
          payload,
        );
      } else {
        final dayEntries = await ref.read(
          _weightLogsProvider(widget.selectedDate).future,
        );
        if (dayEntries.isNotEmpty) {
          final entryId = dayEntries.first['id'] as String?;
          if (entryId != null) {
            await service.updateRecordEntry(
              RecordService.weightColumn,
              entryId,
              payload,
            );
          } else {
            await service.updateRecord(RecordService.weightColumn, payload);
          }
        } else {
          await service.updateRecord(RecordService.weightColumn, payload);
        }
      }
      ref.invalidate(_weightLogsProvider(widget.selectedDate));
      ref.invalidate(_weightWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allWeightLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(_displayLabel);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.weightLogCouldNotSave),
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
        title: Text(context.l10n.weightLogDeleteTitle),
        content: Text(context.l10n.weightLogDeleteMessage),
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
          .deleteRecordEntry(RecordService.weightColumn, entryId);
      ref.invalidate(_weightLogsProvider(widget.selectedDate));
      ref.invalidate(_weightWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allWeightLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.weightLogDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.weightLogCouldNotDelete),
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
                          ? context.l10n.weightLogEditTitle
                          : context.l10n.weightLogLogTitle,
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
                children: [
                  WeightDialSelector(
                    value: _weight,
                    onChanged: (value) => setState(() {
                      _didUserChangeWeight = true;
                      _weight = value;
                    }),
                    showStepButtons: true,
                  ),
                  const SizedBox(height: 20),
                  if (_isEditing) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _isSubmitting ? null : _deleteEntry,
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: Text(context.l10n.weightLogDeleteLog),
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
                      onPressed: _isSubmitting ? null : _submit,
                        child: Text(
                          _isSubmitting
                              ? context.l10n.weightLogSaving
                              : _isEditing
                                  ? context.l10n.weightLogSaveChanges
                                  : context.l10n.weightLogAddWeight(
                                      _displayLabel,
                                    ),
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

class _LoggedWeightSection extends ConsumerWidget {
  const _LoggedWeightSection({
    required this.date,
    required this.onEditEntry,
  });

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_weightLogsProvider(date));

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (entries) {
        if (entries.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              context.l10n.weightLogNoWeightForDay,
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
                child: _LoggedWeightCard(
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

class _WeightLogListSection extends StatelessWidget {
  const _WeightLogListSection({
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
          context.l10n.weightLogNoWeightForDay,
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
                child: _LoggedWeightCard(
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

class _LoggedWeightCard extends StatelessWidget {
  const _LoggedWeightCard({required this.entry, required this.onTap});

  final Map<String, dynamic> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final quantity = (entry['quantity'] as num?)?.toDouble() ?? 0;
    final unit = (entry['unit'] as String?) ?? 'kg';
    final valueLabel = quantity == quantity.truncateToDouble()
        ? '${quantity.toInt()} $unit'
        : '${quantity.toStringAsFixed(1)} $unit';

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
                color: colors.accentLilac.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.monitor_weight_rounded,
                size: 18,
                color: colors.heroEnd.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Text(
                    valueLabel,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (timeLabel.isNotEmpty)
                    Text(
                      timeLabel,
                      style: theme.textTheme.labelMedium?.copyWith(
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

class _WeightLogSuccessOverlay extends StatelessWidget {
  const _WeightLogSuccessOverlay({
    required this.amountLabel,
  });

  final String amountLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LogSuccessOverlay(
      title: amountLabel,
      subtitle: context.l10n.weightLogAddedToWeightLog,
      icons: List.generate(
        5,
        (index) => SuccessOverlayIconSpec(
          icon: Icons.monitor_weight_rounded,
          color: index.isEven ? colors.heroEnd : colors.accentLilac,
        ),
      ),
      rippleColor: colors.heroEnd,
      badgeColor: colors.accentLilac.withValues(alpha: 0.28),
    );
  }
}
