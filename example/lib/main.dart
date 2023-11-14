import 'package:flutter/material.dart';
import 'package:mint_admobkit/mint_admobkit.dart';

import 'example_ad_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ExampleAdProvider.getInstance().initializeMobileAdsOnMobile();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mint AdMobKit Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mint AdMobKit Demo'),
      ),
      body: ListView(
        children: [
          AdBanner(
            padding: const EdgeInsets.symmetric(vertical: 50),
            type: const ExampleTopBannerAndroid(unitId: AdIdProvider.mockAdId),
            adIdProvider: ExampleAdProvider.getInstance(),
          ),
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(20),
            child: Text(
              'Test Ad Demo',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          )
        ],
      ),
    );
  }
}
