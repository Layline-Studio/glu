import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../progress_support.dart';
import '../../../theme/app_colors.dart';

class ProgressRangePicker extends StatelessWidget {
  const ProgressRangePicker({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.disabledIndices = const <int>{},
    this.compact = false,
    this.expand = false,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Set<int> disabledIndices;
  final bool compact;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        children: [
          for (var i = 0; i < labels.length; i++)
            (expand
                    ? Expanded(
                        child: Opacity(
                          opacity: disabledIndices.contains(i) ? 0.45 : 1,
                          child: GestureDetector(
                            onTap: disabledIndices.contains(i)
                                ? null
                                : () => onSelected(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: compact ? 8 : 12,
                                vertical: compact ? 7 : 8,
                              ),
                              decoration: BoxDecoration(
                                color: i == selectedIndex
                                    ? colors.textPrimary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                labels[i],
                                textAlign: TextAlign.center,
                                style: (compact
                                        ? theme.textTheme.labelMedium
                                        : theme.textTheme.labelLarge)
                                    ?.copyWith(
                                  color: i == selectedIndex
                                      ? colors.surface
                                      : colors.textSecondary,
                                  fontWeight: compact
                                      ? FontWeight.w500
                                      : FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Opacity(
                        opacity: disabledIndices.contains(i) ? 0.45 : 1,
                        child: GestureDetector(
                          onTap: disabledIndices.contains(i)
                              ? null
                              : () => onSelected(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            padding: EdgeInsets.symmetric(
                              horizontal: compact ? 10 : 12,
                              vertical: compact ? 7 : 8,
                            ),
                            decoration: BoxDecoration(
                              color: i == selectedIndex
                                  ? colors.textPrimary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              labels[i],
                              style: (compact
                                      ? theme.textTheme.labelMedium
                                      : theme.textTheme.labelLarge)
                                  ?.copyWith(
                                color: i == selectedIndex
                                    ? colors.surface
                                    : colors.textSecondary,
                                fontWeight: compact
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ))
                ,
        ],
      ),
    );
  }
}

class CompactModeToggle extends StatelessWidget {
  const CompactModeToggle({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < labels.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color:
                      i == selectedIndex ? colors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  labels[i],
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: i == selectedIndex
                        ? colors.textPrimary
                        : colors.textSecondary,
                    fontWeight:
                        i == selectedIndex ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.tint,
    required this.chart,
    required this.onSeeMore,
    this.value,
    this.caption,
    this.modeToggle = const SizedBox.shrink(),
    this.chartHeight = 96,
  });

  final String title;
  final String? value;
  final String? caption;
  final Color tint;
  final Widget chart;
  final VoidCallback onSeeMore;
  final Widget modeToggle;
  final double chartHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final hasSummary = value != null || caption != null;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
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
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (value != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        value!,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                    if (caption != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        caption!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onSeeMore,
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: colors.textPrimary,
                    ),
                  ),
                  if (modeToggle is! SizedBox) ...[
                    const SizedBox(height: 10),
                    modeToggle,
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: hasSummary ? 18 : 10),
          SizedBox(height: chartHeight, child: chart),
        ],
      ),
    );
  }
}

enum FrequencyGridResolution { daily, monthly }

class MiniFrequencyGridChart extends StatelessWidget {
  const MiniFrequencyGridChart({
    super.key,
    required this.dates,
    required this.values,
    required this.tint,
    required this.xAxisLabels,
    required this.emptyLabel,
    this.binary = false,
    this.resolution = FrequencyGridResolution.daily,
  });

  final List<DateTime> dates;
  final List<double> values;
  final Color tint;
  final List<ChartAxisLabel> xAxisLabels;
  final String emptyLabel;
  final bool binary;
  final FrequencyGridResolution resolution;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty || values.every((value) => value <= 0)) {
      return EmptyChartState(label: emptyLabel);
    }

    final colors = context.appColors;
    final theme = Theme.of(context);
    const xAxisHeight = 18.0;
    final weeks = resolution == FrequencyGridResolution.daily
        ? _buildWeekColumns()
        : const <List<double?>>[];

    return Column(
      children: [
        Expanded(
          child: resolution == FrequencyGridResolution.daily
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    final columnCount = weeks.length;
                    final horizontalGap = columnCount > 1 ? 1.0 : 0.0;
                    final verticalGap = 1.0;
                    final columnWidth = columnCount == 0
                        ? 0.0
                        : (constraints.maxWidth -
                                ((columnCount - 1) * horizontalGap)) /
                            columnCount;
                    final cellHeight =
                        (constraints.maxHeight - (6 * verticalGap)) / 7;
                    final cellSize = math.max(
                      4.0,
                      math.min(columnWidth, cellHeight),
                    );

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var weekIndex = 0;
                            weekIndex < weeks.length;
                            weekIndex++) ...[
                          if (weekIndex > 0) const SizedBox(width: 1),
                          SizedBox(
                            width: columnWidth,
                            child: Column(
                              children: [
                                for (var dayIndex = 0;
                                    dayIndex < 7;
                                    dayIndex++) ...[
                                  if (dayIndex > 0)
                                    const SizedBox(height: 1),
                                  Align(
                                    alignment: Alignment.center,
                                    child: _GridCell(
                                      size: cellSize,
                                      color: _cellColor(
                                        weeks[weekIndex][dayIndex],
                                        colors,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final count = values.length;
                    final horizontalGap = count > 1 ? 1.0 : 0.0;
                    final columnWidth = count == 0
                        ? 0.0
                        : (constraints.maxWidth - ((count - 1) * horizontalGap)) /
                            count;
                    final cellSize = math.max(
                      8.0,
                      math.min(columnWidth, constraints.maxHeight),
                    );

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var index = 0; index < values.length; index++) ...[
                          if (index > 0) const SizedBox(width: 1),
                          SizedBox(
                            width: columnWidth,
                            child: Align(
                              alignment: Alignment.center,
                              child: _GridCell(
                                size: cellSize,
                                color: _cellColor(values[index], colors),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
        ),
        SizedBox(
          height: xAxisHeight,
          child: Stack(
            children: [
              for (final label in xAxisLabels)
                Align(
                  alignment: Alignment(label.position * 2 - 1, 1),
                  child: Text(
                    label.label,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: label.position == 0
                        ? TextAlign.left
                        : label.position == 1
                            ? TextAlign.right
                            : TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary.withValues(alpha: 0.82),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  List<List<double?>> _buildWeekColumns() {
    if (dates.isEmpty || values.isEmpty) return const [];
    final normalizedStart = DateUtils.dateOnly(dates.first)
        .subtract(Duration(days: dates.first.weekday - 1));
    final normalizedEnd = DateUtils.dateOnly(dates.last)
        .add(Duration(days: 7 - dates.last.weekday));
    final totalDays = normalizedEnd.difference(normalizedStart).inDays + 1;
    final totalWeeks = (totalDays / 7).ceil();
    final columns = List<List<double?>>.generate(
      totalWeeks,
      (_) => List<double?>.filled(7, null),
    );
    final byDay = <DateTime, double>{};
    for (var i = 0; i < dates.length && i < values.length; i++) {
      byDay[DateUtils.dateOnly(dates[i])] = values[i];
    }

    for (var dayOffset = 0; dayOffset < totalDays; dayOffset++) {
      final day = normalizedStart.add(Duration(days: dayOffset));
      final weekIndex = dayOffset ~/ 7;
      final weekdayIndex = day.weekday - 1;
      columns[weekIndex][weekdayIndex] = byDay[day];
    }
    return columns;
  }

  Color _cellColor(double? value, AppColors colors) {
    if (value == null) {
      return Colors.transparent;
    }
    if (value <= 0) {
      return colors.canvas;
    }
    if (binary) {
      return tint.withValues(alpha: 0.9);
    }
    final maxValue = values.fold<double>(0, math.max);
    if (maxValue <= 0) {
      return colors.canvas;
    }
    final ratio = (value / maxValue).clamp(0.0, 1.0);
    if (ratio <= 0.25) return tint.withValues(alpha: 0.38);
    if (ratio <= 0.5) return tint.withValues(alpha: 0.52);
    if (ratio <= 0.75) return tint.withValues(alpha: 0.68);
    return tint.withValues(alpha: 0.78);
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          math.min(3, size * 0.18),
        ),
        border: Border.all(
          color: color == Colors.transparent ? Colors.transparent : colors.lineSubtle,
          width: color == Colors.transparent ? 0 : 0.4,
        ),
      ),
    );
  }
}

class EmptyChartState extends StatelessWidget {
  const EmptyChartState({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Center(
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class MiniLineChart extends StatelessWidget {
  const MiniLineChart({
    super.key,
    required this.values,
    required this.tint,
    this.referenceValue,
    this.xAxisLabels = const <ChartAxisLabel>[],
    this.yAxisLabels = const <ChartAxisLabel>[],
    this.minValue,
    this.maxValue,
    this.yAxisLabelFontSize,
    this.yAxisLabelScaleDown = false,
  });

  final List<double?> values;
  final Color tint;
  final double? referenceValue;
  final List<ChartAxisLabel> xAxisLabels;
  final List<ChartAxisLabel> yAxisLabels;
  final double? minValue;
  final double? maxValue;
  final double? yAxisLabelFontSize;
  final bool yAxisLabelScaleDown;

  @override
  Widget build(BuildContext context) {
    if (!values.any((value) => value != null && value > 0)) {
      return EmptyChartState(label: context.l10n.progressNoTrendYet);
    }

    final colors = context.appColors;
    final theme = Theme.of(context);
    const yAxisWidth = 34.0;
    const xAxisHeight = 18.0;
    final axisFontSize = yAxisLabelFontSize ?? theme.textTheme.labelSmall?.fontSize;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: yAxisWidth,
                child: Stack(
                  children: [
                    for (final label in yAxisLabels)
                      Align(
                        alignment: Alignment(1, 1 - (label.position.clamp(0, 1) * 2)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: FittedBox(
                            fit: yAxisLabelScaleDown ? BoxFit.scaleDown : BoxFit.none,
                            alignment: Alignment.centerRight,
                            child: Text(
                              label.label,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.visible,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.textSecondary.withValues(alpha: 0.78),
                                fontWeight: FontWeight.w400,
                                fontSize: axisFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: _LineChartPainter(
                    values: values,
                    tint: tint,
                    referenceValue: referenceValue,
                    minValue: minValue,
                    maxValue: maxValue,
                    gridLines: yAxisLabels.map((label) => label.position).toList(),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: xAxisHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: yAxisWidth),
            child: Stack(
              children: [
                for (final label in xAxisLabels)
                  Align(
                    alignment: Alignment(label.position * 2 - 1, 1),
                    child: Text(
                      label.label,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      textAlign: label.position == 0
                          ? TextAlign.left
                          : label.position == 1
                              ? TextAlign.right
                              : TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary.withValues(alpha: 0.82),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MiniBarChart extends StatelessWidget {
  const MiniBarChart({
    super.key,
    required this.values,
    required this.tint,
    this.referenceValue,
    this.xAxisLabels = const <ChartAxisLabel>[],
    this.yAxisLabels = const <ChartAxisLabel>[],
    this.minValue,
    this.maxValue,
  });

  final List<double> values;
  final Color tint;
  final double? referenceValue;
  final List<ChartAxisLabel> xAxisLabels;
  final List<ChartAxisLabel> yAxisLabels;
  final double? minValue;
  final double? maxValue;

  @override
  Widget build(BuildContext context) {
    if (values.every((value) => value == 0)) {
      return EmptyChartState(label: context.l10n.progressNoActivityYet);
    }

    final colors = context.appColors;
    final theme = Theme.of(context);
    const yAxisWidth = 34.0;
    const xAxisHeight = 18.0;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: yAxisWidth,
                child: Stack(
                  children: [
                    for (final label in yAxisLabels)
                      Align(
                        alignment: Alignment(1, 1 - (label.position.clamp(0, 1) * 2)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            label.label,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.textSecondary.withValues(alpha: 0.78),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: _BarChartPainter(
                    values: values,
                    tint: tint,
                    referenceValue: referenceValue,
                    minValue: minValue,
                    maxValue: maxValue,
                    gridLines: yAxisLabels.map((label) => label.position).toList(),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: xAxisHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: yAxisWidth),
            child: Stack(
              children: [
                for (final label in xAxisLabels)
                  Align(
                    alignment: Alignment(label.position * 2 - 1, 1),
                    child: Text(
                      label.label,
                      textAlign: label.position == 0
                          ? TextAlign.left
                          : label.position == 1
                              ? TextAlign.right
                              : TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary.withValues(alpha: 0.82),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MiniDoseLineChart extends StatefulWidget {
  const MiniDoseLineChart({
    super.key,
    required this.values,
    required this.pointColors,
    required this.legendItems,
    required this.tint,
    this.referenceValue,
    this.xAxisLabels = const <ChartAxisLabel>[],
    this.yAxisLabels = const <ChartAxisLabel>[],
    this.minValue,
    this.maxValue,
    this.highlightRangeMin,
    this.highlightRangeMax,
    this.highlightColor,
    this.highlightRangeLabel,
    this.highlightRangeLabelColor,
    this.rightRangeIndicatorLabel,
    this.showForecasting = false,
    this.pinnedPointIndices = const <int>[],
    this.pointPrimaryLabels,
    this.pointSecondaryLabels,
    this.badgeBackgroundColor,
    this.badgePrimaryTextColor,
    this.badgeSecondaryTextColor,
    this.yAxisWidth = 34,
    this.rightAxisWidth = 34,
    this.yAxisLabelFontSize,
    this.yAxisLabelScaleDown = false,
  });

  final List<double?> values;
  final List<Color?> pointColors;
  final List<DoseLegendItem> legendItems;
  final Color tint;
  final double? referenceValue;
  final List<ChartAxisLabel> xAxisLabels;
  final List<ChartAxisLabel> yAxisLabels;
  final double? minValue;
  final double? maxValue;
  final double? highlightRangeMin;
  final double? highlightRangeMax;
  final Color? highlightColor;
  final String? highlightRangeLabel;
  final Color? highlightRangeLabelColor;
  final String? rightRangeIndicatorLabel;
  final bool showForecasting;
  final List<int> pinnedPointIndices;
  final List<String?>? pointPrimaryLabels;
  final List<String?>? pointSecondaryLabels;
  final Color? badgeBackgroundColor;
  final Color? badgePrimaryTextColor;
  final Color? badgeSecondaryTextColor;
  final double yAxisWidth;
  final double rightAxisWidth;
  final double? yAxisLabelFontSize;
  final bool yAxisLabelScaleDown;

  @override
  State<MiniDoseLineChart> createState() => _MiniDoseLineChartState();
}

class _MiniDoseLineChartState extends State<MiniDoseLineChart>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;
  late final AnimationController _controller;
  late final Animation<double> _progress;
  bool _tickerWasEnabled = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _lastNonNullIndex(widget.values);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tickerEnabled = TickerMode.valuesOf(context).enabled;
    if (tickerEnabled && !_tickerWasEnabled) {
      _controller.forward(from: 0);
    }
    _tickerWasEnabled = tickerEnabled;
  }

  @override
  void didUpdateWidget(MiniDoseLineChart old) {
    super.didUpdateWidget(old);
    if (old.values != widget.values) {
      _selectedIndex = _lastNonNullIndex(widget.values);
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int? _lastNonNullIndex(List<double?> values) {
    for (var i = values.length - 1; i >= 0; i--) {
      if (values[i] != null) return i;
    }
    return null;
  }

  void _handleTap(Offset localPosition, double chartWidth) {
    final n = widget.values.length;
    if (n == 0) return;
    final stepX = n == 1 ? 0.0 : chartWidth / (n - 1);
    int? nearest;
    var minDist = double.infinity;
    for (var i = 0; i < n; i++) {
      if (widget.values[i] == null) continue;
      final x = stepX * i;
      final dist = (localPosition.dx - x).abs();
      if (dist < minDist) {
        minDist = dist;
        nearest = i;
      }
    }
    if (nearest != null) setState(() => _selectedIndex = nearest);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.values.any((value) => value != null && value > 0)) {
      return EmptyChartState(label: context.l10n.progressNoTrendYet);
    }

    final colors = context.appColors;
    final theme = Theme.of(context);
    const xAxisHeight = 18.0;
    const forecastDays = 30;
    final axisFontSize =
        widget.yAxisLabelFontSize ?? theme.textTheme.labelSmall?.fontSize;
    final forecastFraction = widget.showForecasting
        ? widget.values.length / (widget.values.length + forecastDays)
        : 1.0;
    final hasHighlightRange = widget.highlightRangeMin != null &&
        widget.highlightRangeMax != null;
    final showRightIndicator =
        widget.rightRangeIndicatorLabel != null && hasHighlightRange;
    final normalizedRange = hasHighlightRange
        ? _normalizeRange(
            min: widget.minValue ?? 0,
            max: widget.maxValue ?? 1,
            rangeMin: widget.highlightRangeMin!,
            rangeMax: widget.highlightRangeMax!,
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: widget.yAxisWidth,
                child: Stack(
                  children: [
                    for (final label in widget.yAxisLabels)
                      Align(
                        alignment:
                            Alignment(1, 1 - (label.position.clamp(0, 1) * 2)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: FittedBox(
                            fit: widget.yAxisLabelScaleDown ? BoxFit.scaleDown : BoxFit.none,
                            alignment: Alignment.centerRight,
                            child: Text(
                              label.label,
                              textAlign: TextAlign.right,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.textSecondary.withValues(alpha: 0.78),
                                fontWeight: FontWeight.w400,
                                fontSize: axisFontSize,
                              ),
                            ),
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
                      child: AnimatedBuilder(
                        animation: _progress,
                        builder: (context, _) => CustomPaint(
                          painter: _DoseLineChartPainter(
                            values: widget.values,
                            pointColors: widget.pointColors,
                            tint: widget.tint,
                            referenceValue: widget.referenceValue,
                            minValue: widget.minValue,
                            maxValue: widget.maxValue,
                            gridLines: widget.yAxisLabels
                                .map((label) => label.position)
                                .toList(),
                            highlightRangeMin: widget.highlightRangeMin,
                            highlightRangeMax: widget.highlightRangeMax,
                            highlightColor: widget.highlightColor,
                            highlightRangeLabel: widget.highlightRangeLabel,
                            highlightRangeLabelColor:
                                widget.highlightRangeLabelColor,
                            showForecasting: widget.showForecasting,
                            forecastFraction: forecastFraction,
                            drawProgress: _progress.value,
                            selectedPointIndex: _selectedIndex,
                            pinnedPointIndices: widget.pinnedPointIndices,
                            pointPrimaryLabels: widget.pointPrimaryLabels,
                            pointSecondaryLabels: widget.pointSecondaryLabels,
                            badgeBackgroundColor:
                                widget.badgeBackgroundColor ?? colors.surface,
                            badgePrimaryTextColor:
                                widget.badgePrimaryTextColor ?? colors.textPrimary,
                            badgeSecondaryTextColor:
                                widget.badgeSecondaryTextColor ??
                                    colors.textSecondary,
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (showRightIndicator && normalizedRange != null)
                SizedBox(
                  width: widget.rightAxisWidth,
                  child: _ChartRangeIndicator(
                    label: widget.rightRangeIndicatorLabel!,
                    color: widget.highlightColor ?? widget.tint.withValues(alpha: 0.14),
                    start: normalizedRange.$1,
                    end: normalizedRange.$2,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: xAxisHeight,
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.yAxisWidth,
              right: showRightIndicator ? widget.rightAxisWidth : 0,
            ),
            child: Stack(
              children: [
                for (final label in widget.xAxisLabels)
                  Builder(
                    builder: (context) {
                      final adjustedPosition = (label.position * forecastFraction)
                          .clamp(0.0, 1.0);
                      return Align(
                        alignment: Alignment(adjustedPosition * 2 - 1, 1),
                        child: Text(
                          label.label,
                          textAlign: adjustedPosition == 0
                              ? TextAlign.left
                              : adjustedPosition == 1
                                  ? TextAlign.right
                                  : TextAlign.center,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.textSecondary.withValues(alpha: 0.82),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        if (widget.legendItems.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: widget.yAxisWidth),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                for (final item in widget.legendItems)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: item.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.textSecondary.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ChartRangeIndicator extends StatelessWidget {
  const _ChartRangeIndicator({
    required this.label,
    required this.color,
    required this.start,
    required this.end,
  });

  final String label;
  final Color color;
  final double start;
  final double end;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final top = (1 - end.clamp(0.0, 1.0)) * height;
        final bottom = (1 - start.clamp(0.0, 1.0)) * height;
        final rangeHeight = (bottom - top).clamp(8.0, height);
        final labelHeight = 24.0;
        final labelTop =
            ((top + bottom) / 2 - (labelHeight / 2)).clamp(0.0, height - labelHeight);

        return Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 16,
              child: Container(
                width: 1.5,
                color: colors.lineSubtle,
              ),
            ),
            Positioned(
              top: top,
              left: 14,
              child: Container(
                width: 5,
                height: rangeHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Positioned(
              left: 2,
              top: labelTop,
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: colors.lineSubtle),
                  ),
                  child: Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

(double, double) _normalizeRange({
  required double min,
  required double max,
  required double rangeMin,
  required double rangeMax,
}) {
  final usableRange = (max - min).abs() < 0.0001 ? 1.0 : (max - min);
  final start = ((rangeMin - min) / usableRange).clamp(0.0, 1.0);
  final end = ((rangeMax - min) / usableRange).clamp(0.0, 1.0);
  return (math.min(start, end), math.max(start, end));
}

class MiniSeverityChart extends StatelessWidget {
  const MiniSeverityChart({
    super.key,
    required this.values,
    required this.tint,
    this.xAxisLabels = const <ChartAxisLabel>[],
    this.yAxisLabels = const <ChartAxisLabel>[],
  });

  final List<double> values;
  final Color tint;
  final List<ChartAxisLabel> xAxisLabels;
  final List<ChartAxisLabel> yAxisLabels;

  @override
  Widget build(BuildContext context) {
    if (values.every((value) => value == 0)) {
      return EmptyChartState(label: context.l10n.progressNoCheckInsYet);
    }

    final colors = context.appColors;
    final theme = Theme.of(context);
    const yAxisWidth = 34.0;
    const xAxisHeight = 18.0;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: yAxisWidth,
                child: Stack(
                  children: [
                    for (final label in yAxisLabels)
                      Align(
                        alignment: Alignment(1, 1 - (label.position.clamp(0, 1) * 2)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            label.label,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.textSecondary.withValues(alpha: 0.78),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: _SeverityPainter(values: values, tint: tint),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: xAxisHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: yAxisWidth),
            child: Stack(
              children: [
                for (final label in xAxisLabels)
                  Align(
                    alignment: Alignment(label.position * 2 - 1, 1),
                    child: Text(
                      label.label,
                      textAlign: label.position == 0
                          ? TextAlign.left
                          : label.position == 1
                              ? TextAlign.right
                              : TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary.withValues(alpha: 0.82),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.values,
    required this.tint,
    this.referenceValue,
    this.minValue,
    this.maxValue,
    this.gridLines = const <double>[],
  });

  final List<double?> values;
  final Color tint;
  final double? referenceValue;
  final double? minValue;
  final double? maxValue;
  final List<double> gridLines;

  @override
  void paint(Canvas canvas, Size size) {
    final nonNullValues = values.whereType<double>().toList();
    if (nonNullValues.isEmpty) {
      return;
    }
    final resolvedMin = minValue ?? math.min(0, nonNullValues.reduce(math.min));
    final resolvedMax =
        maxValue ?? math.max(nonNullValues.reduce(math.max), referenceValue ?? 0);
    final usableRange =
        (resolvedMax - resolvedMin).abs() < 0.0001 ? 1.0 : (resolvedMax - resolvedMin);
    final points = <Offset>[];
    final stepX = values.length == 1 ? 0.0 : size.width / (values.length - 1);
    final linePath = Path();

    final gridPaint = Paint()
      ..color = tint.withValues(alpha: 0.10)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (final position in gridLines) {
      final y = size.height - (position.clamp(0, 1) * size.height);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      if (value == null) {
        continue;
      }
      final x = stepX * i;
      final normalized = ((value - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final y = size.height - (normalized * (size.height - 10)) - 5;
      final point = Offset(x, y);
      points.add(point);
    }

    if (points.isEmpty) {
      return;
    }

    linePath.moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final controlX = (previous.dx + current.dx) / 2;
      linePath.cubicTo(
        controlX,
        previous.dy,
        controlX,
        current.dy,
        current.dx,
        current.dy,
      );
    }

    final fillPath = Path()
      ..moveTo(points.first.dx, size.height)
      ..lineTo(points.first.dx, points.first.dy);
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
    }
    fillPath
      ..lineTo(points.last.dx, size.height)
      ..close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          tint.withValues(alpha: 0.22),
          tint.withValues(alpha: 0.02),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, areaPaint);

    if (referenceValue != null && referenceValue! > 0) {
      final refNormalized =
          ((referenceValue! - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final refY = size.height - (refNormalized * (size.height - 10)) - 5;
      final referencePaint = Paint()
        ..color = tint.withValues(alpha: 0.28)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      _drawDashedLine(
          canvas, Offset(0, refY), Offset(size.width, refY), referencePaint);
    }

    final linePaint = Paint()
      ..color = tint
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()..color = tint;
    for (final point in points) {
      canvas.drawCircle(point, 2.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.tint != tint ||
        oldDelegate.referenceValue != referenceValue ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.gridLines != gridLines;
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({
    required this.values,
    required this.tint,
    this.referenceValue,
    this.minValue,
    this.maxValue,
    this.gridLines = const <double>[],
  });

  final List<double> values;
  final Color tint;
  final double? referenceValue;
  final double? minValue;
  final double? maxValue;
  final List<double> gridLines;

  @override
  void paint(Canvas canvas, Size size) {
    final resolvedMin = minValue ?? 0;
    final resolvedMax = maxValue ?? math.max(values.reduce(math.max), referenceValue ?? 0);
    final usableRange =
        (resolvedMax - resolvedMin).abs() < 0.0001 ? 1.0 : (resolvedMax - resolvedMin);
    final gap = 6.0;
    final barWidth = (size.width - gap * (values.length - 1)) / values.length;

    final gridPaint = Paint()
      ..color = tint.withValues(alpha: 0.10)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (final position in gridLines) {
      final y = size.height - (position.clamp(0, 1) * size.height);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    if (referenceValue != null && referenceValue! > 0) {
      final refNormalized =
          ((referenceValue! - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final refY = size.height - (refNormalized * (size.height - 10)) - 5;
      final referencePaint = Paint()
        ..color = tint.withValues(alpha: 0.22)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      _drawDashedLine(
          canvas, Offset(0, refY), Offset(size.width, refY), referencePaint);
    }

    final basePaint = Paint()..color = tint.withValues(alpha: 0.12);
    final fillPaint = Paint()..color = tint;
    for (var i = 0; i < values.length; i++) {
      final left = i * (barWidth + gap);
      final normalized = ((values[i] - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final height = normalized * (size.height - 10);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, size.height - height, barWidth, height),
        const Radius.circular(8),
      );
      final baseRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, 0, barWidth, size.height),
        const Radius.circular(8),
      );
      canvas.drawRRect(baseRect, basePaint);
      canvas.drawRRect(rect, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.tint != tint ||
        oldDelegate.referenceValue != referenceValue ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.gridLines != gridLines;
  }
}

class _SeverityPainter extends CustomPainter {
  _SeverityPainter({
    required this.values,
    required this.tint,
  });

  final List<double> values;
  final Color tint;

  @override
  void paint(Canvas canvas, Size size) {
    final gap = 6.0;
    final width = (size.width - gap * (values.length - 1)) / values.length;
    for (var i = 0; i < values.length; i++) {
      final left = i * (width + gap);
      final alpha =
          (0.12 + (values[i].clamp(0, 3) / 3) * 0.72).clamp(0.12, 0.84);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, 0, width, size.height),
        const Radius.circular(8),
      );
      canvas.drawRRect(
        rect,
        Paint()..color = tint.withValues(alpha: alpha),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SeverityPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.tint != tint;
  }
}

class _DoseLineChartPainter extends CustomPainter {
  _DoseLineChartPainter({
    required this.values,
    required this.pointColors,
    required this.tint,
    this.referenceValue,
    this.minValue,
    this.maxValue,
    this.gridLines = const <double>[],
    this.highlightRangeMin,
    this.highlightRangeMax,
    this.highlightColor,
    this.highlightRangeLabel,
    this.highlightRangeLabelColor,
    this.showForecasting = false,
    this.forecastFraction = 1.0,
    this.drawProgress = 1.0,
    this.selectedPointIndex,
    this.pinnedPointIndices = const <int>[],
    this.pointPrimaryLabels,
    this.pointSecondaryLabels,
    required this.badgeBackgroundColor,
    required this.badgePrimaryTextColor,
    required this.badgeSecondaryTextColor,
  });

  final List<double?> values;
  final List<Color?> pointColors;
  final Color tint;
  final double? referenceValue;
  final double? minValue;
  final double? maxValue;
  final List<double> gridLines;
  final double? highlightRangeMin;
  final double? highlightRangeMax;
  final Color? highlightColor;
  final String? highlightRangeLabel;
  final Color? highlightRangeLabelColor;
  final bool showForecasting;
  final double forecastFraction;
  final double drawProgress;
  final int? selectedPointIndex;
  final List<int> pinnedPointIndices;
  final List<String?>? pointPrimaryLabels;
  final List<String?>? pointSecondaryLabels;
  final Color badgeBackgroundColor;
  final Color badgePrimaryTextColor;
  final Color badgeSecondaryTextColor;

  @override
  void paint(Canvas canvas, Size size) {
    final nonNullValues = values.whereType<double>().toList();
    if (nonNullValues.isEmpty) {
      return;
    }

    final resolvedMin = minValue ?? math.min(0, nonNullValues.reduce(math.min));
    final resolvedMax =
        maxValue ?? math.max(nonNullValues.reduce(math.max), referenceValue ?? 0);
    final usableRange =
        (resolvedMax - resolvedMin).abs() < 0.0001 ? 1.0 : (resolvedMax - resolvedMin);
    final plotWidth = size.width * forecastFraction.clamp(0.0, 1.0);
    final stepX = values.length == 1 ? 0.0 : plotWidth / (values.length - 1);
    final points = <_DosePoint>[];

    final gridPaint = Paint()
      ..color = tint.withValues(alpha: 0.10)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    if (highlightRangeMin != null &&
        highlightRangeMax != null &&
        highlightColor != null) {
      final clampedMin =
          ((highlightRangeMin! - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final clampedMax =
          ((highlightRangeMax! - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final top = size.height - (math.max(clampedMin, clampedMax) * size.height);
      final bottom =
          size.height - (math.min(clampedMin, clampedMax) * size.height);
      final rect = Rect.fromLTRB(0, top, size.width, bottom);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        Paint()..color = highlightColor!,
      );

      if (highlightRangeLabel != null && highlightRangeLabel!.isNotEmpty) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: highlightRangeLabel!,
            style: TextStyle(
              color: highlightRangeLabelColor ?? tint,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          textDirection: TextDirection.ltr,
          maxLines: 1,
          ellipsis: '...',
        )..layout(maxWidth: math.max(0, size.width - 24));

        final textOffset = Offset(
          ((size.width - textPainter.width) / 2).clamp(12.0, size.width - textPainter.width - 12),
          ((top + bottom - textPainter.height) / 2).clamp(4.0, size.height - textPainter.height - 4),
        );
        textPainter.paint(canvas, textOffset);
      }
    }

    for (final position in gridLines) {
      final y = size.height - (position.clamp(0, 1) * size.height);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    if (showForecasting && forecastFraction < 1.0) {
      canvas.drawRect(
        Rect.fromLTWH(plotWidth, 0, size.width - plotWidth, size.height),
        Paint()..color = tint.withValues(alpha: 0.03),
      );
    }

    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      if (value == null) continue;
      final normalized = ((value - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final point = Offset(
        stepX * i,
        size.height - (normalized * (size.height - 10)) - 5,
      );
      final color = i < pointColors.length && pointColors[i] != null
          ? pointColors[i]!
          : tint;
      points.add(_DosePoint(offset: point, color: color, valuesIndex: i));
    }

    if (points.isEmpty) {
      return;
    }

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width * drawProgress, size.height));

    if (points.length >= 2) {
      final fillPath = Path()
        ..moveTo(points.first.offset.dx, size.height)
        ..lineTo(points.first.offset.dx, points.first.offset.dy);
      for (var i = 1; i < points.length; i++) {
        final previous = points[i - 1].offset;
        final current = points[i].offset;
        final controlX = (previous.dx + current.dx) / 2;
        fillPath.cubicTo(
          controlX,
          previous.dy,
          controlX,
          current.dy,
          current.dx,
          current.dy,
        );
      }
      fillPath
        ..lineTo(points.last.offset.dx, size.height)
        ..close();

      final areaPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            tint.withValues(alpha: 0.14),
            tint.withValues(alpha: 0.02),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Offset.zero & size);
      canvas.drawPath(fillPath, areaPaint);
    }

    if (referenceValue != null && referenceValue! > 0) {
      final refNormalized =
          ((referenceValue! - resolvedMin) / usableRange).clamp(0.0, 1.0);
      final refY = size.height - (refNormalized * (size.height - 10)) - 5;
      final referencePaint = Paint()
        ..color = tint.withValues(alpha: 0.28)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      _drawDashedLine(
        canvas,
        Offset(0, refY),
        Offset(size.width, refY),
        referencePaint,
      );
    }

    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final segmentPath = Path()..moveTo(previous.offset.dx, previous.offset.dy);
      final controlX = (previous.offset.dx + current.offset.dx) / 2;
      segmentPath.cubicTo(
        controlX,
        previous.offset.dy,
        controlX,
        current.offset.dy,
        current.offset.dx,
        current.offset.dy,
      );
      final segmentPaint = Paint()
        ..color = current.color
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      canvas.drawPath(segmentPath, segmentPaint);
    }

    for (final point in points) {
      final dotPaint = Paint()..color = point.color;
      canvas.drawCircle(point.offset, 3.25, dotPaint);
      canvas.drawCircle(
        point.offset,
        1.2,
        Paint()..color = Colors.white.withValues(alpha: 0.95),
      );
    }

    final calloutIndices = <int>[
      ...pinnedPointIndices,
      if (selectedPointIndex != null &&
          !pinnedPointIndices.contains(selectedPointIndex)) selectedPointIndex!,
    ];
    if (pointPrimaryLabels != null && points.isNotEmpty && calloutIndices.isNotEmpty) {
      for (var i = 0; i < calloutIndices.length; i++) {
        final calloutIndex = calloutIndices[i];
        final selected = points.where((p) => p.valuesIndex == calloutIndex).firstOrNull;
        final primaryLabel = calloutIndex < pointPrimaryLabels!.length
            ? pointPrimaryLabels![calloutIndex]
            : null;
        if (selected == null || primaryLabel == null) continue;
        final secondaryLabel =
            (pointSecondaryLabels != null && calloutIndex < pointSecondaryLabels!.length)
                ? pointSecondaryLabels![calloutIndex]
                : null;
        _drawLastPointBadge(
          canvas,
          size,
          anchor: selected.offset,
          primaryLabel: primaryLabel,
          secondaryLabel: secondaryLabel,
          backgroundColor: badgeBackgroundColor,
          primaryTextColor: badgePrimaryTextColor,
          secondaryTextColor: badgeSecondaryTextColor,
          placeAbove: i.isEven,
        );
      }
    }

    if (showForecasting) {
      final forecastPoint = _forecastPoint(
        values: values,
        size: size,
        resolvedMin: resolvedMin,
        usableRange: usableRange,
        forecastFraction: forecastFraction,
      );
      if (forecastPoint != null) {
        final forecastPaint = Paint()
          ..color = tint.withValues(alpha: 0.55)
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        _drawDashedLine(
          canvas,
          points.last.offset,
          forecastPoint,
          forecastPaint,
        );
        canvas.drawCircle(
          forecastPoint,
          3.4,
          Paint()..color = tint.withValues(alpha: 0.75),
        );
        canvas.drawCircle(
          forecastPoint,
          1.2,
          Paint()..color = Colors.white.withValues(alpha: 0.9),
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DoseLineChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.pointColors != pointColors ||
        oldDelegate.tint != tint ||
        oldDelegate.referenceValue != referenceValue ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.gridLines != gridLines ||
        oldDelegate.highlightRangeMin != highlightRangeMin ||
        oldDelegate.highlightRangeMax != highlightRangeMax ||
        oldDelegate.highlightColor != highlightColor ||
        oldDelegate.highlightRangeLabel != highlightRangeLabel ||
        oldDelegate.highlightRangeLabelColor != highlightRangeLabelColor ||
        oldDelegate.showForecasting != showForecasting ||
        oldDelegate.forecastFraction != forecastFraction ||
        oldDelegate.drawProgress != drawProgress ||
        oldDelegate.selectedPointIndex != selectedPointIndex ||
        oldDelegate.pinnedPointIndices != pinnedPointIndices ||
        oldDelegate.pointPrimaryLabels != pointPrimaryLabels ||
        oldDelegate.pointSecondaryLabels != pointSecondaryLabels ||
        oldDelegate.badgeBackgroundColor != badgeBackgroundColor ||
        oldDelegate.badgePrimaryTextColor != badgePrimaryTextColor ||
        oldDelegate.badgeSecondaryTextColor != badgeSecondaryTextColor;
  }
}

Offset? _forecastPoint({
  required List<double?> values,
  required Size size,
  required double resolvedMin,
  required double usableRange,
  required double forecastFraction,
}) {
  final indexedValues = <(int, double)>[];
  for (var i = 0; i < values.length; i++) {
    final value = values[i];
    if (value != null) {
      indexedValues.add((i, value));
    }
  }
  if (indexedValues.length < 2) return null;

  final recent = indexedValues.length <= 4
      ? indexedValues
      : indexedValues.sublist(indexedValues.length - 4);
  final first = recent.first;
  final last = recent.last;
  final indexSpan = (last.$1 - first.$1).abs();
  if (indexSpan == 0) return null;

  final slopePerStep = (last.$2 - first.$2) / indexSpan;
  final forecastSteps = math.max(
    1,
    (values.length * ((1 - forecastFraction) / forecastFraction)).round(),
  );
  final forecastValue = last.$2 + (slopePerStep * forecastSteps);
  final normalized =
      ((forecastValue - resolvedMin) / usableRange).clamp(0.0, 1.0);
  final forecastY = size.height - (normalized * (size.height - 10)) - 5;
  return Offset(size.width, forecastY.clamp(5.0, size.height - 5));
}

class _DosePoint {
  const _DosePoint({
    required this.offset,
    required this.color,
    required this.valuesIndex,
  });

  final Offset offset;
  final Color color;
  final int valuesIndex;
}

void _drawDashedLine(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint,
) {
  const dash = 6.0;
  const gap = 5.0;
  final delta = end - start;
  final distance = delta.distance;
  if (distance <= 0) return;
  final direction = Offset(delta.dx / distance, delta.dy / distance);

  var progress = 0.0;
  while (progress < distance) {
    final next = math.min(progress + dash, distance);
    final segmentStart = Offset(
      start.dx + (direction.dx * progress),
      start.dy + (direction.dy * progress),
    );
    final segmentEnd = Offset(
      start.dx + (direction.dx * next),
      start.dy + (direction.dy * next),
    );
    canvas.drawLine(segmentStart, segmentEnd, paint);
    progress = next + gap;
  }
}

void _drawLastPointBadge(
  Canvas canvas,
  Size size, {
  required Offset anchor,
  required String primaryLabel,
  required String? secondaryLabel,
  required Color backgroundColor,
  required Color primaryTextColor,
  required Color secondaryTextColor,
  bool placeAbove = false,
}) {
  final primaryPainter = TextPainter(
    text: TextSpan(
      text: primaryLabel,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ).copyWith(color: primaryTextColor),
    ),
    textDirection: TextDirection.ltr,
    maxLines: 1,
  )..layout();

  final secondaryPainter = secondaryLabel == null
      ? null
      : (TextPainter(
          text: TextSpan(
          text: secondaryLabel,
          style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
            ).copyWith(color: secondaryTextColor),
          ),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        )..layout());

  const horizontalPadding = 6.0;
  const verticalPadding = 4.0;
  const gap = 1.0;
  const tailHeight = 5.0;
  const tailWidth = 7.0;
  final badgeWidth = math.max(
        primaryPainter.width,
        secondaryPainter?.width ?? 0,
      ) +
      horizontalPadding * 2;
  final badgeHeight = primaryPainter.height +
      (secondaryPainter == null ? 0 : secondaryPainter.height + gap) +
      verticalPadding * 2;

  final left = (anchor.dx - badgeWidth / 2).clamp(0.0, size.width - badgeWidth);
  final preferredTop = placeAbove
      ? anchor.dy - badgeHeight - tailHeight - 6
      : anchor.dy + tailHeight + 4;
  final top = preferredTop.clamp(0.0, size.height - badgeHeight);
  final rect = RRect.fromRectAndRadius(
    Rect.fromLTWH(left, top, badgeWidth, badgeHeight),
    const Radius.circular(8),
  );

  canvas.drawRRect(
    rect,
    Paint()..color = backgroundColor,
  );

  final tailBaseX = (anchor.dx - left).clamp(8.0, badgeWidth - 8.0);
  final badgeIsAbove = top < anchor.dy;
  final tailAnchorY = badgeIsAbove ? anchor.dy - 4 : anchor.dy + 4;
  final tailEdgeY = badgeIsAbove ? top + badgeHeight - 0.5 : top + 0.5;
  final tailPath = Path()
    ..moveTo(left + tailBaseX - (tailWidth / 2), tailEdgeY)
    ..lineTo(left + tailBaseX, tailAnchorY)
    ..lineTo(left + tailBaseX + (tailWidth / 2), tailEdgeY)
    ..close();
  canvas.drawPath(
    tailPath,
    Paint()..color = backgroundColor,
  );

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
