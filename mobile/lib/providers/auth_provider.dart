import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_config_provider.dart';
import 'deep_link_provider.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref);
});

final authSessionProvider = StreamProvider<Session?>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.hasSupabase) {
    return Stream.value(null);
  }

  final client = Supabase.instance.client;
  return Stream<Session?>.multi((controller) {
    Future(() => controller.add(client.auth.currentSession));
    final subscription = client.auth.onAuthStateChange.listen((event) {
      controller.add(event.session);
    });
    controller.onCancel = subscription.cancel;
  });
});

class AuthController {
  const AuthController(this.ref);

  final Ref ref;

  Future<bool> handleDeepLinkAuth() async {
    final deepLinkState = ref.read(deepLinkProvider);
    final code = deepLinkState.code;
    if (code == null || code.isEmpty) {
      ref.read(deepLinkProvider.notifier).setError(
            'Invalid authentication link. Please request a new one.',
          );
      return false;
    }

    ref.read(deepLinkProvider.notifier).startProcessing();
    try {
      await Supabase.instance.client.auth.exchangeCodeForSession(code);
      ref.read(deepLinkProvider.notifier).clearPendingAuth();
      return true;
    } catch (_) {
      ref.read(deepLinkProvider.notifier).setError(
            'Authentication failed. The link may have expired.',
          );
      return false;
    }
  }
}
