import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';
import '../../models/injection_site_catalog.dart';
import '../../models/medication_catalog.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/reminder_service_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';

class DoseReminderScreen extends ConsumerStatefulWidget {
  const DoseReminderScreen({super.key});

  @override
  ConsumerState<DoseReminderScreen> createState() => _DoseReminderScreenState();
}

class _DoseReminderScreenState extends ConsumerState<DoseReminderScreen> {
  static const _customDoseMenuValue = '__custom_dose__';
  static const _defaultReminderTime = TimeOfDay(hour: 9, minute: 0);
  bool _didSeed = false;
  bool _viewTracked = false;
  bool _isEnabled = false;
  bool _isSaving = false;
  DateTime? _nextDoseDate;
  TimeOfDay _reminderTime = _defaultReminderTime;
  String _method = 'injection';
  String? _medication;
  String? _dose;
  String? _site;

  void _seedIfNeeded() {
    if (_didSeed) return;
    final profileState = ref.watch(profileBootstrapProvider);
    if (profileState.isLoading) {
      return;
    }
    final profile = profileState.asData?.value;
    final settings = profile?.settings ?? const <String, dynamic>{};
    final reminderItem = profile?.reminders.dose.items.isNotEmpty == true
        ? profile!.reminders.dose.items.first
        : null;
    final reminderMetadata =
        reminderItem?.metadata ?? const <String, dynamic>{};
    final currentMethod = settings['medication_method'] as String?;
    final currentMedication = settings['medication_name']?.toString().trim();
    final currentDoseRaw = settings['current_dose_mg'];

    final enabled = profile?.reminders.dose.enabled ?? false;
    final savedMethod = reminderMetadata['format'] as String?;
    final savedMedication = reminderMetadata['medication']?.toString().trim();
    final savedDoseRaw = reminderMetadata['dose'];
    final savedSite = reminderMetadata['injection_site'] as String?;
    final savedAt = reminderItem?.schedule.scheduledAt;

    _method = savedMethod == 'pill'
        ? 'pill'
        : (currentMethod == 'pill' ? 'pill' : 'injection');
    final medicationOptions = MedicationCatalog.medicationsForMethod(_method);
    _medication = medicationOptions.contains(savedMedication)
        ? savedMedication
        : (medicationOptions.contains(currentMedication)
            ? currentMedication
            : (medicationOptions.isEmpty ? null : medicationOptions.first));
    final currentDose = MedicationCatalog.normalizeDoseValue(
          currentDoseRaw,
          medication: _medication,
        ) ??
        MedicationCatalog.coerceDoseValue(currentDoseRaw);
    final savedDose = MedicationCatalog.normalizeDoseValue(
          savedDoseRaw,
          medication: _medication,
        ) ??
        MedicationCatalog.coerceDoseValue(savedDoseRaw);
    final doseOptions = MedicationCatalog.dosesForMedication(_medication);
    _dose = savedDose ??
        currentDose ??
        (doseOptions.isEmpty ? null : doseOptions.first);
    _site = _method == 'injection'
        ? (savedSite != null && InjectionSiteCatalog.values.contains(savedSite)
            ? savedSite
            : InjectionSiteCatalog.values.first)
        : null;
    final savedDateTime = savedAt == null ? null : DateTime.tryParse(savedAt);
    _nextDoseDate = savedAt == null
        ? _suggestedNextDoseDate(settings)
        : DateUtils.dateOnly(DateTime.tryParse(savedAt) ?? DateTime.now());
    _reminderTime = savedDateTime == null
        ? _defaultReminderTime
        : TimeOfDay.fromDateTime(savedDateTime.toLocal());
    _isEnabled = enabled && _nextDoseDate != null;
    _didSeed = true;
    if (!_viewTracked) {
      _viewTracked = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        ref.read(analyticsServiceProvider).capture(
          eventName: 'next_dose_reminder_screen_viewed',
          properties: {
            'source': 'next_dose_reminder',
            'is_enabled': _isEnabled,
            'has_scheduled_next_dose': _nextDoseDate != null,
            'method': _method,
          },
        );
      });
    }
  }

  DateTime? _suggestedNextDoseDate(Map<String, dynamic> settings) {
    final today = DateUtils.dateOnly(DateTime.now());
    final frequency = settings['medication_frequency'] as String?;
    final daysBetween =
        settings['medication_frequency_days_between_doses'] as int?;
    final days = switch (frequency) {
      'daily' => 1,
      'every_7_days' => 7,
      'every_14_days' => 14,
      'weekly' => 7,
      'biweekly' => 14,
      'monthly' => 30,
      'custom' => daysBetween,
      _ => null,
    };
    if (days == null || days <= 0) return null;
    return today.add(Duration(days: days));
  }

  bool get _isValid {
    if (!_isEnabled) return true;
    if (_nextDoseDate == null || _medication == null || _dose == null) {
      return false;
    }
    if (_method == 'injection' && _site == null) {
      return false;
    }
    return true;
  }

  List<String> _doseMenuItems() {
    final options = [...MedicationCatalog.dosesForMedication(_medication)];
    final custom = MedicationCatalog.coerceDoseValue(_dose);
    if (custom != null && !options.contains(custom)) {
      options.add(custom);
    }
    options.add(_customDoseMenuValue);
    return options;
  }

  Future<void> _pickCustomDose() async {
    final controller = TextEditingController(
      text: MedicationCatalog.coerceDoseValue(_dose) ?? '',
    );
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.l10n.doseReminderCustomDoseTitle),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: context.l10n.doseReminderCustomDoseHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l10n.commonCancel),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: Text(context.l10n.commonSave),
            ),
          ],
        );
      },
    );
    final normalized = MedicationCatalog.coerceDoseValue(result);
    if (!mounted || normalized == null) return;
    HapticFeedback.selectionClick();
    setState(() {
      _dose = normalized;
    });
  }

  Future<void> _pickDate() async {
    final initialDate = _nextDoseDate ??
        DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)));
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime(2035),
    );
    if (picked == null) return;
    HapticFeedback.selectionClick();
    setState(() {
      _nextDoseDate = DateUtils.dateOnly(picked);
      _isEnabled = true;
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
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
    setState(() {
      _reminderTime = picked;
      _isEnabled = true;
    });
  }

  Future<void> _save() async {
    if (_isSaving || !_isValid) return;
    setState(() {
      _isSaving = true;
    });
    try {
      final nextDoseAt = !_isEnabled || _nextDoseDate == null
          ? null
          : formatIsoWithTimezone(
              DateTime(
                _nextDoseDate!.year,
                _nextDoseDate!.month,
                _nextDoseDate!.day,
                _reminderTime.hour,
                _reminderTime.minute,
              ),
            );
      await ref.read(reminderServiceProvider).updateNextDoseReminder(
            enabled: _isEnabled,
            nextDoseAt: nextDoseAt,
            format: _method,
            medication: _medication,
            dose: _dose == null
                ? null
                : MedicationCatalog.formatDoseLabel(_dose!),
            injectionSite: _method == 'injection' ? _site : null,
          );
      ref.read(analyticsServiceProvider).capture(
        eventName: 'next_dose_reminder_saved',
        properties: {
          'source': 'next_dose_reminder',
          'is_enabled': _isEnabled,
          'has_scheduled_next_dose': nextDoseAt != null,
          'method': _method,
          'has_medication': _medication != null,
          'has_dose': _dose != null,
          'has_injection_site': _method == 'injection' && _site != null,
        },
      );
      ref.invalidate(profileBootstrapProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _seedIfNeeded();

    final colors = context.appColors;
    final theme = Theme.of(context);
    final label = _nextDoseDate == null
        ? context.l10n.commonSelect
        : DateFormat('EEE, MMM d').format(_nextDoseDate!);
    final timeLabel = _reminderTime.format(context);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: Column(
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
                    context.l10n.doseReminderTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
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
                            Expanded(
                              child: Text(
                                context
                                    .l10n.doseReminderKeepNextDoseReadyOnHome,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ),
                            Switch.adaptive(
                              value: _isEnabled,
                              onChanged: (value) {
                                HapticFeedback.selectionClick();
                                setState(() {
                                  _isEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                        if (_isEnabled) ...[
                          const SizedBox(height: 8),
                          _SelectorRow(
                            label: context.l10n.doseReminderFormat,
                            child: _MenuSelector(
                              value: _method,
                              placeholder: context.l10n.commonSelect,
                              items: const ['injection', 'pill'],
                              itemLabelBuilder: (value) => switch (value) {
                                'injection' => context.l10n.doseReminderInjection,
                                'pill' => context.l10n.doseReminderPill,
                                _ => value,
                              },
                              onSelected: (value) {
                                if (value == null) return;
                                HapticFeedback.selectionClick();
                                setState(() {
                                  _method = value;
                                  final medicationOptions =
                                      MedicationCatalog.medicationsForMethod(
                                    value,
                                  );
                                  if (!medicationOptions
                                      .contains(_medication)) {
                                    _medication = medicationOptions.isEmpty
                                        ? null
                                        : medicationOptions.first;
                                  }
                                  final doseOptions =
                                      MedicationCatalog.dosesForMedication(
                                    _medication,
                                  );
                                  if (!doseOptions.contains(_dose)) {
                                    _dose = doseOptions.isEmpty
                                        ? null
                                        : doseOptions.first;
                                  }
                                  if (value != 'injection') {
                                    _site = null;
                                  } else {
                                    _site ??= InjectionSiteCatalog.values.first;
                                  }
                                });
                              },
                            ),
                          ),
                          _RowDivider(),
                          _SelectorRow(
                            label: context.l10n.doseLogMedication,
                            child: _MenuSelector(
                              value: _medication,
                              placeholder: context.l10n.commonSelect,
                              items: MedicationCatalog.medicationsForMethod(
                                _method,
                              ),
                              onSelected: (value) {
                                HapticFeedback.selectionClick();
                                setState(() {
                                  _medication = value;
                                  final doseOptions =
                                      MedicationCatalog.dosesForMedication(
                                    value,
                                  );
                                  if (!doseOptions.contains(_dose)) {
                                    _dose = doseOptions.isEmpty
                                        ? null
                                        : doseOptions.first;
                                  }
                                });
                              },
                            ),
                          ),
                          _RowDivider(),
                          _SelectorRow(
                            label: context.l10n.doseLogDoseLabel,
                            child: _MenuSelector(
                              value: _dose,
                              placeholder: context.l10n.commonSelect,
                              items: _doseMenuItems(),
                              itemLabelBuilder: (value) => value ==
                                      _customDoseMenuValue
                                  ? context.l10n.doseLogCustomDose
                                  : MedicationCatalog.formatDoseLabel(value),
                              onSelected: (value) async {
                                if (value == _customDoseMenuValue) {
                                  await _pickCustomDose();
                                  return;
                                }
                                HapticFeedback.selectionClick();
                                setState(() {
                                  _dose = value;
                                });
                              },
                            ),
                          ),
                          if (_method == 'injection') ...[
                            _RowDivider(),
                            _SelectorRow(
                              label: context.l10n.doseLogInjectionSite,
                              child: _MenuSelector(
                                value: _site,
                                placeholder: context.l10n.commonSelect,
                                items: InjectionSiteCatalog.values,
                                itemLabelBuilder: (value) =>
                                    InjectionSiteCatalog.labelFor(
                                        context, value),
                                groupedOptions:
                                    InjectionSiteCatalog.optionsForValues(
                                        context, InjectionSiteCatalog.values),
                                onSelected: (value) {
                                  if (value == null) return;
                                  HapticFeedback.selectionClick();
                                  setState(() {
                                    _site = value;
                                  });
                                },
                              ),
                            ),
                          ],
                          _RowDivider(),
                          _SelectorRow(
                            label: context.l10n.doseReminderDate,
                            child: _ActionSelector(
                              label: label,
                              icon: Icons.calendar_month_outlined,
                              onTap: _pickDate,
                            ),
                          ),
                          _RowDivider(),
                          _SelectorRow(
                            label: context.l10n.doseReminderTime,
                            child: _ActionSelector(
                              label: timeLabel,
                              icon: Icons.schedule_rounded,
                              onTap: _pickTime,
                            ),
                          ),
                        ] else ...[
                          const SizedBox(height: 6),
                          Text(
                            context
                                .l10n.doseReminderTurnThisOnToShowNextDoseOnHome,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSaving || !_isValid ? null : _save,
                  child: Text(_isSaving
                      ? context.l10n.commonSaving
                      : context.l10n.doseReminderSaveReminder),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorRow extends StatelessWidget {
  const _SelectorRow({
    required this.label,
    required this.child,
  });

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
              style: theme.textTheme.bodyMedium?.copyWith(
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
              child: child,
            ),
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

class _ActionSelector extends StatelessWidget {
  const _ActionSelector({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return SizedBox(
      width: _MenuSelector._selectorWidth,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Ink(
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
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  icon,
                  size: 16,
                  color: colors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
