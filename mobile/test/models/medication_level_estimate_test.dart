import 'package:flutter_test/flutter_test.dart';
import 'package:glu/models/medication_level_estimate.dart';

void main() {
  group('MedicationLevelEstimate', () {
    test('uses medication-specific half-life to decay a single dose', () {
      final asOf = DateTime(2026, 5, 20, 12);
      final estimate = MedicationLevelEstimate.fromDoseLogs(
        doseLogs: [
          {
            'logged_at': DateTime(2026, 5, 13, 12).toIso8601String(),
            'medication': 'Semaglutide',
            'dose': '2 mg',
          },
        ],
        medicationName: 'Semaglutide',
        asOf: asOf,
      );

      expect(estimate, isNotNull);
      expect(estimate!.usedFallbackHalfLife, isFalse);
      expect(estimate.currentAmountMg, closeTo(1.0, 0.02));
      expect(estimate.currentPercent, 50);
    });

    test('accumulates multiple doses of the same medication', () {
      final asOf = DateTime(2026, 5, 20, 12);
      final estimate = MedicationLevelEstimate.fromDoseLogs(
        doseLogs: [
          {
            'logged_at': DateTime(2026, 5, 13, 12).toIso8601String(),
            'medication': 'Zepbound ®',
            'dose': '5 mg',
          },
          {
            'logged_at': DateTime(2026, 5, 18, 12).toIso8601String(),
            'medication': 'Zepbound ®',
            'dose': '5 mg',
          },
        ],
        medicationName: 'Zepbound ®',
        asOf: asOf,
      );

      expect(estimate, isNotNull);
      expect(estimate!.currentAmountMg, closeTo(5.68, 0.05));
      expect(estimate.currentPercent, 76);
      expect(estimate.doseCount, 2);
    });

    test('falls back to a general half-life for unknown medications', () {
      final asOf = DateTime(2026, 5, 20, 12);
      final estimate = MedicationLevelEstimate.fromDoseLogs(
        doseLogs: [
          {
            'logged_at': DateTime(2026, 5, 13, 12).toIso8601String(),
            'medication': 'Custom Med',
            'dose': '4 mg',
          },
        ],
        medicationName: 'Custom Med',
        asOf: asOf,
      );

      expect(estimate, isNotNull);
      expect(estimate!.usedFallbackHalfLife, isTrue);
      expect(estimate.currentAmountMg, closeTo(2.0, 0.02));
      expect(estimate.currentPercent, 50);
    });

    test('treats medication label variants as the same medication', () {
      final asOf = DateTime(2026, 5, 20, 12);
      final estimate = MedicationLevelEstimate.fromDoseLogs(
        doseLogs: [
          {
            'logged_at': DateTime(2026, 5, 19, 12).toIso8601String(),
            'medication': 'Mounjaro',
            'dose': '5 mg',
          },
        ],
        medicationName: 'Mounjaro ®',
        asOf: asOf,
      );

      expect(estimate, isNotNull);
      expect(estimate!.currentAmountMg, greaterThan(0));
      expect(estimate.doseCount, 1);
    });
  });
}
