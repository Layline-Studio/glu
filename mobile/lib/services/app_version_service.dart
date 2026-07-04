import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_version_status.dart';

class AppVersionService {
  SupabaseClient get _client => Supabase.instance.client;

  Future<AppVersionStatus> checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version.trim();
    final platformKey = _platformKey;

    if (platformKey == null) {
      return AppVersionStatus.none(currentVersion: currentVersion);
    }

    final response = await _loadAppConfigRow();
    if (response == null) {
      return AppVersionStatus.none(currentVersion: currentVersion);
    }

    final row = Map<String, dynamic>.from(response);
    final latestVersion =
        (row['${platformKey}_latest_version'] as String?)?.trim();
    final minimumVersion =
        (row['${platformKey}_minimum_version'] as String?)?.trim();
    final storeUrl = (row['${platformKey}_store_url'] as String?)?.trim();

    final hasAnyConfigValue = <String?>[
      latestVersion,
      minimumVersion,
      storeUrl,
    ].any((value) => value != null && value.isNotEmpty);

    if (!hasAnyConfigValue) {
      return AppVersionStatus.none(currentVersion: currentVersion);
    }

    if (minimumVersion != null &&
        minimumVersion.isNotEmpty &&
        _compareVersions(currentVersion, minimumVersion) < 0) {
      return AppVersionStatus(
        kind: AppUpdatePromptKind.required,
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        minimumVersion: minimumVersion,
        storeUrl: storeUrl,
      );
    }

    return AppVersionStatus.none(currentVersion: currentVersion);
  }

  Future<Map<String, dynamic>?> _loadAppConfigRow() async {
    try {
      final response =
          await _client.from('app_config').select().limit(1).maybeSingle();
      return response == null ? null : Map<String, dynamic>.from(response);
    } on PostgrestException {
      return null;
    }
  }

  String? get _platformKey {
    if (kIsWeb) {
      return null;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
        return 'android';
      default:
        return null;
    }
  }

  int _compareVersions(String left, String right) {
    final leftParts = _parseVersion(left);
    final rightParts = _parseVersion(right);
    final maxLength = leftParts.length > rightParts.length
        ? leftParts.length
        : rightParts.length;
    for (var i = 0; i < maxLength; i++) {
      final leftPart = i < leftParts.length ? leftParts[i] : 0;
      final rightPart = i < rightParts.length ? rightParts[i] : 0;
      if (leftPart != rightPart) {
        return leftPart.compareTo(rightPart);
      }
    }
    return 0;
  }

  List<int> _parseVersion(String version) {
    return version
        .split('.')
        .map(
            (part) => int.tryParse(part.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0)
        .toList();
  }
}
