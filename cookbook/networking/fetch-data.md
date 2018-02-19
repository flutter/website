---
layout: page
title: "Fetch data from the internet"
---

Fetching data from the internet is necessary for most apps. Luckily, Dart and Flutter provide convenient tools to work with data from the internet!

## Ingredients
  
  * [`http`](https://pub.dartlang.org/packages/http) package
  * `convert` package (part of the Dart SDK)
  * [`FutureBuilder`](https://docs.flutter.io/flutter/widgets/FutureBuilder-class.html) Widget
  
## Directions

  1. Make a network request using the `http` package
  2. Convert the response into a custom Dart object
  3. Display the data
  
## 1. Make a network request

The Dart Team publishes the [`http`](https://pub.dartlang.org/packages/http) package for making http requests. It provides the simplest way to fetch data from the internet.

In this example, we'll fetch sample post from the [JSONPlaceholder REST API](https://jsonplaceholder.typicode.com/) using the [`http.get`](https://www.dartdocs.org/documentation/http/latest/http/get.html) method.

```dart
import 'package:http/http.dart' as http;

Future<http.Response> fetchPost() {
  return http.get('https://jsonplaceholder.typicode.com/posts/1');
}
```

The `http.get` method will return a `Future` that contains a `Response`. 

  * [`Future`](https://api.dartlang.org/stable/1.24.3/dart-async/Future-class.html) is a core Dart class for working with async operations. It is used to represent a potential value or error that will be available at some time in the future.
  * The `http.Response` class contains the data received from a successful api call.  

## 2. Convert the response into a custom Dart object

While it's easy to make a network request, working with a raw `Future<http.Response>` isn't very convenient. To make our lives easier, we can convert the `http.Response` into our own Dart object.

### Create a `Post` class

First, we'll need to create a `Post` class that contains the data from our network request. It will also include a factory constructor that allows us to create a `Post` from json.

Converting JSON by hand is only one option. For more information, please see the full article on [JSON and serialization](/json). 

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

Now, we'll update the `fetchPost` function to return a `Future<Post>`. To do so, we'll need to:

  1. Convert the response body into a json `Map` using the `dart:convert` package
  2. Convert the json `Map` into a `Post` using the `fromJson` factory.

```dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  final json = JSON.decode(response.body); 
  
  return new Post.fromJson(json); 
}
```

Hooray! Now we've got a function that we can call to fetch a Post from the internet!

## 3. Display the data

In order to fetch the data and display it on screen, we'll need to:

  1. Create a `LoadingWidget` that shows a spinner while loading the data
  2. Create a `PostWidget` that will display the Post once loaded
  3. Use a `FutureBuilder` Widget to fetch data and show the appropriate Widget
  
Note: It's also a good idea to consider error cases. For simplicity, we'll leave that out for now.

### LoadingWidget

A Widget that will show a Spinner in the center of the screen.

```dart
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}
```

### PostWidget

A Widget that will display the Title and Content of the post we've gotten from the server. 

```dart
class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(24.0),
          child: new Text(
            post.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.symmetric(horizontal: 24.0),
          child: new Text(post.body),
        ),
      ],
    );
  }
}
```

### Load and Show the Post

The `FutureBuilder` Widget comes with Flutter and makes it easy to work with async data sources. We must provide two parameters:

  1. The `Future` we want to work with. In our case, we'll call our `fetchPost()` function. 
  2. A `builder` function that tells Flutter what to render, depending on the State of the Future (Loading, Success, Error) 

```dart
class LoadAndShowPostWidget extends StatelessWidget {
  final Post post;

  LoadAndShowPostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
     future: fetchPost(),
     builder: (context, snapshot) {
       return snapshot.hasData
           ? new PostWidget(post: snapshot.data)
           : new LoadingWidget();
     },
   );
  }
}
```

## Complete Example

```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  final json = JSON.decode(response.body);

  return new Post.fromJson(json);
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
        body: new LoadAndShowPostWidget(),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(24.0),
          child: new Text(
            post.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.symmetric(horizontal: 24.0),
          child: new Text(
            post.body,
          ),
        ),
      ],
    );
  }
}

class LoadAndShowPostWidget extends StatelessWidget {
  final Post post;

  LoadAndShowPostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
     future: fetchPost(),
     builder: (context, snapshot) {
       return snapshot.hasData
           ? new PostWidget(post: snapshot.data)
           : new LoadingWidget();
     },
   );
  }
}
```