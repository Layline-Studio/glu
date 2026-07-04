import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../theme/app_colors.dart';

class ProgressWeightEmptyState extends StatelessWidget {
  const ProgressWeightEmptyState({super.key, required this.onLogWeight});

  final VoidCallback onLogWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F8DBA).withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              decoration: BoxDecoration(
                color: colors.canvas,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colors.lineSubtle,
                ),
              ),
              child: const _ProgressWeightEmptyChartPreview(),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.softSurface,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              context.l10n.progressWeightSignatureChip,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.progressWeightStartTrendTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.progressWeightStartTrendBody,
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
              _ProgressWeightEmptyChip(label: context.l10n.progressWeightMomentum),
              _ProgressWeightEmptyChip(label: context.l10n.progressWeightMilestones),
              _ProgressWeightEmptyChip(label: context.l10n.progressWeightShareReady),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onLogWeight,
              icon: const Icon(Icons.add_rounded),
              label: Text(context.l10n.progressWeightLogWeight),
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
    );
  }
}

class _ProgressWeightEmptyChartPreview extends StatelessWidget {
  const _ProgressWeightEmptyChartPreview();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF6F8DBA).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.show_chart_rounded,
                color: Color(0xFF6F8DBA),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your future trend',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'A cleaner view of real momentum over time',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 136),
            child: _AnimatedProgressWeightPreviewChart(
              lineColor: const Color(0xFF6F8DBA),
              guideColor: colors.textSecondary.withValues(alpha: 0.13),
              accentColor: const Color(0xFFFFAA5B),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedProgressWeightPreviewChart extends StatefulWidget {
  const _AnimatedProgressWeightPreviewChart({
    required this.lineColor,
    required this.guideColor,
    required this.accentColor,
  });

  final Color lineColor;
  final Color guideColor;
  final Color accentColor;

  @override
  State<_AnimatedProgressWeightPreviewChart> createState() =>
      _AnimatedProgressWeightPreviewChartState();
}

class _AnimatedProgressWeightPreviewChartState
    extends State<_AnimatedProgressWeightPreviewChart>
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
          size: const Size(double.infinity, 136),
          painter: _ProgressWeightPreviewPainter(
            lineColor: widget.lineColor,
            guideColor: widget.guideColor,
            accentColor: widget.accentColor,
            drawProgress: drawProgress,
            pulse: pulse,
          ),
        );
      },
    );
  }
}

class _ProgressWeightEmptyChip extends StatelessWidget {
  const _ProgressWeightEmptyChip({required this.label});

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

class _ProgressWeightPreviewPainter extends CustomPainter {
  const _ProgressWeightPreviewPainter({
    required this.lineColor,
    required this.guideColor,
    required this.accentColor,
    required this.drawProgress,
    required this.pulse,
  });

  final Color lineColor;
  final Color guideColor;
  final Color accentColor;
  final double drawProgress;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final guidePaint = Paint()
      ..color = guideColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final ratio in [0.15, 0.4, 0.65, 0.9]) {
      canvas.drawLine(
        Offset(0, size.height * ratio),
        Offset(size.width, size.height * ratio),
        guidePaint,
      );
    }

    final points = <Offset>[
      Offset(size.width * 0.04, size.height * 0.22),
      Offset(size.width * 0.18, size.height * 0.30),
      Offset(size.width * 0.34, size.height * 0.40),
      Offset(size.width * 0.52, size.height * 0.50),
      Offset(size.width * 0.72, size.height * 0.62),
      Offset(size.width * 0.94, size.height * 0.74),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final control1 = Offset((current.dx + next.dx) / 2, current.dy);
      final control2 = Offset((current.dx + next.dx) / 2, next.dy);
      linePath.cubicTo(
        control1.dx,
        control1.dy,
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

    final visibleEnd =
        _progressPointAlongPath(pathMetrics, targetLength) ?? points.first;
    final fillPath = Path.from(animatedPath)
      ..lineTo(visibleEnd.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lineColor.withValues(alpha: 0.20),
            lineColor.withValues(alpha: 0.02),
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

    for (final point in points.where((point) => point.dx <= visibleEnd.dx + 1)) {
      canvas.drawCircle(point, 4.2, Paint()..color = Colors.white);
      canvas.drawCircle(
        point,
        4.2,
        Paint()
          ..color = lineColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }

    final accentPoint = points[3];
    canvas.drawCircle(
      accentPoint,
      7 + (3 * pulse),
      Paint()..color = accentColor.withValues(alpha: 0.2),
    );
    canvas.drawCircle(
      accentPoint,
      4.5,
      Paint()..color = accentColor,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressWeightPreviewPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.guideColor != guideColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.drawProgress != drawProgress ||
        oldDelegate.pulse != pulse;
  }
}

Offset? _progressPointAlongPath(List<ui.PathMetric> metrics, double distance) {
  var traversed = 0.0;
  for (final metric in metrics) {
    if (distance <= traversed + metric.length) {
      return metric.getTangentForOffset(
        (distance - traversed).clamp(0.0, metric.length),
      )?.position;
    }
    traversed += metric.length;
  }
  return metrics.isEmpty
      ? null
      : metrics.last.getTangentForOffset(metrics.last.length)?.position;
}
