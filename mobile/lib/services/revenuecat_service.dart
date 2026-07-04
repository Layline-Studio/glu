import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../config/app_config.dart';

class RevenueCatService extends ChangeNotifier {
  static const proEntitlementId = 'Glu Pro';
  static const monthlyProductId = 'glu_pro_monthly';
  static const yearlyProductId = 'glu_pro_yearly';

  bool _isConfigured = false;
  bool _isBusy = false;
  String? _lastError;
  CustomerInfo? _customerInfo;
  Offerings? _offerings;
  String? _currentAppUserId;

  late final CustomerInfoUpdateListener _customerInfoListener =
      _handleCustomerInfoUpdated;

  bool get isConfigured => _isConfigured;
  bool get isBusy => _isBusy;
  String? get lastError => _lastError;
  CustomerInfo? get customerInfo => _customerInfo;
  Offerings? get offerings => _offerings;
  String? get currentAppUserId => _currentAppUserId;
  String? get activeEntitlementIdentifier {
    final active = _customerInfo?.entitlements.active;
    if (active == null || active.isEmpty) {
      return null;
    }
    return active.keys.first;
  }

  bool get hasGluPro => _hasProEntitlement(_customerInfo);

  EntitlementInfo? get gluProEntitlement =>
      _customerInfo?.entitlements.active[proEntitlementId];

  Offering? get currentOffering => _offerings?.current;

  Package? get monthlyPackage =>
      _findPackageByProductId(monthlyProductId) ?? currentOffering?.monthly;

  Package? get yearlyPackage =>
      _findPackageByProductId(yearlyProductId) ?? currentOffering?.annual;

  bool hasProEntitlement([CustomerInfo? customerInfo]) {
    return _hasProEntitlement(customerInfo ?? _customerInfo);
  }

  Future<bool> checkProEntitlement() async {
    if (!_isConfigured) {
      return false;
    }
    final info = await getCustomerInfo();
    return hasProEntitlement(info);
  }

  Future<CustomerInfo> getCustomerInfo() async {
    if (!_isConfigured) {
      throw StateError('RevenueCat is not configured yet.');
    }
    final info = await Purchases.getCustomerInfo();
    _customerInfo = info;
    _lastError = null;
    notifyListeners();
    return info;
  }

  Future<Offerings?> getOfferings() async {
    if (!_isConfigured) {
      throw StateError('RevenueCat is not configured yet.');
    }
    final offerings = await Purchases.getOfferings();
    _offerings = offerings;
    _lastError = null;
    notifyListeners();
    return offerings;
  }

  Future<void> configure(AppConfig config, {String? appUserId}) async {
    if (_isConfigured) {
      await refresh();
      return;
    }

    final apiKey = _resolveApiKey(config);
    if (apiKey.isEmpty) {
      _lastError = 'RevenueCat API key is missing.';
      notifyListeners();
      return;
    }

    _setBusy(true);
    try {
      await Purchases.setLogLevel(
        kDebugMode ? LogLevel.debug : LogLevel.info,
      );
      final purchasesConfig = PurchasesConfiguration(apiKey)
        ..appUserID = appUserId
        ..entitlementVerificationMode =
            EntitlementVerificationMode.informational;
      await Purchases.configure(purchasesConfig);
      Purchases.addCustomerInfoUpdateListener(_customerInfoListener);
      _isConfigured = true;
      _currentAppUserId = appUserId;
      _lastError = null;
      await refresh();
    } catch (error) {
      _lastError = _formatError(error);
    } finally {
      _setBusy(false);
    }
  }

  Future<void> refresh() async {
    if (!_isConfigured) {
      return;
    }

    _setBusy(true);
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      _offerings = await Purchases.getOfferings();
      _lastError = null;
    } catch (error) {
      _lastError = _formatError(error);
    } finally {
      _setBusy(false);
    }
  }

  Future<PurchaseResult?> purchaseMonthly() async {
    final package = monthlyPackage;
    if (package == null) {
      _lastError = 'Monthly package is not configured in the current offering.';
      notifyListeners();
      return null;
    }
    return purchasePackage(package);
  }

  Future<PurchaseResult?> purchaseYearly() async {
    final package = yearlyPackage;
    if (package == null) {
      _lastError = 'Yearly package is not configured in the current offering.';
      notifyListeners();
      return null;
    }
    return purchasePackage(package);
  }

  Future<PurchaseResult?> purchasePackage(Package package) async {
    if (!_isConfigured) {
      _lastError = 'RevenueCat is not configured yet.';
      notifyListeners();
      return null;
    }

    _setBusy(true);
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      _customerInfo = result.customerInfo;
      _lastError = null;
      notifyListeners();
      return result;
    } on PlatformException catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
      return null;
    } finally {
      _setBusy(false);
    }
  }

  Future<CustomerInfo?> restorePurchases() async {
    if (!_isConfigured) {
      _lastError = 'RevenueCat is not configured yet.';
      notifyListeners();
      return null;
    }

    _setBusy(true);
    try {
      final info = await Purchases.restorePurchases();
      _customerInfo = info;
      _lastError = null;
      notifyListeners();
      return info;
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
      return null;
    } finally {
      _setBusy(false);
    }
  }

  Future<PaywallResult> presentPaywall() async {
    if (!_isConfigured) {
      _lastError = 'RevenueCat is not configured yet.';
      notifyListeners();
      return PaywallResult.error;
    }

    try {
      final result = await RevenueCatUI.presentPaywall(
        offering: currentOffering,
        displayCloseButton: true,
      );
      await refresh();
      return result;
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
      return PaywallResult.error;
    }
  }

  Future<PaywallResult> presentPaywallIfNeeded() async {
    if (!_isConfigured) {
      _lastError = 'RevenueCat is not configured yet.';
      notifyListeners();
      return PaywallResult.error;
    }

    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(
        proEntitlementId,
        offering: currentOffering,
        displayCloseButton: true,
      );
      await refresh();
      return result;
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
      return PaywallResult.error;
    }
  }

  Future<void> presentCustomerCenter() async {
    if (!_isConfigured) {
      _lastError = 'RevenueCat is not configured yet.';
      notifyListeners();
      return;
    }

    try {
      await RevenueCatUI.presentCustomerCenter(
        onRestoreCompleted: (customerInfo) {
          _customerInfo = customerInfo;
          _lastError = null;
          notifyListeners();
        },
        onRestoreFailed: (error) {
          _lastError = '${error.code.name}: ${error.message}';
          notifyListeners();
        },
      );
      await refresh();
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
    }
  }

  Future<void> syncPurchases() async {
    if (!_isConfigured) {
      return;
    }
    try {
      await Purchases.syncPurchases();
      await refresh();
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
    }
  }

  Future<void> logIn(String appUserId) async {
    if (!_isConfigured) {
      _lastError = 'RevenueCat is not configured yet.';
      notifyListeners();
      return;
    }

    _setBusy(true);
    try {
      await Purchases.logIn(appUserId);
      _customerInfo = await Purchases.getCustomerInfo();
      _currentAppUserId = appUserId;
      _lastError = null;
      notifyListeners();
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
    } finally {
      _setBusy(false);
    }
  }

  Future<void> logOut() async {
    if (!_isConfigured) {
      return;
    }

    _setBusy(true);
    try {
      _customerInfo = await Purchases.logOut();
      _currentAppUserId = null;
      _lastError = null;
      notifyListeners();
    } catch (error) {
      _lastError = _formatError(error);
      notifyListeners();
    } finally {
      _setBusy(false);
    }
  }

  @override
  void dispose() {
    if (_isConfigured) {
      Purchases.removeCustomerInfoUpdateListener(_customerInfoListener);
    }
    super.dispose();
  }

  void _handleCustomerInfoUpdated(CustomerInfo customerInfo) {
    _customerInfo = customerInfo;
    notifyListeners();
  }

  Package? _findPackageByProductId(String productId) {
    final offering = currentOffering;
    if (offering == null) {
      return null;
    }

    for (final package in offering.availablePackages) {
      if (package.storeProduct.identifier == productId) {
        return package;
      }
    }
    return null;
  }

  bool _hasProEntitlement(CustomerInfo? customerInfo) {
    final active = customerInfo?.entitlements.active;
    if (active == null || active.isEmpty) {
      return false;
    }
    return active.containsKey(proEntitlementId);
  }

  String _resolveApiKey(AppConfig config) {
    if (config.revenueCatApiKey.isNotEmpty) {
      return config.revenueCatApiKey;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      if (config.revenueCatIosKey.isNotEmpty) {
        return config.revenueCatIosKey;
      }
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      if (config.revenueCatAndroidKey.isNotEmpty) {
        return config.revenueCatAndroidKey;
      }
    }

    return '';
  }

  void _setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  String _formatError(Object error) {
    if (error is PlatformException && error.details is Map) {
      final details = Map<String, dynamic>.from(error.details as Map);
      final purchasesError = PurchasesError.fromJson(details);
      return '${purchasesError.readableErrorCode}: ${purchasesError.message}';
    }

    if (error is PlatformException) {
      return error.message ?? error.code;
    }

    return error.toString();
  }
}
