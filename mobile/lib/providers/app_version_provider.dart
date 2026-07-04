import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_version_status.dart';
import '../services/app_version_service.dart';

final appVersionServiceProvider = Provider<AppVersionService>((ref) {
  return AppVersionService();
});

final appVersionStatusProvider = FutureProvider<AppVersionStatus>((ref) async {
  final service = ref.read(appVersionServiceProvider);
  return service.checkVersion();
});
