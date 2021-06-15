---
title: Parse JSON in the background
description: How to perform a task in the background.
prev:
  title: Make authenticated requests
  path: /docs/cookbook/networking/authenticated-requests
next:
  title: Send data to the internet
  path: /docs/cookbook/networking/send-data
---

<?code-excerpt path-base="../null_safety_examples/cookbook/networking/background_parsing/"?>

By default, Dart apps do all of their work on a single thread.
In many cases, this model simplifies coding and is fast enough
that it does not result in poor app performance or stuttering animations,
often called "jank."

However, you might need to perform an expensive computation,
such as parsing a very large JSON document.
If this work takes more than 16 milliseconds,
your users experience jank.

To avoid jank, you need to perform expensive computations
like this in the background.
On Android, this means scheduling work on a different thread.
In Flutter, you can use a separate [Isolate][].
This recipe uses the following steps:

  1. Add the `http` package.
  2. Make a network request using the `http` package.
  3. Convert the response into a list of photos.
  4. Move this work to a separate isolate.

## 1. Add the `http` package

First, add the [`http`][] package to your project.
The `http` package makes it easier to perform network
requests, such as fetching data from a JSON endpoint.

```yaml
dependencies:
  http: <latest_version>
```

## 2. Make a network request

This example covers how to fetch a large JSON document
that contains a list of 5000 photo objects from the
[JSONPlaceholder REST API][],
using the [`http.get()`][] method.

<?code-excerpt "lib/main_step2.dart (fetchPhotos)"?>
```dart
Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
}
```

{{site.alert.note}}
  You're providing an `http.Client` to the function in this example.
  This makes the function easier to test and use in different environments.
{{site.alert.end}}

## 3. Parse and convert the JSON into a list of photos

Next, following the guidance from the
[Fetch data from the internet][] recipe,
convert the `http.Response` into a list of Dart objects.
This makes the data easier to work with.

### Create a `Photo` class

First, create a `Photo` class that contains data about a photo.
Include a `fromJson()` factory method to make it easy to create a
`Photo` starting with a JSON object.

<?code-excerpt "lib/main_step3.dart (Photo)"?>
```dart
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
```

### Convert the response into a list of photos

Now, use the following instructions to update the
`fetchPhotos()` function so that it returns a
`Future<List<Photo>>`:

  1. Create a `parsePhotos()` function that converts the response
     body into a `List<Photo>`.
  2. Use the `parsePhotos()` function in the `fetchPhotos()` function.

<?code-excerpt "lib/main_step3.dart (parsePhotos)"?>
```dart
// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return parsePhotos(response.body);
}
```

## 4. Move this work to a separate isolate

If you run the `fetchPhotos()` function on a slower device,
you might notice the app freezes for a brief moment as it parses and
converts the JSON. This is jank, and you want to get rid of it.

You can remove the jank by moving the parsing and conversion
to a background isolate using the [`compute()`][]
function provided by Flutter. The `compute()` function runs expensive
functions in a background isolate and returns the result. In this case,
run the `parsePhotos()` function in the background.

<?code-excerpt "lib/main.dart (fetchPhotos)"?>
```dart
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}
```

## Notes on working with isolates

Isolates communicate by passing messages back and forth. These messages can
be primitive values, such as `null`, `num`, `bool`, `double`, or `String`, or
simple objects such as the `List<Photo>` in this example.

You might experience errors if you try to pass more complex objects,
such as a `Future` or `http.Response` between isolates.

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
```

![Isolate demo](/images/cookbook/isolate.gif){:.site-mobile-screenshot}

[`compute()`]: {{site.api}}/flutter/foundation/compute-constant.html
[Fetch data from the internet]: /docs/cookbook/networking/fetch-data
[`http`]: {{site.pub-pkg}}/http
[`http.get()`]: {{site.pub-api}}/http/latest/http/get.html
[Isolate]: {{site.api}}/flutter/dart-isolate/Isolate-class.html
[JSONPlaceholder REST API]: https://jsonplaceholder.typicode.com
