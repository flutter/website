---
title: Fetch data from the internet
description: Instructions on how to make HTTP requests and parse responses.
layout: tutorial
---

Learn the MVVM architecture pattern and how to build HTTP requests with async/await.

<SummaryCard>
title: What you'll accomplish
items:
  - title: Understand the MVVM architecture pattern
    icon: layers
  - title: Build HTTP requests with async/await
    icon: cloud_download
  - title: Handle errors and parse JSON responses
    icon: data_object
</SummaryCard>

---

### Introduction

The overarching pattern that this tutorial implements is called
_Model-View-ViewModel_ or _MVVM_.
MVVM is an [architectural pattern][] used in client apps that
separates your app into three layers:

- **Model**: Handles data operations.
- **View**: Displays the UI.
- **ViewModel**: Manages state and connects the two.

The core tenet of MVVM (and many other patterns) is *separation of concerns*.
Managing state in separate classes (outside your UI widgets) makes
your code more testable, reusable, and easier to maintain.

A single feature in your app contains each one of the MVVM components.
In this tutorial, in addition to Flutter widgets,
you'll create `ArticleModel`, `ArticleViewModel`, and `ArticleView`.

[architectural pattern]: /app-architecture/guide

### Define the Model

The Model is the source-of-truth for your app's data and is responsible for
low-level tasks such as making HTTP requests, caching data, or
managing system resources such as used by a Flutter plugin.
A model doesn't usually need to import Flutter libraries.

Create an empty `ArticleModel` class in your `main.dart` file:

```dart title="lib/main.dart"
class ArticleModel {
  // Properties and methods will be added here.
}
```

### Build the HTTP request

Wikipedia provides a REST API that returns JSON data about articles.
For this app, you'll use the endpoint that returns a random article summary.

```text
https://en.wikipedia.org/api/rest_v1/page/random/summary
```

Add a method to fetch a random Wikipedia article summary:

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
The `async` keyword marks a method as asynchronous, and
`await` waits for expressions that return a [`Future`][].

The `Uri.https` constructor safely builds URLs by
handling encoding and formatting.
This approach is more reliable than string concatenation,
especially when dealing with special characters or query parameters.

[`async` and `await`]: {{site.dart-site}}/language/async
[`Future`]: {{site.api}}/flutter/dart-async/Future-class.html

### Handle network errors

Always handle errors when making HTTP requests.
A status code of **200** indicates success, while other codes indicate errors.
If the status code isn't **200**, the model throws an error for
the UI to display to users.

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

### Parse JSON from Wikipedia

The [Wikipedia API][] returns [JSON][] data that
you decode into a `Summary` class
Complete the `getRandomArticleSummary` method:

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

The `Summary` class is defined in `summary.dart`.
If you're unfamiliar with JSON parsing,
check out the [Getting started with Dart][] tutorial.

[Wikipedia API]: https://en.wikipedia.org/api/rest_v1/
[JSON]: {{site.dart-site}}/tutorial/json
[Getting started with Dart]: {{site.dart-site}}/tutorial

### Review

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Understood the MVVM architecture pattern
    icon: layers
    details: >-
      MVVM separates your app into Model (data operations),
      View (user interface), and ViewModel (state management).
      This separation of concerns makes your code more
      testable, reusable, and easier to maintain.
  - title: Built an HTTP request to fetch Wikipedia data
    icon: cloud_download
    details: >-
      You created an `ArticleModel` class with a method that
      uses `async` and `await` to fetch data from the Wikipedia API.
      To safely build the URLs for the requests,
      you used the `Uri.https` constructor which
      handles encoding and special characters for you.
  - title: Handled errors and parsed JSON responses
    icon: data_object
    details: >-
      You checked the HTTP status code to detect errors and
      used `jsonDecode` to parse the response body.
      Then to convert the raw JSON into a typed Dart object,
      you used the `Summary.fromJson` named constructor.
</SummaryCard>

### Test yourself

<Quiz title="HTTP Requests Quiz">
- question: "What do the `async` and `await` keywords do in Dart?"
  options:
    - text: They make code run on a separate thread.
      correct: false
      explanation: Dart is single-threaded; async/await handles asynchronous operations without threads.
    - text: They mark a function as asynchronous and pause execution until a Future completes.
      correct: true
      explanation: "The `async` keyword marks a function as asynchronous, and `await` pauses execution until the Future resolves."
    - text: They automatically cache the results of function calls.
      correct: false
      explanation: Caching requires separate implementation; async/await is for handling asynchronous operations.
    - text: They convert synchronous code to run in the background.
      correct: false
      explanation: They don't move code to the background; they manage asynchronous execution flow.
- question: "Why is `Uri.https` preferred over string concatenation when building URLs in Dart?"
  options:
    - text: It makes the code shorter.
      correct: false
      explanation: Code length isn't the main benefit; proper encoding is.
    - text: It safely handles encoding and formatting, especially for special characters and query parameters.
      correct: true
      explanation: Uri.https properly encodes special characters and formats URLs, preventing common errors.
    - text: It's required by the http package.
      correct: false
      explanation: You can use strings, but Uri.https is safer and more reliable.
    - text: It automatically validates that the URL exists.
      correct: false
      explanation: Uri.https builds the URL; it doesn't check if the endpoint exists.
</Quiz>
