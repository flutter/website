---
layout: page
title: "Parsing json in the background"
permalink: /cookbook/networking/background-parsing/
---

By default, Dart apps do all of their work on a single thread. In many cases, 
this model simplifies coding and is fast enough that it does not result in 
poor app performance or stuttering animations, often called "jank."

However, we may need to perform an expensive computation, such as parsing a 
very large json document. If this work takes more than 16 milliseconds, our 
users will experience jank.

To avoid jank, we need to perform expensive computations like this in the 
background. On Android, this would mean scheduling work on a different thread. 
In Flutter, we can use a separate [Isolate](https://docs.flutter.io/flutter/dart-isolate/Isolate-class.html).

## Directions

  1. Add the `http` and `isolate` packages
  2. Make a network request using the `http` package
  3. Parse and Convert the json into a List of Photos
  4. Move this work to a separate isolate
  
## 1. Add the `http` and `isolate` packages

First, we'll want to add the [`http`](https://pub.dartlang.org/packages/http) 
and [`isolate`](https://pub.dartlang.org/packages/isolate) packages to our 
project. The `http` package makes it easier to perform network requests, and 
the `isolate` package makes it easier to work with `Isolates`!

```yaml
dependencies:
  http: <latest_version>
  isolate: <latest_version>
```
  
## 2. Make a network request

In this example, we'll fetch a json large document that contains a list of 5000 
photo objects from the [JSONPlaceholder REST API](https://jsonplaceholder.typicode.com/) 
using the [`http.get`](https://docs.flutter.io/flutter/package-http_http/package-http_http-library.html) 
method. 

```dart
Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get('https://jsonplaceholder.typicode.com/photos');
}
```

Note: We're providing an `http.Client` to the function in this example. This
will make the function easier to test and use in different environments!

## 3. Parse and Convert the json into a List of Photos

Next, following the guidance from the [Fetch data from the internet](/cookbook/networking/fetch-data/)
recipe, we'll want to convert our `http.Response` into a list of Dart objects.
This will make the data easier to work with in the future.

### Create a `Photo` class

First, we'll need to create a `Photo` class that contains data about a photo. 
We will also include a `fromJson` factory to make it easy to create a `Photo` 
starting with a json object.

```dart
class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;

  Photo({this.id, this.title, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
```

### Convert the `http.Response` into a `List<Photo>`

Now, we'll update the `fetchPhotos` function to return a `Future<List<Photo>>`. 
To do so, we'll need to:

  1. Parse the response body using the `dart:convert` package
  2. Convert the parsed response into a `List<Photo>`

```dart
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/photos');
  final parsed = json.decode(response.body);

  return parsed.map((json) => new Photo.fromJson(json)).toList();
}
```

## 4. Move this work to a separate isolate

If you run the `fetchPhotos` function on a slower phone, you may notice the app 
freezes for a brief moment as it parses and converts the json. This is jank, 
and we want to be rid of it!

So how can we do that? By moving the parsing and conversion to a background
isolate. To do so, we'll need to:

  1. Create an `IsolateRunner`. This will allow us to run the `fetchPhotos`
  function in a background isolate.
  2. Execute the `fetchPhotos` function using the `IsolateRunner`, passing 
  through the appropriate `http.Client`
  3. Close the `IsolateRunner` when the operation is complete to ensure we clean
  up after ourselves.

In code:

```dart
Future<List<Photo>> fetchPhotosInBackground(http.Client client) async {
  // Spawn a new Isolate and wait for it to be ready
  final runner = await IsolateRunner.spawn();

  return runner
      // Run the fetchPhotos function inside the new isolate
      .run(fetchPhotos, client)
      // Shut the isolate down after the operation is complete
      .whenComplete(() => runner.close());
}
```

## Complete Example

```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isolate/isolate_runner.dart';

Future<List<Photo>> fetchPhotosInBackground(http.Client client) async {
  // Spawn a new Isolate and wait for it to be ready
  final runner = await IsolateRunner.spawn();

  return runner
      // Run the fetchPhotos function inside the new isolate
      .run(fetchPhotos, client)
      // Shut the isolate down after the operation is complete
      .whenComplete(() => runner.close());
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/photos');
  final parsed = json.decode(response.body);

  return parsed.map((json) => new Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return new MaterialApp(
      title: appTitle,
      home: new MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new FutureBuilder<List<Photo>>(
        future: fetchPhotosInBackground(new http.Client()),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? new PhotosList(photos: snapshot.data)
              : new Center(child: new CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return new Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
```

![Isolate Demo](/images/cookbook/isolate.gif)