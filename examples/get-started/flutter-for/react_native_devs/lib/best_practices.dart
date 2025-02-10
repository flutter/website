import 'package:flutter/material.dart';

// #docregion create-state
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});

  final String title;
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}
// #enddocregion create-state

// #docregion use-stateful-widget
class MyStatelessWidget extends StatelessWidget {
  // This widget is the root of your application.
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyStatefulWidget(title: 'State Change Demo'),
    );
  }
}

// #enddocregion use-stateful-widget
