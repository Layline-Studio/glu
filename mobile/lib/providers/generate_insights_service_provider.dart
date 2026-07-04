import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/generate_insights_service.dart';

final generateInsightsServiceProvider =
    Provider<GenerateInsightsService>((ref) {
  return GenerateInsightsService();
});
