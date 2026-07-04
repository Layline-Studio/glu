import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../theme/app_colors.dart';

class WeightProgressEmptyState extends StatelessWidget {
  const WeightProgressEmptyState({super.key, required this.onLogWeight});

  final VoidCallback onLogWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: colors.lineSubtle),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F8DBA).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _WeightEmptyPreview(),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.softSurface,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  context.l10n.weightProgressUnlocksViewChip,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                context.l10n.weightProgressStartsHereTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.l10n.weightProgressStartsHereBody,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _WeightEmptyFeatureChip(label: context.l10n.weightProgressTrendView),
                  _WeightEmptyFeatureChip(label: context.l10n.weightProgressDoseOverlays),
                  _WeightEmptyFeatureChip(label: context.l10n.weightProgressMilestones),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onLogWeight,
                  icon: const Icon(Icons.add_rounded),
                  label: Text(context.l10n.weightProgressLogWeight),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.textPrimary,
                    foregroundColor: colors.canvas,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeightEmptyPreview extends StatelessWidget {
  const _WeightEmptyPreview();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: colors.lineSubtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F8DBA).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.monitor_weight_rounded,
                  color: Color(0xFF6F8DBA),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.progressFutureTrendTitle,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.progressFutureTrendBody,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F8DBA).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  context.l10n.progressGoal,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF4E6A93),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 144,
            child: _AnimatedWeightEmptyPreviewChart(
              lineColor: const Color(0xFF6F8DBA),
              guideColor: colors.textSecondary.withValues(alpha: 0.14),
              markerColor: const Color(0xFFFFAA5B),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedWeightEmptyPreviewChart extends StatefulWidget {
  const _AnimatedWeightEmptyPreviewChart({
    required this.lineColor,
    required this.guideColor,
    required this.markerColor,
  });

  final Color lineColor;
  final Color guideColor;
  final Color markerColor;

  @override
  State<_AnimatedWeightEmptyPreviewChart> createState() =>
      _AnimatedWeightEmptyPreviewChartState();
}

class _AnimatedWeightEmptyPreviewChartState
    extends State<_AnimatedWeightEmptyPreviewChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final drawProgress = Curves.easeOutCubic.transform(
          (_controller.value * 1.35).clamp(0.0, 1.0),
        );
        final pulse = 0.5 + (math.sin(_controller.value * math.pi * 2) + 1) / 4;
        return CustomPaint(
          size: const Size(double.infinity, 144),
          painter: _WeightEmptyPreviewPainter(
            lineColor: widget.lineColor,
            guideColor: widget.guideColor,
            markerColor: widget.markerColor,
            drawProgress: drawProgress,
            pulse: pulse,
          ),
        );
      },
    );
  }
}

class _WeightEmptyFeatureChip extends StatelessWidget {
  const _WeightEmptyFeatureChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _WeightEmptyPreviewPainter extends CustomPainter {
  const _WeightEmptyPreviewPainter({
    required this.lineColor,
    required this.guideColor,
    required this.markerColor,
    required this.drawProgress,
    required this.pulse,
  });

  final Color lineColor;
  final Color guideColor;
  final Color markerColor;
  final double drawProgress;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final guidePaint = Paint()
      ..color = guideColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final guidePath = Path();
    final guideYs = [
      size.height * 0.16,
      size.height * 0.42,
      size.height * 0.68,
      size.height * 0.92,
    ];
    for (final y in guideYs) {
      guidePath.moveTo(0, y);
      guidePath.lineTo(size.width, y);
    }
    canvas.drawPath(guidePath, guidePaint);

    final points = <Offset>[
      Offset(size.width * 0.05, size.height * 0.24),
      Offset(size.width * 0.24, size.height * 0.30),
      Offset(size.width * 0.44, size.height * 0.42),
      Offset(size.width * 0.64, size.height * 0.54),
      Offset(size.width * 0.84, size.height * 0.66),
      Offset(size.width * 0.96, size.height * 0.74),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final control = Offset((current.dx + next.dx) / 2, current.dy);
      final control2 = Offset((current.dx + next.dx) / 2, next.dy);
      linePath.cubicTo(
        control.dx,
        control.dy,
        control2.dx,
        control2.dy,
        next.dx,
        next.dy,
      );
    }

    final pathMetrics = linePath.computeMetrics().toList();
    final totalLength = pathMetrics.fold<double>(
      0,
      (sum, metric) => sum + metric.length,
    );
    final targetLength = totalLength * drawProgress;
    var consumedLength = 0.0;
    final animatedPath = Path();
    for (final metric in pathMetrics) {
      final remainingLength = targetLength - consumedLength;
      if (remainingLength <= 0) break;
      final extractLength = remainingLength.clamp(0.0, metric.length);
      animatedPath.addPath(metric.extractPath(0, extractLength), Offset.zero);
      consumedLength += metric.length;
    }

    final visibleEnd = _pointAlongPath(pathMetrics, targetLength) ?? points.first;
    final areaPath = Path.from(animatedPath)
      ..lineTo(visibleEnd.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();
    canvas.drawPath(
      areaPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lineColor.withValues(alpha: 0.20),
            lineColor.withValues(alpha: 0.01),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    canvas.drawPath(
      animatedPath,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    final pointFill = Paint()..color = Colors.white;
    final pointStroke = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final point in points.where((point) => point.dx <= visibleEnd.dx + 1)) {
      canvas.drawCircle(point, 4.6, pointFill);
      canvas.drawCircle(point, 4.6, pointStroke);
    }

    final milestone = points[4];
    canvas.drawCircle(
      milestone,
      7 + (3 * pulse),
      Paint()..color = markerColor.withValues(alpha: 0.20),
    );
    canvas.drawCircle(
      milestone,
      4.5,
      Paint()..color = markerColor,
    );
  }

  @override
  bool shouldRepaint(covariant _WeightEmptyPreviewPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.guideColor != guideColor ||
        oldDelegate.markerColor != markerColor ||
        oldDelegate.drawProgress != drawProgress ||
        oldDelegate.pulse != pulse;
  }
}

Offset? _pointAlongPath(List<ui.PathMetric> metrics, double distance) {
  var traversed = 0.0;
  for (final metric in metrics) {
    if (distance <= traversed + metric.length) {
      return metric.getTangentForOffset(
        (distance - traversed).clamp(0.0, metric.length),
      )?.position;
    }
    traversed += metric.length;
  }
  return metrics.isEmpty ? null : metrics.last.getTangentForOffset(metrics.last.length)?.position;
}
