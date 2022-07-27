import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './backend.dart';

void main() {
  MyBackend myBackend = MyBackend();
  // #docregion Initialize
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }, (error, stack) {
    myBackend.sendError(error, stack);
  });
  // #enddocregion Initialize
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('hello world!');
  }
}
