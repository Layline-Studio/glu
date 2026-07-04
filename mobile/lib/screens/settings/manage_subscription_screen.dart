import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';
import '../../providers/profile_provider.dart';
import '../../providers/revenuecat_provider.dart';
import '../../providers/subscription_provider.dart';
import '../payment/payment_screen.dart';
import '../../theme/app_colors.dart';

class ManageSubscriptionScreen extends ConsumerStatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  ConsumerState<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState
    extends ConsumerState<ManageSubscriptionScreen> {
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(revenueCatServiceProvider).refresh());
  }

  Future<void> _runAction(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
      ref.invalidate(subscriptionProvider);
      ref.invalidate(profileBootstrapProvider);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _openStoreSettings(String url) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final revenueCat = ref.read(revenueCatServiceProvider);
      await revenueCat.presentCustomerCenter();
      await revenueCat.refresh();
      ref.invalidate(subscriptionProvider);
      ref.invalidate(profileBootstrapProvider);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final revenueCat = ref.watch(revenueCatServiceProvider);
    final subscriptionStatus = ref.watch(subscriptionProvider);
    final isPro = subscriptionStatus.maybeWhen(
      data: (status) => status == SubscriptionStatus.pro,
      orElse: () => false,
    );
    final entitlement = revenueCat.gluProEntitlement;
    final customerInfo = revenueCat.customerInfo;
    final activeSubscription =
        customerInfo?.activeSubscriptions.isNotEmpty == true
            ? customerInfo!.activeSubscriptions.first
            : null;
    final renewalCopy = _renewalCopy(context.l10n, entitlement);

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        backgroundColor: colors.canvas,
        elevation: 0,
        centerTitle: true,
        title: Text(context.l10n.manageSubscriptionTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.lineSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.accentButter,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isPro
                                ? context.l10n.manageSubscriptionProPlan
                                : context.l10n.manageSubscriptionFreePlan,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            isPro
                                ? context.l10n.manageSubscriptionActiveCopy
                                : context.l10n.manageSubscriptionUpgradeCopy,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _SubscriptionFactRow(
                  label: context.l10n.manageSubscriptionPlan,
                  value: isPro
                      ? context.l10n.manageSubscriptionPro
                      : context.l10n.manageSubscriptionFree,
                ),
                if (activeSubscription != null)
                  _SubscriptionFactRow(
                    label: context.l10n.manageSubscriptionProduct,
                    value: activeSubscription,
                  ),
                if (renewalCopy != null)
                  _SubscriptionFactRow(
                    label: context.l10n.manageSubscriptionRenewal,
                    value: renewalCopy,
                  ),
                _SubscriptionFactRow(
                  label: context.l10n.manageSubscriptionStatus,
                  value: isPro
                      ? context.l10n.manageSubscriptionStatusActive
                      : context.l10n.manageSubscriptionStatusInactive,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _busy || revenueCat.isBusy
                        ? null
                        : () async {
                            if (isPro) {
                              await _runAction(() async {
                                await revenueCat.presentCustomerCenter();
                              });
                              return;
                            }
                            if (!mounted) return;
                            await Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const PaymentScreen(
                                  source: 'manage_subscription',
                                ),
                              ),
                            );
                          },
                    child: Text(
                      isPro
                          ? context.l10n.manageSubscriptionManageButton
                          : context.l10n.manageSubscriptionUpgradeButton,
                    ),
                  ),
                ),
                if (customerInfo?.managementURL case final url?)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _busy ? null : () => _openStoreSettings(url),
                        child: Text(
                          context.l10n
                              .manageSubscriptionOpenStoreSubscriptionSettings,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _busy || revenueCat.isBusy
                        ? null
                        : () => _runAction(() async {
                              await revenueCat.restorePurchases();
                            }),
                    child: Text(context.l10n.manageSubscriptionRestorePurchases),
                  ),
                ),
                if (revenueCat.lastError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    revenueCat.lastError!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFBF3B36),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _renewalCopy(AppLocalizations l10n, dynamic entitlement) {
    if (entitlement == null) return null;
    final rawExpiration = entitlement.expirationDate;
    final expiration = switch (rawExpiration) {
      final DateTime value => value,
      final String value => DateTime.tryParse(value),
      _ => null,
    };
    if (expiration == null) {
      return entitlement.willRenew == true
          ? context.l10n.manageSubscriptionRenewsAutomatically
          : context.l10n.manageSubscriptionLifetime;
    }

    final formatted = DateFormat('EEE, MMM d').format(expiration.toLocal());
    if (entitlement.willRenew == true) {
      return context.l10n.manageSubscriptionRenewsOn(formatted);
    }
    return context.l10n.manageSubscriptionExpiresOn(formatted);
  }
}

class _SubscriptionFactRow extends StatelessWidget {
  const _SubscriptionFactRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
