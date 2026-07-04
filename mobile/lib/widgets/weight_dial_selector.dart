import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';

class WeightDialSelector extends StatefulWidget {
  const WeightDialSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.fallbackValue,
    this.showStepButtons = false,
    this.stepAmount,
  });

  final dynamic value;
  final ValueChanged<Map<String, dynamic>> onChanged;
  final dynamic fallbackValue;
  final bool showStepButtons;
  final double? stepAmount;

  @override
  State<WeightDialSelector> createState() => _WeightDialSelectorState();
}

class _WeightDialSelectorState extends State<WeightDialSelector>
    with SingleTickerProviderStateMixin {
  static const _kgMin = 40.0;
  static const _kgMax = 180.0;
  static const _kgDefault = 80.0;
  static const _lbMin = 88.0;
  static const _lbMax = 396.0;
  static const _kgStep = 0.1;
  static const _lbStep = 0.2;

  static const _shellWidth = 286.0;
  static const _shellHeight = 150.0;

  static const _centerNeedleAngle = math.pi / 2;
  static const _halfSweep = math.pi / 2.18;
  static const _dialCenterYOffsetFactor = 1.08;

  late String _unit;
  late double _selectedValue;
  late int _lastHapticBucket;
  late final TextEditingController _inputController;
  late final FocusNode _inputFocusNode;
  late final AnimationController _tapAnimationController;
  Animation<double>? _tapAnimation;

  @override
  void initState() {
    super.initState();
    final map = _valueMap;
    _unit = (map['unit'] as String?) ?? 'kg';
    _selectedValue = _initialValueForUnit(_unit, map);
    _lastHapticBucket = _stepBucket(_selectedValue);
    _inputController = TextEditingController(
      text: _formattedValue(_selectedValue),
    );
    _inputFocusNode = FocusNode()
      ..addListener(() {
        if (!_inputFocusNode.hasFocus) {
          _commitTypedValue();
        }
      });
    _tapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(() {
        final animation = _tapAnimation;
        if (animation == null) {
          return;
        }
        _setValue(animation.value);
      });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocusNode.dispose();
    _tapAnimationController.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _valueMap => widget.value is Map<String, dynamic>
      ? Map<String, dynamic>.from(widget.value as Map<String, dynamic>)
      : <String, dynamic>{};

  Map<String, dynamic> get _fallbackMap =>
      widget.fallbackValue is Map<String, dynamic>
          ? Map<String, dynamic>.from(
              widget.fallbackValue as Map<String, dynamic>,
            )
          : <String, dynamic>{};

  double get _minValue => _unit == 'kg' ? _kgMin : _lbMin;

  double get _maxValue => _unit == 'kg' ? _kgMax : _lbMax;

  double get _majorStep => _unit == 'kg' ? 10 : 20;

  double get _midStep => _unit == 'kg' ? 5 : 10;

  double get _minorStep => _unit == 'kg' ? 0.5 : 1.0;

  double get _stepAmount => widget.stepAmount ?? (_unit == 'kg' ? _kgStep : _lbStep);

  double get _visibleHalfRange => _unit == 'kg' ? 20 : 40;

  double _initialValueForUnit(String unit, Map<String, dynamic> map) {
    final primary = double.tryParse(map['primary']?.toString() ?? '');
    final fallbackPrimary = double.tryParse(
      _fallbackMap['primary']?.toString() ?? '',
    );
    if (unit == 'kg') {
      return (primary ?? fallbackPrimary ?? _kgDefault).clamp(_kgMin, _kgMax);
    }
    return (primary ?? fallbackPrimary ?? (_kgDefault * 2.20462)).clamp(
      _lbMin,
      _lbMax,
    );
  }

  void _setUnit(String unit) {
    if (unit == _unit) {
      return;
    }
    _tapAnimationController.stop();

    final converted = unit == 'kg'
        ? (_selectedValue / 2.20462).clamp(_kgMin, _kgMax)
        : (_selectedValue * 2.20462).clamp(_lbMin, _lbMax);

    setState(() {
      _unit = unit;
      _selectedValue = converted;
    });
    _lastHapticBucket = _stepBucket(_selectedValue);
    _syncInputText();
    _triggerSelectionHapticIfNeeded();
    _emit();
  }

  void _setValue(double value) {
    final clamped = value.clamp(_minValue, _maxValue);
    if ((clamped - _selectedValue).abs() < 0.05) {
      return;
    }
    setState(() {
      _selectedValue = clamped;
    });
    _syncInputText();
    _triggerSelectionHapticIfNeeded();
    _emit();
  }

  void _triggerSelectionHapticIfNeeded() {
    final currentBucket = _stepBucket(_selectedValue);
    if (currentBucket == _lastHapticBucket) {
      return;
    }
    _lastHapticBucket = currentBucket;
    HapticFeedback.selectionClick();
  }

  int _stepBucket(double value) => (value / _stepAmount).round();

  void _emit() {
    widget.onChanged({
      'unit': _unit,
      'primary': _displayNumber.toStringAsFixed(1),
      'secondary': null,
    });
  }

  String _formattedValue(double value) {
    return value == value.truncateToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
  }

  void _syncInputText({bool force = false}) {
    if (_inputFocusNode.hasFocus && !force) {
      return;
    }
    final nextText = _formattedValue(_displayNumber);
    if (_inputController.text == nextText) {
      return;
    }
    _inputController.value = TextEditingValue(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextText.length),
    );
  }

  void _commitTypedValue() {
    final raw = _inputController.text.trim().replaceAll(',', '.');
    final parsed = double.tryParse(raw);
    if (parsed == null) {
      _syncInputText(force: true);
      return;
    }
    final stepped = (_stepAmount * (parsed / _stepAmount).round()).clamp(
      _minValue,
      _maxValue,
    );
    _setValue(stepped);
    _syncInputText(force: true);
  }

  double get _displayNumber => _selectedValue;

  void _handleDragUpdate(DragUpdateDetails details) {
    _tapAnimationController.stop();
    final sensitivity = _unit == 'kg' ? 0.12 : 0.25;
    _setValue(_selectedValue - (details.delta.dx * sensitivity));
  }

  void _handleTapDown(TapDownDetails details) {
    final targetValue = _valueForTap(details.localPosition);
    _animateToValue(targetValue);
  }

  double _valueForTap(Offset localPosition) {
    const center = Offset(
      _shellWidth / 2,
      _shellHeight * _dialCenterYOffsetFactor,
    );
    final dx = localPosition.dx - center.dx;
    final dy = center.dy - localPosition.dy;
    final tappedAngle = math.atan2(dy, dx);
    final minAngle = _centerNeedleAngle - _halfSweep;
    final maxAngle = _centerNeedleAngle + _halfSweep;
    final clampedAngle = tappedAngle.clamp(minAngle, maxAngle);
    final delta =
        ((_centerNeedleAngle - clampedAngle) / _halfSweep) * _visibleHalfRange;
    final raw = (_selectedValue + delta).clamp(_minValue, _maxValue);
    final snapped = (_stepAmount * (raw / _stepAmount).round()).clamp(_minValue, _maxValue);
    return snapped;
  }

  void _animateToValue(double targetValue) {
    final target = targetValue.clamp(_minValue, _maxValue);
    if ((target - _selectedValue).abs() < 0.05) {
      return;
    }

    _tapAnimationController.stop();
    _tapAnimation = Tween<double>(
      begin: _selectedValue,
      end: target,
    ).animate(CurvedAnimation(
      parent: _tapAnimationController,
      curve: Curves.easeOutCubic,
    ));
    _tapAnimationController
      ..reset()
      ..forward();
  }

  void _handleStepTap(double delta) {
    _tapAnimationController.stop();
    _setValue(_selectedValue + delta);
  }

  @override
  void didUpdateWidget(covariant WeightDialSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value == widget.value) {
      return;
    }
    final map = _valueMap;
    final nextUnit = (map['unit'] as String?) ?? _unit;
    final nextValue = _initialValueForUnit(nextUnit, map);
    if (nextUnit != _unit || (nextValue - _selectedValue).abs() > 0.05) {
      setState(() {
        _unit = nextUnit;
        _selectedValue = nextValue;
        _lastHapticBucket = _stepBucket(nextValue);
      });
      _syncInputText();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: _handleTapDown,
            onPanUpdate: _handleDragUpdate,
            child: SizedBox(
              width: _shellWidth,
              height: _shellHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(_shellWidth, _shellHeight),
                    painter: _WeightDialPainter(
                      colors: colors,
                      textTheme: theme.textTheme,
                      selectedValue: _displayNumber,
                      minValue: _minValue,
                      maxValue: _maxValue,
                      majorStep: _majorStep,
                      midStep: _midStep,
                      minorStep: _minorStep,
                      visibleHalfRange: _visibleHalfRange,
                      unit: _unit,
                      centerNeedleAngle: _centerNeedleAngle,
                      halfSweep: _halfSweep,
                    ),
                  ),
                  Positioned(
                    bottom: 26,
                    child: PopupMenuButton<String>(
                      onSelected: _setUnit,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'kg',
                          child: Text(context.l10n.weightDialKgUnit),
                        ),
                        PopupMenuItem(
                          value: 'lb',
                          child: Text(context.l10n.weightDialLbUnit),
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colors.softSurface,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: colors.lineSubtle),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A0C1118),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text(
                            _unit == 'kg'
                                ? context.l10n.weightDialKgUnit
                                : context.l10n.weightDialLbUnit,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colors.textPrimary,
                            ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: colors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.showStepButtons) ...[
                _StepButton(
                  icon: Icons.remove_rounded,
                  onTap: () => _handleStepTap(-_stepAmount),
                ),
                const SizedBox(width: 16),
              ],
              Container(
                padding: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _inputFocusNode.hasFocus
                          ? colors.textSecondary.withValues(alpha: 0.45)
                          : colors.lineSubtle,
                      width: 1,
                    ),
                  ),
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: _inputController,
                    focusNode: _inputFocusNode,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    onSubmitted: (_) => _commitTypedValue(),
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colors.textPrimary,
                    ),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _unit,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
              ),
              if (widget.showStepButtons) ...[
                const SizedBox(width: 16),
                _StepButton(
                  icon: Icons.add_rounded,
                  onTap: () => _handleStepTap(_stepAmount),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatefulWidget {
  const _StepButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_StepButton> createState() => _StepButtonState();
}

class _StepButtonState extends State<_StepButton> {
  static const _initialDelay = Duration(milliseconds: 320);
  static const _repeatInterval = Duration(milliseconds: 90);

  Timer? _holdTimer;
  Timer? _repeatTimer;

  void _triggerTap() {
    HapticFeedback.selectionClick();
    widget.onTap();
  }

  void _startHold() {
    _cancelTimers();
    _triggerTap();
    _holdTimer = Timer(_initialDelay, () {
      _repeatTimer = Timer.periodic(_repeatInterval, (_) {
        _triggerTap();
      });
    });
  }

  void _cancelTimers() {
    _holdTimer?.cancel();
    _repeatTimer?.cancel();
    _holdTimer = null;
    _repeatTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: colors.softSurface,
      shape: CircleBorder(
        side: BorderSide(color: colors.lineSubtle),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTapDown: (_) => _startHold(),
        onTapUp: (_) => _cancelTimers(),
        onTapCancel: _cancelTimers,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            widget.icon,
            color: colors.textPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _WeightDialPainter extends CustomPainter {
  const _WeightDialPainter({
    required this.colors,
    required this.textTheme,
    required this.selectedValue,
    required this.minValue,
    required this.maxValue,
    required this.majorStep,
    required this.midStep,
    required this.minorStep,
    required this.visibleHalfRange,
    required this.unit,
    required this.centerNeedleAngle,
    required this.halfSweep,
  });

  final AppColors colors;
  final TextTheme textTheme;
  final double selectedValue;
  final double minValue;
  final double maxValue;
  final double majorStep;
  final double midStep;
  final double minorStep;
  final double visibleHalfRange;
  final String unit;
  final double centerNeedleAngle;
  final double halfSweep;

  @override
  void paint(Canvas canvas, Size size) {
    final outerPath = _outerShellPath(size);
    final outerPaint = Paint()..color = colors.heroEnd;

    canvas.drawShadow(outerPath, const Color(0x220C1118), 24, false);
    canvas.drawPath(outerPath, outerPaint);

    final innerPath = _innerFacePath(size);
    final innerPaint = Paint()..color = colors.surface;
    canvas.drawPath(innerPath, innerPaint);

    canvas.save();
    canvas.clipPath(innerPath);

    final center = Offset(size.width / 2, size.height * 1.08);
    final radius = size.width * 0.49;

    _drawTicks(canvas, center, radius);
    _drawLabels(canvas, center, radius);
    _drawInnerDepth(canvas, size);
    canvas.restore();
    _drawNeedle(canvas, center, radius);
  }

  Path _outerShellPath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    path.moveTo(w * 0.07, h * 0.38);
    path.quadraticBezierTo(w * 0.08, h * 0.1, w * 0.27, h * 0.05);
    path.quadraticBezierTo(w * 0.5, -4, w * 0.73, h * 0.05);
    path.quadraticBezierTo(w * 0.92, h * 0.1, w * 0.93, h * 0.38);
    path.lineTo(w * 0.98, h * 0.9);
    path.quadraticBezierTo(w * 0.97, h, w * 0.82, h);
    path.lineTo(w * 0.18, h);
    path.quadraticBezierTo(w * 0.03, h, w * 0.02, h * 0.88);
    path.close();

    return path;
  }

  Path _innerFacePath(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    path.moveTo(w * 0.13, h * 0.38);
    path.quadraticBezierTo(w * 0.14, h * 0.14, w * 0.3, h * 0.11);
    path.quadraticBezierTo(w * 0.5, h * 0.06, w * 0.7, h * 0.11);
    path.quadraticBezierTo(w * 0.86, h * 0.14, w * 0.87, h * 0.38);
    path.lineTo(w * 0.87, h * 0.82);
    path.quadraticBezierTo(w * 0.86, h * 0.96, w * 0.74, h * 0.95);
    path.lineTo(w * 0.26, h * 0.94);
    path.quadraticBezierTo(w * 0.14, h * 0.95, w * 0.13, h * 0.79);
    path.close();

    return path;
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = colors.textPrimary
      ..strokeCap = StrokeCap.round;

    final startValue = (selectedValue - visibleHalfRange);
    final endValue = (selectedValue + visibleHalfRange);
    final firstTick = (startValue / minorStep).floor() * minorStep;

    for (double value = firstTick;
        value <= endValue + minorStep;
        value += minorStep) {
      if (value < minValue || value > maxValue) {
        continue;
      }
      final delta = value - selectedValue;
      if (delta.abs() > visibleHalfRange + 0.001) {
        continue;
      }
      final angle = centerNeedleAngle - (delta / visibleHalfRange) * halfSweep;
      final isMajor =
          (value / majorStep).roundToDouble() == (value / majorStep);
      final isMid =
          !isMajor && (value / midStep).roundToDouble() == (value / midStep);

      final outer = _pointOnArc(center, radius, angle);
      final inner = _pointOnArc(
        center,
        radius - (isMajor ? 22 : (isMid ? 16 : 12)),
        angle,
      );

      tickPaint
        ..strokeWidth = isMajor ? 1.8 : (isMid ? 1.2 : 0.95)
        ..color = isMajor
            ? colors.textPrimary
            : isMid
                ? colors.textPrimary.withValues(alpha: 0.56)
                : colors.textPrimary.withValues(alpha: 0.32);

      canvas.drawLine(inner, outer, tickPaint);
    }
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final centerLabel = (selectedValue / majorStep).round() * majorStep;
    final labels = <double>[
      centerLabel - (majorStep * 2),
      centerLabel - majorStep,
      centerLabel,
      centerLabel + majorStep,
      centerLabel + (majorStep * 2),
    ];

    for (final value in labels) {
      if (value < minValue || value > maxValue) {
        continue;
      }
      final delta = value - selectedValue;
      if (delta.abs() > visibleHalfRange + 0.001) {
        continue;
      }
      final angle = centerNeedleAngle - (delta / visibleHalfRange) * halfSweep;
      final labelPoint = _pointOnArc(center, radius - 38, angle);
      final text = value.round().toString();

      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: textTheme.labelSmall?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final offset = Offset(
        labelPoint.dx - (painter.width / 2),
        labelPoint.dy - (painter.height / 2),
      );
      painter.paint(canvas, offset);
    }
  }

  void _drawInnerDepth(Canvas canvas, Size size) {
    final innerBounds = Rect.fromLTWH(
      size.width * 0.13,
      size.height * 0.11,
      size.width * 0.74,
      size.height * 0.84,
    );
    final fadeWidth = innerBounds.width * 0.34;
    final leftFade = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          colors.surface.withValues(alpha: 0.92),
          colors.surface.withValues(alpha: 0),
        ],
      ).createShader(
        Rect.fromLTWH(
          innerBounds.left,
          innerBounds.top,
          fadeWidth,
          innerBounds.height,
        ),
      );
    canvas.drawRect(
      Rect.fromLTWH(
        innerBounds.left,
        innerBounds.top,
        fadeWidth,
        innerBounds.height,
      ),
      leftFade,
    );

    final rightFade = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          colors.surface.withValues(alpha: 0),
          colors.surface.withValues(alpha: 0.92),
        ],
      ).createShader(
        Rect.fromLTWH(
          innerBounds.right - fadeWidth,
          innerBounds.top,
          fadeWidth,
          innerBounds.height,
        ),
      );
    canvas.drawRect(
      Rect.fromLTWH(
        innerBounds.right - fadeWidth,
        innerBounds.top,
        fadeWidth,
        innerBounds.height,
      ),
      rightFade,
    );
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius) {
    final anchor = Offset(center.dx, center.dy - radius + 6);
    final tip = Offset(center.dx, anchor.dy + 22);
    final baseLeft = Offset(anchor.dx - 4.5, anchor.dy + 2);
    final baseRight = Offset(anchor.dx + 4.5, anchor.dy + 2);

    final pointerPath = Path()
      ..moveTo(anchor.dx, anchor.dy - 10)
      ..lineTo(baseRight.dx, baseRight.dy)
      ..lineTo(tip.dx, tip.dy)
      ..lineTo(baseLeft.dx, baseLeft.dy)
      ..close();

    final pointerPaint = Paint()..color = const Color(0xFFE4802A);
    canvas.drawPath(pointerPath, pointerPaint);

    final capPaint = Paint()..color = const Color(0xFFD86F1B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(anchor.dx, anchor.dy - 2),
          width: 8,
          height: 18,
        ),
        const Radius.circular(6),
      ),
      capPaint,
    );
  }

  Offset _pointOnArc(Offset center, double radius, double angle) {
    return Offset(
      center.dx + math.cos(angle) * radius,
      center.dy - math.sin(angle) * radius,
    );
  }

  @override
  bool shouldRepaint(covariant _WeightDialPainter oldDelegate) {
    return oldDelegate.selectedValue != selectedValue ||
        oldDelegate.unit != unit ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.colors != colors;
  }
}
