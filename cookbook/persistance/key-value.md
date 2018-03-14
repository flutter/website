---
layout: page
title: "Storing key-value data on disk"
permalink: /cookbook/persistence/key-value/
---

If we have a relatively small collection of key-values that we'd like to save, we can use the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) plugin.

Normally we would have to write native platform integration for storing data for both platforms. Fortunately the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) plugin can be used for that. The shared preferences plugin wraps `NSUserDefaults` on iOS and `SharedPreferences` on Android, providing a persistent store for simple data.

## Setup

Before we start, we need to add the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) plugin to our `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: "<newest version>"
```

## Saving data

To persist key-value data, we can use `SharedPreferences` class.
For saving data we call `set` method. Note that data is persisted asynchronously. If we want to get notified when data is saved use `commit()` function. 

```dart
// obtain shared preferences 
SharedPreferences prefs = await SharedPreferences.getInstance();

// set new value
prefs.setInt('counter', counter);
```


## Reading data

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();

int counter = (prefs.getInt('counter') ?? 0) + 1;
```

In example above we load data from the `counter` key, if it not exists, `0` is returned. 


## Removing data

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();

prefs.remove('counter');
```

Setter and getter methods are available for all primitive types.

## Supported types

While it is easy and convenient to use key-value storage, it has limitations:

- Only primitive types can be used
  - `int`, `double`, `bool`, `string` and `string list`
- It's not designed to store a lot of data so it's not suitable as application cache.

For more information about Shared Preferences on Android, please visit [Shared preferences documentation](https://developer.android.com/guide/topics/data/data-storage.html#pref) on Android developers website.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Shared preferences demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Shared preferences demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start 
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }
  
  //Incrementing counter after click
  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0) + 1;
    setState(() {
      _counter;
    });
    prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

## Testing support

We can populate SharedPreferences with initial values in our tests by running this code:

```dart
const MethodChannel('plugins.flutter.io/shared_preferences')
  .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{}; // set initial values here if desired
    }
    return null;
  });
```

Code above should be placed inside test file under `test` folder.