import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdType extends Equatable {
  const AdType();
}

abstract class AdIdProvider {
  static const mockAdId = 'mock_id';

  /// Initialize MobileAds on mobile
  Future<void> initializeMobileAdsOnMobile() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await MobileAds.instance.initialize();
    }
  }

  /// get unit ad id on Android
  String getAndroidAdUnitId(AdType adType);

  /// get unit ad id on iOS
  String getIOSAdUnitId(AdType adType);

  /// Get MobileAds unit id
  String getMobileAdsUnitId({
    required AdType adType,
    bool isTest = kDebugMode,
  }) {
    if (isTest) {
      // test ad id
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (!kIsWeb && Platform.isAndroid) {
      return getAndroidAdUnitId(adType);
    } else if (!kIsWeb && Platform.isIOS) {
      return getIOSAdUnitId(adType);
    } else {
      return '';
    }
  }
}

extension StringValidAdId on String {
  bool get isValidAdId => startsWith('ca-app-pub');

  bool get isMockAdId => startsWith('mock');
}
