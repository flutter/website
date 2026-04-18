// ignore_for_file: unused_local_variable
// ignore_for_file: unused_import, avoid_dynamic_calls

import 'package:flutter/material.dart';

import 'summary.dart';

class ArticleModel {}

class ArticleViewModel {
  ArticleViewModel(ArticleModel model);
}

// #docregion MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate your `ArticleViewModel` to test its HTTP requests.
    final viewModel = ArticleViewModel(ArticleModel());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Wikipedia Flutter')),
        body: const Center(child: Text('Check console for article data')),
      ),
    );
  }
}
// #enddocregion MainApp

void main() {
  runApp(const MainApp());
}
