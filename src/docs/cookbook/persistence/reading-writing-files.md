---
title: Reading and Writing Files
prev:
  title: Working with WebSockets
  path: /docs/cookbook/networking/web-sockets
next:
  title: Storing key-value data on disk
  path: /docs/cookbook/persistence/key-value
---

In some cases, it can be handy to read and write files to disk.
This can be used to persist data across app launches,
or to download data from the internet and save it for later offline use.

In order to save files to disk, you'll need to combine the
[`path_provider` plugin]({{site.pub-pkg}}/path_provider) with
the [`dart:io`]({{site.api}}/flutter/dart-io/dart-io-library.html)
library.

## Directions

  1. Find the correct local path
  2. Create a reference to the file location
  3. Write data to the file
  4. Read data from the file

## 1. Find the correct local path

In this example, you'll display a counter. When the counter changes, you'll
write data on disk so you can read it again when the app loads.
Therefore, you must wonder: Where should I store this data?

The [`path_provider`]({{site.pub-pkg}}/path_provider) plugin
provides a platform-agnostic way to access commonly used locations on the
device's filesystem. The plugin currently supports access to two filesystem
locations:

  * *Temporary directory:* A temporary directory (cache) that the system can
    clear at any time. On iOS, this corresponds to the value that
    [`NSTemporaryDirectory()`](https://developer.apple.com/reference/foundation/1409211-nstemporarydirectory)
    returns. On Android, this is the value that
    [`getCacheDir()`]({{site.android-dev}}/reference/android/content/Context#getCacheDir())
    returns.
  * *Documents directory:* A directory for the app to store files that only
    it can access. The system clears the directory only when the app is deleted.
    On iOS, this corresponds to `NSDocumentDirectory`. On Android, this is the
    `AppData` directory.

In this case, you'll want to store information in the documents directory.
You can find the path to the documents directory as follows:

<!-- skip -->
```dart
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
```

## 2. Create a reference to the file location

Once you know where to store the file, you'll need to create a reference to the
file's full location. You can use the
[`File`]({{site.api}}/flutter/dart-io/File-class.html)
class from the [dart:io]({{site.api}}/flutter/dart-io/dart-io-library.html)
library to achieve this.

<!-- skip -->
```dart
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}
```

## 3. Write data to the file

Now that you have a `File` to work with, use it to read and write data.
First, write some data to the file. Since you're working with a counter,
you'll simply store the integer as a String.

<!-- skip -->
```dart
Future<File> writeCounter(int counter) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$counter');
}
```

## 4. Read data from the file

Now that you have some data on disk, you can read it.
Once again, use the `File` class.

<!-- skip -->
```dart
Future<int> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}
```

## Testing

In order to test code that interacts with files, you'll need to Mock calls to
the `MethodChannel`. The `MethodChannel` is the class that Flutter uses to
communicate with the host platform.

In these tests, you can't interact with the filesystem on a device.
You'll need to interact with the test environment's filesystem.

To mock the method call, provide a `setupAll` function in the test file.
This function runs before the tests are executed.

<!-- skip -->
```dart
setUpAll(() async {
  // Create a temporary directory to work with
  final directory = await Directory.systemTemp.createTemp();

  // Mock out the MethodChannel for the path_provider plugin
  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    // If you're getting the apps documents directory, return the path to the
    // temp directory on the test environment instead.
    if (methodCall.method == 'getApplicationDocumentsDirectory') {
      return directory.path;
    }
    return null;
  });
});
```

## Complete example

```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
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
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
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
  _FlutterDemoState createState() => _FlutterDemoState();
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
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```
