// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';

class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  // The view model will be instantiated here next.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Flutter')),
      body: const Center(child: Text('Loading...')),
    );
  }
}
