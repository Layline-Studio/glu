import 'dart:typed_data';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/injection_site_catalog.dart';
import '../models/symptom_catalog.dart';
import '../utils/datetime_utils.dart';
import 'review_prompt_service.dart';

const _uuid = Uuid();

class RecordService {
  RecordService({ReviewPromptService? reviewPromptService})
      : _reviewPromptService = reviewPromptService ?? ReviewPromptService();

  static const assetsBucket = 'assets';
  static const waterColumn = 'water';
  static const exerciseColumn = 'exercise';
  static const weightColumn = 'weight';
  static const mealsColumn = 'meals';
  static const symptomsColumn = 'symptoms';
  static const moodColumn = 'mood';
  static const glowUpColumn = 'glowup';
  static const supplementsColumn = 'supplements';
  static const dosesColumn = 'doses';

  static const _allowedColumns = <String>{
    waterColumn,
    exerciseColumn,
    weightColumn,
    mealsColumn,
    symptomsColumn,
    moodColumn,
    glowUpColumn,
    supplementsColumn,
    dosesColumn,
  };

  SupabaseClient get _client => Supabase.instance.client;
  final ReviewPromptService _reviewPromptService;

  Future<void> resetUserData() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final storage = _client.storage.from(assetsBucket);
    final existingAssets = await storage.list(
      path: user.id,
      searchOptions: const SearchOptions(
        limit: 1000,
        offset: 0,
      ),
    );
    final assetPaths = existingAssets
        .map((object) => object.name)
        .where((name) => name.trim().isNotEmpty)
        .map((name) => '${user.id}/$name')
        .toList();

    if (assetPaths.isNotEmpty) {
      await storage.remove(assetPaths);
    }

    await _client.from('records').update({
      waterColumn: [],
      exerciseColumn: [],
      weightColumn: [],
      mealsColumn: [],
      symptomsColumn: [],
      moodColumn: [],
      glowUpColumn: [],
      supplementsColumn: [],
      dosesColumn: [],
    }).eq('user_id', user.id);
  }

  Future<void> uploadAssetBinary(
    String assetPath,
    Uint8List bytes, {
    required String contentType,
    bool upsert = false,
  }) async {
    if (assetPath.trim().isEmpty) {
      throw ArgumentError('assetPath cannot be empty.');
    }

    await _client.storage.from(assetsBucket).uploadBinary(
          assetPath,
          bytes,
          fileOptions: FileOptions(
            cacheControl: '3600',
            upsert: upsert,
            contentType: contentType,
          ),
        );
  }

  Future<void> updateRecord(
    String columnName,
    Map<String, dynamic> record,
  ) async {
    if (!_allowedColumns.contains(columnName)) {
      throw ArgumentError('Unsupported record column: $columnName');
    }

    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final normalized = _validateRecord(columnName, record);

    await _client.from('records').upsert({
      'user_id': user.id,
    }, onConflict: 'user_id');

    final existing = await _client
        .from('records')
        .select(columnName)
        .eq('user_id', user.id)
        .single();

    final currentValue = existing[columnName];
    final currentRecords = currentValue is List
        ? List<Map<String, dynamic>>.from(
            currentValue
                .map((entry) => Map<String, dynamic>.from(entry as Map)),
          )
        : <Map<String, dynamic>>[];

    final updatedRecords = [...currentRecords, normalized];

    await _client
        .from('records')
        .update({columnName: updatedRecords}).eq('user_id', user.id);

    await _reviewPromptService.registerSuccessfulLog();
    await _trackFirstCoreAction(
      userId: user.id,
      actionType: columnName,
      source: 'update_record',
    );
  }

  Future<void> updateRecordEntry(
    String columnName,
    String entryId,
    Map<String, dynamic> updatedData,
  ) async {
    if (!_allowedColumns.contains(columnName)) {
      throw ArgumentError('Unsupported record column: $columnName');
    }

    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final normalized =
        _validateRecord(columnName, {...updatedData, 'id': entryId});

    final existing = await _client
        .from('records')
        .select(columnName)
        .eq('user_id', user.id)
        .single();

    final currentRecords = List<Map<String, dynamic>>.from(
      (existing[columnName] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map)),
    );

    final updatedRecords =
        currentRecords.map((e) => e['id'] == entryId ? normalized : e).toList();

    await _client
        .from('records')
        .update({columnName: updatedRecords}).eq('user_id', user.id);

    await _trackFirstCoreAction(
      userId: user.id,
      actionType: glowUpColumn,
      source: 'upsert_glow_up_record',
    );
  }

  Future<void> deleteRecordEntry(
    String columnName,
    String entryId,
  ) async {
    if (!_allowedColumns.contains(columnName)) {
      throw ArgumentError('Unsupported record column: $columnName');
    }

    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existing = await _client
        .from('records')
        .select(columnName)
        .eq('user_id', user.id)
        .single();

    final currentRecords = List<Map<String, dynamic>>.from(
      (existing[columnName] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map)),
    );

    final updatedRecords =
        currentRecords.where((e) => e['id'] != entryId).toList();

    await _client
        .from('records')
        .update({columnName: updatedRecords}).eq('user_id', user.id);
  }

  Future<void> upsertGlowUpRecord(Map<String, dynamic> record) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final normalized = _validateGlowUpRecord(record);
    final dateKey = normalized['date'] as String;

    await _client.from('records').upsert({
      'user_id': user.id,
    }, onConflict: 'user_id');

    final existing = await _client
        .from('records')
        .select(glowUpColumn)
        .eq('user_id', user.id)
        .single();

    final currentRecords = List<Map<String, dynamic>>.from(
      (existing[glowUpColumn] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map)),
    );

    final index =
        currentRecords.indexWhere((entry) => entry['date'] == dateKey);
    if (index >= 0) {
      final existingId = currentRecords[index]['id'] as String?;
      currentRecords[index] = {
        ...normalized,
        'id': existingId ?? normalized['id'],
      };
    } else {
      currentRecords.add(normalized);
    }

    currentRecords.sort(
      (a, b) => (a['logged_at'] as String).compareTo(b['logged_at'] as String),
    );

    await _client
        .from('records')
        .update({glowUpColumn: currentRecords}).eq('user_id', user.id);
  }

  Future<List<Map<String, dynamic>>> loadTimeseries(
    String columnName,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (!_allowedColumns.contains(columnName)) {
      throw ArgumentError('Unsupported record column: $columnName');
    }
    if (!endDate.isAfter(startDate)) {
      throw ArgumentError('endDate must be after startDate.');
    }

    final response = await _client.rpc(
      'load_timeseries',
      params: {
        'p_column': columnName,
        'p_start': formatIsoWithTimezone(startDate.toLocal()),
        'p_end': formatIsoWithTimezone(endDate.toLocal()),
      },
    );

    if (response is! List) {
      return const [];
    }

    final entries = response
        .map(
          (row) => Map<String, dynamic>.from(
            (row as Map)['entry'] as Map,
          ),
        )
        .toList();

    // Supabase/PostgREST can silently cap RPC result sets at the project's
    // `max_rows` setting. When that happens on high-frequency datasets like
    // hydration logs, recent entries can be truncated out of the response.
    // Fall back to filtering the full stored JSON array client-side.
    if (entries.length >= 1000) {
      return _loadTimeseriesFromRecordsColumn(
        columnName,
        startDate,
        endDate,
      );
    }

    return entries;
  }

  Future<List<Map<String, dynamic>>> _loadTimeseriesFromRecordsColumn(
    String columnName,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existing = await _client
        .from('records')
        .select(columnName)
        .eq('user_id', user.id)
        .maybeSingle();
    final raw = existing?[columnName];
    final currentRecords = raw is List
        ? List<Map<String, dynamic>>.from(
            raw.map((entry) => Map<String, dynamic>.from(entry as Map)),
          )
        : <Map<String, dynamic>>[];

    final filtered = currentRecords.where((entry) {
      final rawLoggedAt = entry['logged_at'];
      if (rawLoggedAt is! String) return false;
      final loggedAt = DateTime.tryParse(rawLoggedAt);
      if (loggedAt == null) return false;
      return !loggedAt.isBefore(startDate) && loggedAt.isBefore(endDate);
    }).toList();

    filtered.sort(
      (a, b) => (a['logged_at'] as String).compareTo(b['logged_at'] as String),
    );
    return filtered;
  }

  Future<Map<String, dynamic>?> loadLatestRecord(String columnName) async {
    if (!_allowedColumns.contains(columnName)) {
      throw ArgumentError('Unsupported record column: $columnName');
    }

    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final response = await _client
        .from('records')
        .select(columnName)
        .eq('user_id', user.id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    final raw = response[columnName];
    if (raw is! List || raw.isEmpty) {
      return null;
    }

    final entries = raw
        .map((entry) => Map<String, dynamic>.from(entry as Map))
        .where((entry) => entry['logged_at'] is String)
        .toList()
      ..sort((a, b) =>
          (a['logged_at'] as String).compareTo(b['logged_at'] as String));

    return entries.isEmpty ? null : entries.last;
  }

  Map<String, dynamic> _validateRecord(
    String columnName,
    Map<String, dynamic> record,
  ) {
    return switch (columnName) {
      waterColumn => _validateWaterRecord(record),
      weightColumn => _validateWeightRecord(record),
      mealsColumn => _validateMealsRecord(record),
      dosesColumn => _validateDoseRecord(record),
      exerciseColumn => _validateExerciseRecord(record),
      symptomsColumn => _validateSymptomsRecord(record),
      moodColumn => _validateMoodRecord(record),
      glowUpColumn => _validateGlowUpRecord(record),
      supplementsColumn => _validateGenericTimedRecord(columnName, record),
      _ => throw ArgumentError('Unsupported record column: $columnName'),
    };
  }

  Map<String, dynamic> _validateWaterRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final quantity = record['quantity'];
    final unit = record['unit'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Water records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (quantity is! num || !quantity.isFinite || quantity <= 0) {
      throw ArgumentError('Water records require a positive numeric quantity.');
    }
    if (unit != 'ml') {
      throw ArgumentError('Water records must use the canonical ml unit.');
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'quantity': quantity,
      'unit': unit,
    };
  }

  Map<String, dynamic> _validateWeightRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final quantity = record['quantity'];
    final unit = record['unit'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Weight records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (quantity is! num || !quantity.isFinite || quantity <= 0) {
      throw ArgumentError(
          'Weight records require a positive numeric quantity.');
    }
    if (unit != 'kg' && unit != 'lb') {
      throw ArgumentError('Weight records must use either kg or lb.');
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'quantity': quantity,
      'unit': unit,
    };
  }

  Map<String, dynamic> _validateMealsRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final name = record['name'];
    final imagePath = record['image_path'];
    final calories = record['calories'];
    final carbs = record['carbs'];
    final proteins = record['proteins'];
    final fats = record['fats'];
    final fiber = record['fiber'];
    final consumed = record['consumed'] ?? 1.0;
    final notes = record['notes'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Meal records require a valid ISO-8601 logged_at string with timezone.',
      );
    }

    final numericFields = <String, dynamic>{
      'calories': calories,
      'carbs': carbs,
      'proteins': proteins,
      'fats': fats,
      'fiber': fiber,
    };

    if (numericFields.values
        .any((value) => value is! num || !value.isFinite || value < 0)) {
      throw ArgumentError(
        'Meal records require non-negative numeric values for all nutrition fields.',
      );
    }

    final hasAnyPositiveValue =
        numericFields.values.any((value) => (value as num) > 0);
    if (!hasAnyPositiveValue) {
      throw ArgumentError(
        'Meal records require at least one nutrition value greater than zero.',
      );
    }

    if (notes != null && notes is! String) {
      throw ArgumentError('Meal notes must be a string when provided.');
    }
    const allowedConsumedValues = [0.25, 0.5, 0.75, 1.0];
    if (consumed is! num ||
        !consumed.isFinite ||
        !allowedConsumedValues.contains(consumed.toDouble())) {
      throw ArgumentError(
        'Meal records require consumed to be one of 0.25, 0.5, 0.75, or 1.0.',
      );
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      if (name is String && name.trim().isNotEmpty) 'name': name.trim(),
      if (imagePath is String && imagePath.trim().isNotEmpty)
        'image_path': imagePath.trim(),
      ...numericFields,
      'consumed': consumed.toDouble(),
      'notes': (notes as String?)?.trim().isEmpty ?? true
          ? null
          : (notes as String).trim(),
    };
  }

  Map<String, dynamic> _validateDoseRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final createdAt = record['created_at'];
    final method = record['method'];
    final medication = record['medication'];
    final dose = record['dose'];
    final injectionSite = record['injection_site'];
    final notes = record['notes'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Dose records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (createdAt is! String || !isIsoWithTimezone(createdAt)) {
      throw ArgumentError(
        'Dose records require a valid ISO-8601 created_at string with timezone.',
      );
    }
    if (method != 'injection' && method != 'pill') {
      throw ArgumentError(
        'Dose records require method to be injection or pill.',
      );
    }
    if (medication is! String || medication.trim().isEmpty) {
      throw ArgumentError('Dose records require a non-empty medication.');
    }
    if (dose is! String || dose.trim().isEmpty) {
      throw ArgumentError('Dose records require a non-empty dose.');
    }
    if (method == 'injection') {
      if (injectionSite is! String ||
          !InjectionSiteCatalog.values.contains(injectionSite)) {
        throw ArgumentError(
          'Injection dose records require a valid injection_site.',
        );
      }
    } else if (injectionSite != null) {
      throw ArgumentError('Pill dose records must use a null injection_site.');
    }
    if (notes != null && notes is! String) {
      throw ArgumentError('Dose notes must be a string when provided.');
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'created_at': createdAt,
      'method': method,
      'medication': medication.trim(),
      'dose': dose.trim(),
      'injection_site': injectionSite,
      'notes': (notes as String?)?.trim().isEmpty ?? true
          ? null
          : (notes as String).trim(),
    };
  }

  Map<String, dynamic> _validateExerciseRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final activityType = record['activity_type'];
    final durationMinutes = record['duration_minutes'];
    final intensity = record['intensity'];
    final notes = record['notes'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Exercise records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (activityType is! String || activityType.trim().isEmpty) {
      throw ArgumentError(
        'Exercise records require a non-empty activity_type.',
      );
    }
    if (durationMinutes is! num ||
        !durationMinutes.isFinite ||
        durationMinutes <= 0) {
      throw ArgumentError(
        'Exercise records require a positive numeric duration_minutes.',
      );
    }
    if (intensity is! String ||
        !const {'light', 'moderate', 'intense'}.contains(intensity)) {
      throw ArgumentError(
        'Exercise records require intensity to be light, moderate, or intense.',
      );
    }
    if (notes != null && notes is! String) {
      throw ArgumentError('Exercise notes must be a string when provided.');
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'activity_type': activityType.trim(),
      'duration_minutes': durationMinutes,
      'intensity': intensity,
      'notes': (notes as String?)?.trim().isEmpty ?? true
          ? null
          : (notes as String).trim(),
    };
  }

  Map<String, dynamic> _validateSymptomsRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final symptoms = record['symptoms'];
    final severity = record['severity'];
    final notes = record['notes'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Symptom records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (severity is! String ||
        !const {'mild', 'moderate', 'severe'}.contains(severity)) {
      throw ArgumentError(
        'Symptom records require severity to be mild, moderate, or severe.',
      );
    }
    if (symptoms is! List) {
      throw ArgumentError('Symptom records require symptoms to be a list.');
    }
    final normalizedSymptoms = SymptomCatalog.normalizeValues(symptoms);
    if (normalizedSymptoms.length != symptoms.length) {
      throw ArgumentError(
        'Symptom records require all symptoms to use canonical values.',
      );
    }
    if (normalizedSymptoms.contains(SymptomCatalog.noSymptoms) &&
        normalizedSymptoms.length > 1) {
      throw ArgumentError(
        'Symptom records cannot mix no_symptoms with other symptom values.',
      );
    }
    if (notes != null && notes is! String) {
      throw ArgumentError('Symptom notes must be a string when provided.');
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'symptoms': normalizedSymptoms,
      'severity': severity,
      'notes': (notes as String?)?.trim().isEmpty ?? true
          ? null
          : (notes as String).trim(),
    };
  }

  Map<String, dynamic> _validateMoodRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final feeling = record['feeling'];
    final notes = record['notes'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Mood records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (feeling is! String ||
        !const {'great', 'good', 'okay', 'bad'}.contains(feeling)) {
      throw ArgumentError(
        'Mood records require feeling to be great, good, okay, or bad.',
      );
    }
    if (notes != null && notes is! String) {
      throw ArgumentError('Mood notes must be a string when provided.');
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'feeling': feeling,
      'notes': (notes as String?)?.trim().isEmpty ?? true
          ? null
          : (notes as String).trim(),
    };
  }

  Map<String, dynamic> _validateGlowUpRecord(Map<String, dynamic> record) {
    final id = record['id'] as String? ?? _uuid.v4();
    final loggedAt = record['logged_at'];
    final savedAt = record['saved_at'];
    final date = record['date'];
    final beforePath = record['before_path'];
    final afterPath = record['after_path'];
    final comparisonPath = record['comparison_path'];

    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        'Glow up records require a valid ISO-8601 logged_at string with timezone.',
      );
    }
    if (savedAt is! String || !isIsoWithTimezone(savedAt)) {
      throw ArgumentError(
        'Glow up records require a valid ISO-8601 saved_at string with timezone.',
      );
    }
    if (date is! String || !RegExp(r'^\d{8}$').hasMatch(date)) {
      throw ArgumentError('Glow up records require date in yyyyMMdd format.');
    }
    if (beforePath is! String || beforePath.trim().isEmpty) {
      throw ArgumentError('Glow up records require a non-empty before_path.');
    }
    if (afterPath is! String || afterPath.trim().isEmpty) {
      throw ArgumentError('Glow up records require a non-empty after_path.');
    }
    if (comparisonPath is! String || comparisonPath.trim().isEmpty) {
      throw ArgumentError(
        'Glow up records require a non-empty comparison_path.',
      );
    }

    return {
      'id': id,
      'logged_at': loggedAt,
      'date': date,
      'before_path': beforePath.trim(),
      'after_path': afterPath.trim(),
      'comparison_path': comparisonPath.trim(),
      'saved_at': savedAt,
    };
  }

  Map<String, dynamic> _validateGenericTimedRecord(
    String columnName,
    Map<String, dynamic> record,
  ) {
    final loggedAt = record['logged_at'];
    if (loggedAt is! String || !isIsoWithTimezone(loggedAt)) {
      throw ArgumentError(
        '$columnName records require a valid ISO-8601 logged_at string with timezone.',
      );
    }

    return {
      ...record,
      'logged_at': loggedAt,
    };
  }

  Future<void> _trackFirstCoreAction({
    required String userId,
    required String actionType,
    required String source,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'first_core_action_tracked_at_$userId';
      if (prefs.getString(key) != null) {
        return;
      }

      await FirebaseAnalytics.instance.logEvent(
        name: 'first_core_action',
        parameters: {
          'action_type': actionType,
          'source': source,
        },
      );
      await prefs.setString(key, DateTime.now().toUtc().toIso8601String());
    } catch (_) {
      // Best effort only. Core actions should still save if analytics fails.
    }
  }
}
