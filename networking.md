---
layout: page
title: Making Networking Requests in Flutter
permalink: /networking/
---

* TOC Placeholder
{:toc}

## Using the `http` package

Flutter supports the the [http package][http], version `0.11.3+12` or later.

Start by declaring a dependency by adding an http line under `dependencies` in
`pubspec.yaml`:

```
dependencies:
  ...
  http: '>=0.11.3+12'
```

## Making requests

You can create an HTTP [Client][client] with the `Client` constructor:

```dart
import 'package:http/http.dart' as http;

http.Client _httpClient = new http.Client();
```

The client supports common HTTP operations:

* **HTTP GET:** Use [`get`][get] for a general request, [`read`][read] for a
 request returning a string, or [`readbytes`][readbytes] for a request
 returning bytes.

* **HTTP POST:** Use [`post`][post] for a general post.

Note that the API uses [Dart
Futures](https://www.dartlang.org/tutorials/language/futures) in the return
values. These are most easily used with the `then()` methods like this:

```dart
_httpClient.post(url, body: {"name": "doodle", "color": "blue"})
    .then((response) {
  print("Response status: ${response.statusCode}");
});
```

## Decoding and encoding JSON

This is supported via the [`dart:convert`](https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html) library.

To decode/parse the JSON string response into a Map:

```dart
Map data = JSON.decode(response.body);
// Assume the response body is something like: ["foo", { "bar": 499 }]
int barValue = data[1]['bar']; // barValue is set to 499
```

To encode JSON simply pass in a `Map` with the values:
```dart
String encodedString = JSON.encode([1, 2, { "a": null }]);
```

## Example

The following example calls the jsontest.com web service API. This responds with
your local IP address.

1. Create a new flutter app with `flutter create`

1. Add the http dependency as discussed at the top of this page.

1. Replace the contents of `main.dart` with the following:

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _ipAddress = 'Unknown';

  void _getIPAddress() {
    String url = "http://ip.jsontest.com/";
    http.Client _httpClient = new http.Client();
    _httpClient.read(url).then((String response) {
      Map data = JSON.decode(response);
      String ip = data["ip"];

      setState(() {
        _ipAddress = ip;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget spacer = new SizedBox(height: 32.0);

    return new Scaffold(
      body: new Center(
        child: new Column(children: <Widget>[
          spacer,
          new Text('Your current IP address is:'),
          new Text('$_ipAddress.'),
          spacer,
          new RaisedButton(
            onPressed: _getIPAddress,
            child: new Text('Get IP address'),
          )
        ]),
      ),
    );
  }
}

```

## API docs

For full API docs, see:

  * [`Client` in package `http`][client]
  * [`dart:convert` library][convert]

[http]:       https://pub.dartlang.org/packages/http
[client]:     https://www.dartdocs.org/documentation/http/0.11.3%2B10/http/Client-class.html
[get]:        https://www.dartdocs.org/documentation/http/stable/http/get.html
[read]:       https://www.dartdocs.org/documentation/http/stable/http/read.html
[readbytes]:  https://www.dartdocs.org/documentation/http/stable/http/readbytes.html
[post]:       https://www.dartdocs.org/documentation/http/stable/http/post.html
[convert]:    https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html
