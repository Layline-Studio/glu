import 'package:flutter_test/flutter_test.dart';

import 'package:glu/screens/settings/supplement_reminder_screen.dart';

void main() {
  group('nextSupplementOccurrence', () {
    test('moves interval reminders forward when today time already passed', () {
      final occurrence = nextSupplementOccurrence(
        {
          'start_date': '2026-04-10',
          'time_of_day': '08:00',
          'repeat_mode': 'every_x_days',
          'interval_days': 2,
        },
        from: DateTime(2026, 4, 14, 9, 0),
      );

      expect(occurrence, DateTime(2026, 4, 16, 8, 0));
    });

    test('keeps weekly reminders on today when the reminder time is upcoming',
        () {
      final occurrence = nextSupplementOccurrence(
        {
          'start_date': '2026-04-10',
          'time_of_day': '18:00',
          'repeat_mode': 'days_of_week',
          'days_of_week': [2],
        },
        from: DateTime(2026, 4, 14, 9, 0),
      );

      expect(occurrence, DateTime(2026, 4, 14, 18, 0));
    });

    test(
        'skips weekly reminders for today when the reminder time already passed',
        () {
      final occurrence = nextSupplementOccurrence(
        {
          'start_date': '2026-04-10',
          'time_of_day': '08:00',
          'repeat_mode': 'days_of_week',
          'days_of_week': [2],
        },
        from: DateTime(2026, 4, 14, 9, 0),
      );

      expect(occurrence, DateTime(2026, 4, 21, 8, 0));
    });

    test('returns null when weekly reminders have no selected days', () {
      final occurrence = nextSupplementOccurrence(
        {
          'start_date': '2026-04-10',
          'time_of_day': '08:00',
          'repeat_mode': 'days_of_week',
          'days_of_week': <int>[],
        },
        from: DateTime(2026, 4, 14, 9, 0),
      );

      expect(occurrence, isNull);
    });
  });
}
