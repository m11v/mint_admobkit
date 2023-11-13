# Example

Example app for mint_admobkit package

### Integrate Admob on Android
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
