import 'package:flutter/widgets.dart';

import '../l10n/l10n.dart';

class SymptomOption {
  const SymptomOption({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

class SymptomCatalog {
  static const noSymptoms = 'no_symptoms';
  static const anxiety = 'anxiety';
  static const belching = 'belching';
  static const bloating = 'bloating';
  static const constipation = 'constipation';
  static const diarrhea = 'diarrhea';
  static const fatigue = 'fatigue';
  static const foodNoise = 'food_noise';
  static const hairLoss = 'hair_loss';
  static const heartburn = 'heartburn';
  static const indigestion = 'indigestion';
  static const injectionSiteReaction = 'injection_site_reaction';
  static const metallicTaste = 'metallic_taste';
  static const headache = 'headache';
  static const moodSwings = 'mood_swings';
  static const nausea = 'nausea';
  static const reflux = 'reflux';
  static const stomachPain = 'stomach_pain';
  static const suppressedAppetite = 'suppressed_appetite';
  static const vomiting = 'vomiting';

  static const prioritizedValues = <String>[
    nausea,
    diarrhea,
    constipation,
    vomiting,
    stomachPain,
    suppressedAppetite,
    headache,
    fatigue,
    injectionSiteReaction,
  ];

  static List<SymptomOption> options(BuildContext context) => [
        SymptomOption(value: anxiety, label: context.l10n.symptomsLogAnxiety),
        SymptomOption(
          value: belching,
          label: context.l10n.symptomsLogBelching,
        ),
        SymptomOption(
          value: bloating,
          label: context.l10n.symptomsLogBloating,
        ),
        SymptomOption(
          value: constipation,
          label: context.l10n.symptomsLogConstipation,
        ),
        SymptomOption(
          value: diarrhea,
          label: context.l10n.symptomsLogDiarrhea,
        ),
        SymptomOption(value: fatigue, label: context.l10n.symptomsLogFatigue),
        SymptomOption(
          value: foodNoise,
          label: context.l10n.symptomsLogFoodNoise,
        ),
        SymptomOption(
          value: hairLoss,
          label: context.l10n.symptomsLogHairLoss,
        ),
        SymptomOption(
          value: heartburn,
          label: context.l10n.symptomsLogHeartburn,
        ),
        SymptomOption(
          value: indigestion,
          label: context.l10n.symptomsLogIndigestion,
        ),
        SymptomOption(
          value: injectionSiteReaction,
          label: context.l10n.symptomsLogInjectionSiteReaction,
        ),
        SymptomOption(
          value: metallicTaste,
          label: context.l10n.symptomsLogMetallicTaste,
        ),
        SymptomOption(
          value: headache,
          label: context.l10n.symptomsLogHeadache,
        ),
        SymptomOption(
          value: moodSwings,
          label: context.l10n.symptomsLogMoodSwings,
        ),
        SymptomOption(value: nausea, label: context.l10n.symptomsLogNausea),
        SymptomOption(value: reflux, label: context.l10n.symptomsLogReflux),
        SymptomOption(
          value: stomachPain,
          label: context.l10n.symptomsLogStomachPain,
        ),
        SymptomOption(
          value: suppressedAppetite,
          label: context.l10n.symptomsLogSuppressedAppetite,
        ),
        SymptomOption(value: vomiting, label: context.l10n.symptomsLogVomiting),
      ];

  static final values = {
    anxiety,
    belching,
    bloating,
    constipation,
    diarrhea,
    fatigue,
    foodNoise,
    hairLoss,
    heartburn,
    indigestion,
    injectionSiteReaction,
    metallicTaste,
    headache,
    moodSwings,
    nausea,
    reflux,
    stomachPain,
    suppressedAppetite,
    vomiting,
  };

  static List<SymptomOption> prioritizedOptions(BuildContext context) =>
      options(context)
          .where((option) => prioritizedValues.contains(option.value))
          .toList();

  static List<SymptomOption> otherOptions(BuildContext context) =>
      options(context)
          .where((option) => !prioritizedValues.contains(option.value))
          .toList();

  static const Map<String, String> _englishLabelByValue = {
    noSymptoms: 'No symptoms',
    anxiety: 'Anxiety',
    belching: 'Belching',
    bloating: 'Bloating',
    constipation: 'Constipation',
    diarrhea: 'Diarrhea',
    fatigue: 'Fatigue',
    foodNoise: 'Food noise',
    hairLoss: 'Hair loss',
    heartburn: 'Heartburn',
    indigestion: 'Indigestion',
    injectionSiteReaction: 'Injection site reaction',
    metallicTaste: 'Metallic taste',
    headache: 'Headache',
    moodSwings: 'Mood swings',
    nausea: 'Nausea',
    reflux: 'Reflux',
    stomachPain: 'Stomach pain',
    suppressedAppetite: 'Suppressed appetite',
    vomiting: 'Vomiting',
    'migraine': 'Headache',
  };

  static final Map<String, String> _valueByNormalizedInput = {
    noSymptoms: noSymptoms,
    'no symptoms': noSymptoms,
    for (final entry in _englishLabelByValue.entries)
      entry.key.toLowerCase(): entry.key == 'migraine' ? headache : entry.key,
    for (final entry in _englishLabelByValue.entries)
      entry.value.toLowerCase():
          entry.key == 'migraine' ? headache : entry.key,
    'migraine': headache,
  };

  static String labelFor(BuildContext context, String value) {
    return switch (value) {
      noSymptoms => context.l10n.symptomsLogNoSymptoms,
      anxiety => context.l10n.symptomsLogAnxiety,
      belching => context.l10n.symptomsLogBelching,
      bloating => context.l10n.symptomsLogBloating,
      constipation => context.l10n.symptomsLogConstipation,
      diarrhea => context.l10n.symptomsLogDiarrhea,
      fatigue => context.l10n.symptomsLogFatigue,
      foodNoise => context.l10n.symptomsLogFoodNoise,
      hairLoss => context.l10n.symptomsLogHairLoss,
      heartburn => context.l10n.symptomsLogHeartburn,
      indigestion => context.l10n.symptomsLogIndigestion,
      injectionSiteReaction => context.l10n.symptomsLogInjectionSiteReaction,
      metallicTaste => context.l10n.symptomsLogMetallicTaste,
      headache => context.l10n.symptomsLogHeadache,
      moodSwings => context.l10n.symptomsLogMoodSwings,
      nausea => context.l10n.symptomsLogNausea,
      reflux => context.l10n.symptomsLogReflux,
      stomachPain => context.l10n.symptomsLogStomachPain,
      suppressedAppetite => context.l10n.symptomsLogSuppressedAppetite,
      vomiting => context.l10n.symptomsLogVomiting,
      _ => _englishLabelByValue[value] ?? value,
    };
  }

  static String? normalizeValue(String? raw) {
    if (raw == null) {
      return null;
    }
    return _valueByNormalizedInput[raw.trim().toLowerCase()];
  }

  static List<String> normalizeValues(Iterable<dynamic> rawValues) {
    final normalized = <String>[];
    for (final raw in rawValues) {
      final value = normalizeValue(raw?.toString());
      if (value != null && !normalized.contains(value)) {
        normalized.add(value);
      }
    }
    return normalized;
  }
}
