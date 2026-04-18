import 'package:flutter/material.dart';

import 'summary.dart';

// #docregion article
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return const Text('Article content will be displayed here...');
  }
}

// #enddocregion article
