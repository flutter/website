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
class ArticleView extends StatefulWidget {
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  void initState() {
    super.initState();
    viewModel.fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Flutter')),
      body: const Center(child: Text('Loading...')),
    );
  }
}

// #enddocregion view-model
