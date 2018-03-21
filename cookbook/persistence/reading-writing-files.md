---
layout: page
title: "Reading and Writing Files"
permalink: /cookbook/persistence/reading-writing-files/
---

In some cases, it can be handy to read and write files to disk. This can be 
used to persist data across app launches or download data from the internet and
save it for later offline use.

In order to save files to disk, we'll need to combine the 
[`path_provider` plugin](https://pub.dartlang.org/packages/path_provider) with 
the [`dart:io`](https://docs.flutter.io/flutter/dart-io/dart-io-library.html) 
library.
  
## Directions

  1. Find the correct local path
  2. Create a reference to the file location
  3. Write data to the file
  4. Read data from the file
  
## 1. Find the correct local path

In this example, we'll display a counter. When the counter changes, we'll want 
to write data on disk so we can read it again when the app loads. Therefore, we 
need to ask: Where should we store this data?

The [`path_provider`](https://pub.dartlang.org/packages/path_provider) plugin 
provides a platform-agnostic way to access commonly used locations on the 
device's filesystem. The plugin currently supports access to two filesystem 
locations:

  * *Temporary directory:* A temporary directory (cache) that the system can 
  clear at any time. On iOS, this corresponds to the value that 
  [`NSTemporaryDirectory()`](https://developer.apple.com/reference/foundation/1409211-nstemporarydirectory) 
  returns. On Android, this is the value that [`getCacheDir()`](https://developer.android.com/reference/android/content/Context.html#getCacheDir()) 
  returns.
  * *Documents directory:* A directory for the app to store files that only 
  it can access. The system clears the directory only when the app is deleted. 
  On iOS, this corresponds to `NSDocumentDirectory`. On Android, this is the 
  `AppData` directory.
  
In our case, we'll want to store information in the documents directory! We
can find the path to the documents directory like so:
  
```dart
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  
  return directory.path;
}
```

## 2. Create a reference to the file location

Once we know where to store the file, we'll need to create a reference to the 
file's full location. We can use the [`File`](https://docs.flutter.io/flutter/dart-io/File-class.html) 
class from the [dart:io](https://docs.flutter.io/flutter/dart-io/dart-io-library.html) 
library to achieve this.

```dart
Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/counter.txt');
}
```

## 3. Write data to the file

Now that we have a `File` to work with, we can use it to read and write data! 
First, we'll write some data to the file. Since we're working with a counter,
we'll simply store the integer as a String.

```dart
Future<File> writeCounter(int counter) async {
  final file = await _localFile;
  
  // Write the file
  return file.writeAsString('$counter');
}
``` 

## 4. Read data from the file

Now that we have some data on disk, we can read it! Once again, we'll use the 
`File` class to do so.

```dart
Future<int> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If we encounter an error, return 0
    return 0;
  }
}
``` 

## Testing

In order to test code that interacts with files, we'll need to Mock calls to
the `MethodChannel`. The `MethodChannel` is the class that Flutter uses to
communicate with the host platform.

In our tests, we can't interact with the filesystem on a device. We'll need to
interact with our test environment's filesystem!

To mock the method call, we can provide a `setupAll` function in our test file.
This function will run before the tests are executed.

```dart
setUpAll(() async {
  // Create a temporary directory to work with
  final directory = await Directory.systemTemp.createTemp();
  
  // Mock out the MethodChannel for the path_provider plugin
  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    // If we're getting the apps documents directory, return the path to the
    // temp directory on our test environment instead.
    if (methodCall.method == 'getApplicationDocumentsDirectory') {
      return directory.path;
    }
    return null;
  });
});
``` 

## Complete Example

```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Reading and Writing Files',
      home: new FlutterDemo(storage: new CounterStorage()),
    ),
  );
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If we encounter an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}

class FlutterDemo extends StatefulWidget {
  final CounterStorage storage;

  FlutterDemo({Key key, @required this.storage}) : super(key: key);

  @override
  _FlutterDemoState createState() => new _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    // write the variable as a string to the file
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Reading and Writing Files')),
      body: new Center(
        child: new Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
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
