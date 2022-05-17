// ignore_for_file: import_of_legacy_library_into_null_safe

// #docregion UrlLauncher
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  launchURL() {
    launchUrl(p.toUri('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: launchURL,
          child: const Text('Show Flutter homepage'),
        ),
      ),
    );
  }
}
// #enddocregion UrlLauncher
