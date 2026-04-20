import 'package:flutter/material.dart';

import 'summary.dart';

// #docregion page
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
    return const Center(
      child: Text('Article content will be displayed here...'),
    );
  }
}

// #enddocregion page
