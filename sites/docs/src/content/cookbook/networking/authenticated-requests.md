---
title: Make authenticated requests
description: How to fetch authorized data from a web service.
---

<?code-excerpt path-base="cookbook/networking/authenticated_requests/"?>

To fetch data from most web services, you need to provide
authorization. There are many ways to do this,
but perhaps the most common uses the `Authorization` HTTP header.

## Add authorization headers

The [`http`][] package provides a
convenient way to add headers to your requests.
Alternatively, use the [`HttpHeaders`][]
class from the `dart:io` library.

<?code-excerpt "lib/main.dart (get)"?>
```dart
final response = await http.get(
  Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  // Send authorization headers to the backend.
  headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
);
```

## Complete example

This example builds upon the
[Fetching data from the internet][] recipe.

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return Album.fromJson(responseJson);
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
```


[Fetching data from the internet]: /cookbook/networking/fetch-data
[`http`]: {{site.pub-pkg}}/http
[`HttpHeaders`]: {{site.dart.api}}/dart-io/HttpHeaders-class.html
