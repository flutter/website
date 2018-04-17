---
layout: page
title: 文件的读写

permalink: /reading-writing-files/
---

这篇指南介绍了在 Flutter 中如何使用 [`PathProvider`](https://pub.dartlang.org/packages/path_provider) 插件和 Dart's 的 [`IO`](https://api.dartlang.org/stable/dart-io/dart-io-library.html) 库来读写文件。

* TOC
{:toc}

## 简介
[`PathProvider`](https://pub.dartlang.org/packages/path_provider) 插件提供了一套与平台无关的方法可以到访问设备文件系统中的常用路径。该类当前支持访问两种系统路径：

+ **Temporary directory:** 系统可能在任意时间清空的临时目录 (缓存)。在 iOS 系统上，相当于 [`NSTemporaryDirectory()`](https://developer.apple.com/reference/foundation/1409211-nstemporarydirectory) 返回的值。在 Android 系统上，相当于 [`getCacheDir()`](https://developer.android.com/reference/android/content/Context.html#getCacheDir()) 返回的值。
+ **Documents directory:** 用于存储只有应用自己可以访问的文件。只有应用被删掉的时候系统才会清空目录。在 iOS 系统上, 相当于 `NSDocumentDirectory`。在 Android 系统上，相当于 `AppData`。

一旦你的 Flutter 应用引用了文件路径，你就可以使用 [dart:io](https://api.dartlang.org/stable/dart-io/dart-io-library.html) 的接口对文件系统执行读写操作。更多关于使用 Dart 对文件和目录进行操作的信息，请参阅 [overview](https://www.dartlang.org/articles/dart-vm/io) 和 [these examples](https://www.dartlang.org/dart-vm/dart-by-example#files-directories-and-symlinks).

## 读写文件的示例

下面的例子展示了如何修改通过 `flutter create` 默认创建的应用，在多次重启应用之后能够持久化按钮点击的次数:

1. 使用 `flutter create` 创建新的 Flutter 工程或者使用 IntelliJ 中的 文件 > 新建工程。

1. 在 `pubspec.yaml`中对插件 PathProvider [声明依赖](https://pub.dartlang.org/packages/path_provider#-installing-tab-)。

1. 替换 `lib/main.dart` 为以下代码:

```dart
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primarySwatch: Colors.blue),
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
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // write the variable as a string to the file
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Flutter Demo')),
      body: new Center(
        child: new Text('Button tapped $_counter time${
          _counter == 1 ? '' : 's'
        }.'),
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
