import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'mint_admobkit.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({
    super.key,
    required this.padding,
    required this.type,
    required this.adIdProvider,
  });

  final AdType type;
  final AdIdProvider adIdProvider;
  final EdgeInsetsGeometry padding;

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  late String adId;

  @override
  void initState() {
    super.initState();
    adId = widget.adIdProvider.getMobileAdsUnitId(adType: widget.type);

    if (adId.isValidAdId) {
      BannerAd(
        adUnitId: adId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('Failed to load a banner ad: ${err.message}');
            ad.dispose();
          },
        ),
      ).load();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: widget.padding,
          child: SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ),
        ),
      );
    } else if (adId.isMockAdId) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: const Text('Mock Ad'),
      );
    } else {
      return Container();
    }
  }
}
