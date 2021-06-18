---
title: Send data to the internet
description: How to use the http package to send data over the internet.
prev:
  title: Parse JSON in the background
  path: /docs/cookbook/networking/background-parsing
next:
  title: Update data over the internet
  path: /docs/cookbook/networking/update-data
---

<?code-excerpt path-base="../null_safety_examples/cookbook/networking/send_data/"?>

Sending data to the internet is necessary for most apps.
The `http` package has got that covered, too.

This recipe uses the following steps:

  1. Add the `http` package.
  2. Send data to a server using the `http` package.
  3. Convert the response into a custom Dart object.
  4. Get a `title` from user input.
  5. Display the response on screen.

## 1. Add the `http` package

To install the [`http`][] package, add it to the dependencies section
of the `pubspec.yaml` file. You can find the latest version of the
[`http` package][] on pub.dev.

```yaml
dependencies:
  http: <latest_version>
```

Import the `http` package.

<!-- skip -->
```dart
import 'package:http/http.dart' as http;
```

If you develop for android, add the following permission inside manifest tag in the AndroidManifest.xml file located at android/app/src/main.

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```


## 2. Sending data to server

This recipe covers how to create an `Album`
by sending an album title to the
[JSONPlaceholder][] using the
[`http.post()`][] method.

<!-- skip -->
```dart
Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}
```

The `http.post()` method returns a `Future` that contains a `Response`.

* [`Future`][] is a core Dart class for working with
  asynchronous operations. A Future object represents a potential
  value or error that will be available at some time in the future.
* The `http.Response` class contains the data received from a successful
  http call.
* The `createAlbum()` method takes an argument `title`
  that is sent to the server to create an `Album`.

## 3. Convert the `http.Response` to a custom Dart object

While it's easy to make a network request,
working with a raw `Future<http.Response>`
isn't very convenient.  To make your life easier,
convert the `http.Response` into a Dart object.

### Create an Album class

First, create an `Album` class that contains
the data from the network request.
It includes a factory constructor that
creates an `Album` from JSON.

Converting JSON by hand is only one option.
For more information, see the full article on
[JSON and serialization][].

<?code-excerpt "lib/main.dart (Album)"?>
```dart
class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
```

### Convert the `http.Response` to an `Album`

Use the following steps to update the `createAlbum()`
function to return a `Future<Album>`:

  1. Convert the response body into a JSON `Map` with the
     `dart:convert` package.
  2. If the server returns a `CREATED` response with a status
     code of 201, then convert the JSON `Map` into an `Album`
     using the `fromJson()` factory method.
  3. If the server doesn't return a `CREATED` response with a
     status code of 201, then throw an exception.
     (Even in the case of a "404 Not Found" server response,
     throw an exception. Do not return `null`.
     This is important when examining
     the data in `snapshot`, as shown below.)

<?code-excerpt "lib/main.dart (createAlbum)"?>
```dart
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
```

Hooray! Now you've got a function that sends the title to a
server to create an album.

## 4. Get a title from user input

Next, create a `TextField` to enter a title and
a `ElevatedButton` to send data to server.
Also define a `TextEditingController` to read the
user input from a `TextField`.

When the `ElevatedButton` is pressed, the `_futureAlbum`
is set to the value returned by `createAlbum()` method.

<?code-excerpt "lib/main.dart (Column)" replace="/^return //g;/;$//g"?>
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    TextField(
      controller: _controller,
      decoration: InputDecoration(hintText: 'Enter Title'),
    ),
    ElevatedButton(
      onPressed: () {
        setState(() {
          _futureAlbum = createAlbum(_controller.text);
        });
      },
      child: Text('Create Data'),
    ),
  ],
)
```

On pressing the **Create Data** button, make the network request,
which sends the data in the `TextField` to the server
as a `POST` request.
The Future, `_futureAlbum`, is used in the next step.

## 5. Display the response on screen

To display the data on screen, use the
[`FutureBuilder`][] widget.
The `FutureBuilder` widget comes with Flutter and
makes it easy to work with asynchronous data sources.
You must provide two parameters:

  1. The `Future` you want to work with. In this case,
     the future returned from the `createAlbum()` function.
  2. A `builder` function that tells Flutter what to render,
     depending on the state of the `Future`: loading,
     success, or error.

Note that `snapshot.hasData` only returns `true` when
the snapshot contains a non-null data value.
This is why the `createAlbum()` function should throw an exception
even in the case of a "404 Not Found" server response.
If `createAlbum()` returns `null`, then
`CircularProgressIndicator` displays indefinitely.

<?code-excerpt "lib/main.dart (FutureBuilder)" replace="/^return //g;/;$//g"?>
```dart
FutureBuilder<Album>(
  future: _futureAlbum,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!.title);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    return CircularProgressIndicator();
  },
)
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
```

[ConnectionState]: {{site.api}}/flutter/widgets/ConnectionState-class.html
[`didChangeDependencies()`]: {{site.api}}/flutter/widgets/State/didChangeDependencies.html
[Fetch Data]: /docs/cookbook/networking/fetch-data
[`Future`]: {{site.api}}/flutter/dart-async/Future-class.html
[`FutureBuilder`]: {{site.api}}/flutter/widgets/FutureBuilder-class.html
[`http`]: {{site.pub-pkg}}/http
[`http.post()`]: {{site.pub-api}}/http/latest/http/post.html
[`http` package]: {{site.pub-pkg}}/http/install
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Introduction to unit testing]: /docs/cookbook/testing/unit/introduction
[`initState()`]: {{site.api}}/flutter/widgets/State/initState.html
[JSONPlaceholder]: https://jsonplaceholder.typicode.com/
[Mock dependencies using Mockito]: /docs/cookbook/testing/unit/mocking
[JSON and serialization]: /docs/development/data-and-backend/json
[`State`]: {{site.api}}/flutter/widgets/State-class.html
