---
title: Delete data on the internet
description: How to use the http package to delete data on the internet.
prev:
  title: Send data to a new screen
  path: /docs/cookbook/navigation/passing-data
next:
  title: Fetch data from the internet
  path: /docs/cookbook/networking/fetch-data
---

<?code-excerpt path-base="../null_safety_examples/cookbook/networking/delete_data/"?>

This recipe covers how to delete data over
the internet using the `http` package.

This recipe uses the following steps:

  1. Add the `http` package.
  2. Delete data on the server.
  3. Update the screen.

## 1. Add the `http` package

To install the `http` package,
add it to the dependencies section of the `pubspec.yaml` file.
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

## 2. Delete data on the server

This recipe covers how to delete an album from the
[JSONPlaceholder][] using the `http.delete()` method.
Note that this requires the `id` of the album that
you want to delete. For this example,
use something you already know, for example `id = 1`.

<?code-excerpt "lib/main_step1.dart (deleteAlbum)"?>
```dart
Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
```

The `http.delete()` method returns a `Future` that contains a `Response`.

* [`Future`][] is a core Dart class for working with
  async operations. A Future object represents a potential
  value or error that will be available at some time in the future.
* The `http.Response` class contains the data received from a successful
  http call.
* The `deleteAlbum()` method takes an `id` argument that
  is needed to identify the data to be deleted from the server.

## 3. Update the screen

In order to check whether the data has been deleted or not,
first fetch the data from the [JSONPlaceholder][]
using the `http.get()` method, and display it in the screen.
(See the [Fetch Data][] recipe for a complete example.)
You should now have a **Delete Data** button that,
when pressed, calls the `deleteAlbum()` method.

<?code-excerpt "lib/main.dart (Column)" replace="/return //g"?>
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text('${snapshot.data?.title ?? 'Deleted'}'),
    ElevatedButton(
      child: Text('Delete Data'),
      onPressed: () {
        setState(() {
          _futureAlbum =
              deleteAlbum(snapshot.data!.id.toString());
        });
      },
    ),
  ],
);
```
Now, when you click on the ***Delete Data*** button,
the `deleteAlbum()` method is called and the id
you are passing is the id of the data that you retrieved
from the internet. This means you are going to delete
the same data that you fetched from the internet.

### Returning a response from the deleteAlbum() method
Once the delete request has been made,
you can return a response from the `deleteAlbum()`
method to notify our screen that the data has been deleted.

<?code-excerpt "lib/main.dart (deleteAlbum)"?>
```dart
Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}
```

`FutureBuilder()` now rebuilds when it receives a response.
Since the response won't have any data in its body
if the request was successful,
the `Album.fromJson()` method creates an instance of the
`Album` object with a default value (`null` in our case).
This behavior can be altered in any way you wish.

That's all!
Now you've got a function that deletes the data from the internet.

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
    // If the server did return a 200 OK response, then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

class Album {
  final int? id;
  final String? title;

  Album({this.id, this.title});

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
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Delete Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              // If the connection is done,
              // check for response data or an error.
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data?.title ?? 'Deleted'}'),
                      ElevatedButton(
                        child: Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum =
                                deleteAlbum(snapshot.data!.id.toString());
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```

[Fetch Data]: /docs/cookbook/networking/fetch-data
[ConnectionState]: {{site.api}}/flutter/widgets/ConnectionState-class.html
[`didChangeDependencies()`]: {{site.api}}/flutter/widgets/State/didChangeDependencies.html
[`Future`]: {{site.api}}/flutter/dart-async/Future-class.html
[`FutureBuilder`]: {{site.api}}/flutter/widgets/FutureBuilder-class.html
[JSONPlaceholder]: https://jsonplaceholder.typicode.com/
[`http`]: {{site.pub-pkg}}/http
[`http.delete()`]: {{site.pub-api}}/http/latest/http/delete.html
[`http` package]: {{site.pub-pkg}}/http/install
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Introduction to unit testing]: /docs/cookbook/testing/unit/introduction
[`initState()`]: {{site.api}}/flutter/widgets/State/initState.html
[Mock dependencies using Mockito]: /docs/cookbook/testing/unit/mocking
[JSON and serialization]: /docs/development/data-and-backend/json
[`State`]: {{site.api}}/flutter/widgets/State-class.html
