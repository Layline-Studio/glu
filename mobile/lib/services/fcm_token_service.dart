import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FcmTokenService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  StreamSubscription<String>? _refreshSubscription;

  SupabaseClient get _client => Supabase.instance.client;

  /// Register once at app start. Attaches the token-refresh listener for the
  /// lifetime of the app — independent of sign-in/sign-out cycles.
  void startRefreshListener() {
    _refreshSubscription?.cancel();
    _refreshSubscription =
        FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      final userId = _client.auth.currentUser?.id;
      if (userId != null) {
        await _upsert(userId, newToken);
      }
    });
  }

  /// Call whenever a user session becomes active (new login or app restart
  /// with existing session). Ensures the current token is stored.
  Future<void> registerToken() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    // On iOS, FCM needs APNs authorization before getToken() returns a value.
    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _upsert(userId, token);
    }
  }

  /// Call on sign-out to disassociate the device token from the user.
  Future<void> removeToken() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;

    await _client
        .from('device_fcm_tokens')
        .delete()
        .eq('user_id', userId)
        .eq('token', token);
  }

  Future<void> dispose() async {
    await _refreshSubscription?.cancel();
  }

  Future<void> _upsert(String userId, String token) async {
    final platform = await _resolvePlatform();
    if (platform == null) return;

    await _client.from('device_fcm_tokens').upsert(
      {
        'user_id': userId,
        'token': token,
        'platform': platform,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      },
      onConflict: 'user_id, token',
    );
  }

  Future<String?> _resolvePlatform() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        try {
          final info = await _deviceInfo.iosInfo;
          final version = info.systemVersion.trim();
          return version.isEmpty ? 'ios' : 'ios $version';
        } catch (_) {
          return 'ios';
        }
      case TargetPlatform.android:
        try {
          final info = await _deviceInfo.androidInfo;
          final version = info.version.release.trim();
          return version.isEmpty ? 'android' : 'android $version';
        } catch (_) {
          return 'android';
        }
      default:
        return null;
    }
  }
}
