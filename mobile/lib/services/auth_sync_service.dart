import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'fcm_token_service.dart';
import 'revenuecat_service.dart';

class AuthSyncService {
  AuthSyncService({
    required SupabaseClient supabaseClient,
    required RevenueCatService revenueCatService,
    required FcmTokenService fcmTokenService,
  })  : _supabaseClient = supabaseClient,
        _revenueCatService = revenueCatService,
        _fcmTokenService = fcmTokenService;

  final SupabaseClient _supabaseClient;
  final RevenueCatService _revenueCatService;
  final FcmTokenService _fcmTokenService;

  StreamSubscription<AuthState>? _subscription;

  Future<void> start() async {
    _fcmTokenService.startRefreshListener();
    await _syncSession(_supabaseClient.auth.currentSession);
    _subscription = _supabaseClient.auth.onAuthStateChange.listen((event) {
      unawaited(_syncSession(event.session));
    });
  }

  Future<void> _syncSession(Session? session) async {
    final currentRevenueCatUserId = _revenueCatService.currentAppUserId;

    if (session == null) {
      if (currentRevenueCatUserId != null) {
        await _revenueCatService.logOut();
      }
      await _fcmTokenService.removeToken();
      return;
    }

    final userId = session.user.id;
    if (currentRevenueCatUserId == userId) {
      await _revenueCatService.refresh();
      await _fcmTokenService.registerToken();
      return;
    }

    await _revenueCatService.logIn(userId);
    await _revenueCatService.refresh();
    await _fcmTokenService.registerToken();
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    await _fcmTokenService.dispose();
  }
}
