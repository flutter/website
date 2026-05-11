import 'dart:io';

import 'package:flutter/material.dart';

import 'summary.dart';

class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    throw UnimplementedError();
  }
}

class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  Exception? error;
  bool isLoading = false;

  ArticleViewModel(this.model) {
    fetchArticle();
  }

  // #docregion fetchArticle
  Future<void> fetchArticle() async {
    isLoading = true;
    notifyListeners();
    try {
      summary = await model.getRandomArticleSummary();
      print('Article loaded: ${summary!.titles.normalized}'); // Temporary
      error = null; // Clear any previous errors.
    } on HttpException catch (e) {
      print('Error loading article: ${e.message}'); // Temporary
      error = e;
      summary = null;
    }
    isLoading = false;
    notifyListeners();
  }

  // #enddocregion fetchArticle
}
