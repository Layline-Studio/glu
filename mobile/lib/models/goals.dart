// Goals are stored in profiles.goals JSONB with this shape:
//
// {
//   "water": {
//     "enabled": true,
//     "history": [
//       { "created_at": "2026-04-01", "timeframe": "daily", "target_ml": 2000 }
//     ]
//   },
//   "meals": {
//     "enabled": true,
//     "history": [
//       {
//         "created_at": "2026-04-01",
//         "timeframe": "daily",
//         "mode": "meals",
//         "target_value": 3
//       }
//     ]
//   },
//   ...
// }
//
// History entries are keyed by date (created_at = date string "yyyy-MM-dd").
// Same-day saves overwrite the existing entry (last wins).
// Toggling enabled does NOT add a history entry.

enum GoalTimeframe {
  daily,
  weekly;

  String get label => switch (this) {
        GoalTimeframe.daily => 'Day',
        GoalTimeframe.weekly => 'Week',
      };
}

enum MealsGoalMode {
  meals,
  calories;

  String get label => switch (this) {
        MealsGoalMode.meals => 'Meals',
        MealsGoalMode.calories => 'Calories',
      };
}

// ── Water ─────────────────────────────────────────────────────────────────────

class WaterGoalEntry {
  const WaterGoalEntry({
    required this.createdAt,
    required this.timeframe,
    required this.targetMl,
  });

  final String createdAt; // "yyyy-MM-dd"
  final GoalTimeframe timeframe;
  final double targetMl;

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'timeframe': timeframe.name,
        'target_ml': targetMl,
      };

  factory WaterGoalEntry.fromJson(Map<String, dynamic> j) => WaterGoalEntry(
        createdAt: j['created_at'] as String,
        timeframe: _tf(j['timeframe']),
        targetMl: (j['target_ml'] as num?)?.toDouble() ?? 2000,
      );
}

class WaterGoal {
  const WaterGoal({this.enabled = true, this.history = const []});

  final bool enabled;
  final List<WaterGoalEntry> history;

  WaterGoalEntry? get current => history.isEmpty ? null : history.last;

  WaterGoal copyWith({bool? enabled, List<WaterGoalEntry>? history}) =>
      WaterGoal(
        enabled: enabled ?? this.enabled,
        history: history ?? this.history,
      );

  /// Appends or overwrites the entry for today.
  WaterGoal withEntry(WaterGoalEntry entry) {
    final updated = [...history];
    final idx = updated.indexWhere((e) => e.createdAt == entry.createdAt);
    if (idx >= 0) {
      updated[idx] = entry;
    } else {
      updated.add(entry);
    }
    return copyWith(history: updated);
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'history': history.map((e) => e.toJson()).toList(),
      };

  factory WaterGoal.fromJson(Map<String, dynamic> j) => WaterGoal(
        enabled: j['enabled'] as bool? ?? true,
        history: (j['history'] as List<dynamic>?)
                ?.map((e) => WaterGoalEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// ── Exercise ──────────────────────────────────────────────────────────────────

class ExerciseGoalEntry {
  const ExerciseGoalEntry({
    required this.createdAt,
    required this.timeframe,
    required this.targetMinutes,
  });

  final String createdAt;
  final GoalTimeframe timeframe;
  final int targetMinutes;

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'timeframe': timeframe.name,
        'target_minutes': targetMinutes,
      };

  factory ExerciseGoalEntry.fromJson(Map<String, dynamic> j) =>
      ExerciseGoalEntry(
        createdAt: j['created_at'] as String,
        timeframe: _tf(j['timeframe']),
        targetMinutes: (j['target_minutes'] as num?)?.toInt() ?? 30,
      );
}

class ExerciseGoal {
  const ExerciseGoal({this.enabled = true, this.history = const []});

  final bool enabled;
  final List<ExerciseGoalEntry> history;

  ExerciseGoalEntry? get current => history.isEmpty ? null : history.last;

  ExerciseGoal copyWith({
    bool? enabled,
    List<ExerciseGoalEntry>? history,
  }) =>
      ExerciseGoal(
        enabled: enabled ?? this.enabled,
        history: history ?? this.history,
      );

  ExerciseGoal withEntry(ExerciseGoalEntry entry) {
    final updated = [...history];
    final idx = updated.indexWhere((e) => e.createdAt == entry.createdAt);
    if (idx >= 0) {
      updated[idx] = entry;
    } else {
      updated.add(entry);
    }
    return copyWith(history: updated);
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'history': history.map((e) => e.toJson()).toList(),
      };

  factory ExerciseGoal.fromJson(Map<String, dynamic> j) => ExerciseGoal(
        enabled: j['enabled'] as bool? ?? true,
        history: (j['history'] as List<dynamic>?)
                ?.map((e) =>
                    ExerciseGoalEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// ── Meals ─────────────────────────────────────────────────────────────────────

class MealsGoalEntry {
  const MealsGoalEntry({
    required this.createdAt,
    required this.timeframe,
    required this.mode,
    required this.targetValue,
  });

  final String createdAt;
  final GoalTimeframe timeframe;
  final MealsGoalMode mode;
  final int targetValue;

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'timeframe': timeframe.name,
        'mode': mode.name,
        'target_value': targetValue,
      };

  factory MealsGoalEntry.fromJson(Map<String, dynamic> j) => MealsGoalEntry(
        createdAt: j['created_at'] as String,
        timeframe: _tf(j['timeframe']),
        mode: _mealsMode(j['mode']),
        targetValue: (j['target_value'] as num?)?.toInt() ??
            (j['logs_per_period'] as num?)?.toInt() ??
            3,
      );
}

class MealsGoal {
  const MealsGoal({this.enabled = true, this.history = const []});

  final bool enabled;
  final List<MealsGoalEntry> history;

  MealsGoalEntry? get current => history.isEmpty ? null : history.last;

  MealsGoal copyWith({bool? enabled, List<MealsGoalEntry>? history}) =>
      MealsGoal(
        enabled: enabled ?? this.enabled,
        history: history ?? this.history,
      );

  MealsGoal withEntry(MealsGoalEntry entry) {
    final updated = [...history];
    final idx = updated.indexWhere((e) => e.createdAt == entry.createdAt);
    if (idx >= 0) {
      updated[idx] = entry;
    } else {
      updated.add(entry);
    }
    return copyWith(history: updated);
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'history': history.map((e) => e.toJson()).toList(),
      };

  factory MealsGoal.fromJson(Map<String, dynamic> j) => MealsGoal(
        enabled: j['enabled'] as bool? ?? true,
        history: (j['history'] as List<dynamic>?)
                ?.map((e) => MealsGoalEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// ── Protein / Fiber ──────────────────────────────────────────────────────────

class NutrientGoalEntry {
  const NutrientGoalEntry({
    required this.createdAt,
    required this.timeframe,
    required this.targetGrams,
  });

  final String createdAt;
  final GoalTimeframe timeframe;
  final int targetGrams;

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'timeframe': timeframe.name,
        'target_grams': targetGrams,
      };

  factory NutrientGoalEntry.fromJson(Map<String, dynamic> j) =>
      NutrientGoalEntry(
        createdAt: j['created_at'] as String,
        timeframe: _tf(j['timeframe']),
        targetGrams: (j['target_grams'] as num?)?.toInt() ??
            (j['target_value'] as num?)?.toInt() ??
            0,
      );
}

class NutrientGoal {
  const NutrientGoal({this.enabled = true, this.history = const []});

  final bool enabled;
  final List<NutrientGoalEntry> history;

  NutrientGoalEntry? get current => history.isEmpty ? null : history.last;

  NutrientGoal copyWith({
    bool? enabled,
    List<NutrientGoalEntry>? history,
  }) =>
      NutrientGoal(
        enabled: enabled ?? this.enabled,
        history: history ?? this.history,
      );

  NutrientGoal withEntry(NutrientGoalEntry entry) {
    final updated = [...history];
    final idx = updated.indexWhere((e) => e.createdAt == entry.createdAt);
    if (idx >= 0) {
      updated[idx] = entry;
    } else {
      updated.add(entry);
    }
    return copyWith(history: updated);
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'history': history.map((e) => e.toJson()).toList(),
      };

  factory NutrientGoal.fromJson(Map<String, dynamic> j) => NutrientGoal(
        enabled: j['enabled'] as bool? ?? true,
        history: (j['history'] as List<dynamic>?)
                ?.map((e) =>
                    NutrientGoalEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// ── Weight ────────────────────────────────────────────────────────────────────

class WeightGoalEntry {
  const WeightGoalEntry({
    required this.createdAt,
    required this.timeframe,
    required this.targetKg,
    this.targetUnit = 'kg',
  });

  final String createdAt;
  final GoalTimeframe timeframe;
  final double targetKg;
  final String targetUnit;

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'timeframe': timeframe.name,
        'target_kg': targetKg,
        'target_unit': targetUnit,
      };

  factory WeightGoalEntry.fromJson(Map<String, dynamic> j) => WeightGoalEntry(
        createdAt: j['created_at'] as String,
        timeframe: _tf(j['timeframe']),
        targetKg: (j['target_kg'] as num?)?.toDouble() ?? 0,
        targetUnit: j['target_unit'] as String? ?? 'kg',
      );
}

class WeightGoal {
  const WeightGoal({this.enabled = true, this.history = const []});

  final bool enabled;
  final List<WeightGoalEntry> history;

  WeightGoalEntry? get current => history.isEmpty ? null : history.last;

  WeightGoal copyWith({bool? enabled, List<WeightGoalEntry>? history}) =>
      WeightGoal(
        enabled: enabled ?? this.enabled,
        history: history ?? this.history,
      );

  WeightGoal withEntry(WeightGoalEntry entry) {
    final updated = [...history];
    final idx = updated.indexWhere((e) => e.createdAt == entry.createdAt);
    if (idx >= 0) {
      updated[idx] = entry;
    } else {
      updated.add(entry);
    }
    return copyWith(history: updated);
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'history': history.map((e) => e.toJson()).toList(),
      };

  factory WeightGoal.fromJson(Map<String, dynamic> j) => WeightGoal(
        enabled: j['enabled'] as bool? ?? true,
        history: (j['history'] as List<dynamic>?)
                ?.map(
                    (e) => WeightGoalEntry.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// ── Root ──────────────────────────────────────────────────────────────────────

class AppGoals {
  const AppGoals({
    this.water = const WaterGoal(),
    this.exercise = const ExerciseGoal(),
    this.meals = const MealsGoal(),
    this.protein = const NutrientGoal(),
    this.fiber = const NutrientGoal(),
    this.weight = const WeightGoal(),
  });

  static const empty = AppGoals();

  final WaterGoal water;
  final ExerciseGoal exercise;
  final MealsGoal meals;
  final NutrientGoal protein;
  final NutrientGoal fiber;
  final WeightGoal weight;

  AppGoals copyWith({
    WaterGoal? water,
    ExerciseGoal? exercise,
    MealsGoal? meals,
    NutrientGoal? protein,
    NutrientGoal? fiber,
    WeightGoal? weight,
  }) =>
      AppGoals(
        water: water ?? this.water,
        exercise: exercise ?? this.exercise,
        meals: meals ?? this.meals,
        protein: protein ?? this.protein,
        fiber: fiber ?? this.fiber,
        weight: weight ?? this.weight,
      );

  Map<String, dynamic> toJson() => {
        'water': water.toJson(),
        'exercise': exercise.toJson(),
        'meals': meals.toJson(),
        'protein': protein.toJson(),
        'fiber': fiber.toJson(),
        'weight': weight.toJson(),
      };

  factory AppGoals.fromJson(Map<String, dynamic> json) => AppGoals(
        water: WaterGoal.fromJson(json['water'] as Map<String, dynamic>? ?? {}),
        exercise: ExerciseGoal.fromJson(
            json['exercise'] as Map<String, dynamic>? ?? {}),
        meals: MealsGoal.fromJson(json['meals'] as Map<String, dynamic>? ?? {}),
        protein: NutrientGoal.fromJson(
            json['protein'] as Map<String, dynamic>? ?? {}),
        fiber:
            NutrientGoal.fromJson(json['fiber'] as Map<String, dynamic>? ?? {}),
        weight:
            WeightGoal.fromJson(json['weight'] as Map<String, dynamic>? ?? {}),
      );
}

// ── Helpers ───────────────────────────────────────────────────────────────────

GoalTimeframe _tf(Object? value) {
  try {
    return GoalTimeframe.values.byName(value as String);
  } catch (_) {
    return GoalTimeframe.daily;
  }
}

MealsGoalMode _mealsMode(Object? value) {
  try {
    return MealsGoalMode.values.byName(value as String);
  } catch (_) {
    return MealsGoalMode.meals;
  }
}

/// Today as "yyyy-MM-dd" — used as the history entry key.
String goalToday() {
  final now = DateTime.now();
  return '${now.year.toString().padLeft(4, '0')}-'
      '${now.month.toString().padLeft(2, '0')}-'
      '${now.day.toString().padLeft(2, '0')}';
}
