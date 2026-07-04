class MedicationCatalog {
  const MedicationCatalog._();

  static const int _defaultDoseCarryForwardDays = 49;
  static const double _defaultHalfLifeHours = 168;

  static const Map<String, int> _doseCarryForwardDaysByMedication = {
    'Zepbound ®': 35,
    'Mounjaro ®': 35,
    'Tirzepatide': 35,
    'Wegovy ®': 49,
    'Semaglutide': 49,
    'Ozempic ®': 49,
    'Semaglutide Pill': 49,
    'Wegovy ® Pill': 49,
    'Rybelsus ®': 49,
    'Foundayo ® Pill': 49,
    'Saxenda ®': 7,
    'Victoza ®': 7,
    'Trulicity ®': 35,
    'Retatrutide': 35,
  };

  static const Map<String, double> _halfLifeHoursByMedication = {
    'Zepbound ®': 120,
    'Mounjaro ®': 120,
    'Tirzepatide': 120,
    'Wegovy ®': 168,
    'Semaglutide': 168,
    'Ozempic ®': 168,
    'Semaglutide Pill': 168,
    'Wegovy ® Pill': 168,
    'Rybelsus ®': 168,
    'Foundayo ® Pill': 168,
    'Saxenda ®': 13,
    'Victoza ®': 13,
    'Trulicity ®': 120,
    'Retatrutide': 120,
  };

  static const shotMedications = <String>[
    'Zepbound ®',
    'Mounjaro ®',
    'Tirzepatide',
    'Wegovy ®',
    'Semaglutide',
    'Ozempic ®',
    'Retatrutide',
    'Saxenda ®',
    'Victoza ®',
    'Trulicity ®',
  ];

  static const pillMedications = <String>[
    'Semaglutide Pill',
    'Wegovy ® Pill',
    'Rybelsus ®',
    'Foundayo ® Pill',
  ];

  static const Map<String, List<String>> _doseOptionsByMedication = {
    'Zepbound ®': ['2.5', '5', '7.5', '10', '12.5', '15'],
    'Mounjaro ®': ['2.5', '5', '7.5', '10', '12.5', '15'],
    'Tirzepatide': ['2.5', '5', '7.5', '10', '12.5', '15'],
    'Wegovy ®': ['0.25', '0.5', '1', '1.7', '2.4'],
    'Semaglutide': ['0.25', '0.5', '1', '1.7', '2', '2.4'],
    'Ozempic ®': ['0.25', '0.5', '1', '2'],
    'Retatrutide': ['2', '4', '6', '9', '12'],
    'Saxenda ®': ['0.6', '1.2', '1.8', '2.4', '3'],
    'Victoza ®': ['0.6', '1.2', '1.8'],
    'Trulicity ®': ['0.75', '1.5', '3', '4.5'],
    'Semaglutide Pill': ['3', '7', '14'],
    'Wegovy ® Pill': ['1.5', '4', '9', '25'],
    'Rybelsus ®': ['3', '7', '14'],
  };

  static List<String> medicationsForMethod(String? method) {
    return method == 'pill' ? pillMedications : shotMedications;
  }

  static List<String> dosesForMedication(String? medication) {
    if (medication == null) {
      return const [];
    }
    return _doseOptionsByMedication[medication] ?? const [];
  }

  static ({double min, double max, double step}) customDoseRangeForMedication(
    String? medication,
  ) {
    return (min: 0.25, max: 25, step: 0.05);
  }

  static String customInitialDoseForMedication(String? medication) {
    final range = customDoseRangeForMedication(medication);
    final standard = dosesForMedication(medication).toSet();
    var candidate = range.min;
    while (candidate <= range.max) {
      final normalized = _normalizeNumericString(candidate);
      if (!standard.contains(normalized)) {
        return normalized;
      }
      candidate += range.step;
    }
    return _normalizeNumericString(range.max);
  }

  static String? coerceDoseValue(dynamic value) {
    if (value == null) {
      return null;
    }
    final raw = value.toString().trim().toLowerCase();
    final sanitized =
        raw.endsWith('mg') ? raw.substring(0, raw.length - 2).trim() : raw;
    final numeric = double.tryParse(sanitized);
    if (numeric == null) {
      return null;
    }
    return _normalizeNumericString(_roundToStep(numeric, 0.05));
  }

  static String? normalizeDoseValue(
    dynamic value, {
    String? medication,
  }) {
    final normalized = coerceDoseValue(value);
    if (normalized == null) {
      return null;
    }
    final allowed = medication == null
        ? _doseOptionsByMedication.values.expand((values) => values).toSet()
        : dosesForMedication(medication).toSet();
    return allowed.contains(normalized) ? normalized : null;
  }

  static int doseCarryForwardDaysForMedication(String? medication) {
    final normalized = normalizeMedicationName(medication);
    if (normalized == null) {
      return _defaultDoseCarryForwardDays;
    }
    return _doseCarryForwardDaysByMedication.entries
        .firstWhere(
          (entry) => normalizeMedicationName(entry.key) == normalized,
          orElse: () => const MapEntry('', _defaultDoseCarryForwardDays),
        )
        .value;
  }

  static int get maxDoseCarryForwardDays {
    var maxDays = _defaultDoseCarryForwardDays;
    for (final value in _doseCarryForwardDaysByMedication.values) {
      if (value > maxDays) {
        maxDays = value;
      }
    }
    return maxDays;
  }

  static bool hasSpecificHalfLifeForMedication(String? medication) {
    final normalized = normalizeMedicationName(medication);
    if (normalized == null) {
      return false;
    }
    return _halfLifeHoursByMedication.keys
        .any((key) => normalizeMedicationName(key) == normalized);
  }

  static Duration halfLifeForMedication(String? medication) {
    final normalized = normalizeMedicationName(medication);
    final hours = normalized == null
        ? _defaultHalfLifeHours
        : _halfLifeHoursByMedication.entries
            .firstWhere(
              (entry) => normalizeMedicationName(entry.key) == normalized,
              orElse: () => const MapEntry('', _defaultHalfLifeHours),
            )
            .value;
    return Duration(minutes: (hours * 60).round());
  }

  static Duration levelLookbackForMedication(String? medication) {
    final halfLife = halfLifeForMedication(medication);
    return Duration(minutes: halfLife.inMinutes * 7);
  }

  static String? normalizeMedicationName(String? medication) {
    final normalized = medication?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    final stripped = normalized
        .replaceAll('®', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();
    return stripped.isEmpty ? null : stripped;
  }

  static String formatDoseLabel(String value) => '${_displayDose(value)} mg';

  static String _normalizeNumericString(double value) {
    final rounded = _roundToStep(value, 0.05);
    if ((rounded % 1).abs() < 0.000001) {
      return rounded.toInt().toString();
    }
    return rounded
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  static String _displayDose(String value) {
    final numeric = double.tryParse(value);
    if (numeric == null) {
      return value;
    }
    final rounded = _roundToStep(numeric, 0.05);
    if ((rounded % 1).abs() < 0.000001) {
      return rounded.toInt().toString();
    }
    return rounded
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  static double _roundToStep(double value, double step) {
    return (value / step).round() * step;
  }
}
