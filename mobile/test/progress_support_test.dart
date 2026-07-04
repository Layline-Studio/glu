import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glu/screens/progress/progress_support.dart';

Map<String, dynamic> _weightRecord(DateTime loggedAt, double quantity) {
  return {
    'logged_at': loggedAt.toUtc().toIso8601String(),
    'quantity': quantity,
  };
}

Map<String, dynamic> _doseRecord(
  DateTime loggedAt, {
  required String medication,
  required String dose,
}) {
  return {
    'logged_at': loggedAt.toUtc().toIso8601String(),
    'medication': medication,
    'dose': dose,
  };
}

void main() {
  test('does not carry dose labels before the first logged dose', () {
    final now = DateTime.utc(2026, 5, 20);
    final firstDoseAt = DateTime.utc(2026, 3, 1);
    final firstWeightAt = DateTime.utc(2026, 2, 10);
    final records = [
      _weightRecord(firstWeightAt, 100),
      _weightRecord(DateTime.utc(2026, 3, 1), 99.2),
    ];
    final doses = [
      _doseRecord(firstDoseAt, medication: 'Semaglutide', dose: '2.5'),
    ];

    final annotated = buildDoseAnnotatedWeightSeries(
      records,
      doses,
      ProgressRange.allTime,
      unit: 'kg',
      now: now,
    );

    final beforeDoseIndex = 0;
    final onDoseIndex =
        DateUtils.dateOnly(firstDoseAt).difference(DateUtils.dateOnly(firstWeightAt)).inDays;

    expect(annotated.pointSecondaryLabels[beforeDoseIndex], 'No dose');
    expect(annotated.pointSecondaryLabels[onDoseIndex], '2.5');
  });

  test('stops carrying the last dose after the medication washout window', () {
    final now = DateTime.utc(2026, 5, 20);
    final lastDoseAt = DateTime.utc(2026, 4, 1);
    final firstWeightAt = DateTime.utc(2026, 3, 15);
    final withinWashoutAt = DateTime.utc(2026, 4, 15);
    final afterWashoutAt = DateTime.utc(2026, 5, 20);
    final records = [
      _weightRecord(firstWeightAt, 100),
      _weightRecord(withinWashoutAt, 98.8),
      _weightRecord(afterWashoutAt, 97.6),
    ];
    final doses = [
      _doseRecord(lastDoseAt, medication: 'Semaglutide', dose: '2.5'),
    ];

    final annotated = buildDoseAnnotatedWeightSeries(
      records,
      doses,
      ProgressRange.allTime,
      unit: 'kg',
      now: now,
    );

    final firstWeightIndex = 0;
    final withinWashoutIndex = DateUtils.dateOnly(withinWashoutAt)
        .difference(DateUtils.dateOnly(firstWeightAt))
        .inDays;
    final afterWashoutIndex = DateUtils.dateOnly(afterWashoutAt)
        .difference(DateUtils.dateOnly(firstWeightAt))
        .inDays;

    expect(annotated.pointSecondaryLabels[firstWeightIndex], 'No dose');
    expect(annotated.pointSecondaryLabels[withinWashoutIndex], '2.5');
    expect(annotated.pointSecondaryLabels[afterWashoutIndex], 'No dose');
  });
}
