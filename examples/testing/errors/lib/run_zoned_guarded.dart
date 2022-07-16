import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './backend.dart';

void main() {
  MyBackend myBackend = MyBackend();
  // #docregion Initialize
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    myBackend.sendError(error, stack);
  });
  // #enddocregion Initialize
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('hello world!');
  }
}
