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
      /// Initialize MobileAds first,
      /// discussion: https://groups.google.com/g/google-admob-ads-sdk/c/HB3ApoxDnWs/m/7Lq2MOuPBAAJ
      await MobileAds.instance.initialize();

      /// Create debug params, see https://developers.google.com/admob/flutter/eu-consent#testing
      /// For example:
      /// ConsentDebugSettings debugSettings = ConsentDebugSettings(
      ///     debugGeography: DebugGeography.debugGeographyEea,
      ///     testIdentifiers: ['1FA151D7EFD6EA233C2AD95E1FB9175C'],
      /// );
      /// final params = ConsentRequestParameters(
      ///   consentDebugSettings: debugSettings,
      /// );
      /// To get the the device id in testIdentifiers, search `ConsentDebugSettings.Builder().addTestDeviceHashedId` in terminal.
      final params = ConsentRequestParameters();
      ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
        final isConsentFormAvailable =
            await ConsentInformation.instance.isConsentFormAvailable();
        if (isConsentFormAvailable) {
          final consentStatus =
              await ConsentInformation.instance.getConsentStatus();
          debugPrint('👉👉👉👉👉 consent status = $consentStatus');
          if (consentStatus == ConsentStatus.required) {
            ConsentForm.loadConsentForm(
              (ConsentForm consentForm) async {
                var status =
                    await ConsentInformation.instance.getConsentStatus();
                if (status == ConsentStatus.required) {
                  consentForm.show(
                    (_) {},
                  );
                }
              },
              (_) {},
            );
          }
        } else {
          debugPrint('👉👉👉👉👉 consent form is unavailable');
        }
      }, (_) {});
    }
  }

  Future<void> resetConsentInformation() async {
    if (kDebugMode) {
      ConsentInformation.instance.reset();
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
