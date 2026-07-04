import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/analytics_service.dart';

final analyticsServiceSingleton = AnalyticsService();

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return analyticsServiceSingleton;
});
