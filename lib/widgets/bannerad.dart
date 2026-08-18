import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:poker_companion/core/purchases.dart';

class CustomBannerAd extends StatefulWidget {
  const CustomBannerAd({super.key});

  @override
  State<CustomBannerAd> createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  BannerAd? _bannerAd;
  AdSize? _adSize;
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!Platform.isAndroid || _requested || PurchaseService.adsRemoved.value) return;
    _requested = true;
    _loadAd(MediaQuery.sizeOf(context).width.truncate());
  }

  Future<void> _loadAd(int width) async {
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (size == null || !mounted) return;

    setState(() => _adSize = size);
    final banner = BannerAd(
      size: size,
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _bannerAd = ad as BannerAd),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) setState(() => _adSize = null);
        },
      ),
      request: const AdRequest(),
    );
    banner.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: PurchaseService.adsRemoved,
      builder: (context, removed, _) {
        final size = _adSize;
        if (removed || !Platform.isAndroid || size == null) return const SizedBox();
        final ad = _bannerAd;
        return SizedBox(
          width: size.width.toDouble(),
          height: 0,
          child: ad == null ? null : AdWidget(ad: ad),
        );
      },
    );
  }
}
