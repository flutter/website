// ignore_for_file: unused_import, unused_field, unused_local_variable, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';

// #docregion main
void main() {
  runApp(const MainApp());
}
// #enddocregion main

// #docregion MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          // #docregion Text
          child: Text('Hello World!'),
          // #enddocregion Text
        ),
      ),
    );
  }
}

// #enddocregion MainApp
