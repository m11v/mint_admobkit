import 'package:flutter/material.dart';

import '../mint_admobkit.dart';

/// The widget to show a banner ad

class AdBanner extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final adId = adIdProvider.getMobileAdsUnitId(adType: type);
    return Padding(
      padding: padding,
      child: SimpleAdBanner(
        adID: adId,
      ),
    );
  }
}
