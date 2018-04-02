---
layout: page
title: Making HTTP Networking Requests in Flutter
permalink: /networking/
---

This page describes how to make HTTP networking requests in Flutter. For
sockets, see [dart:io][dartio].

* TOC Placeholder
{:toc}

## Making HTTP requests

The core http support is in [`dart:io`][dartio], so to create an HTTP [Client][client]
we need to add an import:
<!-- skip -->
```dart
import 'dart:io';

var httpClient = new HttpClient();
```

The client supports common HTTP operations, such as [`GET`][get],
[`POST`][post], [`PUT`][put], [`DELETE`][delete].  

## Dealing with asynchronousy

Note that the HTTP APIs use [Dart
Futures](https://www.dartlang.org/tutorials/language/futures) in the return
values. We recommend using the API calls with the `async`/`await` syntax.

The networking calls generally follow a stepped approach:

1. Create the client.
2. Construct the Uri.
3. Invoke the operation, and await the request object. Optionally, configure the
   headers and body of the request.
4. Close the request, and await the response.
5. Decode the response.

Several of these steps use Future based APIs. Sample APIs calls for each step
above are:

<!-- skip -->
```dart
get() async {
  var httpClient = new HttpClient();
  var uri = new Uri.http(
      'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
}
```

See 'Example' below for a full code sample.

## Decoding and encoding JSON

Simple decoding and encoding of JSON is possible using the
[`dart:convert`](https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html)
library. For additional JSON documentation, see [JSON and serialization](/json/).

To decode a simple JSON string and parse the response into a Map:

<!-- skip -->
```dart
Map data = json.decode(responseBody);
// Assume the response body is something like: ['foo', { 'bar': 499 }]
int barValue = data[1]['bar']; // barValue is set to 499
```

To encode simple JSON, pass a simple value (string, boolean, or number literal), or a
Map, List, or List of Maps containing simple values, to the `encode` method:

<!-- skip -->
```dart
String encodedString = json.encode([1, 2, { 'a': null }]);
```

## Example: JSON request via HTTPS POST

The following example shows how to make a RESTful style JSON request via an HTTPS POST call.

```dart
import 'dart:async';
import 'dart:convert' show UTF8, JSON;
import 'dart:io';

Future<Map<String, dynamic>> performApiRequest(
    HttpClient client, String url, Map<String, dynamic> jsonBody,
    [String accessToken]) async {
  final String requestBody = JSON.encode(jsonBody);
  HttpClientRequest request = await client.postUrl(Uri.parse(url))
    ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
    ..headers.contentType = ContentType.JSON
    ..headers.contentLength = requestBody.length
    ..headers.chunkedTransferEncoding = false;
  if (accessToken != null) {
    request.headers.add(HttpHeaders.AUTHORIZATION, 'Bearer $accessToken');
  }
  request.write(requestBody);
  HttpClientResponse response = await request.close();
  if (response.headers.contentType.toString() != ContentType.JSON.toString()) {
    throw new UnsupportedError('Server returned an unsupported content type: '
        '${response.headers.contentType} from ${request.uri}');
  }
  if (response.statusCode != HttpStatus.OK) {
    throw new StateError(
        'Server responded with error: ${response.statusCode} ${response.reasonPhrase}');
  }
  return JSON.decode(await response.transform(UTF8.decoder).join());
}
```


## Example: decoding JSON from HTTPS GET

The following example shows how to decode JSON from an HTTPS GET call in a Flutter app.

It calls the [httpbin.com](https://httpbin.com) web service testing API,
which then responds with your local IP address. Note that secure
networking (HTTPS) is used.

1. Create a new flutter app with `flutter create`.

1. Replace the contents of `lib/main.dart` with the following:

```dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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
  var _ipAddress = 'Unknown';

  _getIPAddress() async {
    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonString = await response.transform(utf8.decoder).join();
        var data = json.decode(jsonString);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _ipAddress = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(height: 32.0);

    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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

  * [library `dart:io`][dartio]
  * [library `dart:convert`][convert]

[dartio]:     https://docs.flutter.io/flutter/dart-io/dart-io-library.html
[convert]:    https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html
[client]:     https://docs.flutter.io/flutter/dart-io/HttpClient-class.html
[get]:        https://docs.flutter.io/flutter/dart-io/HttpClient/getUrl.html
[post]:       https://docs.flutter.io/flutter/dart-io/HttpClient/postUrl.html
[put]:        https://docs.flutter.io/flutter/dart-io/HttpClient/putUrl.html
[delete]:     https://docs.flutter.io/flutter/dart-io/HttpClient/deleteUrl.html
