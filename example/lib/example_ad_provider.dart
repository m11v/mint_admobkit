import 'package:mint_admobkit/mint_admobkit.dart';

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
