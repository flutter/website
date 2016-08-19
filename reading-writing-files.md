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

## Writing a string to a file
Use the File object’s [writeAsString()](https://api.dartlang.org/stable/1.18.1/dart-io/File/writeAsString.html) method to write a string to a file. After writing the string, the method closes the file.

```dart
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<Null> main() async {
  runApp(null); // this line is required to initialize the shell
  String dir = (await PathProvider.getApplicationDocumentsDirectory()).path;
  String filename = "$dir/foo.txt";
  File file = new File(filename);
  await file.writeAsString('some content');
}
```

## Reading a file as a string
Use the File object's [`readAsString()`](https://api.dartlang.org/stable/1.18.1/dart-core/Resource/readAsString.html) method to read a file as a string, then display it on the screen.

```dart
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<Null> main() async {
  runApp(null); // this line is required to initialize the shell
  String dir = (await PathProvider.getApplicationDocumentsDirectory()).path;
  String filename = "$dir/foo.txt";
  File file = new File(filename);
  String contents = await file.readAsString();
  runApp(
    new Center(child: new Text('Contents: $contents'))
  );
}
```
