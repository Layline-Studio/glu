import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_transaction_provider.dart';

class DeepLinkState {
  const DeepLinkState({
    this.pendingAuthUri,
    this.isProcessing = false,
    this.error,
  });

  final Uri? pendingAuthUri;
  final bool isProcessing;
  final String? error;

  DeepLinkState copyWith({
    Uri? pendingAuthUri,
    bool? isProcessing,
    String? error,
    bool clearPendingUri = false,
    bool clearError = false,
  }) {
    return DeepLinkState(
      pendingAuthUri:
          clearPendingUri ? null : (pendingAuthUri ?? this.pendingAuthUri),
      isProcessing: isProcessing ?? this.isProcessing,
      error: clearError ? null : (error ?? this.error),
    );
  }

  bool get hasPendingAuth => pendingAuthUri != null && !isProcessing;

  String? get code => pendingAuthUri?.queryParameters['code'];
}

final deepLinkProvider = NotifierProvider<DeepLinkNotifier, DeepLinkState>(
  DeepLinkNotifier.new,
);

class DeepLinkNotifier extends Notifier<DeepLinkState> {
  static const _customScheme = 'glu';
  static const _customHost = 'login-callback';
  static const _httpsScheme = 'https';
  static const _httpsHost = 'myglu.health';
  static const _httpsPath = '/signin-callback';

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  DateTime? _lastProcessedTime;
  DateTime? _pendingAuthTimestamp;
  bool _initialized = false;

  static const _staleLinkMinutes = 10;
  static const _debounceSeconds = 5;

  @override
  DeepLinkState build() {
    ref.onDispose(() {
      _linkSubscription?.cancel();
    });
    return const DeepLinkState();
  }

  Future<void> init() async {
    if (_initialized) {
      return;
    }
    _initialized = true;
    _clearStaleState();

    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleIncomingUri(initialUri);
      }
    } catch (_) {
      // No initial link available.
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      _handleIncomingUri,
      onError: (_) {
        state = state.copyWith(error: 'Failed to receive authentication link.');
      },
    );
  }

  bool _isAuthCallback(Uri uri) {
    final customSchemeMatch =
        uri.scheme == _customScheme && uri.host == _customHost;
    final httpsMatch = uri.scheme == _httpsScheme &&
        uri.host == _httpsHost &&
        uri.path == _httpsPath;
    return customSchemeMatch || httpsMatch;
  }

  void _clearStaleState() {
    if (_pendingAuthTimestamp == null) {
      return;
    }
    if (DateTime.now().difference(_pendingAuthTimestamp!).inMinutes >=
        _staleLinkMinutes) {
      _pendingAuthTimestamp = null;
      state = const DeepLinkState();
    }
  }

  void _handleIncomingUri(Uri uri) {
    if (!_isAuthCallback(uri) || state.isProcessing) {
      return;
    }

    final now = DateTime.now();
    if (_lastProcessedTime != null &&
        now.difference(_lastProcessedTime!) <
            const Duration(seconds: _debounceSeconds)) {
      return;
    }
    _lastProcessedTime = now;

    final code = uri.queryParameters['code'];
    if (code == null || code.isEmpty) {
      state = state.copyWith(
        error: 'Invalid authentication link. Please request a new one.',
        clearPendingUri: true,
      );
      return;
    }

    final callbackState = uri.queryParameters['state'] ?? '';
    unawaited(_validateAndStore(uri, callbackState));
  }

  Future<void> _validateAndStore(Uri uri, String callbackState) async {
    final valid = await ref.read(authTransactionProvider.notifier).validateAndConsume(
          callbackState,
          allowMissingStateForMagicLink: callbackState.isEmpty,
        );

    if (!valid) {
      state = state.copyWith(
        error: 'Sign-in link is invalid or has expired. Please try again.',
        clearPendingUri: true,
      );
      return;
    }

    _pendingAuthTimestamp = DateTime.now();
    state = state.copyWith(
      pendingAuthUri: uri,
      clearError: true,
    );
  }

  @visibleForTesting
  void handleCallbackUriForTest(Uri uri) => _handleIncomingUri(uri);

  void startProcessing() {
    state = state.copyWith(isProcessing: true);
  }

  void clearPendingAuth() {
    _pendingAuthTimestamp = null;
    state = state.copyWith(
      clearPendingUri: true,
      isProcessing: false,
      clearError: true,
    );
  }

  void setError(String error) {
    state = state.copyWith(
      error: error,
      isProcessing: false,
    );
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}
