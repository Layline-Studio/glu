import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/main_shell.dart';

const _homeRoute = 'home';
const _logRoute = 'log';
const _progressRoute = 'progress';
const _settingsRoute = 'settings';

// Tab indices must match the order in MainShell.
const _routeToTab = {
  _homeRoute: 0,
  _logRoute: 1,
  _progressRoute: 2,
  _settingsRoute: 3,
};

class NotificationRouterService {
  StreamSubscription<RemoteMessage>? _subscription;

  /// Call once inside MainShell.initState(), after the shell is mounted.
  /// Handles all three FCM tap scenarios:
  ///   - terminated: getInitialMessage()
  ///   - background tap: onMessageOpenedApp
  ///   - foreground tap: onMessage (requires a local notification bridge — skipped here)
  Future<void> start(WidgetRef ref) async {
    // Terminated: app launched by tapping a notification.
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      _navigate(ref, initial);
    }

    // Background: app was running but in background when notification was tapped.
    _subscription = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _navigate(ref, message);
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  void _navigate(WidgetRef ref, RemoteMessage message) {
    final route = message.data['route'] as String?;
    final tabIndex = _routeToTab[route];
    if (tabIndex != null) {
      ref.read(shellTabRequestProvider.notifier).request(tabIndex);
    }
  }
}
