---
title: Making authenticated requests
prev:
  title: Fetch data from the internet
  path: /docs/cookbook/networking/fetch-data
next:
  title: Parsing JSON in the background
  path: /docs/cookbook/networking/background-parsing
---

In order to fetch data from many web services, you need to provide
authorization. There are many ways to do this, but perhaps the most common
uses the `Authorization` HTTP header.

## Add Authorization Headers

The [`http`]({{site.pub-pkg}}/http) package provides a
convenient way to add headers to your requests. You can also take advantage of
the `dart:io` package for common `HttpHeaders`.

<!-- skip -->
```dart
Future<http.Response> fetchPost() {
  return http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    // Send authorization headers to the backend
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
}
```

## Complete example

This example builds upon the [Fetching Data from the
Internet](/docs/cookbook/networking/fetch-data/) recipe.

```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  final responseJson = json.decode(response.body);

  return Post.fromJson(responseJson);
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
```
