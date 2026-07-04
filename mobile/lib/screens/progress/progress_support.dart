import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/medication_catalog.dart';
import '../../l10n/l10n.dart';

enum ProgressRange {
  sevenDays('7D', 7),
  thirtyDays('30D', 30),
  ninetyDays('3M', 90),
  sixMonths('6M', 180),
  oneYear('1Y', 365),
  allTime('All time', 10000);

  const ProgressRange(this.label, this.days);

  final String label;
  final int days;
}

class ChartAxisLabel {
  const ChartAxisLabel({
    required this.position,
    required this.label,
  });

  final double position;
  final String label;
}

class ChartScale {
  const ChartScale({
    required this.min,
    required this.max,
    required this.labels,
  });

  final double min;
  final double max;
  final List<ChartAxisLabel> labels;
}

String progressRangeLabel(AppLocalizations l10n, ProgressRange range) {
  return switch (range) {
    ProgressRange.sevenDays => '7D',
    ProgressRange.thirtyDays => '30D',
    ProgressRange.ninetyDays => '3M',
    ProgressRange.sixMonths => '6M',
    ProgressRange.oneYear => '1Y',
    ProgressRange.allTime => l10n.progressRangeAllTime,
  };
}

class DoseAnnotatedWeightSeries {
  const DoseAnnotatedWeightSeries({
    required this.values,
    required this.pointColors,
    required this.legendItems,
    required this.pointCount,
    required this.pinnedCalloutIndices,
    required this.pointPrimaryLabels,
    required this.pointSecondaryLabels,
  });

  final List<double?> values;
  final List<Color?> pointColors;
  final List<DoseLegendItem> legendItems;
  final int pointCount;
  final List<int> pinnedCalloutIndices;
  final List<String?> pointPrimaryLabels;
  final List<String?> pointSecondaryLabels;
}

class DoseLegendItem {
  const DoseLegendItem({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;
}

List<ProgressRange> availableProgressRanges(
  List<Map<String, dynamic>> records, {
  DateTime? now,
}) {
  if (records.isEmpty) {
    return const [ProgressRange.sevenDays];
  }

  final today = DateUtils.dateOnly(now ?? DateTime.now());
  DateTime? earliest;
  for (final record in records) {
    final loggedAt = parseLoggedAt(record);
    if (loggedAt == null) continue;
    final day = DateUtils.dateOnly(loggedAt);
    if (earliest == null || day.isBefore(earliest)) {
      earliest = day;
    }
  }

  if (earliest == null) {
    return const [ProgressRange.sevenDays];
  }

  final spanDays = today.difference(earliest).inDays;
  final ranges = <ProgressRange>[];
  for (final range in ProgressRange.values) {
    if (range == ProgressRange.allTime) {
      if (spanDays > ProgressRange.sixMonths.days) {
        ranges.add(range);
      }
      break;
    }
    if (spanDays < range.days) {
      ranges.add(range);
      break;
    }
    ranges.add(range);
  }
  return ranges;
}

ProgressRange resolvedProgressRangeForRecords(
  List<Map<String, dynamic>> records,
  ProgressRange? selected, {
  DateTime? now,
}) {
  final availableRanges = availableProgressRanges(records, now: now);
  final preferredRange = defaultProgressRangeForRecords(records, now: now);
  final candidate = selected ?? preferredRange;

  if (availableRanges.contains(candidate)) {
    return candidate;
  }
  if (availableRanges.contains(preferredRange)) {
    return preferredRange;
  }
  return availableRanges.last;
}

ProgressRange defaultProgressRangeForRecords(
  List<Map<String, dynamic>> records, {
  DateTime? now,
}) {
  if (records.isEmpty) {
    return ProgressRange.thirtyDays;
  }

  final today = DateUtils.dateOnly(now ?? DateTime.now());
  final earliest = earliestRecordDay(records, now: now);
  if (earliest == null) {
    return ProgressRange.thirtyDays;
  }

  final spanDays = today.difference(earliest).inDays;
  if (spanDays > ProgressRange.sixMonths.days) {
    return ProgressRange.allTime;
  }
  if (spanDays > ProgressRange.ninetyDays.days) {
    return ProgressRange.sixMonths;
  }
  if (spanDays > ProgressRange.thirtyDays.days) {
    return ProgressRange.ninetyDays;
  }
  return ProgressRange.thirtyDays;
}

DateTime progressRangeStart(ProgressRange range, {DateTime? now}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  return today.subtract(Duration(days: range.days - 1));
}

DateTime progressRangeEndExclusive({DateTime? now}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  return today.add(const Duration(days: 1));
}

DateTime? parseLoggedAt(Map<String, dynamic> record) {
  final raw = record['logged_at'];
  if (raw is! String) return null;
  return DateTime.tryParse(raw)?.toLocal();
}

DateTime? earliestRecordDay(
  List<Map<String, dynamic>> records, {
  DateTime? now,
}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  DateTime? earliest;
  for (final record in records) {
    final loggedAt = parseLoggedAt(record);
    if (loggedAt == null) continue;
    final day = DateUtils.dateOnly(loggedAt);
    if (day.isAfter(today)) continue;
    if (earliest == null || day.isBefore(earliest)) {
      earliest = day;
    }
  }
  return earliest;
}

int progressRangeDayCount(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  if (range != ProgressRange.allTime) {
    return range.days;
  }

  final earliest =
      records == null ? null : earliestRecordDay(records, now: now);
  if (earliest == null) {
    return ProgressRange.oneYear.days;
  }

  return math.max(1, today.difference(earliest).inDays + 1);
}

DateTime resolvedProgressRangeStart(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  if (range != ProgressRange.allTime) {
    return progressRangeStart(range, now: now);
  }

  final dayCount = progressRangeDayCount(range, records: records, now: now);
  return today.subtract(Duration(days: dayCount - 1));
}

DateTime resolvedProgressRangeStartTrimmedToData(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
}) {
  final start = resolvedProgressRangeStart(range, records: records, now: now);
  if (records == null || records.isEmpty) {
    return start;
  }

  DateTime? firstDayWithinRange;
  for (final record in records) {
    final loggedAt = parseLoggedAt(record);
    if (loggedAt == null) continue;
    final day = DateUtils.dateOnly(loggedAt);
    if (day.isBefore(start)) continue;
    if (firstDayWithinRange == null || day.isBefore(firstDayWithinRange)) {
      firstDayWithinRange = day;
    }
  }

  if (firstDayWithinRange == null || firstDayWithinRange.isBefore(start)) {
    return start;
  }

  return firstDayWithinRange;
}

List<DateTime> dailyBuckets(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
}) {
  final start = resolvedProgressRangeStart(range, records: records, now: now);
  final dayCount = progressRangeDayCount(range, records: records, now: now);
  return List<DateTime>.generate(
    dayCount,
    (index) => start.add(Duration(days: index)),
  );
}

List<DateTime> dailyBucketsTrimmedToData(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  final start = resolvedProgressRangeStartTrimmedToData(
    range,
    records: records,
    now: now,
  );
  final dayCount = math.max(1, today.difference(start).inDays + 1);
  return List<DateTime>.generate(
    dayCount,
    (index) => start.add(Duration(days: index)),
  );
}

List<DateTime> monthBuckets(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
}) {
  final today = DateUtils.dateOnly(now ?? DateTime.now());
  final start = resolvedProgressRangeStart(range, records: records, now: now);
  final normalizedStart = DateTime(start.year, start.month);
  final normalizedEnd = DateTime(today.year, today.month);
  final monthCount =
      ((normalizedEnd.year - normalizedStart.year) * 12) +
      (normalizedEnd.month - normalizedStart.month) +
      1;
  return List<DateTime>.generate(
    math.max(1, monthCount),
    (index) => DateTime(
      normalizedStart.year,
      normalizedStart.month + index,
    ),
  );
}

List<double> sumByDay(
  List<Map<String, dynamic>> records,
  ProgressRange range, {
  required double Function(Map<String, dynamic> record) valueOf,
  DateTime? now,
}) {
  final buckets = dailyBuckets(range, records: records, now: now);
  final values = List<double>.filled(buckets.length, 0);
  final start = buckets.first;

  for (final record in records) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final day = DateUtils.dateOnly(date);
    final index = day.difference(start).inDays;
    if (index >= 0 && index < values.length) {
      values[index] += valueOf(record);
    }
  }

  return values;
}

List<double> sumByMonth(
  List<Map<String, dynamic>> records,
  ProgressRange range, {
  required double Function(Map<String, dynamic> record) valueOf,
  DateTime? now,
}) {
  final buckets = monthBuckets(range, records: records, now: now);
  final values = List<double>.filled(buckets.length, 0);
  final start = buckets.first;

  for (final record in records) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final month = DateTime(date.year, date.month);
    final index = ((month.year - start.year) * 12) + (month.month - start.month);
    if (index >= 0 && index < values.length) {
      values[index] += valueOf(record);
    }
  }

  return values;
}

List<double> sumByDayWithinDisplayRange(
  List<Map<String, dynamic>> records, {
  required ProgressRange displayRange,
  required ProgressRange activeRange,
  required double Function(Map<String, dynamic> record) valueOf,
  DateTime? now,
}) {
  final buckets = dailyBuckets(displayRange, records: records, now: now);
  final values = List<double>.filled(buckets.length, 0);
  final displayStart = buckets.first;
  final displayEnd = buckets.last;
  final activeStart = activeRange == ProgressRange.allTime
      ? displayStart
      : progressRangeStart(activeRange, now: now);

  for (final record in records) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final day = DateUtils.dateOnly(date);
    if (day.isBefore(displayStart) || day.isAfter(displayEnd)) continue;
    if (day.isBefore(activeStart)) continue;
    final index = day.difference(displayStart).inDays;
    if (index >= 0 && index < values.length) {
      values[index] += valueOf(record);
    }
  }

  return values;
}

List<double> averageByDay(
  List<Map<String, dynamic>> records,
  ProgressRange range, {
  required double Function(Map<String, dynamic> record) valueOf,
  DateTime? now,
}) {
  final buckets = dailyBuckets(range, records: records, now: now);
  final totals = List<double>.filled(buckets.length, 0);
  final counts = List<int>.filled(buckets.length, 0);
  final start = buckets.first;

  for (final record in records) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final day = DateUtils.dateOnly(date);
    final index = day.difference(start).inDays;
    if (index >= 0 && index < totals.length) {
      totals[index] += valueOf(record);
      counts[index]++;
    }
  }

  return List<double>.generate(
    totals.length,
    (index) => counts[index] == 0 ? 0 : totals[index] / counts[index],
  );
}

double? averageValue(
  List<Map<String, dynamic>> records, {
  required double Function(Map<String, dynamic> record) valueOf,
}) {
  if (records.isEmpty) return null;
  var total = 0.0;
  var count = 0;
  for (final record in records) {
    total += valueOf(record);
    count++;
  }
  if (count == 0) return null;
  return total / count;
}

List<double?> latestValueSeriesSparse(
  List<Map<String, dynamic>> records,
  ProgressRange range, {
  required double? Function(Map<String, dynamic> record) valueOf,
  DateTime? now,
}) {
  final buckets = dailyBuckets(range, records: records, now: now);
  final values = List<double?>.filled(buckets.length, null);
  final start = buckets.first;
  final latestByDay = <int, double>{};

  for (final record in records) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final day = DateUtils.dateOnly(date);
    final index = day.difference(start).inDays;
    final value = valueOf(record);
    if (index >= 0 && index < values.length && value != null) {
      latestByDay[index] = value;
    }
  }

  for (final entry in latestByDay.entries) {
    values[entry.key] = entry.value;
  }

  return values;
}

List<double?> latestValueSeriesSparseTrimmedToData(
  List<Map<String, dynamic>> records,
  ProgressRange range, {
  required double? Function(Map<String, dynamic> record) valueOf,
  DateTime? now,
}) {
  final buckets = dailyBucketsTrimmedToData(range, records: records, now: now);
  final values = List<double?>.filled(buckets.length, null);
  final start = buckets.first;
  final latestByDay = <int, double>{};

  for (final record in records) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final day = DateUtils.dateOnly(date);
    final index = day.difference(start).inDays;
    final value = valueOf(record);
    if (index >= 0 && index < values.length && value != null) {
      latestByDay[index] = value;
    }
  }

  for (final entry in latestByDay.entries) {
    values[entry.key] = entry.value;
  }

  return values;
}

List<double?> movingAverageSparse(List<double?> values, int window) {
  if (values.isEmpty) return values;
  final result = <double?>[];
  for (var i = 0; i < values.length; i++) {
    final start = (i - window + 1).clamp(0, values.length - 1);
    final slice = values
        .sublist(start, i + 1)
        .whereType<double>()
        .where((value) => value > 0);
    if (slice.isEmpty) {
      result.add(null);
    } else {
      result.add(slice.reduce((a, b) => a + b) / slice.length);
    }
  }
  return result;
}

double convertWeightToKg(double value, String unit) {
  return unit == 'lb' ? value / 2.2046226218 : value;
}

double convertKgToWeight(double kg, String unit) {
  return unit == 'lb' ? kg * 2.2046226218 : kg;
}

String recordWeightUnit(Map<String, dynamic> record) {
  final unit = record['unit'] as String?;
  return unit == 'lb' ? 'lb' : 'kg';
}

List<ChartAxisLabel> buildWeightXAxisLabels(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
  AppLocalizations? l10n,
}) {
  return buildTimeXAxisLabelsTrimmedToData(
    range,
    records: records,
    now: now,
    l10n: l10n,
  );
}

List<ChartAxisLabel> buildTimeXAxisLabels(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
  AppLocalizations? l10n,
}) {
  final buckets = dailyBuckets(range, records: records, now: now);
  final lastIndex = buckets.length - 1;
  final allTimeSpecs = <(int, String Function(DateTime))>[
    (0, (date) => DateFormat('MMM y').format(date)),
    ((lastIndex / 3).round(), (date) => DateFormat('MMM y').format(date)),
    (((lastIndex * 2) / 3).round(), (date) => DateFormat('MMM y').format(date)),
    (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
  ];
  final specs = switch (range) {
    ProgressRange.sevenDays => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('EEE').format(date)),
        (3, (date) => DateFormat('EEE').format(date)),
        (6, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.thirtyDays => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM d').format(date)),
        (9, (date) => DateFormat('MMM d').format(date)),
        (19, (date) => DateFormat('MMM d').format(date)),
        (29, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.ninetyDays => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM').format(date)),
        (44, (date) => DateFormat('MMM').format(date)),
        (89, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.sixMonths => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM').format(date)),
        (59, (date) => DateFormat('MMM').format(date)),
        (119, (date) => DateFormat('MMM').format(date)),
        (179, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.oneYear => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM').format(date)),
        (121, (date) => DateFormat('MMM').format(date)),
        (243, (date) => DateFormat('MMM').format(date)),
        (364, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.allTime => allTimeSpecs,
  };

  return specs.map((spec) {
    final index = spec.$1.clamp(0, lastIndex);
    final date = buckets[index];
    return ChartAxisLabel(
      position: lastIndex == 0 ? 0 : index / lastIndex,
      label: spec.$2(date),
    );
  }).toList();
}

List<ChartAxisLabel> buildTimeXAxisLabelsTrimmedToData(
  ProgressRange range, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
  AppLocalizations? l10n,
}) {
  final buckets = dailyBucketsTrimmedToData(range, records: records, now: now);
  final lastIndex = buckets.length - 1;
  final allTimeSpecs = <(int, String Function(DateTime))>[
    (0, (date) => DateFormat('MMM y').format(date)),
    ((lastIndex / 3).round(), (date) => DateFormat('MMM y').format(date)),
    (((lastIndex * 2) / 3).round(), (date) => DateFormat('MMM y').format(date)),
    (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
  ];
  final specs = switch (range) {
    ProgressRange.sevenDays => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('EEE').format(date)),
        ((lastIndex / 2).round(), (date) => DateFormat('EEE').format(date)),
        (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.thirtyDays => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM d').format(date)),
        ((lastIndex / 3).round(), (date) => DateFormat('MMM d').format(date)),
        (
          ((lastIndex * 2) / 3).round(),
          (date) => DateFormat('MMM d').format(date)
        ),
        (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.ninetyDays => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM').format(date)),
        ((lastIndex / 2).round(), (date) => DateFormat('MMM').format(date)),
        (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.sixMonths => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM').format(date)),
        ((lastIndex / 3).round(), (date) => DateFormat('MMM').format(date)),
        (
          ((lastIndex * 2) / 3).round(),
          (date) => DateFormat('MMM').format(date)
        ),
        (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.oneYear => <(int, String Function(DateTime))>[
        (0, (date) => DateFormat('MMM').format(date)),
        ((lastIndex / 3).round(), (date) => DateFormat('MMM').format(date)),
        (
          ((lastIndex * 2) / 3).round(),
          (date) => DateFormat('MMM').format(date)
        ),
        (lastIndex, (_) => l10n?.commonToday ?? 'Today'),
      ],
    ProgressRange.allTime => allTimeSpecs,
  };

  return specs.map((spec) {
    final index = spec.$1.clamp(0, lastIndex);
    final date = buckets[index];
    return ChartAxisLabel(
      position: lastIndex == 0 ? 0 : index / lastIndex,
      label: spec.$2(date),
    );
  }).toList();
}

List<ChartAxisLabel> buildGroupedTimeXAxisLabels(
  ProgressRange range,
  int bucketCount, {
  List<Map<String, dynamic>>? records,
  DateTime? now,
  AppLocalizations? l10n,
}) {
  if (bucketCount <= 0) {
    return const [];
  }
  if (bucketCount == 1) {
    return [
      ChartAxisLabel(position: 0, label: l10n?.commonNow ?? 'Now'),
    ];
  }
  final start = resolvedProgressRangeStart(range, records: records, now: now);
  final bucketDays = math.max(
    1,
    (progressRangeDayCount(range, records: records, now: now) / bucketCount)
        .round(),
  );
  final indices = {
    0,
    (bucketCount / 2).floor().clamp(0, bucketCount - 1),
    bucketCount - 1,
  }.toList()
    ..sort();
  return indices.map((index) {
    final date = start.add(Duration(days: index * bucketDays));
    final label = index == bucketCount - 1
        ? (l10n?.commonNow ?? 'Now')
        : range == ProgressRange.oneYear || range == ProgressRange.allTime
            ? DateFormat('MMM').format(date)
            : DateFormat('MMM d').format(date);
    return ChartAxisLabel(
      position: index / (bucketCount - 1),
      label: label,
    );
  }).toList();
}

List<ChartAxisLabel> buildMonthXAxisLabels(
  List<DateTime> buckets, {
  AppLocalizations? l10n,
}) {
  if (buckets.isEmpty) {
    return const [];
  }
  if (buckets.length == 1) {
    return [
      ChartAxisLabel(
        position: 0,
        label: DateFormat('MMM y').format(buckets.first),
      ),
    ];
  }
  final indices = {
    0,
    (buckets.length / 2).floor().clamp(0, buckets.length - 1),
    buckets.length - 1,
  }.toList()
    ..sort();
  return indices.map((index) {
    final isLast = index == buckets.length - 1;
    return ChartAxisLabel(
      position: index / (buckets.length - 1),
      label: isLast
          ? (l10n?.commonToday ?? 'Today')
          : DateFormat('MMM y').format(buckets[index]),
    );
  }).toList();
}

ChartScale buildWeightChartScale(
  List<double?> values,
  String unit, {
  double? referenceValue,
  double? minOverride,
  int tickCount = 3,
}) {
  final numericValues = [
    ...values.whereType<double>(),
    if (referenceValue != null) referenceValue,
  ];
  const axisStep = 5.0;
  if (numericValues.isEmpty) {
    final fallbackMin = unit == 'lb' ? 95.0 : 40.0;
    final fallbackTickCount = tickCount.clamp(3, 4);
    final fallbackMax = fallbackMin + (axisStep * (fallbackTickCount - 1));
    return ChartScale(
      min: fallbackMin,
      max: fallbackMax,
      labels: List<ChartAxisLabel>.generate(fallbackTickCount, (index) {
        final position =
            fallbackTickCount == 1 ? 0.0 : index / (fallbackTickCount - 1);
        final value = fallbackMin + (axisStep * index);
        return ChartAxisLabel(
          position: position,
          label: _formatAxisValue(value, unit),
        );
      }),
    );
  }

  final padding = 5.0;
  final computedMinValue = numericValues.reduce(math.min) - padding;
  final minValue = minOverride ?? computedMinValue;
  final paddedMax = numericValues.reduce(math.max) + padding;
  final niceMin = (minValue / axisStep).floor() * axisStep;
  final niceMax = (paddedMax / axisStep).ceil() * axisStep;
  final spanSteps = math.max(1, ((niceMax - niceMin) / axisStep).round());
  final preferredTickCount = spanSteps <= 2 ? 3 : 4;
  final resolvedTickCount = preferredTickCount.clamp(3, 4);
  final labels = List<ChartAxisLabel>.generate(resolvedTickCount, (index) {
    final position =
        resolvedTickCount == 1 ? 0.0 : index / (resolvedTickCount - 1);
    final value = niceMin + ((niceMax - niceMin) * position);
    return ChartAxisLabel(
      position: position,
      label: _formatAxisValue(
        (value / axisStep).round() * axisStep,
        unit,
      ),
    );
  });
  return ChartScale(
    min: niceMin,
    max: niceMax,
    labels: labels,
  );
}

ChartScale buildNumericChartScale(
  List<double> values, {
  double? referenceValue,
  int tickCount = 3,
  double minFloor = 0,
  required String Function(double value) formatter,
}) {
  final numericValues = [
    ...values,
    if (referenceValue != null) referenceValue,
  ];
  if (numericValues.isEmpty) {
    final fallbackMax = minFloor + 100.0;
    return ChartScale(
      min: minFloor,
      max: fallbackMax,
      labels: [
        ChartAxisLabel(position: 0, label: formatter(minFloor)),
        ChartAxisLabel(
          position: 0.5,
          label: formatter((minFloor + fallbackMax) / 2),
        ),
        ChartAxisLabel(position: 1, label: formatter(fallbackMax)),
      ],
    );
  }

  var minValue = numericValues.reduce(math.min);
  var maxValue = numericValues.reduce(math.max);
  if (minValue > minFloor) {
    minValue = minFloor;
  }
  if ((maxValue - minValue).abs() < 0.01) {
    final padding = maxValue.abs() < 10 ? 1.0 : maxValue.abs() * 0.1;
    minValue -= padding;
    maxValue += padding;
  }

  final rawRange = maxValue - minValue;
  final niceRange = _niceNumber(rawRange, false);
  final step = _niceNumber(niceRange / (tickCount - 1), true);
  final niceMin = (minValue / step).floor() * step;
  final niceMax = (maxValue / step).ceil() * step;
  final labelCount = (((niceMax - niceMin) / step).round() + 1)
      .clamp(tickCount, tickCount + 1);
  final labels = List<ChartAxisLabel>.generate(labelCount, (index) {
    final value = niceMin + (step * index);
    final position = (value - niceMin) / (niceMax - niceMin);
    return ChartAxisLabel(
      position: position.clamp(0, 1),
      label: formatter(value),
    );
  });

  return ChartScale(
    min: niceMin,
    max: niceMax,
    labels: labels,
  );
}

List<ChartAxisLabel> buildSeverityYAxisLabels(AppLocalizations l10n) {
  return [
    ChartAxisLabel(position: 0, label: l10n.progressLow),
    ChartAxisLabel(position: 0.5, label: l10n.progressMed),
    ChartAxisLabel(position: 1, label: l10n.progressHigh),
  ];
}

List<ChartAxisLabel> buildMoodYAxisLabels(AppLocalizations l10n) {
  return [
    ChartAxisLabel(position: 0, label: l10n.progressBad),
    ChartAxisLabel(position: 0.33, label: l10n.progressOkay),
    ChartAxisLabel(position: 0.66, label: l10n.progressGood),
    ChartAxisLabel(position: 1, label: l10n.progressGreat),
  ];
}

double moodFeelingScore(String feeling) {
  return switch (feeling) {
    'bad' => 1,
    'okay' => 2,
    'good' => 3,
    'great' => 4,
    _ => 2,
  }
      .toDouble();
}

String moodLabelForScore(double score, AppLocalizations l10n) {
  if (score < 1.5) return l10n.progressMostlyBad;
  if (score < 2.5) return l10n.progressMostlyOkay;
  if (score < 3.5) return l10n.progressMostlyGood;
  return l10n.progressMostlyGreat;
}

String formatWaterAxisValue(double value) {
  if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}L';
  }
  return '${value.round()}';
}

String formatMinutesAxisValue(double value) => value.round().toString();

String formatCountAxisValue(double value) => value.round().toString();

String formatCaloriesAxisValue(double value) => value.round().toString();

DoseAnnotatedWeightSeries buildDoseAnnotatedWeightSeries(
  List<Map<String, dynamic>> weightRecords,
  List<Map<String, dynamic>> doseRecords,
  ProgressRange range, {
  required String unit,
  AppLocalizations? l10n,
  DateTime? now,
}) {
  final buckets = dailyBucketsTrimmedToData(range, records: weightRecords);
  final values = List<double?>.filled(buckets.length, null);
  final pointColors = List<Color?>.filled(buckets.length, null);
  final pointPrimaryLabels = List<String?>.filled(buckets.length, null);
  final pointSecondaryLabels = List<String?>.filled(buckets.length, null);
  final start = buckets.first;
  final sortedDoses = [...doseRecords]..sort((a, b) {
    final aDate = parseLoggedAt(a);
    final bDate = parseLoggedAt(b);
    if (aDate == null && bDate == null) return 0;
    if (aDate == null) return -1;
    if (bDate == null) return 1;
    return aDate.compareTo(bDate);
  });
  final doseCarryForwardUntil =
      _doseCarryForwardCutoffAt(sortedDoses, now: now);

  final latestWeightByDay = <int, _AnnotatedWeightPoint>{};
  for (final record in weightRecords) {
    final date = parseLoggedAt(record);
    if (date == null) continue;
    final index = DateUtils.dateOnly(date).difference(start).inDays;
    if (index < 0 || index >= values.length) continue;
    final quantity = record['quantity'] as num?;
    if (quantity == null) continue;
    final kg = convertWeightToKg(quantity.toDouble(), recordWeightUnit(record));
    final resolvedValue = convertKgToWeight(kg, unit);
    final doseLabel = _latestDoseLabelAt(
      date,
      sortedDoses,
      carryForwardUntil: doseCarryForwardUntil,
    );
    latestWeightByDay[index] = _AnnotatedWeightPoint(
      value: resolvedValue,
      doseLabel: doseLabel,
      timestamp: date,
    );
  }

  final palette = <Color>[
    const Color(0xFF4E84E6),
    const Color(0xFF6D5EF4),
    const Color(0xFF2FAE8F),
    const Color(0xFFF2A541),
    const Color(0xFFE76F51),
    const Color(0xFFC855BC),
    const Color(0xFF7A8A99),
  ];
  final doseLabels = latestWeightByDay.values
      .map((point) => point.doseLabel)
      .whereType<String>()
      .toSet()
      .toList()
    ..sort(_compareDoseLabels);
  final colorByDose = <String, Color>{
    for (var i = 0; i < doseLabels.length; i++)
      doseLabels[i]: palette[i % palette.length],
  };
  final fallbackColor = const Color(0xFFBCC7D6);
  final sortedEntries = latestWeightByDay.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  final pinnedCalloutIndices = <int>[];
  String? previousDoseLabel;
  for (final entry in sortedEntries) {
    final doseLabel = entry.value.doseLabel;
    if (previousDoseLabel != null && doseLabel != previousDoseLabel) {
      pinnedCalloutIndices.add(entry.key);
    }
    previousDoseLabel = doseLabel;
  }
  if (sortedEntries.isNotEmpty) {
    final latestIndex = sortedEntries.last.key;
    if (!pinnedCalloutIndices.contains(latestIndex)) {
      pinnedCalloutIndices.add(latestIndex);
    }
  }

  for (final entry in latestWeightByDay.entries) {
    values[entry.key] = entry.value.value;
    pointColors[entry.key] = entry.value.doseLabel == null
        ? fallbackColor
        : colorByDose[entry.value.doseLabel!] ?? fallbackColor;
    pointPrimaryLabels[entry.key] =
        '${entry.value.value.toStringAsFixed(unit == 'lb' ? 0 : 1)} $unit';
    pointSecondaryLabels[entry.key] = entry.value.doseLabel ?? l10n?.progressNoDose ?? 'No dose';
  }

  final legendItems = <DoseLegendItem>[
    for (final label in doseLabels)
      DoseLegendItem(label: label, color: colorByDose[label]!),
    if (latestWeightByDay.values.any((point) => point.doseLabel == null))
      DoseLegendItem(
        label: l10n?.progressNoDose ?? 'No dose',
        color: const Color(0xFFBCC7D6),
      ),
  ];

  return DoseAnnotatedWeightSeries(
    values: values,
    pointColors: pointColors,
    legendItems: legendItems,
    pointCount: latestWeightByDay.length,
    pinnedCalloutIndices: pinnedCalloutIndices,
    pointPrimaryLabels: pointPrimaryLabels,
    pointSecondaryLabels: pointSecondaryLabels,
  );
}

DateTime? _doseCarryForwardCutoffAt(
  List<Map<String, dynamic>> doses, {
  DateTime? now,
}) {
  _LatestDoseMeta? latest;
  for (final dose in doses) {
    final doseAt = parseLoggedAt(dose);
    if (doseAt == null) continue;
    if (latest == null || doseAt.isAfter(latest.timestamp)) {
      latest = _LatestDoseMeta(
        timestamp: doseAt,
        medication: dose['medication']?.toString().trim(),
      );
    }
  }
  if (latest == null) return null;

  final carryForwardDays =
      MedicationCatalog.doseCarryForwardDaysForMedication(latest.medication);
  return latest.timestamp.add(Duration(days: carryForwardDays));
}

String? _latestDoseLabelAt(
  DateTime timestamp,
  List<Map<String, dynamic>> doses, {
  DateTime? carryForwardUntil,
}) {
  if (carryForwardUntil != null && !timestamp.isBefore(carryForwardUntil)) {
    return null;
  }

  String? match;
  for (final dose in doses) {
    final doseAt = parseLoggedAt(dose);
    if (doseAt == null) continue;
    if (doseAt.isAfter(timestamp)) {
      break;
    }
    final rawDose = dose['dose']?.toString().trim();
    if (rawDose != null && rawDose.isNotEmpty) {
      match = rawDose;
    }
  }
  return match;
}

class _LatestDoseMeta {
  const _LatestDoseMeta({
    required this.timestamp,
    required this.medication,
  });

  final DateTime timestamp;
  final String? medication;
}

int _compareDoseLabels(String a, String b) {
  final aValue = _leadingDoseValue(a);
  final bValue = _leadingDoseValue(b);
  if (aValue != null && bValue != null) {
    final compare = aValue.compareTo(bValue);
    if (compare != 0) {
      return compare;
    }
  }
  return a.compareTo(b);
}

double? _leadingDoseValue(String label) {
  final match = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(label);
  return match == null ? null : double.tryParse(match.group(1)!);
}

class _AnnotatedWeightPoint {
  const _AnnotatedWeightPoint({
    required this.value,
    required this.doseLabel,
    required this.timestamp,
  });

  final double value;
  final String? doseLabel;
  final DateTime timestamp;
}

double _niceNumber(double value, bool round) {
  if (value <= 0) {
    return 1;
  }
  final exponent = math.pow(10, (math.log(value) / math.ln10).floor());
  final fraction = value / exponent;
  late final double niceFraction;
  if (round) {
    if (fraction < 1.5) {
      niceFraction = 1;
    } else if (fraction < 3) {
      niceFraction = 2;
    } else if (fraction < 7) {
      niceFraction = 5;
    } else {
      niceFraction = 10;
    }
  } else {
    if (fraction <= 1) {
      niceFraction = 1;
    } else if (fraction <= 2) {
      niceFraction = 2;
    } else if (fraction <= 5) {
      niceFraction = 5;
    } else {
      niceFraction = 10;
    }
  }
  return niceFraction * exponent;
}

String _formatAxisValue(double value, String unit) {
  final decimals = unit == 'lb' ? 0 : (value.abs() >= 10 ? 0 : 1);
  return value.toStringAsFixed(decimals);
}
