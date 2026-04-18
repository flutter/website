import 'package:flutter/material.dart';

import 'summary.dart';

class ArticleViewModel extends ChangeNotifier {
  ArticleViewModel(ArticleModel model);
  bool get isLoading => false;
  Summary? get summary => null;
  Exception? get error => null;
  Future<void> fetchArticle() async {}
}

class ArticleModel {}

// #docregion view-model
class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Flutter')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return const Center(child: Text('Loading...'));
        },
      ),
    );
  }
}

// #enddocregion view-model
