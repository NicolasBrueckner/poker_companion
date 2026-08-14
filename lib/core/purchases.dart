import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:poker_companion/core/utility.dart';

class PurchaseService {
  PurchaseService._();

  static const String removeAdsId = 'remove_ads';

  static final InAppPurchase _iap = InAppPurchase.instance;
  static StreamSubscription<List<PurchaseDetails>>? _subscription;

  static final ValueNotifier<bool> adsRemoved = ValueNotifier(PrefValues.adsRemoved);
  static final ValueNotifier<ProductDetails?> product = ValueNotifier(null);

  static Future<void> init() async {
    if (!await _iap.isAvailable()) return;

    _subscription = _iap.purchaseStream.listen(_onPurchaseUpdate);

    final response = await _iap.queryProductDetails({removeAdsId});
    if (response.productDetails.isNotEmpty) {
      product.value = response.productDetails.first;
    }
  }

  static Future<void> buyRemoveAds() async {
    final details = product.value;
    if (details == null) return;
    await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: details));
  }

  static Future<void> restore() => _iap.restorePurchases();

  static void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.productID == removeAdsId) {
        switch (purchase.status) {
          case PurchaseStatus.purchased:
          case PurchaseStatus.restored:
            PrefValues.adsRemoved = true;
            adsRemoved.value = true;
          case PurchaseStatus.error:
          case PurchaseStatus.canceled:
          case PurchaseStatus.pending:
            break;
        }
      }

      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }

  static void dispose() => _subscription?.cancel();
}
