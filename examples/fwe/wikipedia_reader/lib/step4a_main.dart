import 'package:flutter/material.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});

  // The view model will be instantiated here next.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Flutter')),
      body: const Center(child: Text('Loading...')),
    );
  }
}
