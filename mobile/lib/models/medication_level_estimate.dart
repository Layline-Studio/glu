import 'dart:math' as math;

import 'medication_catalog.dart';

class MedicationLevelEstimate {
  const MedicationLevelEstimate({
    required this.medicationName,
    required this.asOf,
    required this.halfLife,
    required this.currentAmountMg,
    required this.recentPeakAmountMg,
    required this.lastDoseAt,
    required this.lastDoseAmountMg,
    required this.doseCount,
    required this.usedFallbackHalfLife,
    required this.recentLevelFractions,
  });

  final String medicationName;
  final DateTime asOf;
  final Duration halfLife;
  final double currentAmountMg;
  final double recentPeakAmountMg;
  final DateTime lastDoseAt;
  final double lastDoseAmountMg;
  final int doseCount;
  final bool usedFallbackHalfLife;
  final List<double> recentLevelFractions;

  int get currentPercent {
    if (recentPeakAmountMg <= 0) {
      return 0;
    }
    return ((currentAmountMg / recentPeakAmountMg) * 100).round().clamp(0, 100);
  }

  static MedicationLevelEstimate? fromDoseLogs({
    required List<Map<String, dynamic>> doseLogs,
    String? medicationName,
    DateTime? asOf,
  }) {
    final effectiveAsOf = (asOf ?? DateTime.now()).toLocal();
    final parsedLogs = _parseDoseEvents(
      doseLogs: doseLogs,
      asOf: effectiveAsOf,
    );
    final effectiveMedication =
        _resolveMedicationName(parsedLogs, medicationName);
    if (effectiveMedication == null || effectiveMedication.isEmpty) {
      return null;
    }

    final halfLife = MedicationCatalog.halfLifeForMedication(
      effectiveMedication,
    );
    final lookback = MedicationCatalog.levelLookbackForMedication(
      effectiveMedication,
    );
    final windowStart = effectiveAsOf.subtract(lookback);
    final relevantLogs = _filterDoseEvents(
      parsedLogs,
      medicationName: effectiveMedication,
      windowStart: windowStart,
    );
    if (relevantLogs.isEmpty) {
      return null;
    }

    var runningLevelMg = 0.0;
    var peakLevelMg = 0.0;
    DateTime? previousEventAt;

    for (final event in relevantLogs) {
      if (previousEventAt != null) {
        runningLevelMg = _decayLevel(
          runningLevelMg,
          from: previousEventAt,
          to: event.loggedAt,
          halfLife: halfLife,
        );
      }
      runningLevelMg += event.doseMg;
      peakLevelMg = math.max(peakLevelMg, runningLevelMg);
      previousEventAt = event.loggedAt;
    }

    final lastDose = relevantLogs.last;
    final currentLevelMg = previousEventAt == null
        ? 0.0
        : _decayLevel(
            runningLevelMg,
            from: previousEventAt,
            to: effectiveAsOf,
            halfLife: halfLife,
          );
    peakLevelMg = math.max(peakLevelMg, currentLevelMg);

    final recentFractions = List<double>.generate(7, (index) {
      final daysAgo = 6 - index;
      final sampleAt = effectiveAsOf.subtract(Duration(days: daysAgo));
      final sampleLevel = _levelAt(
        relevantLogs,
        sampleAt,
        halfLife,
      );
      if (peakLevelMg <= 0) {
        return 0;
      }
      return (sampleLevel / peakLevelMg).clamp(0.0, 1.0);
    });

    return MedicationLevelEstimate(
      medicationName: effectiveMedication,
      asOf: effectiveAsOf,
      halfLife: halfLife,
      currentAmountMg: currentLevelMg,
      recentPeakAmountMg: peakLevelMg,
      lastDoseAt: lastDose.loggedAt,
      lastDoseAmountMg: lastDose.doseMg,
      doseCount: relevantLogs.length,
      usedFallbackHalfLife: !MedicationCatalog.hasSpecificHalfLifeForMedication(
        effectiveMedication,
      ),
      recentLevelFractions: recentFractions,
    );
  }

  static List<double?> buildDailySeries({
    required List<Map<String, dynamic>> doseLogs,
    String? medicationName,
    DateTime? asOf,
    int days = 90,
  }) {
    if (days <= 0) {
      return const [];
    }

    final effectiveAsOf = (asOf ?? DateTime.now()).toLocal();
    final parsedLogs = _parseDoseEvents(
      doseLogs: doseLogs,
      asOf: effectiveAsOf,
    );
    final effectiveMedication =
        _resolveMedicationName(parsedLogs, medicationName);
    if (effectiveMedication == null || effectiveMedication.isEmpty) {
      return List<double?>.filled(days, null);
    }

    final halfLife = MedicationCatalog.halfLifeForMedication(
      effectiveMedication,
    );
    final sampleWindowStart = effectiveAsOf.subtract(Duration(days: days - 1));
    final relevantWindowStart = sampleWindowStart.subtract(
      MedicationCatalog.levelLookbackForMedication(effectiveMedication),
    );
    final relevantLogs = _filterDoseEvents(
      parsedLogs,
      medicationName: effectiveMedication,
      windowStart: relevantWindowStart,
    );
    if (relevantLogs.isEmpty) {
      return List<double?>.filled(days, null);
    }

    return List<double?>.generate(days, (index) {
      final sampleAt = sampleWindowStart.add(Duration(days: index));
      return _levelAt(
        relevantLogs,
        sampleAt,
        halfLife,
      );
    });
  }

  static double _levelAt(
    List<_DoseEvent> doseEvents,
    DateTime asOf,
    Duration halfLife,
  ) {
    if (doseEvents.isEmpty) {
      return 0;
    }

    var levelMg = 0.0;
    DateTime? previousEventAt;
    for (final event in doseEvents) {
      if (event.loggedAt.isAfter(asOf)) {
        break;
      }
      if (previousEventAt != null) {
        levelMg = _decayLevel(
          levelMg,
          from: previousEventAt,
          to: event.loggedAt,
          halfLife: halfLife,
        );
      }
      levelMg += event.doseMg;
      previousEventAt = event.loggedAt;
    }

    if (previousEventAt == null) {
      return 0;
    }

    return _decayLevel(
      levelMg,
      from: previousEventAt,
      to: asOf,
      halfLife: halfLife,
    );
  }

  static double _decayLevel(
    double amountMg, {
    required DateTime from,
    required DateTime to,
    required Duration halfLife,
  }) {
    final elapsedMicroseconds = to.difference(from).inMicroseconds;
    if (elapsedMicroseconds <= 0 || amountMg <= 0) {
      return amountMg;
    }
    final halfLifeMicroseconds = halfLife.inMicroseconds;
    if (halfLifeMicroseconds <= 0) {
      return amountMg;
    }
    final halfLivesElapsed = elapsedMicroseconds / halfLifeMicroseconds;
    return amountMg * math.pow(0.5, halfLivesElapsed);
  }

  static List<_DoseEvent> _parseDoseEvents({
    required List<Map<String, dynamic>> doseLogs,
    required DateTime asOf,
  }) {
    return doseLogs
        .map(_DoseEvent.tryParse)
        .whereType<_DoseEvent>()
        .where((event) => !event.loggedAt.isAfter(asOf))
        .toList()
      ..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));
  }

  static List<_DoseEvent> _filterDoseEvents(
    List<_DoseEvent> doseEvents, {
    required String medicationName,
    required DateTime windowStart,
  }) {
    final targetMedication = MedicationCatalog.normalizeMedicationName(
      medicationName,
    );
    if (targetMedication == null) {
      return const [];
    }

    return doseEvents
        .where(
          (event) =>
              MedicationCatalog.normalizeMedicationName(
                    event.medicationName,
                  ) ==
                  targetMedication &&
              !event.loggedAt.isBefore(windowStart),
        )
        .toList();
  }

  static String? _resolveMedicationName(
    List<_DoseEvent> parsedLogs,
    String? medicationName,
  ) {
    final requestedMedication = medicationName?.trim();
    if (requestedMedication != null && requestedMedication.isNotEmpty) {
      return requestedMedication;
    }
    if (parsedLogs.isEmpty) {
      return null;
    }
    return parsedLogs.last.medicationName;
  }
}

class _DoseEvent {
  const _DoseEvent({
    required this.loggedAt,
    required this.medicationName,
    required this.doseMg,
  });

  final DateTime loggedAt;
  final String medicationName;
  final double doseMg;

  static _DoseEvent? tryParse(Map<String, dynamic> raw) {
    final rawLoggedAt = raw['logged_at'] as String?;
    final loggedAt =
        rawLoggedAt == null ? null : DateTime.tryParse(rawLoggedAt);
    final medicationName = raw['medication']?.toString().trim();
    final normalizedDose = MedicationCatalog.coerceDoseValue(raw['dose']);
    final doseMg =
        normalizedDose == null ? null : double.tryParse(normalizedDose);
    if (loggedAt == null ||
        medicationName == null ||
        medicationName.isEmpty ||
        doseMg == null ||
        !doseMg.isFinite ||
        doseMg <= 0) {
      return null;
    }
    return _DoseEvent(
      loggedAt: loggedAt.toLocal(),
      medicationName: medicationName,
      doseMg: doseMg,
    );
  }
}
