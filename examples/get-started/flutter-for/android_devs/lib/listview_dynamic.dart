import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: ListView(children: widgets),
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets = List.from(widgets);
          widgets.add(getRow(widgets.length));
          developer.log('row $i');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Row $i'),
      ),
    );
  }
}
