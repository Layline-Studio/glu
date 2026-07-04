import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/record_service.dart';
import 'record_service_provider.dart';

/// Today's logged meal entries. Shared across the home screen and any
/// feature that needs a live view of today's intake (e.g. Portion Check).
final todayMealsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final service = ref.read(recordServiceProvider);
  final start = DateUtils.dateOnly(DateTime.now());
  final end = start.add(const Duration(days: 1));
  return service.loadTimeseries(RecordService.mealsColumn, start, end);
});

/// Total calories consumed today, weighted by each meal's portion fraction.
int computeConsumedCalories(List<Map<String, dynamic>> meals) {
  var total = 0.0;
  for (final m in meals) {
    final cals = (m['calories'] as num?)?.toDouble() ?? 0;
    final portion =
        ((m['consumed'] as num?)?.toDouble() ?? 1.0).clamp(0.0, 1.0);
    total += cals * portion;
  }
  return total.round();
}
