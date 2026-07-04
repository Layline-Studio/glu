import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../providers/app_refresh_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';
import '../../widgets/log_week_day_selector.dart';
import '../../widgets/log_success_overlay.dart';
import 'swipe_back_detector.dart';

final _allWaterLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.waterColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
      (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String));
  return results;
});

final _waterLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.waterColumn,
    date,
    date.add(const Duration(days: 1)),
  );
  results.sort(
      (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String));
  return results;
});

final _waterWeekDatesProvider =
    FutureProvider.autoDispose.family<Set<DateTime>, DateTime>((
  ref,
  date,
) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.waterColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

enum _WaterUnit {
  ml,
  oz;

  static _WaterUnit fromString(String? s) =>
      s == 'oz' ? _WaterUnit.oz : _WaterUnit.ml;
}

String _formatAmount(int amountMl, _WaterUnit unit) {
  if (unit == _WaterUnit.ml) {
    if (amountMl >= 1000) {
      final liters = amountMl / 1000;
      return liters % 1 == 0
          ? '${liters.toStringAsFixed(0)} L'
          : '${liters.toStringAsFixed(1)} L';
    }
    return '$amountMl ml';
  }
  final ounces = amountMl / 29.5735;
  return '${ounces.toStringAsFixed(1)} oz';
}

// ── Background screen ─────────────────────────────────────────────────────────

class WaterLogScreen extends ConsumerStatefulWidget {
  const WaterLogScreen({super.key});

  @override
  ConsumerState<WaterLogScreen> createState() => _WaterLogScreenState();
}

class _WaterLogScreenState extends ConsumerState<WaterLogScreen> {
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
      builder: (_) => _WaterInputSheet(
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
        ref.watch(_waterWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allWaterLogsProvider(0));

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
                            context.l10n.waterLogTitle,
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
                          child: _LoggedHydrationSection(
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
                          data: (entries) => _WaterLogListSection(
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
                  child: _WaterLogSuccessOverlay(label: label),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Input sheet ───────────────────────────────────────────────────────────────

class _WaterInputSheet extends ConsumerStatefulWidget {
  const _WaterInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
  });

  final Map<String, dynamic>? existingEntry;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_WaterInputSheet> createState() => _WaterInputSheetState();
}

class _WaterInputSheetState extends ConsumerState<_WaterInputSheet> {
  static const double _presetCardWidth = 154;
  static const double _presetCardSpacing = 14;
  static const List<_DrinkPreset> _basePresets = [
    _DrinkPreset(
      id: 'small_glass',
      name: 'Small glass',
      amountMl: 250,
      icon: Icons.local_drink_outlined,
    ),
    _DrinkPreset(
      id: 'glass',
      name: 'Glass',
      amountMl: 300,
      icon: Icons.wine_bar_outlined,
    ),
    _DrinkPreset(
      id: 'bottle',
      name: 'Bottle',
      amountMl: 500,
      icon: Icons.sports_bar_outlined,
    ),
    _DrinkPreset(
      id: 'large_bottle',
      name: 'Large bottle',
      amountMl: 1000,
      icon: Icons.water_drop_outlined,
    ),
    _DrinkPreset(
      id: 'two_liters',
      name: '2 L',
      amountMl: 2000,
      icon: Icons.water_rounded,
    ),
    _DrinkPreset(
      id: 'custom',
      name: 'Custom',
      amountMl: 2500,
      icon: Icons.tune_rounded,
      isCustom: true,
    ),
  ];

  late final ScrollController _presetScrollController;
  late int _selectedPresetIndex;
  late int _visiblePresetIndex;
  late _WaterUnit _unit;
  late int _customAmountMl;
  bool _isSubmitting = false;

  bool get _isEditing => widget.existingEntry != null;

  _DrinkPreset get _selectedPreset {
    final preset = _basePresets[_selectedPresetIndex];
    if (!preset.isCustom) return preset;
    return preset.copyWith(amountMl: _customAmountMl);
  }

  String _presetName(BuildContext context, String id) {
    return switch (id) {
      'small_glass' => context.l10n.waterLogSmallGlass,
      'glass' => context.l10n.waterLogGlass,
      'bottle' => context.l10n.waterLogBottle,
      'large_bottle' => context.l10n.waterLogLargeBottle,
      'two_liters' => context.l10n.waterLogTwoLiters,
      'custom' => context.l10n.waterLogCustomPreset,
      _ => id,
    };
  }

  _DrinkPreset _displayPreset(BuildContext context, _DrinkPreset preset) {
    return _DrinkPreset(
      id: preset.id,
      name: _presetName(context, preset.id),
      amountMl: preset.amountMl,
      icon: preset.icon,
      isCustom: preset.isCustom,
    );
  }

  String _addDrinkCtaLabel(BuildContext context) => _isEditing
      ? context.l10n.commonSave
      : context.l10n.waterLogAddDrink(
          _formatAmount(_selectedPreset.amountMl, _unit),
        );

  String _friendlyDate(BuildContext context, DateTime date) {
    return formatFriendlyLogDate(context, date);
  }

  @override
  void initState() {
    super.initState();
    _presetScrollController = ScrollController();
    _presetScrollController.addListener(_handlePresetScroll);

    // Resolve unit from profile settings
    final profileSettings =
        ref.read(profileBootstrapProvider).asData?.value?.settings;
    _unit = _WaterUnit.fromString(profileSettings?['water_unit'] as String?);

    // Resolve initial preset selection
    _customAmountMl = 2500;
    final entry = widget.existingEntry;
    if (entry != null) {
      final amountMl = (entry['quantity'] as num?)?.round() ?? 300;
      final matchIndex =
          _basePresets.indexWhere((p) => !p.isCustom && p.amountMl == amountMl);
      if (matchIndex >= 0) {
        _selectedPresetIndex = matchIndex;
      } else {
        _customAmountMl = amountMl;
        _selectedPresetIndex = _basePresets.length - 1;
      }
    } else {
      _selectedPresetIndex = 1; // default: Glass
    }
    _visiblePresetIndex = _selectedPresetIndex;

    // Scroll carousel to initial selection after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final itemExtent = _presetCardWidth + _presetCardSpacing;
      _presetScrollController.jumpTo(
        (_selectedPresetIndex * itemExtent).clamp(
          0,
          _presetScrollController.position.maxScrollExtent,
        ),
      );
    });
  }

  @override
  void dispose() {
    _presetScrollController
      ..removeListener(_handlePresetScroll)
      ..dispose();
    super.dispose();
  }

  void _handlePresetScroll() {
    final itemExtent = _presetCardWidth + _presetCardSpacing;
    final nextIndex = (_presetScrollController.offset / itemExtent)
        .round()
        .clamp(0, _basePresets.length - 1);
    if (nextIndex != _visiblePresetIndex && mounted) {
      setState(() => _visiblePresetIndex = nextIndex);
    }
  }

  Future<void> _selectPreset(int index) async {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedPresetIndex = index;
      _visiblePresetIndex = index;
    });
    final itemExtent = _presetCardWidth + _presetCardSpacing;
    _presetScrollController.animateTo(
      index * itemExtent,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );

    if (_basePresets[index].isCustom) {
      final didConfirm = await _editCustomAmount();
      if (!didConfirm && mounted) {
        setState(() {
          _selectedPresetIndex = 1;
          _visiblePresetIndex = 1;
        });
        _presetScrollController.animateTo(
          _presetCardWidth + _presetCardSpacing,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  void _setUnit(_WaterUnit unit) {
    if (_unit == unit) return;
    HapticFeedback.selectionClick();
    setState(() => _unit = unit);
  }

  Future<bool> _editCustomAmount() async {
    int draftMl = _customAmountMl;
    HapticFeedback.selectionClick();
    final didConfirm = await showModalBottomSheet<bool>(
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
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
                      context.l10n.waterLogCustomDrinkTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.l10n.waterLogCustomDrinkBody,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      _formatAmount(draftMl, _unit),
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: colors.heroEnd,
                      inactiveTrackColor: colors.softSurface,
                      thumbColor: colors.textPrimary,
                      overlayColor: colors.heroEnd.withValues(alpha: 0.12),
                    ),
                    child: Slider(
                      value: draftMl.toDouble(),
                      min: 250,
                      max: 4000,
                      divisions: 15,
                      onChanged: (value) {
                        setModalState(() {
                          draftMl =
                              ((value / 250).round() * 250).clamp(250, 4000);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            Navigator.of(context).pop(false);
                          },
                          child: Text(context.l10n.commonCancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            setState(() => _customAmountMl = draftMl);
                            Navigator.of(context).pop(true);
                          },
                          child: Text(context.l10n.waterLogUseThisAmount),
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
    return didConfirm ?? false;
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final amountMl = _selectedPreset.amountMl;
    final loggedAt = _buildLoggedAt();

    final payload = {
      'logged_at': formatIsoWithTimezone(loggedAt),
      'quantity': amountMl.toDouble(),
      'unit': 'ml',
    };

    try {
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
            RecordService.waterColumn, existingId, payload);
      } else {
        await service.updateRecord(RecordService.waterColumn, payload);
      }
      ref.invalidate(_waterLogsProvider(widget.selectedDate));
      ref.invalidate(_waterWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allWaterLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      final label =
          context.l10n.waterLogAddedToHydrationLog(_formatAmount(amountMl, _unit));
      Navigator.of(context).pop(label);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(context.l10n.waterLogCouldNotSave),
          behavior: SnackBarBehavior.floating,
        ));
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
        title: Text(context.l10n.waterLogDeleteTitle),
        content: Text(context.l10n.waterLogDeleteMessage),
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
          .deleteRecordEntry(RecordService.waterColumn, entryId);
      ref.invalidate(_waterLogsProvider(widget.selectedDate));
      ref.invalidate(_waterWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allWaterLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.waterLogDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.waterLogCouldNotDelete),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

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
                          ? context.l10n.waterLogEditTitle
                          : context.l10n.waterLogLogTitle,
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
          // Unit switch
          Center(
            child: _UnitSwitch(unit: _unit, onChanged: _setUnit),
          ),
          const SizedBox(height: 16),
          // Carousel
          SizedBox(
            height: 206,
            child: ListView.separated(
              controller: _presetScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _basePresets.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (_, __) =>
                  const SizedBox(width: _presetCardSpacing),
              itemBuilder: (context, index) {
                final preset = _basePresets[index];
                final effectivePreset = preset.isCustom
                    ? preset.copyWith(amountMl: _customAmountMl)
                    : preset;
                final displayPreset = _displayPreset(context, effectivePreset);
                return SizedBox(
                  width: _presetCardWidth,
                  child: _DrinkPresetCard(
                    preset: displayPreset,
                    unit: _unit,
                    isSelected: index == _selectedPresetIndex,
                    onTap: () => _selectPreset(index),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          _PresetPagerIndicator(
            itemCount: _basePresets.length,
            selectedIndex: _visiblePresetIndex,
          ),
          const SizedBox(height: 20),
          // Submit button
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 0, 20, 24 + MediaQuery.viewInsetsOf(context).bottom),
            child: Column(
              children: [
                if (_isEditing) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: _isSubmitting ? null : _deleteEntry,
                      icon: const Icon(Icons.delete_outline_rounded),
                      label: Text(context.l10n.waterLogDeleteLog),
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
                    child:
                        Text(
                          _isSubmitting
                              ? context.l10n.waterLogSaving
                              : _addDrinkCtaLabel(context),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Success overlay ───────────────────────────────────────────────────────────

class _WaterLogSuccessOverlay extends StatelessWidget {
  const _WaterLogSuccessOverlay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LogSuccessOverlay(
      title: label,
      icons: List.generate(
        5,
        (index) => SuccessOverlayIconSpec(
          icon: Icons.water_drop_rounded,
          color: index.isEven ? colors.heroEnd : colors.accentSky,
        ),
      ),
      rippleColor: colors.heroEnd,
      badgeColor: colors.accentSky.withValues(alpha: 0.28),
    );
  }
}

// ── Preset carousel ───────────────────────────────────────────────────────────

class _DrinkPreset {
  const _DrinkPreset({
    required this.id,
    required this.name,
    required this.amountMl,
    required this.icon,
    this.isCustom = false,
  });

  final String id;
  final String name;
  final int amountMl;
  final IconData icon;
  final bool isCustom;

  _DrinkPreset copyWith({int? amountMl}) {
    return _DrinkPreset(
      id: id,
      name: name,
      amountMl: amountMl ?? this.amountMl,
      icon: icon,
      isCustom: isCustom,
    );
  }
}

class _DrinkPresetCard extends StatelessWidget {
  const _DrinkPresetCard({
    required this.preset,
    required this.unit,
    required this.isSelected,
    required this.onTap,
  });

  final _DrinkPreset preset;
  final _WaterUnit unit;
  final bool isSelected;
  final VoidCallback onTap;

  String get _amountLabel {
    if (unit == _WaterUnit.ml) {
      if (preset.amountMl >= 1000) {
        final liters = preset.amountMl / 1000;
        return liters % 1 == 0
            ? '${liters.toStringAsFixed(0)} L'
            : '${liters.toStringAsFixed(1)} L';
      }
      return '${preset.amountMl} ml';
    }
    final ounces = preset.amountMl / 29.5735;
    return '${ounces.toStringAsFixed(1)} oz';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isSelected ? colors.heroEnd : colors.lineSubtle,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Container(
                width: 66,
                height: 96,
                decoration: BoxDecoration(
                  color: colors.softSurface,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: _DrinkPresetIllustration(
                  preset: preset,
                  isSelected: isSelected,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                preset.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _amountLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PresetPagerIndicator extends StatelessWidget {
  const _PresetPagerIndicator({
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

class _DrinkPresetIllustration extends StatelessWidget {
  const _DrinkPresetIllustration({
    required this.preset,
    required this.isSelected,
  });

  final _DrinkPreset preset;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final liquidColor = isSelected ? colors.heroEnd : colors.accentSky;
    final strokeColor = isSelected ? colors.heroEnd : colors.textSecondary;

    return Center(
      child: switch (preset.id) {
        'small_glass' => _SmallGlassIllustration(
            liquidColor: liquidColor,
            strokeColor: strokeColor,
          ),
        'glass' => _GlassIllustration(
            liquidColor: liquidColor,
            strokeColor: strokeColor,
          ),
        'bottle' => _BottleIllustration(
            liquidColor: liquidColor,
            strokeColor: strokeColor,
            tall: false,
          ),
        'large_bottle' || 'two_liters' => _BottleIllustration(
            liquidColor: liquidColor,
            strokeColor: strokeColor,
            tall: true,
          ),
        'custom' => _CustomDrinkIllustration(
            liquidColor: liquidColor,
            strokeColor: strokeColor,
          ),
        _ => _GlassIllustration(
            liquidColor: liquidColor,
            strokeColor: strokeColor,
          ),
      },
    );
  }
}

class _SmallGlassIllustration extends StatelessWidget {
  const _SmallGlassIllustration({
    required this.liquidColor,
    required this.strokeColor,
  });

  final Color liquidColor;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 62,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 38,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: strokeColor, width: 2),
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
          Container(
            width: 30,
            height: 24,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: liquidColor.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassIllustration extends StatelessWidget {
  const _GlassIllustration({
    required this.liquidColor,
    required this.strokeColor,
  });

  final Color liquidColor;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 70,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 42,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: strokeColor, width: 2),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withValues(alpha: 0.42),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: liquidColor.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottleIllustration extends StatelessWidget {
  const _BottleIllustration({
    required this.liquidColor,
    required this.strokeColor,
    required this.tall,
  });

  final Color liquidColor;
  final Color strokeColor;
  final bool tall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tall ? 44 : 40,
      height: tall ? 82 : 74,
      child: CustomPaint(
        painter: _BottlePainter(
          strokeColor: strokeColor,
          liquidColor: liquidColor,
          tall: tall,
        ),
      ),
    );
  }
}

class _CustomDrinkIllustration extends StatelessWidget {
  const _CustomDrinkIllustration({
    required this.liquidColor,
    required this.strokeColor,
  });

  final Color liquidColor;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: liquidColor.withValues(alpha: 0.16),
        shape: BoxShape.circle,
        border: Border.all(color: strokeColor, width: 2),
      ),
      child: Icon(Icons.tune_rounded, size: 24, color: strokeColor),
    );
  }
}

class _BottlePainter extends CustomPainter {
  const _BottlePainter({
    required this.strokeColor,
    required this.liquidColor,
    required this.tall,
  });

  final Color strokeColor;
  final Color liquidColor;
  final bool tall;

  @override
  void paint(Canvas canvas, Size size) {
    final outlinePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final shellPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.42)
      ..style = PaintingStyle.fill;
    final fillPaint = Paint()
      ..color = liquidColor.withValues(alpha: 0.92)
      ..style = PaintingStyle.fill;
    final capPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    final bottleWidth = size.width * (tall ? 0.76 : 0.72);
    final bodyHeight = size.height * (tall ? 0.76 : 0.70);
    final neckWidth = bottleWidth * 0.38;
    final neckHeight = size.height * 0.14;
    final capWidth = neckWidth * 1.02;
    final capHeight = size.height * 0.08;
    final left = (size.width - bottleWidth) / 2;
    final top = size.height - bodyHeight;
    final right = left + bottleWidth;
    final bottom = size.height - 2;
    final neckLeft = (size.width - neckWidth) / 2;
    final shoulderY = top + neckHeight + 6;

    final bottlePath = Path()
      ..moveTo(neckLeft, top + capHeight + 1)
      ..lineTo(neckLeft, top + neckHeight)
      ..quadraticBezierTo(left, shoulderY, left, top + neckHeight + 16)
      ..lineTo(left, bottom - 10)
      ..quadraticBezierTo(left, bottom, left + 10, bottom)
      ..lineTo(right - 10, bottom)
      ..quadraticBezierTo(right, bottom, right, bottom - 10)
      ..lineTo(right, top + neckHeight + 16)
      ..quadraticBezierTo(
          right, shoulderY, neckLeft + neckWidth, top + neckHeight)
      ..lineTo(neckLeft + neckWidth, top + capHeight + 1)
      ..close();

    canvas.drawPath(bottlePath, shellPaint);
    canvas.drawPath(bottlePath, outlinePaint);

    final capRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, top + capHeight / 2 + 1),
        width: capWidth,
        height: capHeight,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(capRect, capPaint);

    final fillLeft = left + 5;
    final fillRight = right - 5;
    final fillBottom = bottom - 5;
    final fillTop = top + (tall ? bodyHeight * 0.44 : bodyHeight * 0.38);
    final fillPath = Path()
      ..moveTo(fillLeft, fillTop + 8)
      ..quadraticBezierTo(fillLeft, fillTop, fillLeft + 8, fillTop)
      ..lineTo(fillRight - 8, fillTop)
      ..quadraticBezierTo(fillRight, fillTop, fillRight, fillTop + 8)
      ..lineTo(fillRight, fillBottom - 8)
      ..quadraticBezierTo(fillRight, fillBottom, fillRight - 8, fillBottom)
      ..lineTo(fillLeft + 8, fillBottom)
      ..quadraticBezierTo(fillLeft, fillBottom, fillLeft, fillBottom - 8)
      ..close();

    canvas.save();
    canvas.clipPath(bottlePath);
    canvas.drawPath(fillPath, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BottlePainter oldDelegate) =>
      strokeColor != oldDelegate.strokeColor ||
      liquidColor != oldDelegate.liquidColor ||
      tall != oldDelegate.tall;
}

// ── Unit switch ───────────────────────────────────────────────────────────────

class _UnitSwitch extends StatelessWidget {
  const _UnitSwitch({required this.unit, required this.onChanged});

  final _WaterUnit unit;
  final ValueChanged<_WaterUnit> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UnitPill(
            label: context.l10n.waterLogMlUnit,
            selected: unit == _WaterUnit.ml,
            onTap: () => onChanged(_WaterUnit.ml),
          ),
          _UnitPill(
            label: context.l10n.waterLogOzUnit,
            selected: unit == _WaterUnit.oz,
            onTap: () => onChanged(_WaterUnit.oz),
          ),
        ],
      ),
    );
  }
}

class _UnitPill extends StatelessWidget {
  const _UnitPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? colors.softSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: selected ? colors.textPrimary : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ── Week day selector ─────────────────────────────────────────────────────────

// ── Logged hydration list ─────────────────────────────────────────────────────

class _LoggedHydrationSection extends ConsumerWidget {
  const _LoggedHydrationSection(
      {required this.date, required this.onEditEntry});

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_waterLogsProvider(date));

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (entries) {
        if (entries.isEmpty) return const SizedBox.shrink();

        final profileSettings =
            ref.read(profileBootstrapProvider).asData?.value?.settings;
        final unit =
            _WaterUnit.fromString(profileSettings?['water_unit'] as String?);

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
                  child: _LoggedHydrationCard(
                    entry: entry,
                    unit: unit,
                    onTap: () => onEditEntry(entry),
                  ),
                )),
          ],
        );
      },
    );
  }
}

class _WaterLogListSection extends ConsumerWidget {
  const _WaterLogListSection({
    required this.entries,
    required this.onEditEntry,
  });

  final List<Map<String, dynamic>> entries;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final profileSettings =
        ref.read(profileBootstrapProvider).asData?.value?.settings;
    final unit = _WaterUnit.fromString(profileSettings?['water_unit'] as String?);

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
                child: _LoggedHydrationCard(
                  entry: entry,
                  unit: unit,
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

class _LoggedHydrationCard extends StatelessWidget {
  const _LoggedHydrationCard({
    required this.entry,
    required this.unit,
    required this.onTap,
  });

  final Map<String, dynamic> entry;
  final _WaterUnit unit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final amountMl = (entry['quantity'] as num?)?.round() ?? 0;
    final displayAmount = _formatAmount(amountMl, unit);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.accentSky.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.water_drop_rounded,
                size: 18,
                color: colors.heroEnd.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Text(
                    displayAmount,
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
