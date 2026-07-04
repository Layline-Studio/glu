import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';

const _activeMarkerColor = Color(0xFFE4802A);

class HeightRulerSelector extends StatefulWidget {
  const HeightRulerSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.compact = false,
  });

  final dynamic value;
  final ValueChanged<Map<String, dynamic>> onChanged;
  final bool compact;

  @override
  State<HeightRulerSelector> createState() => _HeightRulerSelectorState();
}

class _HeightRulerSelectorState extends State<HeightRulerSelector> {
  static const _metricMin = 120;
  static const _metricMax = 230;
  static const _metricDefault = 170;
  static const _imperialMin = 48;
  static const _imperialMax = 84;
  static const _itemExtent = 40.0;
  static const _compactItemExtent = 36.0;
  static const _rulerHeight = 320.0;
  static const _compactRulerHeight = 256.0;

  late final ScrollController _scrollController;
  late String _unit;
  late int _selectedValue;
  bool _isJumping = false;

  @override
  void initState() {
    super.initState();
    final map = _valueMap;
    _unit = (map['unit'] as String?) ?? 'metric';
    _selectedValue = _initialValueForUnit(_unit, map);
    _scrollController = ScrollController(
      initialScrollOffset: _offsetForValue(_selectedValue),
    );
    _scrollController.addListener(_handleScroll);
  }

  Map<String, dynamic> get _valueMap => widget.value is Map<String, dynamic>
      ? Map<String, dynamic>.from(widget.value as Map<String, dynamic>)
      : <String, dynamic>{};

  List<int> get _values => [
        for (var value = _maxValue; value >= _minValue; value--) value,
      ];

  int get _minValue => _unit == 'metric' ? _metricMin : _imperialMin;

  int get _maxValue => _unit == 'metric' ? _metricMax : _imperialMax;

  double get _currentRulerHeight =>
      widget.compact ? _compactRulerHeight : _rulerHeight;

  double get _currentItemExtent =>
      widget.compact ? _compactItemExtent : _itemExtent;

  double get _currentVerticalPadding =>
      (_currentRulerHeight - _currentItemExtent) / 2;

  @override
  void didUpdateWidget(covariant HeightRulerSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value == widget.value && oldWidget.compact == widget.compact) {
      return;
    }
    final map = _valueMap;
    final nextUnit = (map['unit'] as String?) ?? _unit;
    final nextValue = _initialValueForUnit(nextUnit, map);
    if (
      nextUnit != _unit ||
      nextValue != _selectedValue ||
      oldWidget.compact != widget.compact
    ) {
      setState(() {
        _unit = nextUnit;
        _selectedValue = nextValue;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _jumpToSelectedValue();
      });
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  int _initialValueForUnit(String unit, Map<String, dynamic> map) {
    final primary = int.tryParse(map['primary']?.toString() ?? '');
    final secondary = int.tryParse(map['secondary']?.toString() ?? '');
    if (unit == 'metric') {
      final cm = primary ?? _metricDefault;
      return cm.clamp(_metricMin, _metricMax);
    }
    final totalInches = primary != null
        ? (primary * 12) + (secondary ?? 0)
        : (_metricDefault / 2.54).round();
    return totalInches.clamp(_imperialMin, _imperialMax);
  }

  void _handleScroll() {
    if (_isJumping || !_scrollController.hasClients) {
      return;
    }

    final rawIndex = (_scrollController.offset / _currentItemExtent).round();
    final index = rawIndex.clamp(0, _values.length - 1);
    final nextValue = _values[index];

    if (nextValue == _selectedValue) {
      return;
    }

    setState(() {
      _selectedValue = nextValue;
    });
    HapticFeedback.selectionClick();
    _emit();
  }

  double _offsetForValue(int value) {
    final index = (_maxValue - value).clamp(0, _values.length - 1);
    return index * _currentItemExtent;
  }

  void _jumpToSelectedValue() {
    if (!_scrollController.hasClients) {
      return;
    }

    _isJumping = true;
    _scrollController.jumpTo(_offsetForValue(_selectedValue));
    _isJumping = false;
  }

  Future<void> _animateToSelectedValue() async {
    if (!_scrollController.hasClients) {
      return;
    }
    _isJumping = true;
    await _scrollController.animateTo(
      _offsetForValue(_selectedValue),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
    _isJumping = false;
  }

  void _setUnit(String unit) {
    if (unit == _unit) {
      return;
    }
    final converted = unit == 'metric'
        ? (_selectedValue * 2.54).round().clamp(_metricMin, _metricMax)
        : (_selectedValue / 2.54).round().clamp(_imperialMin, _imperialMax);
    setState(() {
      _unit = unit;
      _selectedValue = converted;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _jumpToSelectedValue();
      _emit();
    });
  }

  void _emit() {
    if (_unit == 'metric') {
      widget.onChanged({
        'unit': 'metric',
        'primary': _selectedValue.toString(),
        'secondary': null,
      });
      return;
    }

    widget.onChanged({
      'unit': 'imperial',
      'primary': (_selectedValue ~/ 12).toString(),
      'secondary': (_selectedValue % 12).toString(),
    });
  }

  String _displayValue(BuildContext context) {
    if (_unit == 'metric') {
      return '$_selectedValue ${context.l10n.heightRulerCmUnit}';
    }
    final feet = _selectedValue ~/ 12;
    final inches = _selectedValue % 12;
    return '$feet ${context.l10n.heightRulerFtUnit} $inches ${context.l10n.heightRulerInUnit}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return SizedBox(
      height: _currentRulerHeight,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Positioned(
                  left: -18,
                  top: 20,
                  bottom: 20,
                  child: Container(
                    width: 42,
                    decoration: BoxDecoration(
                      color: colors.heroEnd,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Transform.translate(
                    offset: const Offset(-75, 0),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: _currentVerticalPadding,
                      ),
                      itemExtent: _currentItemExtent,
                      itemCount: _values.length,
                      itemBuilder: (context, index) {
                        final value = _values[index];
                        final isSelected = value == _selectedValue;

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _selectedValue = value;
                            });
                            HapticFeedback.selectionClick();
                            _emit();
                            _animateToSelectedValue();
                          },
                          child: SizedBox(
                            width: 88,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: widget.compact ? 30 : 34,
                                  child: Text(
                                    '$value',
                                    textAlign: TextAlign.right,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: isSelected
                                          ? colors.textPrimary
                                          : colors.textSecondary,
                                      fontSize: widget.compact ? 12 : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: isSelected ? 20 : 14,
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? _activeMarkerColor
                                        : colors.lineSubtle,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colors.canvas,
                            colors.canvas.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colors.canvas.withValues(alpha: 0),
                            colors.canvas,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: (_rulerHeight - 3) / 2,
                  child: SizedBox(
                    width: 54,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 3,
                        width: 40,
                        decoration: BoxDecoration(
                          color: _activeMarkerColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 4,
            child: Transform.translate(
              offset: const Offset(-40, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _displayValue(context),
                    style: (widget.compact
                            ? theme.textTheme.headlineSmall
                            : theme.textTheme.headlineMedium)
                        ?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: widget.compact ? 12 : 18),
                  PopupMenuButton<String>(
                    onSelected: _setUnit,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'imperial',
                        child: Text(context.l10n.heightRulerFtInUnit),
                      ),
                      PopupMenuItem(
                        value: 'metric',
                        child: Text(context.l10n.heightRulerCmUnit),
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: colors.softSurface,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colors.lineSubtle),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _unit == 'metric'
                                ? l10n.heightRulerCmUnit
                                : l10n.heightRulerFtInUnit,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: colors.textSecondary,
                          ),
                        ],
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
