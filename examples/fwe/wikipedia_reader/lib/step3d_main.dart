// ignore_for_file: unused_import, avoid_dynamic_calls

import 'dart:io';
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
    try {
      summary = await model.getRandomArticleSummary();
      error = null; // Clear any previous errors.
    } on HttpException catch (e) {
      error = e;
      summary = null;
    }
    isLoading = false;
    notifyListeners();
  }
}

// #enddocregion ArticleViewModel
