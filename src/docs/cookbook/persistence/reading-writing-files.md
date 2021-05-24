---
title: Read and write files
description: How to read from and write to files on disk.
prev:
  title: Persist data with SQLite
  path: /docs/cookbook/persistence/sqlite
next:
  title: Store key-value data on disk
  path: /docs/cookbook/persistence/key-value
---

<?code-excerpt path-base="../null_safety_examples/cookbook/persistence/reading_writing_files/"?>

In some cases, you need to read and write files to disk.
For example, you may need to persist data across app launches,
or download data from the internet and save it for later offline use.

To save files to disk, combine the [`path_provider`][]
plugin with the [`dart:io`][] library.

This recipe uses the following steps:

  1. Find the correct local path.
  2. Create a reference to the file location.
  3. Write data to the file.
  4. Read data from the file.

## 1. Find the correct local path

This example displays a counter. When the counter changes,
write data on disk so you can read it again when the app loads.
Where should you store this data?

The [`path_provider`][] package
provides a platform-agnostic way to access commonly used locations on the
device's file system. The plugin currently supports access to
two file system locations:

*Temporary directory*
: A temporary directory (cache) that the system can
  clear at any time. On iOS, this corresponds to the
  [`NSCachesDirectory`][]. On Android, this is the value that
  [`getCacheDir()`][] returns.

*Documents directory*
: A directory for the app to store files that only
  it can access. The system clears the directory only when the app
  is deleted.
  On iOS, this corresponds to the `NSDocumentDirectory`.
  On Android, this is the `AppData` directory.

This example stores information in the documents directory.
You can find the path to the documents directory as follows:

<?code-excerpt "lib/main.dart (localPath)"?>
```dart
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
```

## 2. Create a reference to the file location

Once you know where to store the file, create a reference to the
file's full location. You can use the [`File`][]
class from the [`dart:io`][] library to achieve this.

<?code-excerpt "lib/main.dart (localFile)"?>
```dart
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}
```

## 3. Write data to the file

Now that you have a `File` to work with,
use it to read and write data.
First, write some data to the file.
The counter is an integer, but is written to the
file as a string using the `'$counter'` syntax.

<?code-excerpt "lib/main.dart (writeCounter)"?>
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

<?code-excerpt "lib/main.dart (readCounter)"?>
```dart
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
```

## Testing

To test code that interacts with files, you need to mock calls to
the `MethodChannel`&mdash;the class that
communicates with the host platform. For security reasons,
you can't directly interact with the file system on a device,
so you interact with the test environment's file system.

To mock the method call, provide a `setupAll()` function in the test file.
This function runs before the tests are executed.

<?code-excerpt "test/widget_test.dart (setUpAll)"?>
```dart
setUpAll(() async {
  // Create a temporary directory.
  final directory = await Directory.systemTemp.createTemp();

  // Mock out the MethodChannel for the path_provider plugin.
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

<?code-excerpt "lib/main.dart"?>
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
      final contents = await file.readAsString();

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

  FlutterDemo({Key? key, required this.storage}) : super(key: key);

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;

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

[`dart:io`]: {{site.api}}/flutter/dart-io/dart-io-library.html
[`File`]: {{site.api}}/flutter/dart-io/File-class.html
[`getCacheDir()`]: {{site.android-dev}}/reference/android/content/Context#getCacheDir()
[`NSCachesDirectory`]: https://developer.apple.com/documentation/foundation/nssearchpathdirectory/nscachesdirectory
[`path_provider`]: {{site.pub-pkg}}/path_provider
