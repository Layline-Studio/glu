import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_profile.dart';
import 'auth_provider.dart';
import 'profile_service_provider.dart';
import '../services/profile_service.dart';

final profileBootstrapProvider = FutureProvider<AppProfile?>((ref) async {
  final session = await ref.watch(authSessionProvider.future);
  if (session == null) {
    return null;
  }

  final service = ref.read(profileServiceProvider);
  try {
    return service.bootstrapProfile();
  } on StaleAuthSessionException {
    return null;
  }
});
