---
layout: page
title: "Fetch data from the internet"
permalink: /cookbook/networking/fetch-data/
---

Fetching data from the internet is necessary for most apps. Luckily, Dart and 
Flutter provide tools for this type of work!
  
## Directions

  1. Make a network request using the `http` package
  2. Convert the response into a custom Dart object
  
## 1. Make a network request

The [`http`](https://pub.dartlang.org/packages/http) package provides the 
simplest way to fetch data from the internet.

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

## 2. Convert the response into a custom Dart object

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
  final json = JSON.decode(response.body); 
  
  return new Post.fromJson(json); 
}
```

Hooray! Now we've got a function that we can call to fetch a Post from the 
internet!

## Complete Example

```dart
import 'dart:async';
import 'dart:convert';
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
```