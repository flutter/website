// ignore_for_file: directives_ordering

import './error_handler.dart';
// #docregion Main
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await myErrorsHandler.initialize();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      myErrorsHandler.onErrorDetails(details);
      exit(1);
    };
    runApp(MyApp());
  }, (error, stack) {
    myErrorsHandler.onError(error, stack);
    exit(1);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
    );
  }
}
// #enddocregion Main