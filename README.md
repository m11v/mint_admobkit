# mint_admobkit

A set of AdMob integration utils for [MintMinter](https://play.google.com/store/apps/dev?id=6660530813735178327) apps

[![License](https://img.shields.io/github/license/m11v/mint_admobkit)](https://github.com/m11v/mint_admobkit/blob/main/LICENSE)
[![Flutter CI](https://github.com/m11v/mint_admobkit/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/m11v/mint_admobkit)
[![Pub](https://img.shields.io/pub/v/mint_admobkit?label=Pub)](https://pub.dev/packages/mint_admobkit)
[![Package publisher](https://img.shields.io/pub/publisher/mint_admobkit.svg)](https://pub.dev/packages/mint_admobkit/publisher)

- AdBanner: show a banner ad
- SimpleAdBanner: show a banner ad simple
- AdIdProvider: provide ids for different ad type
- AdType: defines ad type
- AttView: Show ATT request on iOS

## Usage
### Integrate AdMob on Android
1. Update AndroidManifest.xml:
- Add permissions before `<application`:
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  <uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
  ```
- Add metadata before `</application>`:
  ```xml
  <!-- Sample AdMob app ID: ca-app-pub-3940256099942544~3347511713 -->
  <meta-data
      android:name="com.google.android.gms.ads.APPLICATION_ID"
      android:value="ca-app-pub-3940256099942544~3347511713"/>
  
  <!-- Delay app measurement until MobileAds.initialize() is called. See https://developers.google.com/admob/flutter/eu-consent#delay_app_measurement_optional -->
  <meta-data
      android:name="com.google.android.gms.ads.DELAY_APP_MEASUREMENT_INIT"
      android:value="true"/>
  ```
2. Add an ad provider:
```dart
import 'package:mintminter_mint/ad/ad.dart';

sealed class ExampleAdType extends AdType {
  const ExampleAdType({required this.unitId});

  final String unitId;

  @override
  List<Object?> get props => [
    unitId,
  ];
}

class ExampleTopBannerAndroid extends ExampleAdType {
  const ExampleTopBannerAndroid({
    required super.unitId,
  });

  @override
  List<Object?> get props => [super.unitId];
}

class ExampleAdProvider extends AdIdProvider {
  ExampleAdProvider._internal();

  static ExampleAdProvider? _instance;

  /// Get an ExampleAdProvider instance
  factory ExampleAdProvider.getInstance() {
    _instance ??= ExampleAdProvider._internal();

    return _instance!;
  }

  /// Dispose ExampleAdProvider instance
  static dispose() {
    _instance = null;
  }

  @override
  String getAndroidAdUnitId(AdType adType) {
    if (adType is ExampleAdType) {
      return adType.unitId;
    } else {
      return '';
    }
  }

  @override
  String getIOSAdUnitId(AdType adType) {
    return '';
  }
}


```
3. Init the add provider in main
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ExampleAdProvider.getInstance().initializeMobileAdsOnMobile();

  runApp(const App());
}
```
4. Use `AdBanner`:
```dart
AdBanner(
    padding: const EdgeInsets.symmetric(vertical: 50),
    type: const ExampleTopBannerAndroid(unitId: AdIdProvider.mockAdId), 
    adIdProvider: ExampleAdProvider.getInstance(),
)
```
