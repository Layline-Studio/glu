import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/l10n.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../providers/revenuecat_provider.dart';
import '../../theme/app_colors.dart';

enum PaywallOutcome {
  skipped,
  purchased,
  restored,
  alreadySubscribed,
}

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    super.key,
    this.onFinished,
    this.source = 'unknown',
    this.allowSystemDismiss = true,
  });

  final ValueChanged<PaywallOutcome>? onFinished;
  final String source;
  final bool allowSystemDismiss;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  static const _termsUrl = 'https://myglu.health/terms';
  static const _privacyUrl = 'https://myglu.health/privacy';

  int _selectedPlan = 1;
  bool _isPurchasing = false;
  bool _viewTracked = false;
  bool _itemListTracked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewTracked) {
      return;
    }
    _viewTracked = true;
    ref.read(analyticsServiceProvider).capture(
      eventName: 'paywall_viewed',
      properties: {
        'source': widget.source,
      },
    );
  }

  AnalyticsEventItem _analyticsItemForPackage(Package package) {
    return AnalyticsEventItem(
      itemId: package.storeProduct.identifier,
      itemName: package.storeProduct.title,
      itemCategory: 'subscription',
      itemVariant: package.packageType.name,
      price: package.storeProduct.price,
      currency: package.storeProduct.currencyCode,
      quantity: 1,
      parameters: {
        'package_id': package.identifier,
        'package_type': package.packageType.name,
        'source': widget.source,
      },
    );
  }

  List<AnalyticsEventItem> _analyticsItemsForPackages(_PaywallPackages packages) {
    final items = <AnalyticsEventItem>[];
    if (packages.monthly != null) {
      items.add(_analyticsItemForPackage(packages.monthly!));
    }
    if (packages.yearly != null) {
      items.add(_analyticsItemForPackage(packages.yearly!));
    }
    return items;
  }

  Future<void> _logFirebaseViewItemList(_PaywallPackages packages) async {
    try {
      await FirebaseAnalytics.instance.logViewItemList(
        itemListId: 'paywall_offerings',
        itemListName: 'Paywall offerings',
        items: _analyticsItemsForPackages(packages),
        parameters: {
          'source': widget.source,
        },
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  Future<void> _logFirebaseSelectItem(Package package) async {
    try {
      await FirebaseAnalytics.instance.logSelectItem(
        itemListId: 'paywall_offerings',
        itemListName: 'Paywall offerings',
        items: [_analyticsItemForPackage(package)],
        parameters: {
          'source': widget.source,
          'selected_plan_index': _selectedPlan,
          'package_id': package.identifier,
          'package_type': package.packageType.name,
        },
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  Map<String, Object> _firebasePurchaseParameters(Package package) {
    return {
      'source': widget.source,
      'package_id': package.identifier,
      'package_type': package.packageType.name,
      'store_product_id': package.storeProduct.identifier,
      'selected_plan_index': _selectedPlan,
    };
  }

  Future<void> _logFirebaseBeginCheckout(Package package) async {
    try {
      await FirebaseAnalytics.instance.logBeginCheckout(
        currency: package.storeProduct.currencyCode,
        value: package.storeProduct.price,
        items: [_analyticsItemForPackage(package)],
        parameters: _firebasePurchaseParameters(package),
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  Future<void> _logFirebasePurchase({
    required Package package,
    required PurchaseResult result,
  }) async {
    final transactionId = result.storeTransaction.transactionIdentifier;
    try {
      await FirebaseAnalytics.instance.logPurchase(
        currency: package.storeProduct.currencyCode,
        value: package.storeProduct.price,
        transactionId: transactionId.isEmpty ? null : transactionId,
        items: [_analyticsItemForPackage(package)],
        parameters: _firebasePurchaseParameters(package),
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  Future<void> _logFirebaseSubscriptionStarted(Package package) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: 'subscription_started',
        parameters: {
          'source': widget.source,
          'package_id': package.identifier,
          'package_type': package.packageType.name,
          'store_product_id': package.storeProduct.identifier,
          'has_trial': package.storeProduct.introductoryPrice != null,
        },
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  Future<void> _logFirebaseTrialStarted(Package package) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: 'trial_started',
        parameters: {
          'source': widget.source,
          'package_id': package.identifier,
          'package_type': package.packageType.name,
          'store_product_id': package.storeProduct.identifier,
        },
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  Future<void> _logFirebasePurchaseFailed({
    required Package package,
    required String errorCode,
    required bool cancelled,
  }) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: cancelled
            ? 'paywall_purchase_cancelled'
            : 'paywall_purchase_failed',
        parameters: {
          ..._firebasePurchaseParameters(package),
          'error_code': errorCode,
        },
      );
    } catch (_) {
      // Firebase logging should never block the purchase flow.
    }
  }

  _PaywallPackages _resolvePackages(Offerings? offerings) {
    final packages = offerings?.current?.availablePackages ?? const <Package>[];

    Package? firstOfType(PackageType type) {
      return packages.cast<Package?>().firstWhere(
            (p) => p?.packageType == type,
            orElse: () => null,
          );
    }

    final fallbackFirst = packages.isNotEmpty ? packages.first : null;
    final fallbackSecond = packages.length > 1 ? packages[1] : fallbackFirst;
    final monthly = firstOfType(PackageType.monthly) ?? fallbackFirst;
    final yearly = firstOfType(PackageType.annual) ??
        firstOfType(PackageType.sixMonth) ??
        fallbackSecond;

    return _PaywallPackages(
      all: packages,
      monthly: monthly,
      yearly: yearly,
    );
  }

  int? _discountPercent({
    required Package? monthly,
    required Package? yearly,
  }) {
    if (monthly == null || yearly == null) return null;

    final monthlyPrice = monthly.storeProduct.price;
    final yearlyPrice = yearly.storeProduct.price;
    final yearlyMonths = _billingMonths(yearly.packageType);
    if (monthlyPrice <= 0 || yearlyPrice <= 0 || yearlyMonths <= 0) {
      return null;
    }

    final fullPrice = monthlyPrice * yearlyMonths;
    final savings = fullPrice - yearlyPrice;
    if (savings <= 0) return null;

    final percent = ((savings / fullPrice) * 100).round();
    return percent > 0 ? percent : null;
  }

  int _billingMonths(PackageType packageType) {
    switch (packageType) {
      case PackageType.monthly:
        return 1;
      case PackageType.twoMonth:
        return 2;
      case PackageType.threeMonth:
        return 3;
      case PackageType.sixMonth:
        return 6;
      case PackageType.annual:
        return 12;
      default:
        return 12;
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    if (!mounted) return;
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.paywallCouldNotOpenLink)),
    );
  }

  void _finish(PaywallOutcome outcome) {
    ref.read(analyticsServiceProvider).capture(
      eventName: switch (outcome) {
        PaywallOutcome.skipped => 'paywall_skipped',
        PaywallOutcome.purchased => 'paywall_purchase_completed',
        PaywallOutcome.restored => 'paywall_restore_completed',
        PaywallOutcome.alreadySubscribed => 'paywall_already_subscribed',
      },
      properties: {
        'source': widget.source,
      },
    );
    widget.onFinished?.call(outcome);
    if (widget.onFinished == null && mounted) {
      Navigator.of(context).pop(
        outcome == PaywallOutcome.purchased ||
            outcome == PaywallOutcome.restored ||
            outcome == PaywallOutcome.alreadySubscribed,
      );
    }
  }

  Future<bool> _reconcileActiveEntitlement({
    required String packageId,
    required String packageType,
  }) async {
    final service = ref.read(revenueCatServiceProvider);
    try {
      final customerInfo = await service.getCustomerInfo();
      if (!mounted || !service.hasProEntitlement(customerInfo)) return false;

      ref.invalidate(subscriptionProvider);
      _finish(PaywallOutcome.alreadySubscribed);
      final l10n = context.l10n;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.paywallAlreadySubscribed)),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _handlePurchase(Package package) async {
    if (_isPurchasing) return;
    setState(() => _isPurchasing = true);
    ref.read(analyticsServiceProvider).capture(
      eventName: 'paywall_purchase_started',
      properties: {
        'source': widget.source,
        'package_id': package.identifier,
        'package_type': package.packageType.name,
        'store_product_id': package.storeProduct.identifier,
        'selected_plan_index': _selectedPlan,
      },
    );
    await _logFirebaseBeginCheckout(package);

    try {
      final service = ref.read(revenueCatServiceProvider);
      final result = await service.purchasePackage(package);

      if (!mounted) return;

      final purchasedCustomerInfo = result?.customerInfo;
      if (purchasedCustomerInfo != null &&
          service.hasProEntitlement(purchasedCustomerInfo)) {
        await _logFirebasePurchase(package: package, result: result!);
        await _logFirebaseSubscriptionStarted(package);
        if (package.storeProduct.introductoryPrice != null) {
          await _logFirebaseTrialStarted(package);
        }
        if (!mounted) return;
        ref.invalidate(subscriptionProvider);
        _finish(PaywallOutcome.purchased);
        final l10n = context.l10n;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paywallPurchaseSuccess)),
        );
        return;
      }

      final l10n = context.l10n;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.paywallPurchaseIncomplete)),
      );
    } on PurchasesErrorCode catch (e) {
      ref.read(analyticsServiceProvider).capture(
        eventName: e == PurchasesErrorCode.purchaseCancelledError
            ? 'paywall_purchase_cancelled'
            : 'paywall_purchase_failed',
        properties: {
          'source': widget.source,
          'package_id': package.identifier,
          'package_type': package.packageType.name,
          'error_code': e.name,
        },
      );
      await _logFirebasePurchaseFailed(
        package: package,
        errorCode: e.name,
        cancelled: e == PurchasesErrorCode.purchaseCancelledError,
      );
      if (!mounted) return;
      final reconciled = e == PurchasesErrorCode.purchaseCancelledError
          ? false
          : await _reconcileActiveEntitlement(
              packageId: package.identifier,
              packageType: package.packageType.name,
            );
      if (reconciled || !mounted) return;
      if (e != PurchasesErrorCode.purchaseCancelledError) {
        final l10n = context.l10n;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paywallPurchaseFailedWithCode(e.name))),
        );
      }
    } catch (_) {
      ref.read(analyticsServiceProvider).capture(
        eventName: 'paywall_purchase_failed',
        properties: {
          'source': widget.source,
          'package_id': package.identifier,
          'package_type': package.packageType.name,
          'error_code': 'unknown',
        },
      );
      await _logFirebasePurchaseFailed(
        package: package,
        errorCode: 'unknown',
        cancelled: false,
      );
      if (!mounted) return;
      final reconciled = await _reconcileActiveEntitlement(
        packageId: package.identifier,
        packageType: package.packageType.name,
      );
      if (reconciled || !mounted) return;
      final l10n = context.l10n;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.paywallPurchaseFailed)),
      );
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  Future<void> _handleRestore() async {
    if (_isPurchasing) return;
    setState(() => _isPurchasing = true);
    final l10n = context.l10n;
    ref.read(analyticsServiceProvider).capture(
      eventName: 'paywall_restore_started',
      properties: {
        'source': widget.source,
      },
    );

    try {
      final service = ref.read(revenueCatServiceProvider);
      final customerInfo = await service.restorePurchases();

      if (!mounted) return;

      if (service.hasProEntitlement(customerInfo)) {
        ref.invalidate(subscriptionProvider);
        _finish(PaywallOutcome.restored);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paywallRestoreSuccess)),
        );
      } else {
        ref.read(analyticsServiceProvider).capture(
          eventName: 'paywall_restore_no_subscription',
          properties: {
            'source': widget.source,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.paywallRestoreNoSubscription)),
        );
      }
    } catch (_) {
      ref.read(analyticsServiceProvider).capture(
        eventName: 'paywall_restore_failed',
        properties: {
          'source': widget.source,
        },
      );
      if (!mounted) return;
      final l10n = context.l10n;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.paywallRestoreFailed)),
      );
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final offeringsAsync = ref.watch(offeringsProvider);

    return PopScope(
      canPop: widget.allowSystemDismiss && !_isPurchasing,
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          bottom: false,
          child: offeringsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  '$error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (offerings) {
              final packages = _resolvePackages(offerings);
              if (!_itemListTracked) {
                _itemListTracked = true;
                unawaited(_logFirebaseViewItemList(packages));
              }
              final selectedPackage =
                  _selectedPlan == 0 ? packages.monthly : packages.yearly;
              final monthlyPrice =
                  packages.monthly?.storeProduct.priceString ?? '\$4.99';
              final yearlyPrice =
                  packages.yearly?.storeProduct.priceString ?? '\$44.99';
              final yearlyDiscount = _discountPercent(
                monthly: packages.monthly,
                yearly: packages.yearly,
              );

              return LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxHeight < 820;
                  final stickyHeight = compact ? 290.0 : 320.0;
                  final contentMaxWidth =
                      constraints.maxWidth >= 768 ? 560.0 : 640.0;

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: _isPurchasing
                                      ? null
                                      : () => _finish(PaywallOutcome.skipped),
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: colors.textSecondary
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  padding: EdgeInsets.fromLTRB(
                                    20,
                                    8,
                                    20,
                                    stickyHeight + 32,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: compact ? 118 : 128,
                                        child: Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: compact ? 92 : 100,
                                                height: compact ? 92 : 100,
                                                decoration: BoxDecoration(
                                                  color: colors.surface,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  border: Border.all(
                                                    color: colors.lineSubtle,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.05),
                                                      blurRadius: 14,
                                                      offset:
                                                          const Offset(0, 6),
                                                    ),
                                                  ],
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image.asset(
                                                  'assets/icons/app_icon.png',
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        l10n.paywallTitle,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        l10n.paywallSubtitle,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _BenefitCard(colors: colors),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: stickyHeight - 56,
                                  child: IgnorePointer(
                                    child: Container(
                                      height: 72,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            colors.canvas.withValues(alpha: 0),
                                            colors.canvas
                                                .withValues(alpha: 0.96),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    color: colors.canvas,
                                    padding: EdgeInsets.fromLTRB(
                                      20,
                                      compact ? 12 : 14,
                                      20,
                                      compact ? 18 : 24,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Divider(
                                            color: colors.lineSubtle
                                                .withValues(alpha: 0.6),
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(height: compact ? 16 : 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: _PlanTile(
                                                title: l10n.paywallMonthlyTitle,
                                                subtitle:
                                                    l10n.paywallMonthlySubtitle,
                                                price: monthlyPrice,
                                                period: '/mo',
                                                selected: _selectedPlan == 0,
                                                compact: compact,
                                                onTap: _isPurchasing
                                                    ? null
                                                    : () {
                                                        setState(() =>
                                                            _selectedPlan = 0);
                                                        if (packages.monthly !=
                                                            null) {
                                                          unawaited(
                                                            _logFirebaseSelectItem(
                                                              packages.monthly!,
                                                            ),
                                                          );
                                                        }
                                                      },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: _PlanTile(
                                                title: l10n.paywallYearlyTitle,
                                                subtitle:
                                                    l10n.paywallYearlySubtitle,
                                                price: yearlyPrice,
                                                period: '/yr',
                                                selected: _selectedPlan == 1,
                                                compact: compact,
                                                badge: yearlyDiscount == null
                                                    ? null
                                                    : l10n.paywallSavePercent(
                                                        yearlyDiscount,
                                                      ),
                                                onTap: _isPurchasing
                                                    ? null
                                                    : () {
                                                        setState(() =>
                                                            _selectedPlan = 1);
                                                        if (packages.yearly !=
                                                            null) {
                                                          unawaited(
                                                            _logFirebaseSelectItem(
                                                              packages.yearly!,
                                                            ),
                                                          );
                                                        }
                                                      },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: compact ? 14 : 18),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.shield_outlined,
                                              size: compact ? 14 : 16,
                                              color: colors.textSecondary,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              l10n.paywallNoCommitment,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: colors.textSecondary,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                l10n.paywallSeparator,
                                                style: theme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              l10n.paywallCancelAnytime,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: colors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        SizedBox(
                                          width: double.infinity,
                                          height: compact ? 54 : 60,
                                          child: FilledButton(
                                            onPressed: _isPurchasing ||
                                                    selectedPackage == null
                                                ? null
                                                : () => _handlePurchase(
                                                    selectedPackage),
                                            child: _isPurchasing
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(l10n.paywallContinue),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: _isPurchasing
                                                  ? null
                                                  : _handleRestore,
                                              child: Text(
                                                l10n.paywallRestore,
                                                style: theme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text(
                                                l10n.paywallSeparator,
                                                style: theme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => _openUrl(_termsUrl),
                                              child: Text(
                                                l10n.paywallTerms,
                                                style: theme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text(
                                                l10n.paywallSeparator,
                                                style: theme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  _openUrl(_privacyUrl),
                                              child: Text(
                                                l10n.paywallPrivacy,
                                                style: theme
                                                    .textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final benefits = <({IconData icon, String label})>[
      (
        icon: Icons.notifications_active_outlined,
        label: l10n.paywallBenefitReminders,
      ),
      (
        icon: Icons.share_rounded,
        label: l10n.paywallBenefitShareProgress,
      ),
      (
        icon: Icons.show_chart_rounded,
        label: l10n.paywallBenefitSpotRegain,
      ),
      (
        icon: Icons.track_changes_rounded,
        label: l10n.paywallBenefitInsights,
      ),
      (
        icon: Icons.dashboard_outlined,
        label: l10n.paywallBenefitWeeklyGoals,
      ),
      (
        icon: Icons.bolt_rounded,
        label: l10n.paywallBenefitHealthyHabits,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        children: [
          for (var i = 0; i < benefits.length; i++) ...[
            Row(
              children: [
                Icon(
                  benefits[i].icon,
                  size: 18,
                  color: colors.textPrimary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    benefits[i].label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            if (i != benefits.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  static const _accentBlue = Color(0xFF5B8CFF);

  const _PlanTile({
    required this.title,
    required this.price,
    required this.period,
    required this.compact,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.badge,
  });

  final String title;
  final String price;
  final String period;
  final bool compact;
  final bool selected;
  final VoidCallback? onTap;
  final String? subtitle;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 12 : 18,
              vertical: compact ? 14 : 18,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? _accentBlue.withValues(alpha: 0.08)
                  : colors.surface,
              borderRadius: BorderRadius.circular(compact ? 16 : 20),
              border: Border.all(
                color: selected ? _accentBlue : colors.lineSubtle,
                width: selected ? 1.5 : 1,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: _accentBlue.withValues(alpha: 0.14),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: compact ? 4 : 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      period,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (subtitle != null) ...[
                  SizedBox(height: compact ? 4 : 6),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      fontSize: compact ? 11 : null,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _accentBlue,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badge!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PaywallPackages {
  const _PaywallPackages({
    required this.all,
    required this.monthly,
    required this.yearly,
  });

  final List<Package> all;
  final Package? monthly;
  final Package? yearly;
}
