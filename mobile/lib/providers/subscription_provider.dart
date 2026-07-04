import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../services/revenuecat_service.dart';
import 'auth_provider.dart';
import 'profile_provider.dart';
import 'revenuecat_provider.dart';

enum SubscriptionStatus { free, pro }

const debugSubscriptionOverrideKey = 'debug_subscription_override';

final subscriptionProvider = FutureProvider<SubscriptionStatus>((ref) async {
  final authSession = ref.watch(authSessionProvider).value;
  if (authSession == null) return SubscriptionStatus.free;
  final email = authSession.user.email?.trim().toLowerCase();
  final emailHasPro = email?.endsWith('@layline.ventures') ?? false;
  final isInternalUser = emailHasPro;

  final service = ref.read(revenueCatServiceProvider);
  final profile = await ref.read(profileBootstrapProvider.future).catchError(
        (_) => null,
      );
  final debugOverride =
      (profile?.settings[debugSubscriptionOverrideKey] as String?)
          ?.trim()
          .toLowerCase();
  if (isInternalUser && debugOverride == 'pro') {
    return SubscriptionStatus.pro;
  }
  if (isInternalUser && debugOverride == 'free') {
    return SubscriptionStatus.free;
  }

  final revenueCatHasPro = await service.checkProEntitlement().catchError(
        (_) => false,
      );
  final profileHasPro =
      profile?.subscriptionTier?.trim().toLowerCase() ==
      RevenueCatService.proEntitlementId;
  final hasPro = revenueCatHasPro || profileHasPro || emailHasPro;
  return hasPro ? SubscriptionStatus.pro : SubscriptionStatus.free;
});

final isProProvider = Provider<bool>((ref) {
  final status = ref.watch(subscriptionProvider);
  return status.maybeWhen(
    data: (value) => value == SubscriptionStatus.pro,
    orElse: () => false,
  );
});

final offeringsProvider = FutureProvider<Offerings?>((ref) async {
  final service = ref.read(revenueCatServiceProvider);
  return service.getOfferings();
});
