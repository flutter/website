---
title: Update data over the internet
description: How to use the http package to update data over the internet.
prev:
  title: Send data to the internet
  path: /docs/cookbook/networking/send-data
next:
  title: Work with WebSockets
  path: /docs/cookbook/networking/web-sockets
---

<?code-excerpt path-base="../null_safety_examples/cookbook/networking/update_data/"?>

Updating data over the internet is necessary for most apps.
The `http` package has got that covered!

This recipe uses the following steps:

  1. Add the `http` package.
  2. Update data over the internet using the `http` package.
  3. Convert the response into a custom Dart object.
  4. Get the data from the internet.
  5. Update the existing `title` from user input.
  6. Update and display the response on screen.

## 1. Add the `http` package

To install the `http` package,
add it to the dependencies section
of the `pubspec.yaml` file.
You can find the latest version of the
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

## 2. Updating data over the internet using the `http` package

This recipe covers how to update an album title to the
[JSONPlaceholder][] using the [`http.put()`][] method.

<?code-excerpt "lib/main_step2.dart (updateAlbum)"?>
```dart
Future<http.Response> updateAlbum(String title) {
  return http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}
```

The `http.put()` method returns a `Future` that contains a `Response`.

* [`Future`][] is a core Dart class for working with
  async operations. A `Future` object represents a potential
  value or error that will be available at some time in the future.
* The `http.Response` class contains the data received from a successful
  http call.
* The `updateAlbum()` method takes an argument, `title`,
  which is sent to the server to update the `Album`.

## 3. Convert the `http.Response` to a custom Dart object

While it's easy to make a network request,
working with a raw `Future<http.Response>`
isn't very convenient. To make your life easier,
convert the `http.Response` into a Dart object.

### Create an Album class

First, create an `Album` class that contains the data from the
network request. It includes a factory constructor that
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

Now, use the following steps to update the `updateAlbum()`
function to return a `Future<Album>`:

  1. Convert the response body into a JSON `Map` with the
     `dart:convert` package.
  2. If the server returns an `UPDATED` response with a status
     code of 200, then convert the JSON `Map` into an `Album`
     using the `fromJson()` factory method.
  3. If the server doesn't return an `UPDATED` response with a
     status code of 200, then throw an exception.
     (Even in the case of a "404 Not Found" server response,
     throw an exception. Do not return `null`.
     This is important when examining
     the data in `snapshot`, as shown below.)

<?code-excerpt "lib/main.dart (updateAlbum)"?>
```dart
Future<Album> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}
```

Hooray!
Now you've got a function that updates the title of an album.

### 4. Get the data from the internet

Get the data from internet before you can update it.
For a complete example, see the [Fetch data][] recipe.

<?code-excerpt "lib/main.dart (fetchAlbum)"?>
```dart
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
```

Ideally, you will use this method to set
`_futureAlbum` during `initState` to fetch
the data from the internet.

## 5. Update the existing title from user input

Create a `TextField` to enter a title and a `ElevatedButton`
to update the data on server.
Also define a `TextEditingController` to
read the user input from a `TextField`.

When the `ElevatedButton` is pressed,
the `_futureAlbum` is set to the value returned by
`updateAlbum()` method.

<?code-excerpt "lib/main_step5.dart (Column)"?>
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Enter Title'),
      ),
    ),
    ElevatedButton(
      onPressed: () {
        setState(() {
          _futureAlbum = updateAlbum(_controller.text);
        });
      },
      child: Text('Update Data'),
    ),
  ],
);
```

On pressing the **Update Data** button, a network request
sends the data in the `TextField` to the server as a `POST` request.
The `_futureAlbum` variable is used in the next step.

## 5. Display the response on screen

To display the data on screen, use the
[`FutureBuilder`][] widget.
The `FutureBuilder` widget comes with Flutter and
makes it easy to work with async data sources.
You must provide two parameters:

  1. The `Future` you want to work with. In this case,
     the future returned from the `updateAlbum()` function.
  2. A `builder` function that tells Flutter what to render,
     depending on the state of the `Future`: loading,
     success, or error.

Note that `snapshot.hasData` only returns `true` when
the snapshot contains a non-null data value.
This is why the `updateAlbum` function should throw an exception
even in the case of a "404 Not Found" server response.
If `updateAlbum` returns `null` then
`CircularProgressIndicator` will display indefinitely.

<?code-excerpt "lib/main_step5.dart (FutureBuilder)"?>
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
);
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
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
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data!.title),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: 'Enter Title'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureAlbum = updateAlbum(_controller.text);
                          });
                        },
                        child: Text('Update Data'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```

[ConnectionState]: {{site.api}}/flutter/widgets/ConnectionState-class.html
[`didChangeDependencies()`]: {{site.api}}/flutter/widgets/State/didChangeDependencies.html
[Fetch data]: /docs/cookbook/networking/fetch-data
[`Future`]: {{site.api}}/flutter/dart-async/Future-class.html
[`FutureBuilder`]: {{site.api}}/flutter/widgets/FutureBuilder-class.html
[JSONPlaceholder]: https://jsonplaceholder.typicode.com/
[`http`]: {{site.pub-pkg}}/http
[`http.put()`]: {{site.pub-api}}/http/latest/http/put.html
[`http` package]: {{site.pub}}/packages/http/install
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Introduction to unit testing]: /docs/cookbook/testing/unit/introduction
[`initState()`]: {{site.api}}/flutter/widgets/State/initState.html
[JSON and serialization]: /docs/development/data-and-backend/json
[Mock dependencies using Mockito]: /docs/cookbook/testing/unit/mocking
[`State`]: {{site.api}}/flutter/widgets/State-class.html
