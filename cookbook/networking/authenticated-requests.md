---
layout: page
title: "Making authenticated requests"
permalink: /cookbook/networking/authenticated-requests/
---

In order to fetch data from many web services, you need to provide 
authorization. There are many ways to do this, but perhaps the most common 
requires using the `Authorization` HTTP header.

## Add Authorization Headers

The [`http`](https://pub.dartlang.org/packages/http) package provides a 
convenient way to add headers to your requests. You can also take advantage of 
the `dart:io` package for common `HttpHeaders`.

```dart
Future<http.Response> fetchPost() {
  return http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    // Send authorization headers to your backend
    headers: {HttpHeaders.AUTHORIZATION: "Basic your_api_token_here"},
  );
}
```

## Complete Example

This example builds upon the [Fetching Data from the Internet](/cookbook/networking/fetch-data/) 
recipe.

```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    headers: {HttpHeaders.AUTHORIZATION: "Basic your_api_token_here"},
  );
  final json = json.decode(response.body); 
  
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