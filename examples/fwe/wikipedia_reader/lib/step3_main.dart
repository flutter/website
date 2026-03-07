// ignore_for_file: unused_import, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'summary.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Wikipedia Flutter')),
        body: const Center(child: Text('Loading...')),
      ),
    );
  }
}

class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);

    if (response.statusCode != 200) {
      throw const HttpException('Failed to update resource');
    }

    return Summary.fromJson(jsonDecode(response.body) as Map<String, Object?>);
  }
}

class ArticleViewModel extends ChangeNotifier {
  ArticleViewModel({required this.model});
  final ArticleModel model;

  Summary? _summary;
  Summary? get summary => _summary;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Exception? _error;
  Exception? get error => _error;

  Future<void> fetchArticle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _summary = await model.getRandomArticleSummary();
      _error = null;
    } on Exception catch (e) {
      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
