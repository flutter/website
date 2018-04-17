---
layout: page
title: "Fetch data from the internet"
permalink: /cookbook/networking/fetch-data/
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
[`http.get`](https://docs.flutter.io/flutter/package-http_http/package-http_http-library.html) 
method.

```dart
Future<http.Response> fetchPost() {
  return http.get('https://jsonplaceholder.typicode.com/posts/1');
}
```

The `http.get` method returns a `Future` that contains a `Response`. 

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
full article on [JSON and serialization](/json). 

```dart
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
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

  1. Convert the response body into a json `Map` with the `dart:convert` package
  2. Convert the json `Map` into a `Post` using the `fromJson` factory.

```dart
Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  final responseJson = json.decode(response.body); 
  
  return new Post.fromJson(responseJson); 
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

```dart
new FutureBuilder<Post>(
  future: fetchPost(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return new Text(snapshot.data.title);
    } else if (snapshot.hasError) {
      return new Text("${snapshot.error}");
    }

    // By default, show a loading spinner
    return new CircularProgressIndicator();
  },
);
```

## Complete Example

```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');
  final responseJson = json.decode(response.body);

  return new Post.fromJson(responseJson);
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fetch Data Example'),
        ),
        body: new Center(
          child: new FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
```
