// ignore_for_file: unused_import

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

// #docregion ArticleView
class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Flutter')),
      body: Center(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return switch ((
              viewModel.isLoading,
              viewModel.summary,
              viewModel.error,
            )) {
              (true, _, _) => const CircularProgressIndicator(),
              (_, final summary?, _) => ArticlePage(
                summary: summary,
                nextArticleCallback: viewModel.fetchArticle,
              ),
              (_, _, final Exception e) => Text('Error: $e'),
              _ => const Text('Something went wrong!'),
            };
          },
        ),
      ),
    );
  }
}
// #enddocregion ArticleView

class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) => const Placeholder();
}
