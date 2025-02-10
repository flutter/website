// ignore_for_file: prefer_const_constructors

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'main_app_scaffold.dart';

void main() {
  runApp(const AppScaffold());

  // Required when using bits_dojo for custom TitleBars
  doWhenWindowReady(() {
    appWindow.title = 'Adaptive App Demo';
    appWindow.show();
  });
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
      create: (_) => AppModel(),
      child: Builder(
        builder: (context) {
          bool touchMode = context.select<AppModel, bool>((m) => m.touchMode);
          // #docregion visual-density
          double densityAmt = touchMode ? 0.0 : -1.0;
          VisualDensity density = VisualDensity(
            horizontal: densityAmt,
            vertical: densityAmt,
          );
          return MaterialApp(
            theme: ThemeData(visualDensity: density),
            home: MainAppScaffold(),
            debugShowCheckedModeBanner: false,
          );
          // #enddocregion visual-density
        },
      ),
    );
  }
}
