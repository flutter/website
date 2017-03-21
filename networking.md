---
layout: page
title: Making HTTP Networking Requests in Flutter
permalink: /networking/
---

This page describes how to make HTTP networking requests in Flutter. For
sockets, see [dart:io][dartio].

* TOC Placeholder
{:toc}

## Using the `http` package

Flutter supports the [http package][http], version `0.11.3+12` or later.

Start by declaring a dependency on `http` in `pubspec.yaml`:

```
dependencies:
  ...
  http: '>=0.11.3+12'
```

## Making HTTP requests

Next, create an HTTP [Client][client]. We recommend using
[`createHttpClient`](https://docs.flutter.io/flutter/services/createHttpClient.html)
to enable tests to provide an `http.MockClient`:

<!-- skip -->
```dart
import 'package:flutter/services.dart';

var httpClient = createHttpClient();
```

The client supports common HTTP operations, such as:

* **HTTP GET:** Use [`get`][get] for a general request, [`read`][read] for a
 request returning a string, or [`readbytes`][readbytes] for a request
 returning bytes.

* **HTTP POST:** Use [`post`][post] for a general post.

Code sample:

<!-- skip -->
```dart
postData() async {
  ...
  var response = await httpClient.post(url, body: {"name": "doodle", "color": "blue"});
  print("Response status: ${response.statusCode}");
}
```

Note that the HTTP APIs use [Dart
Futures](https://www.dartlang.org/tutorials/language/futures) in the return
values. We recommend using the API calls with the `async`/`await` syntax as shown in
the preceding code sample.

## Decoding and encoding JSON

Support for decoding and encoding JSON is provided by the [`dart:convert`](https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html) library.

To decode the JSON string and parse the response into a Map:

<!-- skip -->
```dart
Map data = JSON.decode(response.body);
// Assume the response body is something like: ["foo", { "bar": 499 }]
int barValue = data[1]['bar']; // barValue is set to 499
```

To encode JSON, pass a simple value (string, boolean, or number literal), or a
Map, List, or List of Maps containing simple values, to the `encode` method:

<!-- skip -->
```dart
String encodedString = JSON.encode([1, 2, { "a": null }]);
```

## Example: decoding JSON from HTTPS GET

The following example shows how to decode JSON from an HTTPS GET call in a Flutter app.

It calls the [httpbin.com](http://httpbin.com) web service testing API,
which then responds with your local IP address. Note that secure
networking (HTTPS) is used.

1. Create a new flutter app with `flutter create`.

1. Add the [http dependency](#using-http-package).

1. Replace the contents of `lib/main.dart` with the following:

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  _getIPAddress() async {
    String url = "https://httpbin.org/ip";
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);
    String ip = data["origin"];

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _ipAddress = ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(height: 32.0);

    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            spacer,
            new Text('Your current IP address is:'),
            new Text('$_ipAddress.'),
            spacer,
            new RaisedButton(
              onPressed: _getIPAddress,
              child: new Text('Get IP address'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## API docs

For full API docs, see:

  * [package `http`][http]
  * [`Client` in package `http`][client]
  * [library `dart:convert`][convert]
  * [library `dart:io`][dartio]

[http]:       https://pub.dartlang.org/packages/http
[client]:     https://www.dartdocs.org/documentation/http/latest/http/Client-class.html
[get]:        https://www.dartdocs.org/documentation/http/latest/http/get.html
[read]:       https://www.dartdocs.org/documentation/http/latest/http/read.html
[readbytes]:  https://www.dartdocs.org/documentation/http/latest/http/readbytes.html
[post]:       https://www.dartdocs.org/documentation/http/latest/http/post.html
[convert]:    https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html
[dartio]:     https://api.dartlang.org/stable/dart-io/dart-io-library.html
