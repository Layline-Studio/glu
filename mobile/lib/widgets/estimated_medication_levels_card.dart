import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../l10n/l10n.dart';
import '../models/medication_level_estimate.dart';
import '../theme/app_colors.dart';

class EstimatedMedicationLevelsCard extends StatelessWidget {
  static const double _cardHeight = 214;

  const EstimatedMedicationLevelsCard({
    super.key,
    required this.doseLogs,
    this.isLoading = false,
  });

  final List<Map<String, dynamic>> doseLogs;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (doseLogs.isEmpty && !isLoading) {
      return const SizedBox.shrink();
    }

    final colors = context.appColors;
    final theme = Theme.of(context);
    final chartWindow = _ChartWindow.pastThreeMonths();
    final estimate = isLoading
        ? null
        : MedicationLevelEstimate.fromDoseLogs(
            doseLogs: doseLogs,
            asOf: chartWindow.asOf,
          );
    final chartValues = isLoading
        ? const <double?>[]
        : MedicationLevelEstimate.buildDailySeries(
            doseLogs: doseLogs,
            asOf: chartWindow.asOf,
            days: chartWindow.dayCount,
          );

    return Container(
      width: double.infinity,
      height: _cardHeight,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: isLoading
          ? _LoadingState(colors: colors)
          : (estimate == null
              ? _EmptyState(colors: colors, theme: theme)
              : _FilledState(
                  estimate: estimate,
                  chartValues: chartValues,
                  chartStart: chartWindow.start,
                  colors: colors,
                  theme: theme,
                )),
    );
  }
}

class _FilledState extends StatelessWidget {
  const _FilledState({
    required this.estimate,
    required this.chartValues,
    required this.chartStart,
    required this.colors,
    required this.theme,
  });

  final MedicationLevelEstimate estimate;
  final List<double?> chartValues;
  final DateTime chartStart;
  final AppColors colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MedicationLevelHeader(
          colors: colors,
          theme: theme,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: MedicationLevelAreaChart(
            values: chartValues,
            tint: const Color(0xFF367DE8),
            start: chartStart,
            asOf: estimate.asOf,
          ),
        ),
      ],
    );
  }
}

class MedicationLevelAreaChart extends StatefulWidget {
  static const double _plotHorizontalInset = 6;
  static const double _yAxisLabelRightPadding = 4;

  const MedicationLevelAreaChart({
    super.key,
    required this.values,
    required this.tint,
    required this.start,
    required this.asOf,
  });

  final List<double?> values;
  final Color tint;
  final DateTime start;
  final DateTime asOf;

  @override
  State<MedicationLevelAreaChart> createState() =>
      _MedicationLevelAreaChartState();
}

class _MedicationLevelAreaChartState extends State<MedicationLevelAreaChart> {
  int? _selectedIndex;

  @override
  void didUpdateWidget(covariant MedicationLevelAreaChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values ||
        oldWidget.start != widget.start ||
        oldWidget.asOf != widget.asOf) {
      _selectedIndex = null;
    }
  }

  void _handleTap(Offset localPosition, double chartWidth) {
    final values = widget.values;
    if (values.isEmpty) return;
    const leftInset = MedicationLevelAreaChart._plotHorizontalInset;
    const rightInset = MedicationLevelAreaChart._plotHorizontalInset;
    final plotWidth = math.max(chartWidth - leftInset - rightInset, 0.0);
    final stepX = values.length == 1 ? 0.0 : plotWidth / (values.length - 1);

    int? nearest;
    var minDistance = double.infinity;
    for (var i = 0; i < values.length; i++) {
      if (values[i] == null) continue;
      final x = leftInset + (stepX * i);
      final distance = (localPosition.dx - x).abs();
      if (distance < minDistance) {
        minDistance = distance;
        nearest = i;
      }
    }
    if (nearest == null) return;

    if (nearest == _selectedIndex) {
      setState(() => _selectedIndex = null);
    } else {
      HapticFeedback.selectionClick();
      setState(() => _selectedIndex = nearest);
    }
  }

  @override
  Widget build(BuildContext context) {
    final values = widget.values;
    if (!values.any((value) => value != null && value > 0)) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF6FAFF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            context.l10n.progressNoTrendYet,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.appColors.textSecondary,
                ),
          ),
        ),
      );
    }

    final nonNullValues = values.whereType<double>().toList();
    final maxValue = math.max(nonNullValues.reduce(math.max), 0.1);
    final yLabels = _buildYLabels(maxValue);
    final xLabels = _buildXLabels(widget.start, widget.asOf);
    final verticalGridLines = {
      ...xLabels.map((label) => label.position),
      1.0,
    }.toList()
      ..sort();

    final yAxisLabelStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.appColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ) ??
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
    final yAxisLabelWidth = _measureYAxisLabelWidth(yLabels, yAxisLabelStyle);

    final selectedIndex = _selectedIndex;
    final selectedValue =
        selectedIndex != null && selectedIndex < values.length
            ? values[selectedIndex]
            : null;
    final selectedPrimaryLabel =
        selectedValue != null ? '${selectedValue.toStringAsFixed(1)} mg' : null;
    final selectedSecondaryLabel = selectedIndex != null
        ? DateFormat('MMM d').format(
            widget.start.add(Duration(days: selectedIndex)),
          )
        : null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: yAxisLabelWidth,
                  child: Stack(
                    children: [
                      for (final label in yLabels)
                        Align(
                          alignment: Alignment(
                              1, 1 - (label.position.clamp(0, 1) * 2)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right:
                                  MedicationLevelAreaChart._yAxisLabelRightPadding,
                            ),
                            child: Text(
                              label.label,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.visible,
                              style: yAxisLabelStyle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapUp: (details) => _handleTap(
                          details.localPosition,
                          constraints.maxWidth,
                        ),
                        child: CustomPaint(
                          painter: _MedicationLevelAreaChartPainter(
                            values: values,
                            tint: widget.tint,
                            maxValue: maxValue,
                            horizontalGridLines:
                                yLabels.map((label) => label.position).toList(),
                            verticalGridLines: verticalGridLines,
                            selectedIndex: selectedIndex,
                            selectedPrimaryLabel: selectedPrimaryLabel,
                            selectedSecondaryLabel: selectedSecondaryLabel,
                          ),
                          child: const SizedBox.expand(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 26,
            child: Padding(
              padding: EdgeInsets.only(
                left: yAxisLabelWidth +
                    MedicationLevelAreaChart._plotHorizontalInset,
                right: 2 + MedicationLevelAreaChart._plotHorizontalInset,
              ),
              child: Stack(
                children: [
                  for (final label in xLabels)
                    Align(
                      alignment: Alignment(label.position * 2 - 1, 1),
                      child: Text(
                        label.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.appColors.textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
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

  List<_ChartAxisLabel> _buildYLabels(double maxValue) {
    const steps = 5;
    final roundedMax = (maxValue * 10).ceil() / 10;
    return List<_ChartAxisLabel>.generate(steps + 1, (index) {
      final ratio = index / steps;
      final value = roundedMax * ratio;
      return _ChartAxisLabel(
        label: '${value.toStringAsFixed(1)} mg',
        position: ratio,
      );
    });
  }

  /// Widest y-axis label's rendered width, so the column is exactly as wide
  /// as the current max value needs (e.g. "0.0 mg" vs "25.1 mg") instead of
  /// a fixed guess that either wraps long labels or over-pads short ones.
  double _measureYAxisLabelWidth(
    List<_ChartAxisLabel> labels,
    TextStyle style,
  ) {
    var maxWidth = 0.0;
    for (final label in labels) {
      final painter = TextPainter(
        text: TextSpan(text: label.label, style: style),
        textDirection: ui.TextDirection.ltr,
        maxLines: 1,
      )..layout();
      maxWidth = math.max(maxWidth, painter.width);
    }
    return maxWidth + MedicationLevelAreaChart._yAxisLabelRightPadding;
  }

  List<_ChartAxisLabel> _buildXLabels(DateTime start, DateTime asOf) {
    final monthFormatter = DateFormat('MMM');
    final yearFormatter = DateFormat('yyyy');
    final totalDays = math.max(asOf.difference(start).inDays, 1);
    final labels = <_ChartAxisLabel>[];

    var monthDate = DateTime(start.year, start.month, 1);
    final finalMonth = DateTime(asOf.year, asOf.month, 1);

    while (!monthDate.isAfter(finalMonth)) {
      final offsetDays = monthDate.difference(start).inDays.clamp(0, totalDays);
      labels.add(
        _ChartAxisLabel(
          label:
              '${monthFormatter.format(monthDate)}\n${yearFormatter.format(monthDate)}',
          position: offsetDays / totalDays,
        ),
      );
      monthDate = DateTime(monthDate.year, monthDate.month + 1, 1);
    }

    return labels;
  }
}

class _MedicationLevelHeader extends StatelessWidget {
  const _MedicationLevelHeader({
    required this.colors,
    required this.theme,
  });

  final AppColors colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.homeMedicationLevelTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF20324A),
              fontWeight: FontWeight.w600,
              fontSize: 17,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showMedicationLevelInfo(context),
          icon: Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: colors.textSecondary,
          ),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints.tightFor(width: 28, height: 28),
          splashRadius: 18,
          tooltip: context.l10n.homeMedicationLevelInfoTitle,
        ),
      ],
    );
  }

  Future<void> _showMedicationLevelInfo(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.homeMedicationLevelInfoTitle),
        content: Text(context.l10n.homeMedicationLevelInfoBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.l10n.homeMedicationLevelInfoDismiss),
          ),
        ],
      ),
    );
  }
}

class _ChartWindow {
  const _ChartWindow({
    required this.start,
    required this.asOf,
  });

  final DateTime start;
  final DateTime asOf;

  int get dayCount => asOf.difference(start).inDays + 1;

  factory _ChartWindow.pastThreeMonths([DateTime? now]) {
    final asOf = (now ?? DateTime.now()).toLocal();
    return _ChartWindow(
      start: DateTime(asOf.year, asOf.month - 2, 1),
      asOf: asOf,
    );
  }
}

class _ChartAxisLabel {
  const _ChartAxisLabel({
    required this.label,
    required this.position,
  });

  final String label;
  final double position;
}

class _MedicationLevelAreaChartPainter extends CustomPainter {
  _MedicationLevelAreaChartPainter({
    required this.values,
    required this.tint,
    required this.maxValue,
    required this.horizontalGridLines,
    required this.verticalGridLines,
    this.selectedIndex,
    this.selectedPrimaryLabel,
    this.selectedSecondaryLabel,
  });

  final List<double?> values;
  final Color tint;
  final double maxValue;
  final List<double> horizontalGridLines;
  final List<double> verticalGridLines;
  final int? selectedIndex;
  final String? selectedPrimaryLabel;
  final String? selectedSecondaryLabel;

  @override
  void paint(Canvas canvas, Size size) {
    final points = <Offset>[];
    final nonNullValues = values.whereType<double>().toList();
    if (nonNullValues.isEmpty) {
      return;
    }

    final usableRange = maxValue <= 0 ? 1.0 : maxValue;
    const topInset = 8.0;
    const bottomInset = 8.0;
    const leftInset = MedicationLevelAreaChart._plotHorizontalInset;
    const rightInset = MedicationLevelAreaChart._plotHorizontalInset;
    final chartWidth = math.max(size.width - leftInset - rightInset, 0.0);
    final stepX = values.length == 1 ? 0.0 : chartWidth / (values.length - 1);

    final gridPaint = Paint()
      ..color = const Color(0xFFE7EDF5)
      ..strokeWidth = 1;
    for (final position in horizontalGridLines) {
      final y = size.height - (position.clamp(0, 1) * size.height);
      canvas.drawLine(
        Offset(leftInset, y),
        Offset(size.width - rightInset, y),
        gridPaint,
      );
    }
    for (final position in verticalGridLines) {
      final x = leftInset + (chartWidth * position.clamp(0, 1));
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      if (value == null) continue;
      final normalized = (value / usableRange).clamp(0.0, 1.0);
      final x = leftInset + (stepX * i);
      final y = size.height -
          bottomInset -
          (normalized * (size.height - topInset - bottomInset));
      points.add(Offset(x, y));
    }

    if (points.isEmpty) {
      return;
    }

    final fillPath = Path()
      ..moveTo(points.first.dx, size.height)
      ..lineTo(points.first.dx, points.first.dy);
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);

    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final controlX = (previous.dx + current.dx) / 2;
      fillPath.cubicTo(
        controlX,
        previous.dy,
        controlX,
        current.dy,
        current.dx,
        current.dy,
      );
      linePath.cubicTo(
        controlX,
        previous.dy,
        controlX,
        current.dy,
        current.dx,
        current.dy,
      );
    }

    fillPath
      ..lineTo(points.last.dx, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          tint.withValues(alpha: 0.26),
          tint.withValues(alpha: 0.04),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = tint
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(linePath, linePaint);

    canvas.drawCircle(
      points.first,
      2.2,
      Paint()..color = tint.withValues(alpha: 0.64),
    );
    canvas.drawCircle(
      points.last,
      3.4,
      Paint()..color = tint,
    );

    final selected = selectedIndex;
    if (selected != null &&
        selected >= 0 &&
        selected < values.length &&
        values[selected] != null) {
      final value = values[selected]!;
      final normalized = (value / usableRange).clamp(0.0, 1.0);
      final x = leftInset + (stepX * selected);
      final y = size.height -
          bottomInset -
          (normalized * (size.height - topInset - bottomInset));
      final anchor = Offset(x, y);

      final guidelinePaint = Paint()
        ..color = tint.withValues(alpha: 0.32)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), guidelinePaint);

      canvas.drawCircle(anchor, 6, Paint()..color = tint.withValues(alpha: 0.16));
      canvas.drawCircle(anchor, 3.6, Paint()..color = tint);
      canvas.drawCircle(anchor, 1.5, Paint()..color = Colors.white);

      if (selectedPrimaryLabel != null) {
        _drawMedicationLevelCallout(
          canvas,
          size,
          anchor: anchor,
          primaryLabel: selectedPrimaryLabel!,
          secondaryLabel: selectedSecondaryLabel,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MedicationLevelAreaChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.tint != tint ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.horizontalGridLines != horizontalGridLines ||
        oldDelegate.verticalGridLines != verticalGridLines ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.selectedPrimaryLabel != selectedPrimaryLabel ||
        oldDelegate.selectedSecondaryLabel != selectedSecondaryLabel;
  }
}

/// Draws a rounded speech-bubble callout with a tail pointing at [anchor],
/// showing the tapped point's value (bold) and date (dimmed). Placed above
/// the point when there's room, below otherwise; clamped to stay on-canvas.
void _drawMedicationLevelCallout(
  Canvas canvas,
  Size size, {
  required Offset anchor,
  required String primaryLabel,
  String? secondaryLabel,
}) {
  const backgroundColor = Color(0xFF20324A);
  const primaryTextColor = Colors.white;
  final secondaryTextColor = Colors.white.withValues(alpha: 0.72);

  final primaryPainter = TextPainter(
    text: TextSpan(
      text: primaryLabel,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
      ),
    ),
    textDirection: ui.TextDirection.ltr,
    maxLines: 1,
  )..layout();

  final secondaryPainter = secondaryLabel == null
      ? null
      : (TextPainter(
          text: TextSpan(
            text: secondaryLabel,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: secondaryTextColor,
            ),
          ),
          textDirection: ui.TextDirection.ltr,
          maxLines: 1,
        )..layout());

  const horizontalPadding = 8.0;
  const verticalPadding = 5.0;
  const gap = 1.0;
  const tailHeight = 5.0;
  const tailWidth = 8.0;
  final badgeWidth = math.max(
        primaryPainter.width,
        secondaryPainter?.width ?? 0,
      ) +
      horizontalPadding * 2;
  final badgeHeight = primaryPainter.height +
      (secondaryPainter == null ? 0 : secondaryPainter.height + gap) +
      verticalPadding * 2;

  final left = (anchor.dx - badgeWidth / 2)
      .clamp(0.0, math.max(size.width - badgeWidth, 0.0))
      .toDouble();
  const minTopMargin = 2.0;
  final preferredTopAbove = anchor.dy - badgeHeight - tailHeight - 6;
  final placeAbove = preferredTopAbove >= minTopMargin;
  final preferredTop =
      placeAbove ? preferredTopAbove : anchor.dy + tailHeight + 6;
  final top = preferredTop
      .clamp(0.0, math.max(size.height - badgeHeight, 0.0))
      .toDouble();

  final rect = RRect.fromRectAndRadius(
    Rect.fromLTWH(left, top, badgeWidth, badgeHeight),
    const Radius.circular(8),
  );
  canvas.drawRRect(rect, Paint()..color = backgroundColor);

  final tailBaseX = (anchor.dx - left)
      .clamp(8.0, math.max(badgeWidth - 8.0, 8.0))
      .toDouble();
  final badgeIsAbove = top < anchor.dy;
  final tailAnchorY = badgeIsAbove ? anchor.dy - 3 : anchor.dy + 3;
  final tailEdgeY = badgeIsAbove ? top + badgeHeight - 0.5 : top + 0.5;
  final tailPath = Path()
    ..moveTo(left + tailBaseX - tailWidth / 2, tailEdgeY)
    ..lineTo(left + tailBaseX, tailAnchorY)
    ..lineTo(left + tailBaseX + tailWidth / 2, tailEdgeY)
    ..close();
  canvas.drawPath(tailPath, Paint()..color = backgroundColor);

  primaryPainter.paint(
    canvas,
    Offset(left + horizontalPadding, top + verticalPadding),
  );
  if (secondaryPainter != null) {
    secondaryPainter.paint(
      canvas,
      Offset(
        left + horizontalPadding,
        top + verticalPadding + primaryPainter.height + gap,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.colors, required this.theme});

  final AppColors colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MedicationLevelHeader(
          colors: colors,
          theme: theme,
        ),
        const SizedBox(height: 22),
        Text(
          context.l10n.progressNoDoseLogsYet,
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.homeMedicationLevelEmptyBody,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.textSecondary,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MedicationLevelHeader(
          colors: colors,
          theme: Theme.of(context),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.softSurface,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }
}
