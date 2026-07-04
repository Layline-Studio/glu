import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/profile_service.dart';
import 'revenuecat_provider.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  final revenueCatService = ref.read(revenueCatServiceProvider);
  return ProfileService(revenueCatService: revenueCatService);
});
