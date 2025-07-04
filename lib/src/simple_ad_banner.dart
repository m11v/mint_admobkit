import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../mint_admobkit.dart';

/// The widget to show a banner ad
class SimpleAdBanner extends StatefulWidget {
  const SimpleAdBanner({
    super.key,
    required this.adID,
  });

  final String adID;

  @override
  State<SimpleAdBanner> createState() => _SimpleAdBannerState();
}

class _SimpleAdBannerState extends State<SimpleAdBanner> {
  BannerAd? _bannerAd;

  late String adId;

  @override
  void initState() {
    super.initState();
    adId = widget.adID;

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
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
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
