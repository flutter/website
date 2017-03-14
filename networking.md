---
layout: page
title: Making HTTP Networking Requests in Flutter
permalink: /networking/
---

This page discusses how to make HTTP networking requests in Flutter. For
HTTP servers and sockets, see [dart:io][dartio].

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

## Making HTTP requests

You can create an HTTP [Client][client] with the `Client` constructor:

<!-- skip -->
```dart
import 'package:http/http.dart' as http;

var httpClient = new http.Client();
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
values. We recommend you use the API calls with the `async`/`await` syntax as in
the code above.

## Decoding and encoding JSON

This is supported via the [`dart:convert`](https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html) library.

To decode/parse the JSON string response into a Map:

<!-- skip -->
```dart
Map data = JSON.decode(response.body);
// Assume the response body is something like: ["foo", { "bar": 499 }]
int barValue = data[1]['bar']; // barValue is set to 499
```

To encode JSON pass a simple value (string, boolean, or number literal), or a
Map, List, or List of Maps containing simple values to the `encode` method:

<!-- skip -->
```dart
String encodedString = JSON.encode([1, 2, { "a": null }]);
```

## Example Flutter app decoding JSON returned by a HTTPS GET call

The following example calls the [httpbin.com](http://httpbin.com) web service
testing API. This responds with your local IP address. Note that it uses secure
'https' networking.

1. Create a new flutter app with `flutter create`

1. Add the http dependency as discussed at the top of this page.

1. Replace the contents of `lib/main.dart` with the following:

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

  _getIPAddress() async {
    String url = "https://httpbin.org/ip";
    var httpClient = new http.Client();
    var response = await httpClient.read(url);
    Map data = JSON.decode(response);
    String ip = data["origin"];

    setState(() {
      _ipAddress = ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(height: 32.0);

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

  * [package `http`][http]
  * [`Client` in package `http`][client]
  * [library `dart:convert`][convert]
  * [library `dart:io`][dartio]

[http]:       https://pub.dartlang.org/packages/http
[client]:     https://www.dartdocs.org/documentation/http/stable/http/Client-class.html
[get]:        https://www.dartdocs.org/documentation/http/stable/http/get.html
[read]:       https://www.dartdocs.org/documentation/http/stable/http/read.html
[readbytes]:  https://www.dartdocs.org/documentation/http/stable/http/readbytes.html
[post]:       https://www.dartdocs.org/documentation/http/stable/http/post.html
[convert]:    https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html
[dartio]:     https://api.dartlang.org/stable/dart-io/dart-io-library.html