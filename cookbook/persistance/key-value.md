---
layout: page
title: "Storing key-value data on disk"
permalink: /cookbook/persistence/key-value/
---

If you have a relatively small collection of key-values that you'd like to save, you should use the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) APIs

Normally we would have to write native platform integration for storing data for both platforms, but fortunetly [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) plugin can be used for that. 

Shared preferences plugin wraps `NSUserDefaults` (on iOS) and `SharedPreferences` (on Android), providing a persistent store for simple data. Data is persisted to disk automatically and asynchronously.

## Setup

Before you start, you need to add [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) plugin to you `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: "<newest version>"
```

## Saving, reading and removing data

In order to access store simply use `SharedPreferences` class.

```dart
// import shared preferences plugin
import 'package:shared_preferences/shared_preferences.dart';

// obtain shared preferences 
SharedPreferences prefs = await SharedPreferences.getInstance();

// get  value by key, return null if not available
int counter = (prefs.getInt('counter') ?? 0) + 1;
print('Pressed $counter times.');

// set new value
prefs.setInt('counter', counter);

// removes value for given key
prefs.remove('counter');

```

In example above we load data from `counter` key, if it not exists, `0` is returned. 

For saving data we call `set` method. Note that data is persisted on disk automatically and asynchronously. If you want to get notified when data is saved use `commit()` function. 

Adequately setter and getter methods are available for all primitive types.

## Supported types

While is easy and convenient to use key-value storage, it has limitations:

- Only primitive types can be used
  - `int`, `double`, `bool`, `string` and `string list`
- It's not designed to store a lot of data so it's not suitable as application cache.

If you want to read more about Shared preferences on Android please visit [Shared preferences documentation](https://developer.android.com/guide/topics/data/data-storage.html#pref) on Android developers website.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new Center(
      child: new RaisedButton(
        onPressed: _incrementCounter,
        child: new Text('Increment Counter'),
        ),
      ),
    ),
  ));
}

_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  prefs.setInt('counter', counter);
}
```

## Testing support

You can populate SharedPreferences with initial values in your tests by running this code:

```dart
const MethodChannel('plugins.flutter.io/shared_preferences')
  .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{}; // set initial values here if desired
    }
    return null;
  });
```