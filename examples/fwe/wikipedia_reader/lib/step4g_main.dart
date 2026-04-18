// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'summary.dart';

// #docregion ArticleWidget
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          if (summary.hasImage) ...[
            Image.network(summary.originalImage!.source),
          ],
          const Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}

// #enddocregion ArticleWidget
