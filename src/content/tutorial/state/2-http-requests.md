---
title: Fetch data from the internet
description: Instructions on how to make HTTP requests and parse responses.
permalink: /tutorial/http-request/
sitemap: false
---

The overarching pattern that this tutorial implements is called
*Model-View-ViewModel* or *MVVM*. MVVM is an [architectural pattern][]
used in client apps that separates your app into three layers: the
Model handles data operations, the View displays the UI, and the
ViewModel manages state and connects them. The core tenet of MVVM
(and many other patterns) is *separation of concerns*. Managing state
in separate classes (outside your UI widgets) makes your code more
testable, reusable, and easier to maintain.

<img src="/assets/images/docs/tutorial/simple_mvvm.png" width="100%"
alt="A diagram that shows the three layers of MVVM architecture: Model, ViewModel, and View.">

A single feature in your app contains each one of the MVVM components. In
this tutorial, you'll create an `ArticleModel`, `ArticleViewModel` and
`ArticleView`, in addition to Flutter widgets.

## Define the Model

The Model is the source-of-truth for your app's data, and is
responsible for low-level tasks such as making HTTP
requests, caching data, or managing system resources such as a plugin.
A model doesn't usually need to import Flutter libraries.

Create an empty `ArticleModel` class in your `main.dart` file:

```dart
class ArticleModel {
  // Properties and methods will be added here.
}
```

## Build the HTTP request

Wikipedia provides a REST API that returns JSON data about articles.
For this app, you'll use the endpoint that returns a random article
summary.

```txt
https://en.wikipedia.org/api/rest_v1/page/random/summary
```

Add a method to fetch random Wikipedia article summaries:

```dart
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);

    // TODO: Add error handling and JSON parsing.
  }
}
```

Use the [`async` and `await`][] keywords to handle asynchronous operations.
The `async` keyword marks a method as asynchronous, and `await` marks
expressions that return a [`Future`][].

The `Uri.https()` constructor safely builds URLs by handling encoding
and formatting. This approach is more reliable than string
concatenation, especially when dealing with special characters or
query parameters.

## Handle network errors

Always handle errors when making HTTP requests. A status code of 200 indicates
success, while other codes indicate errors. If the
status code isn't 200, the model throws an error for the UI to
display to users.

```dart
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);

    if (response.statusCode != 200) {
      throw HttpException('Failed to update resource');
    }

    // TODO: Parse JSON and return Summary.
  }
}
```

## Parse JSON from Wikipedia

The [Wikipedia API][] returns [JSON][] data that you decode into
a `Summary` class. Complete the `getRandomArticleSummary` method:

```dart
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);

    if (response.statusCode != 200) {
      throw HttpException('Failed to update resource');
    }

    return Summary.fromJson(jsonDecode(response.body));
  }
}
```

The `dartpedia` package provides the `Summary` class. If you're
unfamiliar with JSON parsing, see the [Dart Getting Started
tutorial][].

[architectural pattern]: /architecture/guide
[JSON]: {{site.dart-site}}/tutorial/json
[`async` and `await`]: https://dart.dev/language/async
[`Future`]: https://api.dart.dev/stable/dart-async/Future-class.html
[Wikipedia API]: https://en.wikipedia.org/api/rest_v1/
[Dart Getting Started tutorial]: {{site.dart-site}}/tutorial/json
