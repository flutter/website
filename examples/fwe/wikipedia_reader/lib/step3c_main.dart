// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'summary.dart';

class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    throw UnimplementedError();
  }
}

// #docregion ArticleViewModel
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  Exception? error;
  bool isLoading = false;

  ArticleViewModel(this.model) {
    fetchArticle();
  }

  Future<void> fetchArticle() async {
    isLoading = true;
    notifyListeners();

    // TODO: Add data fetching logic

    isLoading = false;
    notifyListeners();
  }
}

// #enddocregion ArticleViewModel
