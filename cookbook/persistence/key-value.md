---
layout: page
title: "Storing key-value data on disk"
permalink: /cookbook/persistence/key-value/
---

If we have a relatively small collection of key-values that we'd like to save, 
we can use the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) 
plugin.

Normally we would have to write native platform integrations for storing data on
both platforms. Fortunately, the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) 
plugin can be used to persist key-value data on disk. The shared preferences 
plugin wraps `NSUserDefaults` on iOS and `SharedPreferences` on Android, 
providing a persistent store for simple data.

## Directions

  1. Add the dependency
  2. Save Data
  3. Read Data
  4. Remove Data

## 1. Add the dependency

Before we start, we need to add the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) 
plugin to our `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: "<newest version>"
```

## 2. Save data

To persist data, we can use the setter methods provided by the 
`SharedPreferences` class. Setter methods are available for various primitive 
types, such as `setInt`, `setBool`, and `setString`.

Setter methods do two things: First, synchronously update the key-value pair 
in-memory. Then, persist the data to disk.

```dart
// obtain shared preferences 
final prefs = await SharedPreferences.getInstance();

// set new value
prefs.setInt('counter', counter);
```

## 3. Read data

To read data, we can use the appropriate getter method provided by the 
`SharedPreferences` class. For each setter there is a corresponding getter. 
For example, we can use the `getInt`, `getBool`, and `getString` methods.  

```dart
final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it does not exist, return 0.
final counter = prefs.getInt('counter') ?? 0;
```

## 4. Remove data

To delete data, we can use the `remove` method.

```dart
final prefs = await SharedPreferences.getInstance();

prefs.remove('counter');
```

## Supported types

While it is easy and convenient to use key-value storage, it has limitations:

- Only primitive types can be used: `int`, `double`, `bool`, `string` and `stringList`
- It's not designed to store a lot of data. 

For more information about Shared Preferences on Android, please visit 
[Shared preferences documentation](https://developer.android.com/guide/topics/data/data-storage.html#pref) 
on the Android developers website.

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

It can be a good idea to test code that persists data using 
`shared_preferences`. To do so, we'll need to mock out the `MethodChannel` used 
by the `shared_preferences` library.

We can populate `SharedPreferences` with initial values in our tests by running
the following code in a `setupAll` method in our test files:

```dart
const MethodChannel('plugins.flutter.io/shared_preferences')
  .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{}; // set initial values here if desired
    }
    return null;
  });
```
