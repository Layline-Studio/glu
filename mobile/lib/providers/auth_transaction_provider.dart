import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_transaction.dart';

const _pendingAuthTransactionKey = 'pending_auth_transaction';

final authTransactionProvider =
    NotifierProvider<AuthTransactionNotifier, PendingAuthTransaction?>(
  AuthTransactionNotifier.new,
);

class AuthTransactionNotifier extends Notifier<PendingAuthTransaction?> {
  late final Future<void> _loadFuture;

  @override
  PendingAuthTransaction? build() {
    _loadFuture = _loadFromPrefs();
    return null;
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final transaction =
          PendingAuthTransaction.tryDecode(prefs.getString(_pendingAuthTransactionKey));
      if (transaction == null) {
        return;
      }
      if (transaction.isExpired) {
        await prefs.remove(_pendingAuthTransactionKey);
        return;
      }
      state = transaction;
    } catch (_) {
      // Best effort only.
    }
  }

  Future<String> createTransaction(AuthMethod method) async {
    final transaction = PendingAuthTransaction(
      state: PendingAuthTransaction.generateState(),
      createdAt: DateTime.now(),
      method: method,
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_pendingAuthTransactionKey, transaction.encode());
    } catch (_) {
      // Best effort only.
    }

    state = transaction;
    return transaction.state;
  }

  Future<bool> validateAndConsume(
    String callbackState, {
    bool allowMissingStateForMagicLink = false,
  }) async {
    await _loadFuture;
    final transaction = state;
    if (transaction == null) {
      return false;
    }
    if (transaction.isExpired) {
      await clearTransaction();
      return false;
    }
    if (callbackState.isEmpty &&
        allowMissingStateForMagicLink &&
        transaction.method == AuthMethod.magicLink) {
      await clearTransaction();
      return true;
    }
    if (transaction.state != callbackState) {
      return false;
    }
    await clearTransaction();
    return true;
  }

  Future<void> clearTransaction() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingAuthTransactionKey);
    } catch (_) {
      // Best effort only.
    }
    state = null;
  }
}
