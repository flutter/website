// ignore_for_file: unused_import, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

  // Methods will be added next.
  Future<void> fetchArticle() async {}
}

// #enddocregion ArticleViewModel
