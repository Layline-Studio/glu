import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';

class BmiIndicator extends StatelessWidget {
  static const _markerColor = Color(0xFFE4802A);

  const BmiIndicator({
    super.key,
    required this.age,
    required this.heightValue,
    required this.weightValue,
    this.targetWeightValue,
    this.title = '',
    this.showValueLabel = true,
    this.showUnitLabel = true,
    this.showLegend = true,
  });

  final int? age;
  final dynamic heightValue;
  final dynamic weightValue;
  final dynamic targetWeightValue;
  final String title;
  final bool showValueLabel;
  final bool showUnitLabel;
  final bool showLegend;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final showCategoryLabel = age == null || age! >= 20;
    final metrics = BmiMetrics.tryParse(
      age: age,
      heightValue: heightValue,
      weightValue: weightValue,
    );
    final targetMetrics = targetWeightValue == null
        ? null
        : BmiMetrics.tryParse(
            age: age,
            heightValue: heightValue,
            weightValue: targetWeightValue,
          );

    if (metrics == null) {
      return const SizedBox.shrink();
    }

    final indicatorPosition = _indicatorPosition(metrics.bmi);
    final targetIndicatorPosition = targetMetrics == null
        ? null
        : _indicatorPosition(targetMetrics.bmi);
    final statusColor = metrics.category.color;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.isEmpty ? l10n.bmiIndicatorYourBmi : title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (showCategoryLabel && !showValueLabel) ...[
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    metrics.category.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),
          if (showValueLabel) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  metrics.bmi.toStringAsFixed(1),
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (showUnitLabel) ...[
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'kg/m²',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                if (showCategoryLabel)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      metrics.category.label,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              final markerLeft = math.max<double>(
                0,
                math.min<double>(
                  barWidth - 4,
                  (barWidth * indicatorPosition) - 2,
                ),
              );
              final targetMarkerLeft = targetIndicatorPosition == null
                  ? null
                  : math.max<double>(
                      0,
                      math.min<double>(
                        barWidth - 2,
                        (barWidth * targetIndicatorPosition) - 1,
                      ),
                    );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: colors.heroEnd.withValues(alpha: 0.12),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8FC6FF),
                              Color(0xFF7BD2B8),
                              Color(0xFFF6D76D),
                              Color(0xFFF3A35C),
                              Color(0xFFE65C6E),
                            ],
                          ),
                        ),
                      ),
                      ..._thresholds.map((threshold) {
                        final left = (barWidth * _indicatorPosition(threshold)) - 0.5;
                        return Positioned(
                          left: math.max(0, math.min(barWidth - 1, left)),
                          top: 3,
                          bottom: 3,
                          child: Container(
                            width: 1,
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        );
                      }),
                      if (targetMarkerLeft != null)
                        Positioned(
                          left: targetMarkerLeft,
                          top: -8,
                          bottom: -8,
                          width: 2,
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: _DashedVerticalLinePainter(
                                color: _markerColor.withValues(alpha: 0.78),
                                dashHeight: 3,
                                dashGap: 3,
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        ),
                      if (!showValueLabel && showCategoryLabel)
                        Positioned(
                          right: 0,
                          top: -8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              metrics.category.label,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        left: markerLeft,
                        top: -8,
                        bottom: -8,
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: _markerColor,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x220C1118),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (showLegend) ...[
                    const SizedBox(height: 12),
                    const _BmiLegend(),
                    const SizedBox(height: 8),
                    _BmiMarkerLegend(showTarget: targetIndicatorPosition != null),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  static const _thresholds = [18.5, 25.0, 30.0];

  double _indicatorPosition(double bmi) {
    const minBmi = 15.0;
    const maxBmi = 40.0;
    final clamped = bmi.clamp(minBmi, maxBmi);
    return (clamped - minBmi) / (maxBmi - minBmi);
  }
}

class _DashedVerticalLinePainter extends CustomPainter {
  const _DashedVerticalLinePainter({
    required this.color,
    this.dashHeight = 3,
    this.dashGap = 3,
    this.strokeWidth = 1.5,
  });

  final Color color;
  final double dashHeight;
  final double dashGap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final x = size.width / 2;
    var y = 0.0;
    while (y < size.height) {
      final endY = math.min(y + dashHeight, size.height);
      canvas.drawLine(Offset(x, y), Offset(x, endY), paint);
      y += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedVerticalLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashHeight != dashHeight ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class _BmiLegend extends StatelessWidget {
  const _BmiLegend();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      children: [
        _LegendItem(
          label: context.l10n.bmiIndicatorUnderweight,
          marker: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF8FC6FF),
              shape: BoxShape.circle,
            ),
          ),
          textStyle: theme.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 8,
          ),
        ),
        _LegendItem(
          label: context.l10n.bmiIndicatorNormal,
          marker: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF7BD2B8),
              shape: BoxShape.circle,
            ),
          ),
          textStyle: theme.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 8,
          ),
        ),
        _LegendItem(
          label: context.l10n.bmiIndicatorOverweight,
          marker: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFF3A35C),
              shape: BoxShape.circle,
            ),
          ),
          textStyle: theme.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 8,
          ),
        ),
        _LegendItem(
          label: context.l10n.bmiIndicatorObesity,
          marker: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFE65C6E),
              shape: BoxShape.circle,
            ),
          ),
          textStyle: theme.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}

class _BmiMarkerLegend extends StatelessWidget {
  const _BmiMarkerLegend({required this.showTarget});

  final bool showTarget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      children: [
        _LegendItem(
          label: context.l10n.bmiIndicatorCurrentBmi,
          marker: Container(
            width: 16,
            height: 4,
            decoration: BoxDecoration(
              color: BmiIndicator._markerColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          textStyle: theme.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 8,
          ),
        ),
        if (showTarget)
          _LegendItem(
            label: context.l10n.onboardingTargetBmiTitle,
            marker: SizedBox(
              width: 16,
              height: 8,
              child: CustomPaint(
                painter: _DashedHorizontalLinePainter(
                  color: BmiIndicator._markerColor.withValues(alpha: 0.78),
                  dashHeight: 2.5,
                  dashGap: 2.5,
                  strokeWidth: 1.4,
                ),
              ),
            ),
            textStyle: theme.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w400,
              fontSize: 8,
            ),
          ),
      ],
    );
  }
}

class _DashedHorizontalLinePainter extends CustomPainter {
  const _DashedHorizontalLinePainter({
    required this.color,
    this.dashHeight = 3,
    this.dashGap = 3,
    this.strokeWidth = 1.5,
  });

  final Color color;
  final double dashHeight;
  final double dashGap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final y = size.height / 2;
    var x = 0.0;
    while (x < size.width) {
      final endX = math.min(x + dashHeight, size.width);
      canvas.drawLine(Offset(x, y), Offset(endX, y), paint);
      x += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedHorizontalLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashHeight != dashHeight ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.label,
    required this.marker,
    required this.textStyle,
  });

  final String label;
  final Widget marker;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          marker,
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

enum BmiCategory {
  underweight('Underweight', Color(0xFF8FC6FF)),
  normal('Normal', Color(0xFF7BD2B8)),
  overweight('Overweight', Color(0xFFF3A35C)),
  obesity('Obesity', Color(0xFFE65C6E));

  const BmiCategory(this.label, this.color);

  final String label;
  final Color color;
}

class BmiMetrics {
  const BmiMetrics({
    required this.bmi,
    required this.weightKg,
    required this.heightMeters,
    required this.category,
  });

  final double bmi;
  final double weightKg;
  final double heightMeters;
  final BmiCategory category;

  static BmiMetrics? tryParse({
    required int? age,
    required dynamic heightValue,
    required dynamic weightValue,
  }) {
    final heightMeters = _parseHeightMeters(heightValue);
    final weightKg = _parseWeightKg(weightValue);
    if (heightMeters == null || weightKg == null || heightMeters <= 0) {
      return null;
    }

    final bmi = weightKg / (heightMeters * heightMeters);
    final category = bmi < 18.5
        ? BmiCategory.underweight
        : bmi < 25
            ? BmiCategory.normal
            : bmi < 30
                ? BmiCategory.overweight
                : BmiCategory.obesity;

    return BmiMetrics(
      bmi: bmi,
      weightKg: weightKg,
      heightMeters: heightMeters,
      category: category,
    );
  }

  static double? _parseHeightMeters(dynamic value) {
    if (value is! Map) {
      return null;
    }

    final map = Map<String, dynamic>.from(value);
    final unit = map['unit']?.toString();
    if (unit == 'metric') {
      final cm = double.tryParse(map['primary']?.toString() ?? '');
      return cm == null ? null : cm / 100;
    }

    if (unit == 'imperial') {
      final feet = double.tryParse(map['primary']?.toString() ?? '');
      final inches = double.tryParse(map['secondary']?.toString() ?? '') ?? 0;
      if (feet == null) {
        return null;
      }
      return ((feet * 12) + inches) * 0.0254;
    }

    return null;
  }

  static double? _parseWeightKg(dynamic value) {
    if (value is! Map) {
      return null;
    }

    final map = Map<String, dynamic>.from(value);
    final unit = map['unit']?.toString();
    final primary = double.tryParse(map['primary']?.toString() ?? '');
    if (primary == null) {
      return null;
    }

    if (unit == 'kg') {
      return primary;
    }
    if (unit == 'lb') {
      return primary / 2.20462;
    }
    return null;
  }
}
