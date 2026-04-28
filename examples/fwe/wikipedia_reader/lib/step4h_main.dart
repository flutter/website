import 'package:flutter/material.dart';

import 'summary.dart';

// #docregion article
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        spacing: 10,
        children: [
          if (summary.hasImage) Image.network(summary.originalImage!.source),
          const Text('Article content will be displayed here...'),
        ],
      ),
    );
  }
}

// #enddocregion article
