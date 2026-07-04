import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../l10n/l10n.dart';
import '../../providers/profile_provider.dart';
import '../../providers/reminder_service_provider.dart';
import '../../theme/app_colors.dart';

const _uuid = Uuid();

// ISO weekday: 1=Monday … 7=Sunday
const _dayValues = [1, 2, 3, 4, 5, 6, 7];

List<String> supplementDayLabels(AppLocalizations l10n) => [
      l10n.supplementReminderDayMon,
      l10n.supplementReminderDayTue,
      l10n.supplementReminderDayWed,
      l10n.supplementReminderDayThu,
      l10n.supplementReminderDayFri,
      l10n.supplementReminderDaySat,
      l10n.supplementReminderDaySun,
    ];

class SupplementReminderScreen extends ConsumerStatefulWidget {
  const SupplementReminderScreen({super.key});

  @override
  ConsumerState<SupplementReminderScreen> createState() =>
      _SupplementReminderScreenState();
}

class _SupplementReminderScreenState
    extends ConsumerState<SupplementReminderScreen> {
  List<Map<String, dynamic>> _reminders = [];
  bool _loaded = false;

  void _loadIfNeeded() {
    if (_loaded) return;
    _loaded = true;
    final profile = ref.read(profileBootstrapProvider).asData?.value;
    _reminders = profile?.reminders.supplement.toSupplementReminderJsonList() ??
        const <Map<String, dynamic>>[];
  }

  Future<void> _save() async {
    await ref
        .read(reminderServiceProvider)
        .updateSupplementReminders(_reminders);
    ref.invalidate(profileBootstrapProvider);
  }

  Future<void> _openAddSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _SupplementInputSheet(),
    );
    if (result == null || !mounted) return;
    setState(() {
      _reminders = [..._reminders, result];
    });
    await _save();
  }

  Future<void> _deleteReminder(String id) async {
    HapticFeedback.selectionClick();
    setState(() {
      _reminders = _reminders.where((r) => r['id'] != id).toList();
    });
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    _loadIfNeeded();
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                    context.l10n.supplementReminderTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            // Body
            Expanded(
              child: _reminders.isEmpty
                  ? _EmptyState(onAdd: _openAddSheet)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: colors.lineSubtle),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0; i < _reminders.length; i++) ...[
                                if (i > 0)
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: colors.lineSubtle,
                                  ),
                                _SupplementRow(
                                  reminder: _reminders[i],
                                  onDelete: () => _deleteReminder(
                                      _reminders[i]['id'] as String),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            // Add button
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _openAddSheet,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(context.l10n.supplementReminderAddSupplement),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.medication_liquid_outlined,
              size: 48,
              color: colors.textSecondary,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.supplementReminderNoSupplementsYet,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              context.l10n.supplementReminderAddFirstBody,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Row for each supplement
// ---------------------------------------------------------------------------

class _SupplementRow extends StatelessWidget {
  const _SupplementRow({required this.reminder, required this.onDelete});
  final Map<String, dynamic> reminder;
  final VoidCallback onDelete;

  String _scheduleLabel(BuildContext context) {
    final mode = reminder['repeat_mode'] as String?;
    if (mode == 'every_x_days') {
      final interval = reminder['interval_days'];
      return interval == 1
          ? context.l10n.supplementReminderEveryDay
          : context.l10n.supplementReminderEveryXDays(
              interval?.toString() ?? '?',
            );
    }
    // days_of_week
    final days = (reminder['days_of_week'] as List?)?.cast<int>() ?? [];
    if (days.isEmpty) return context.l10n.supplementReminderNoDaysSet;
    if (days.length == 7) return context.l10n.supplementReminderEveryDay;
    final labels = supplementDayLabels(context.l10n);
    return days.map((d) => labels[d - 1]).join(', ');
  }

  String _timeLabel() {
    final t = reminder['time_of_day'] as String?;
    if (t == null || t.isEmpty) return '';
    final parts = t.split(':');
    if (parts.length < 2) return t;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    final dt = DateTime(2000, 1, 1, h, m);
    return DateFormat('h:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final name = (reminder['name'] as String?)?.trim() ??
        context.l10n.supplementReminderSupplementFallback;
    final schedule = _scheduleLabel(context);
    final time = _timeLabel();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time.isEmpty ? schedule : '$schedule · $time',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: colors.textSecondary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Add supplement bottom sheet
// ---------------------------------------------------------------------------

class _SupplementInputSheet extends StatefulWidget {
  const _SupplementInputSheet();

  @override
  State<_SupplementInputSheet> createState() => _SupplementInputSheetState();
}

class _SupplementInputSheetState extends State<_SupplementInputSheet> {
  final _nameController = TextEditingController();
  TimeOfDay _time = _nextRounded15Min();

  static TimeOfDay _nextRounded15Min() {
    final now = TimeOfDay.now();
    final totalMinutes = now.hour * 60 + now.minute;
    final rounded = ((totalMinutes / 15).ceil()) * 15;
    return TimeOfDay(hour: (rounded ~/ 60) % 24, minute: rounded % 60);
  }

  DateTime _startDate = DateUtils.dateOnly(DateTime.now());
  String _repeatMode = 'days_of_week';
  final Set<int> _selectedDays = {1, 2, 3, 4, 5}; // Mon–Fri default
  int _intervalDays = 1;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool get _hasValidSchedule {
    if (_repeatMode == 'days_of_week') {
      return _selectedDays.isNotEmpty;
    }
    return _intervalDays > 0;
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty && _hasValidSchedule;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        final cs = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: cs.copyWith(
              tertiaryContainer: cs.primaryContainer,
              onTertiaryContainer: cs.onPrimaryContainer,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) return;
    HapticFeedback.selectionClick();
    setState(() => _time = picked);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime(2035),
    );
    if (picked == null) return;
    HapticFeedback.selectionClick();
    setState(() => _startDate = DateUtils.dateOnly(picked));
  }

  void _submit() {
    if (!_isValid) return;
    HapticFeedback.selectionClick();
    final h = _time.hour.toString().padLeft(2, '0');
    final m = _time.minute.toString().padLeft(2, '0');
    final result = <String, dynamic>{
      'id': _uuid.v4(),
      'name': _nameController.text.trim(),
      'time_of_day': '$h:$m',
      'start_date': DateFormat('yyyy-MM-dd').format(_startDate),
      'repeat_mode': _repeatMode,
      'days_of_week': _repeatMode == 'days_of_week'
          ? (_selectedDays.toList()..sort())
          : null,
      'interval_days': _repeatMode == 'every_x_days' ? _intervalDays : null,
    };
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final timeLabel = _time.format(context);
    final dateLabel = DateFormat('EEE, MMM d').format(_startDate);
    final dayLabels = supplementDayLabels(context.l10n);

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
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
            Text(
              context.l10n.supplementReminderAddSupplement,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),

            // Name field
            TextField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: context.l10n.supplementReminderSupplementName,
                filled: true,
                fillColor: colors.softSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.lineSubtle),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.lineSubtle),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 1.5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // Time + Start date row
            Row(
              children: [
                Expanded(
                  child: _SheetSelector(
                    label: context.l10n.supplementReminderTime,
                    value: timeLabel,
                    icon: Icons.access_time_rounded,
                    onTap: _pickTime,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SheetSelector(
                    label: context.l10n.supplementReminderStartDate,
                    value: dateLabel,
                    icon: Icons.calendar_month_outlined,
                    onTap: _pickDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Repeat mode toggle — full width
            Text(
              context.l10n.supplementReminderRepeat,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: 'days_of_week',
                    label: Text(context.l10n.supplementReminderDaysOfWeek),
                  ),
                  ButtonSegment(
                    value: 'every_x_days',
                    label: Text(context.l10n.supplementReminderEveryXDaysLabel),
                  ),
                ],
                selected: {_repeatMode},
                onSelectionChanged: (s) {
                  HapticFeedback.selectionClick();
                  setState(() => _repeatMode = s.first);
                },
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                    theme.textTheme.labelSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Mode-specific controls
            if (_repeatMode == 'days_of_week') ...[
              // Single row of 7 equal day toggles, no checkmark
              Row(
                children: [
                  for (int i = 0; i < _dayValues.length; i++) ...[
                    if (i > 0) const SizedBox(width: 6),
                    Expanded(
                      child: _DayToggleButton(
                        label: dayLabels[i],
                        selected: _selectedDays.contains(_dayValues[i]),
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            if (_selectedDays.contains(_dayValues[i])) {
                              _selectedDays.remove(_dayValues[i]);
                            } else {
                              _selectedDays.add(_dayValues[i]);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ],
              ),
              if (_selectedDays.isEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  context.l10n.supplementReminderSelectAtLeastOneDay,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ] else ...[
              // Full-width row: "Every" on left, stepper + unit on right
              Row(
                children: [
                  Text(
                    context.l10n.supplementReminderEvery,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _IntervalStepper(
                      value: _intervalDays,
                      onChanged: (v) => setState(() => _intervalDays = v),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 30,
                    child: Text(
                      _intervalDays == 1
                          ? context.l10n.supplementReminderDay
                          : context.l10n.supplementReminderDays,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),

            // Save button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isValid ? _submit : null,
                child: Text(context.l10n.supplementReminderAdd),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Day toggle button (single row, no checkmark)
// ---------------------------------------------------------------------------

class _DayToggleButton extends StatelessWidget {
  const _DayToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 36,
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : colors.softSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : colors.lineSubtle,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: selected ? Colors.white : colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Selector widget for sheet
// ---------------------------------------------------------------------------

class _SheetSelector extends StatelessWidget {
  const _SheetSelector({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colors.softSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colors.lineSubtle),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(icon, size: 16, color: colors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Interval stepper
// ---------------------------------------------------------------------------

class _IntervalStepper extends StatelessWidget {
  const _IntervalStepper({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.softSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StepButton(
            icon: Icons.remove,
            onTap: value > 1
                ? () {
                    HapticFeedback.selectionClick();
                    onChanged(value - 1);
                  }
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$value',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add,
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(value + 1);
            },
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return InkResponse(
      onTap: onTap,
      radius: 18,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 16,
          color: onTap != null ? colors.textPrimary : colors.textSecondary,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Public helpers used by home_screen.dart
// ---------------------------------------------------------------------------

/// Returns the next occurrence of [reminder] on or after [from].
/// Returns null if the reminder has no valid schedule.
DateTime? nextSupplementOccurrence(
  Map<String, dynamic> reminder, {
  DateTime? from,
}) {
  final startRaw = reminder['start_date'] as String?;
  final timeRaw = reminder['time_of_day'] as String?;
  final mode = reminder['repeat_mode'] as String?;

  final startDate = startRaw != null ? DateTime.tryParse(startRaw) : null;
  if (startDate == null) return null;

  int hour = 0, minute = 0;
  if (timeRaw != null) {
    final parts = timeRaw.split(':');
    hour = int.tryParse(parts[0]) ?? 0;
    minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
  }

  final base = from ?? DateTime.now();
  final baseDay = DateUtils.dateOnly(base);
  final startDay = DateUtils.dateOnly(startDate);

  if (mode == 'every_x_days') {
    final interval = (reminder['interval_days'] as int?) ?? 1;
    if (interval <= 0) return null;
    // Find first day >= max(today, startDay) that is aligned to start
    final effectiveStart = baseDay.isBefore(startDay) ? startDay : baseDay;
    final diffFromStart = effectiveStart.difference(startDay).inDays;
    final remainder = diffFromStart % interval;
    final daysToAdd = remainder == 0 ? 0 : (interval - remainder);
    final nextDay = effectiveStart.add(Duration(days: daysToAdd));
    var occurrence =
        DateTime(nextDay.year, nextDay.month, nextDay.day, hour, minute);
    if (!occurrence.isAfter(base)) {
      occurrence = occurrence.add(Duration(days: interval));
    }
    return occurrence;
  }

  // days_of_week
  final days = (reminder['days_of_week'] as List?)?.cast<int>() ?? [];
  if (days.isEmpty) return null;

  final effectiveStart = baseDay.isBefore(startDay) ? startDay : baseDay;
  for (int offset = 0; offset <= 7; offset++) {
    final candidate = effectiveStart.add(Duration(days: offset));
    if (days.contains(candidate.weekday)) {
      final occurrence = DateTime(
          candidate.year, candidate.month, candidate.day, hour, minute);
      if (occurrence.isAfter(base)) {
        return occurrence;
      }
    }
  }
  for (int offset = 8; offset <= 14; offset++) {
    final candidate = effectiveStart.add(Duration(days: offset));
    if (days.contains(candidate.weekday)) {
      return DateTime(
          candidate.year, candidate.month, candidate.day, hour, minute);
    }
  }
  return null;
}

/// Returns a human-readable relative label for a supplement occurrence.
String supplementRelativeLabel(DateTime occurrence) {
  return supplementRelativeLabelLocalized(
    occurrence,
    null,
  );
}

String supplementRelativeLabelLocalized(
  DateTime occurrence,
  AppLocalizations? l10n,
) {
  final today = DateUtils.dateOnly(DateTime.now());
  final occDay = DateUtils.dateOnly(occurrence);
  final delta = occDay.difference(today).inDays;
  if (delta == 0) return l10n?.commonToday ?? 'Today';
  if (delta == 1) return l10n?.commonTomorrow ?? 'Tomorrow';
  if (delta > 1 && delta <= 6) {
    return l10n?.supplementReminderInDays(delta) ?? 'In $delta days';
  }
  if (delta > 6) {
    final weeks = (delta / 7).floor();
    if (weeks == 1) {
      return l10n?.supplementReminderInOneWeek ?? 'In 1 week';
    }
    return l10n?.supplementReminderInWeeks(weeks) ?? 'In $weeks weeks';
  }
  return DateFormat('EEE, MMM d').format(occurrence);
}
