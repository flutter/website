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
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Loading...'))),
    );
  }
}

class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    return throw UnimplementedError();
  }
}

// #docregion ArticleViewModel
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  Exception? error;
  bool isLoading = false;

  ArticleViewModel(this.model);
}

// #enddocregion ArticleViewModel
