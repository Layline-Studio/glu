import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

import '../l10n/l10n.dart';
import '../config/app_config.dart';
import '../providers/revenuecat_provider.dart';
import '../services/revenuecat_service.dart';

class SubscriptionDebugScreen extends ConsumerStatefulWidget {
  const SubscriptionDebugScreen({super.key, required this.config});

  final AppConfig config;

  @override
  ConsumerState<SubscriptionDebugScreen> createState() =>
      _SubscriptionDebugScreenState();
}

class _SubscriptionDebugScreenState
    extends ConsumerState<SubscriptionDebugScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(revenueCatServiceProvider).configure(widget.config);
    });
  }

  @override
  Widget build(BuildContext context) {
    final revenueCat = ref.watch(revenueCatServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.subscriptionDebugTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _StatusCard(
            revenueCat: revenueCat,
            config: widget.config,
          ),
          const SizedBox(height: 16),
          _PackageCard(
            title: context.l10n.subscriptionDebugMonthly,
            package: revenueCat.monthlyPackage,
            onPressed: revenueCat.isBusy
                ? null
                : () => revenueCat.purchaseMonthly(),
          ),
          const SizedBox(height: 12),
          _PackageCard(
            title: context.l10n.subscriptionDebugYearly,
            package: revenueCat.yearlyPackage,
            onPressed: revenueCat.isBusy
                ? null
                : () => revenueCat.purchaseYearly(),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(
                onPressed: revenueCat.isBusy ? null : revenueCat.refresh,
                child: Text(context.l10n.subscriptionDebugRefreshCustomerInfo),
              ),
              FilledButton(
                onPressed: revenueCat.isBusy
                    ? null
                    : revenueCat.presentPaywallIfNeeded,
                child: Text(context.l10n.subscriptionDebugPresentPaywall),
              ),
              OutlinedButton(
                onPressed: revenueCat.isBusy
                    ? null
                    : revenueCat.presentCustomerCenter,
                child: Text(context.l10n.subscriptionDebugOpenCustomerCenter),
              ),
              OutlinedButton(
                onPressed: revenueCat.isBusy
                    ? null
                    : revenueCat.restorePurchases,
                child: Text(context.l10n.subscriptionDebugRestorePurchases),
              ),
              OutlinedButton(
                onPressed: revenueCat.isBusy ? null : revenueCat.syncPurchases,
                child: Text(context.l10n.subscriptionDebugSyncPurchases),
              ),
            ],
          ),
          if (revenueCat.lastError != null) ...[
            const SizedBox(height: 16),
            Text(
              revenueCat.lastError!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.revenueCat, required this.config});

  final RevenueCatService revenueCat;
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    final entitlement = revenueCat.gluProEntitlement;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.subscriptionDebugRevenuecatStatus),
            const SizedBox(height: 12),
            Text('${context.l10n.subscriptionDebugConfigured}: ${revenueCat.isConfigured}'),
            Text('${context.l10n.subscriptionDebugBusy}: ${revenueCat.isBusy}'),
            Text('${context.l10n.subscriptionDebugAppUserId}: ${revenueCat.currentAppUserId ?? context.l10n.subscriptionDebugAnonymous}'),
            Text('${context.l10n.subscriptionDebugApiKeyAvailable}: ${config.hasRevenueCat}'),
            Text('${context.l10n.subscriptionDebugGluProActive}: ${revenueCat.hasGluPro}'),
            Text(
              '${context.l10n.subscriptionDebugActiveSubscriptions}: '
              '${revenueCat.customerInfo?.activeSubscriptions.join(', ') ?? '-'}',
            ),
            Text(
              '${context.l10n.subscriptionDebugManagementUrl}: '
              '${revenueCat.customerInfo?.managementURL ?? '-'}',
            ),
            if (entitlement != null) ...[
              Text('${context.l10n.subscriptionDebugEntitlementProduct}: ${entitlement.productIdentifier}'),
              Text('${context.l10n.subscriptionDebugWillRenew}: ${entitlement.willRenew}'),
              Text('${context.l10n.subscriptionDebugExpiration}: ${entitlement.expirationDate ?? context.l10n.subscriptionDebugLifetime}'),
            ],
          ],
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.title,
    required this.package,
    required this.onPressed,
  });

  final String title;
  final Package? package;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final storeProduct = package?.storeProduct;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 8),
            Text('${context.l10n.subscriptionDebugPackageFound}: ${package != null}'),
            Text('${context.l10n.subscriptionDebugProductId}: ${storeProduct?.identifier ?? '-'}'),
            Text('${context.l10n.subscriptionDebugTitleLabel}: ${storeProduct?.title ?? '-'}'),
            Text('${context.l10n.subscriptionDebugPrice}: ${storeProduct?.priceString ?? '-'}'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: package == null ? null : onPressed,
              child: Text(context.l10n.subscriptionDebugPurchase(title)),
            ),
          ],
        ),
      ),
    );
  }
}
