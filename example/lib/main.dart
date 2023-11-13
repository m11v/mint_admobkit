import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
