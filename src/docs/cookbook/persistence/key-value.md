---
title: Store key-value data on disk
description: How to use the shared_preferences package to store key-value data.
prev:
  title: Read and write files
  path: /docs/cookbook/persistence/reading-writing-files
next:
  title: Play and pause a video
  path: /docs/cookbook/plugins/play-video
---

<?code-excerpt path-base="../null_safety_examples/cookbook/persistence/key_value/"?>

If you have a relatively small collection of key-values
to save, you can use the [`shared_preferences`][] plugin.

Normally,
you would have to write native platform integrations for storing
data on both iOS and Android. Fortunately,
the [`shared_preferences`][] plugin can be used to persist
key-value data on disk. The shared preferences plugin
wraps `NSUserDefaults` on iOS and `SharedPreferences` on Android,
providing a persistent store for simple data.

This recipe uses the following steps:

  1. Add the dependency.
  2. Save data.
  3. Read data.
  4. Remove data.

## 1. Add the dependency

Before starting, add the [`shared_preferences`][]
plugin to the `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: "<newest version>"
```

## 2. Save data

To persist data, use the setter methods provided by the
`SharedPreferences` class. Setter methods are available for
various primitive types, such as `setInt`, `setBool`, and `setString`.

Setter methods do two things: First, synchronously update the
key-value pair in-memory. Then, persist the data to disk.

<!-- skip -->
```dart
// obtain shared preferences
final prefs = await SharedPreferences.getInstance();

// set value
prefs.setInt('counter', counter);
```

## 3. Read data

To read data, use the appropriate getter method provided by the
`SharedPreferences` class. For each setter there is a corresponding getter.
For example, you can use the `getInt`, `getBool`, and `getString` methods.

<!-- skip -->
```dart
final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
final counter = prefs.getInt('counter') ?? 0;
```

## 4. Remove data

To delete data, use the `remove()` method.

<!-- skip -->
```dart
final prefs = await SharedPreferences.getInstance();

prefs.remove('counter');
```

## Supported types

Although key-value storage is easy and convenient to use,
it has limitations:

* Only primitive types can be used: `int`, `double`, `bool`, `string`,
  and `stringList`.
* It's not designed to store a lot of data.

For more information about shared preferences on Android,
see the [shared preferences documentation][]
on the Android developers website.

## Testing support

It's a good idea to test code that persists data using
`shared_preferences`. You can do this by mocking out the
`MethodChannel` used by the `shared_preferences` library.

Populate `SharedPreferences` with initial values in your tests
by running the following code in a `setupAll()` method in
your test files:

<!-- skip -->
```dart
const MethodChannel('plugins.flutter.io/shared_preferences')
  .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{}; // set initial values here if desired
    }
    return null;
  });
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shared preferences demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  //Incrementing counter after click
  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```


[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[shared preferences documentation]: {{site.android-dev}}/guide/topics/data/data-storage#pref
