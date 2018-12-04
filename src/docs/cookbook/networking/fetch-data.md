---
title: Fetch data from the internet
---

Fetching data from the internet is necessary for most apps. Luckily, Dart and
Flutter provide tools for this type of work!

## Directions

  1. Add the `http` package
  2. Make a network request using the `http` package
  3. Convert the response into a custom Dart object
  4. Fetch and Display the data with Flutter

## 1. Add the `http` package

The [`http`](https://pub.dartlang.org/packages/http) package provides the
simplest way to fetch data from the internet.

To install the `http` package, we need to add it to the dependencies section
of our `pubspec.yaml`. We can [find the latest version of the http package on
the pub website](https://pub.dartlang.org/packages/http#-installing-tab-).

```yaml
dependencies:
  http: <latest_version>
```

## 2. Make a network request

In this example, we'll fetch a sample post from the
[JSONPlaceholder REST API](https://jsonplaceholder.typicode.com/) using the
[http.get()]({{site.pub-api}}/http/latest/http/get.html) method.

<!-- skip -->
```dart
Future<http.Response> fetchPost() {
  return http.get('https://jsonplaceholder.typicode.com/posts/1');
}
```

The `http.get()` method returns a `Future` that contains a `Response`.

  * [`Future`](https://docs.flutter.io/flutter/dart-async/Future-class.html) is
  a core Dart class for working with async operations. It is used to represent a
  potential value or error that will be available at some time in the future.
  * The `http.Response` class contains the data received from a successful http
  call.

## 3. Convert the response into a custom Dart object

While it's easy to make a network request, working with a raw
`Future<http.Response>` isn't very convenient. To make our lives easier, we can
convert the `http.Response` into our own Dart object.

### Create a `Post` class

First, we'll need to create a `Post` class that contains the data from our
network request. It will also include a factory constructor that allows us to
create a `Post` from json.

Converting JSON by hand is only one option. For more information, please see the
full article on [JSON and serialization](/docs/development/data-and-backend/json).

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

Now, we'll update the `fetchPost` function to return a `Future<Post>`. To do so,
we'll need to:

  1. Convert the response body into a json `Map` with the `dart:convert`
  package.
  2. If the server returns an "OK" response with a status code of 200, convert
  the json `Map` into a `Post` using the `fromJson` factory.
  3. If the server returns an unexpected response, throw an error

<!-- skip -->
```dart
Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
```

Hooray! Now we've got a function that we can call to fetch a Post from the
internet!

## 4. Fetch and Display the data

In order to fetch the data and display it on screen, we can use the
[`FutureBuilder`](https://docs.flutter.io/flutter/widgets/FutureBuilder-class.html)
widget! The `FutureBuilder` Widget comes with Flutter and makes it easy to work
with async data sources.

We must provide two parameters:

  1. The `Future` we want to work with. In our case, we'll call our
  `fetchPost()` function.
  2. A `builder` function that tells Flutter what to render, depending on the
  state of the `Future`: loading, success, or error.

<!-- skip -->
```dart
FutureBuilder<Post>(
  future: fetchPost(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data.title);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    // By default, show a loading spinner
    return CircularProgressIndicator();
  },
);
```

## 5. Moving the fetch call out of the `build()` method

Although it's convenient, it's not recommended to put a call to an API in your
`build()` method.

Flutter calls the `build()` method every time it wants to change anything in the
view, and this happens surprisingly often.  If you leave the fetch call in your
`build()` method, you'll flood the API with unnecessary calls and slow down your
app.

Here are some better options so it'll only hit the API when the page is
initially loaded.

### Pass it into a `StatelessWidget`

With this strategy, the parent widget is responsible for calling the fetch
method, storing its result, and then passing it to your widget.

<!-- skip -->
```dart
class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);
```

You can see a working example of this in the complete example below.

### Call it in the lifecycle of a `StatefulWidget`'s state

If your widget is stateful, you can call the fetch method in either the
[`initState`](https://docs.flutter.io/flutter/widgets/State/initState.html) or
[`didChangeDependencies`](https://docs.flutter.io/flutter/widgets/State/didChangeDependencies.html)
methods.

`initState` is called exactly once and then never again. If you want to have the
option of reloading the API in response to an
[`InheritedWidget`](https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html)
changing, put the call into the `didChangeDependencies` method.  See
[`State`](https://docs.flutter.io/flutter/widgets/State-class.html) for more
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

## Testing

For information on how to test this functionality, please see the following
recipes:

  * [Introduction to unit testing](/docs/cookbook/testing/unit)
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
    // If the call to the server was successful, parse the JSON
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

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

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

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```
