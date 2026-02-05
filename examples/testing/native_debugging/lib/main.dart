// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(colorSchemeSeed: Colors.purple),
      home: const MyHomePage(title: 'URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
      scheme: 'https',
      host: 'docs.flutter.dev',
      path: 'testing/native-debugging',
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(toLaunch.toString()),
            ),
            FilledButton(
              onPressed: () => setState(() {
                _launched = _launchInBrowser(toLaunch);
              }),
              child: const Text('Launch in browser'),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            FilledButton(
              onPressed: () => setState(() {
                _launched = _launchInWebView(toLaunch);
              }),
              child: const Text('Launch in app'),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        ),
      ),
    );
  }
}
