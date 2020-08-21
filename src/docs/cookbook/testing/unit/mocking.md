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

```yaml
dependencies:
  http: <newest_version>
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: <newest_version>
```

## 2. Create a function to test

In this example, unit test the `fetchPost` function from the
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

<!-- skip -->
```dart
class Post {
  dynamic data;
  Post.fromJson(this.data);
}

Future<Post> fetchPost(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
```

## 3. Create a test file with a mock `http.Client`

Next, create a test file along with a `MockClient` class.
Following the advice in the [Introduction to unit testing][] recipe,
create a file called `fetch_post_test.dart` in the root `test` folder.

The `MockClient` class implements the `http.Client` class. This allows
you to pass the `MockClient` to the `fetchPost` function,
and return different http responses in each test.

<!-- skip -->
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  // Tests go here
}
```

## 4. Write a test for each condition

The `fetchPost()` function does one of two things:

  1. Returns a `Post` if the http call succeeds
  2. Throws an `Exception` if the http call fails

Therefore, you want to test these two conditions.
Use the `MockClient` class to return an "Ok" response
for the success test, and an error response for the unsuccessful test.
Test these conditions using the `when()` function provided by
Mockito:

<!-- skip -->
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      expect(await fetchPost(client), isA<Post>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });
  });
}
```

### 5. Run the tests

Now that you have a `fetchPost()` function with tests in place,
run the tests.

```terminal
$ dart test/fetch_post_test.dart
```

You can also run tests inside your favorite editor by following the
instructions in the [Introduction to unit testing][] recipe.

### Summary

In this example, you've learned how to use Mockito to test functions or classes
that depend on web services or databases. This is only a short introduction to
the Mockito library and the concept of mocking. For more information,
see the documentation provided by the [Mockito package][].


[Fetch data from the internet]: /docs/cookbook/networking/fetch-data
[Introduction to unit testing]: /docs/cookbook/testing/unit/introduction
[Mockito package]: {{site.pub-pkg}}/mockito
