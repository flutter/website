---
layout: page
title: Reading and Writing Files
sidebar: home_sidebar
permalink: /reading-writing-files/
---

This guide describes how to read and write files in Flutter by using the [`PathProvider`](https://docs.flutter.io/flutter/services/PathProvider-class.html) class.

* TOC
{:toc}

## Introduction
The [`PathProvider`](https://docs.flutter.io/flutter/services/PathProvider-class.html) class provides a platform-agnostic way to
access commonly used locations on the device's filesystem. The class currently supports access to two filesystem locations:

+ **Temporary directory:** A temporary directory (cache) that the system can clear at any time. On iOS, this corresponds to the value that [`NSTemporaryDirectory()`](https://developer.apple.com/reference/foundation/1409211-nstemporarydirectory) returns. On Android, this is the value that [`getCacheDir()`](https://developer.android.com/reference/android/content/Context.html#getCacheDir()) returns.
+ **Documents directory:** A directory for the app to store files that only it can access. The system clears the directory only when the app is deleted. On iOS, this corresponds to `NSDocumentsDirectory`. On Android, this is the `AppData` directory.

Once your Flutter app has a reference to a file location, you can use the [dart:io](https://api.dartlang.org/stable/1.18.1/dart-io/dart-io-library.html) APIs to perform read/write operations to the filesystem. For more information about working on files and directories using Dart, see this [overview](https://www.dartlang.org/articles/dart-vm/io) and [these examples](https://www.dartlang.org/dart-vm/dart-by-example#files-directories-and-symlinks).

## Example of reading and writing to a file

The following example shows how to modify the default app created by `flutter create`, so that
the app persists the number of button presses across relaunches.

```dart
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FlutterDemo(),
    ),
  );
}

class FlutterDemo extends StatefulWidget {
  FlutterDemo({Key key}) : super(key: key);

  @override
  _FlutterDemoState createState() => new _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    String dir = (
      await PathProvider.getApplicationDocumentsDirectory()
    ).path;                // get the path to the document directory
    String filename = "$dir/counter.txt";
    return new File(filename);
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
                            // read the variable as a string from the file
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _getLocalFile().then((File file) {
        file.writeAsString("$_counter");
                            // write the variable as a string to the file
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demo'),
      ),
      body: new Center(
        child: new Text('Button tapped $_counter time${
          _counter == 1 ? '' : 's' }.'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
```
