// ignore_for_file: unused_import

// #docregion All
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'summary.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Wikipedia Flutter')),
        body: const Center(child: Text('Loading...')),
      ),
    );
  }
}
// #enddocregion MainApp

// #enddocregion All
