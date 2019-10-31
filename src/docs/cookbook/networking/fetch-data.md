---
title: Fetch data from the internet
prev:
  title: Send data to a new screen
  path: /docs/cookbook/navigation/passing-data
next:
  title: Make authenticated requests
  path: /docs/cookbook/networking/authenticated-requests
---

Fetching data from the internet is necessary for most apps.
Luckily, Dart and Flutter provide tools, such as the
`http` package, for this type of work.

This recipe uses the following steps:

  1. Add the `http` package.
  2. Make a network request using the `http` package.
  3. Convert the response into a custom Dart object.
  4. Fetch and display the data with Flutter.

## 1. Add the `http` package

The [`http`]({{site.pub-pkg}}/http) package provides the
simplest way to fetch data from the internet.

To install the `http` package, add it to the dependencies section
of the `pubspec.yaml`. You can find the latest version of the
[http package]({{site.pub}}/packages/http#-installing-tab-)
the pub.dev.

```yaml
dependencies:
  http: <latest_version>
```

Import the http package.

<!-- skip -->
```dart
import 'package:http/http.dart' as http;
```

## 2. Make a network request

In this example, fetch a sample post from the
[JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the
[http.get()]({{site.pub-api}}/http/latest/http/get.html) method.

<!-- skip -->
```dart
Future<http.Response> fetchPost() {
  return http.get('https://jsonplaceholder.typicode.com/posts/1');
}
```

The `http.get()` method returns a `Future` that contains a `Response`.

  * [`Future`]({{site.api}}/flutter/dart-async/Future-class.html) is
    a core Dart class for working with async operations.
    A Future object represents a potential value or error that will be
    available at some time in the future.
  * The `http.Response` class contains the data received from a successful
    http call.

## 3. Convert the response into a custom Dart object

While it's easy to make a network request, working with a raw
`Future<http.Response>` isn't very convenient. To make your life easier,
convert the `http.Response` into a Dart object.

### Create a `Post` class

First, create a `Post` class that contains the data from the
network request. It includes a factory constructor that
creates a `Post` from JSON.

Converting JSON by hand is only one option. For more information,
see the full article on [JSON and
serialization](/docs/development/data-and-backend/json).

<!-- skip -->
```dart
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
```

### Convert the `http.Response` to a `Post`

Now, use the following steps to update the `fetchPost()`
function to return a `Future<Post>`:

  1. Convert the response body into a JSON `Map` with the `dart:convert`
     package.
  2. If the server returns an "OK" response with a status code of 200, convert
     the JSON `Map` into a `Post` using the `fromJson()` factory method.
  3. If the server returns an unexpected response, throw an error.

<!-- skip -->
```dart
Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
```

Hooray! Now you've got a function that fetches a post from the
internet.

## 4. Fetch the data
Call the fetch method in either the
[`initState()`]({{site.api}}/flutter/widgets/State/initState.html) or
[`didChangeDependencies()`]({{site.api}}/flutter/widgets/State/didChangeDependencies.html)
methods.

The `initState()` method is called exactly once and then never again.
If you want to have the option of reloading the API in response to an
[`InheritedWidget`]({{site.api}}/flutter/widgets/InheritedWidget-class.html)
changing, put the call into the `didChangeDependencies()` method.  See
[`State`]({{site.api}}/flutter/widgets/State-class.html) for more
details.

<!-- skip -->
```dart
class _MyAppState extends State<MyApp> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }
```

This Future will be used in the next step.

## 5. Display the data
To to display the data on screen, use the
[`FutureBuilder`]({{site.api}}/flutter/widgets/FutureBuilder-class.html)
widget. The `FutureBuilder` widget comes with Flutter and makes it easy
to work with async data sources.

You must provide two parameters:

  1. The `Future` you want to work with. In this case, the future returned from
  the `fetchPost()` function.
  2. A `builder` function that tells Flutter what to render, depending on the
  state of the `Future`: loading, success, or error.

<!-- skip -->
```dart
FutureBuilder<Post>(
  future: post,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data.title);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
);
```

## Why is fetchPost() called in initState()?

Although it's convenient, it's not recommended to put an API call in a
`build()` method.

Flutter calls the `build()` method every time it wants to change anything
in the view, and this happens surprisingly often. If you leave the fetch
call in your `build()` method, you'll flood the API with unnecessary calls
and slow down your app.

## Testing

For information on how to test this functionality,
see the following recipes:

  * [Introduction to unit testing](/docs/cookbook/testing/unit/introduction)
  * [Mock dependencies using Mockito](/docs/cookbook/testing/unit/mocking)

## Complete example

```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
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
