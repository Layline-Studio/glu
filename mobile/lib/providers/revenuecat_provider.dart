import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/revenuecat_service.dart';

final revenueCatServiceSingleton = RevenueCatService();

final revenueCatServiceProvider = Provider<RevenueCatService>((ref) {
  return revenueCatServiceSingleton;
});
