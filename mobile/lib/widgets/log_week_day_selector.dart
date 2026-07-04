import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LogWeekDaySelector extends StatefulWidget {
  const LogWeekDaySelector({
    super.key,
    required this.selected,
    required this.onSelect,
    this.highlightedDates = const <DateTime>{},
  });

  final DateTime selected;
  final ValueChanged<DateTime> onSelect;
  final Set<DateTime> highlightedDates;

  @override
  State<LogWeekDaySelector> createState() => _LogWeekDaySelectorState();
}

class _LogWeekDaySelectorState extends State<LogWeekDaySelector> {
  static const _initialPage = 500;
  late final PageController _pageController;

  static DateTime get _todayDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime _weekStart(int pageOffset) {
    final today = _todayDate;
    final monday = today.subtract(Duration(days: today.weekday - 1));
    return monday.add(Duration(days: 7 * (pageOffset - _initialPage)));
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    final newWeekStart = _weekStart(page);
    final today = _todayDate;
    final equivalent =
        newWeekStart.add(Duration(days: widget.selected.weekday - 1));
    final target = equivalent.isAfter(today) ? today : equivalent;
    widget.onSelect(target);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const _ClampedPageScrollPhysics(),
        itemCount: _initialPage + 1,
        itemBuilder: (context, page) => _WeekRow(
          weekStart: _weekStart(page),
          highlightedDates: widget.highlightedDates,
          selected: widget.selected,
          onSelect: widget.onSelect,
        ),
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  const _WeekRow({
    required this.weekStart,
    required this.highlightedDates,
    required this.selected,
    required this.onSelect,
  });

  final DateTime weekStart;
  final Set<DateTime> highlightedDates;
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      children: List.generate(days.length, (i) {
        final day = days[i];
        final isSelected = day == selected;
        final isToday = day == todayDate;
        final isFuture = day.isAfter(todayDate);
        final hasEntry = highlightedDates.contains(day);

        return Expanded(
          child: GestureDetector(
            onTap: isFuture ? null : () => onSelect(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? colors.textPrimary
                    : isToday
                        ? colors.textPrimary.withValues(alpha: 0.07)
                        : Colors.transparent,
                border: hasEntry && !isSelected
                    ? Border.all(
                        color: colors.textPrimary,
                        width: 1.25,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labels[i],
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? colors.canvas
                          : isFuture
                              ? colors.textSecondary.withValues(alpha: 0.3)
                              : colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${day.day}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: isSelected
                          ? colors.canvas
                          : isFuture
                              ? colors.textSecondary.withValues(alpha: 0.3)
                              : colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ClampedPageScrollPhysics extends ScrollPhysics {
  const _ClampedPageScrollPhysics() : super(parent: const PageScrollPhysics());

  @override
  _ClampedPageScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      const _ClampedPageScrollPhysics();

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value > position.maxScrollExtent &&
        position.pixels >= position.maxScrollExtent) {
      return value - position.maxScrollExtent;
    }
    return super.applyBoundaryConditions(position, value);
  }
}
