import 'package:flutter/material.dart';

void main() => runApp(const AccessibleApp());

class AccessibleApp extends StatelessWidget {
  const AccessibleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your accessible app',
      home: Scaffold(appBar: AppBar(title: const Text('Your accessible app'))),
    );
  }
}
