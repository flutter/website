---
title: Mock dependencies using Mockito
description: Use the Mockito package to mimic the behavior of services for testing.
short-title: Mocking
prev:
  title: An introduction to unit testing
  path: /docs/cookbook/testing/unit/introduction
next:
  title: An introduction to widget testing
  path: /docs/cookbook/testing/widget/introduction
---

<?code-excerpt path-base="../null_safety_examples/cookbook/testing/unit/mocking"?>

Sometimes, unit tests might depend on classes that fetch data from live
web services or databases. This is inconvenient for a few reasons:

  * Calling live services or databases slows down test execution.
  * A passing test might start failing if a web service or database returns
    unexpected results. This is known as a "flaky test."
  * It is difficult to test all possible success and failure scenarios
    by using a live web service or database.

Therefore, rather than relying on a live web service or database,
you can "mock" these dependencies. Mocks allow emulating a live
web service or database and return specific results depending
on the situation.

Generally speaking, you can mock dependencies by creating an alternative
implementation of a class. Write these alternative implementations by
hand or make use of the [Mockito package][] as a shortcut.

This recipe demonstrates the basics of mocking with the
Mockito package using the following steps:

  1. Add the package dependencies.
  2. Create a function to test.
  3. Create a test file with a mock `http.Client`.
  4. Write a test for each condition.
  5. Run the tests.

For more information, see the [Mockito package][] documentation.

## 1. Add the package dependencies

To use the `mockito` package, add it to the
`pubspec.yaml` file along with the `flutter_test` dependency in the
`dev_dependencies` section.

This example also uses the `http` package,
so define that dependency in the `dependencies` section.

`mockito: 5.0.0` supports Dart's null safety thanks to code generation.
To run the required code generation, add the `build_runner` dependency
in the `dev_dependencies` section.

```yaml
dependencies:
  http: <newest_version>
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: <newest_version>
  build_runner: <newest_version>
```

## 2. Create a function to test

In this example, unit test the `fetchAlbum` function from the
[Fetch data from the internet][] recipe.
To test this function, make two changes:

  1. Provide an `http.Client` to the function. This allows providing the
     correct `http.Client` depending on the situation.
     For Flutter and server-side projects, provide an `http.IOClient`.
     For Browser apps, provide an `http.BrowserClient`.
     For tests, provide a mock `http.Client`.
  2. Use the provided `client` to fetch data from the internet,
     rather than the static `http.get()` method, which is difficult to mock.

The function should now look like this:

<?code-excerpt "lib/main.dart (fetchAlbum)"?>
```dart
Future<Album> fetchAlbum(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
```

In your app code, you can provide an `http.Client` to the `fetchAlbum` method 
directly with `fetchAlbum(http.Client())`. `http.Client()` creates a default
`http.Client`.

## 3. Create a test file with a mock `http.Client`

Next, create a test file.

Following the advice in the [Introduction to unit testing][] recipe,
create a file called `fetch_album_test.dart` in the root `test` folder.

Add the annotation `@GenerateMocks([http.Client])` to the main
function to generate a `MockClient` class with `mockito`.

The generated `MockClient` class implements the `http.Client` class.
This allows you to pass the `MockClient` to the `fetchAlbum` function,
and return different http responses in each test.

The generated mocks will be located in `fetch_album_test.mocks.dart`.
Import this file to use them.

<?code-excerpt "test/fetch_album_test.dart (mockClient)"?>
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocking/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
```

Next, generate the mocks running the following command:

```terminal
$ flutter pub run build_runner build
```

## 4. Write a test for each condition

The `fetchAlbum()` function does one of two things:

  1. Returns an `Album` if the http call succeeds
  2. Throws an `Exception` if the http call fails

Therefore, you want to test these two conditions.
Use the `MockClient` class to return an "Ok" response
for the success test, and an error response for the unsuccessful test.
Test these conditions using the `when()` function provided by
Mockito:

<?code-excerpt "test/fetch_album_test.dart"?>
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocking/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
```

## 5. Run the tests

Now that you have a `fetchAlbum()` function with tests in place,
run the tests.

```terminal
$ flutter test test/fetch_album_test.dart
```

You can also run tests inside your favorite editor by following the
instructions in the [Introduction to unit testing][] recipe.

## Complete example

##### lib/main.dart

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
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
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
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

##### test/fetch_album_test.dart

<?code-excerpt "test/fetch_album_test.dart"?>
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocking/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
```

## Summary

In this example, you've learned how to use Mockito to test functions or classes
that depend on web services or databases. This is only a short introduction to
the Mockito library and the concept of mocking. For more information,
see the documentation provided by the [Mockito package][].


[Fetch data from the internet]: /docs/cookbook/networking/fetch-data
[Introduction to unit testing]: /docs/cookbook/testing/unit/introduction
[Mockito package]: {{site.pub-pkg}}/mockito
