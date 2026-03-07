// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'summary.dart';

// #docregion ArticlePage
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [const Text('Article content will be displayed here')],
      ),
    );
  }
}

// #enddocregion ArticlePage
