import 'package:flutter/material.dart';

// #docregion theme
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.red,
        ),
      ),
      home: const SampleAppPage(),
    );
  }
}
// #enddocregion theme

class SampleAppPage extends StatelessWidget {
  const SampleAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}
