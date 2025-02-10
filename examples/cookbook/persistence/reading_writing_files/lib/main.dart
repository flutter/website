import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// #docregion localPath
import 'package:path_provider/path_provider.dart';
// #enddocregion localPath

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    ),
  );
}

class CounterStorage {
  // #docregion localPath
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  // #enddocregion localPath

  // #docregion localFile
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
  // #enddocregion localFile

  // #docregion readCounter
  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
  // #enddocregion readCounter

  // #docregion writeCounter
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

  // #enddocregion writeCounter
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reading and Writing Files')),
      body: Center(
        child: Text('Button tapped $_counter time${_counter == 1 ? '' : 's'}.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
