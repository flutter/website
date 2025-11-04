---
title: State management in Flutter
description: Instructions on how to manage state with ChangeNotifiers.
permalink: /tutorial/change-notifier/
sitemap: false
---

When developers talk about state-management in Flutter, they're
essentially referring to the pattern by which your app updates the
data it needs to render correctly, and then tells Flutter to re-render
the UI with that new data.

In MVVM, this responsibility falls to the ViewModel layer, which sits
between and connects your UI to your Model layer. In Flutter,
ViewModels use Flutter's `ChangeNotifier` class to
notify the UI when data changes.

To use [ChangeNotifier][], extend it in your state management class to
gain access to the `notifyListeners()` method, which triggers UI
rebuilds when called.

## Create the basic ViewModel structure

Create the `ArticleViewModel` class with its basic structure and state
properties:

```dart
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model);
}
```

The ViewModel holds three pieces of state:

- `summary`: The current Wikipedia article data.
- `errorMessage`: Any error that occurred during data fetching.
- `loading`: A flag to show progress indicators.

## Add constructor initialization

Update the constructor to automatically fetch content when the
ViewModel is created:

```dart
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }

  // Method will be added next
}
```

This constructor initialization provides immediate content when the
ViewModel is created. Because constructors can't be asynchronous,
it delegates initial content fetching to a separate method.

## Create the getRandomArticleSummary method

Add the method that fetches data and manages state updates:

```dart
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }

  Future<void> getRandomArticleSummary() async {
    loading = true;
    notifyListeners();

    // TODO: Add data fetching logic

    loading = false;
    notifyListeners();
  }
}
```
The ViewModel updates the `loading` property and calls
`notifyListeners()` to inform the UI. When the operation completes, it
toggles the property back. When you build the UI, you'll use this
`loading` property to show a loading indicator while fetching a new
article.

## Retrieve an article from the ArticleModel

Complete the `getRandomArticleSummary` method to fetch an article
summary. Use a [try-catch block][] to gracefully handle network
errors, and store error messages that the UI can display to users. The
method clears previous errors on success and clears the previous
article summary on error to maintain consistent state.

```dart
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }

  Future<void> getRandomArticleSummary() async {
    loading = true;
    notifyListeners();
    try {
      summary = await model.getRandomArticleSummary();
      errorMessage = null; // Clear any previous errors
    } on HttpException catch (error) {
      errorMessage = error.message;
      summary = null;
    }
    loading = false;
    notifyListeners();
  }
}
```

## Test the ViewModel

Before building the full UI, test that your HTTP requests work by
printing results to the console. First, update your
`ArticleViewModel`'s `getRandomArticleSummary` method to print the
results:

```dart
Future<void> getRandomArticleSummary() async {
  loading = true;
  notifyListeners();
  try {
    summary = await model.getRandomArticleSummary();
    print('Article loaded: ${summary!.titles.normalized}'); // Temporary
    errorMessage = null;
  } on HttpException catch (error) {
    print('Error loading article: ${error.message}'); // Temporary
    errorMessage = error.message;
    summary = null;
  }
  loading = false;
  notifyListeners();
}
```

Then, update the `MainApp` widget to create the ViewModel, which calls
the `getRandomArticleSummary` method on creation:

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create ViewModel to test HTTP requests
    final viewModel = ArticleViewModel(ArticleModel());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wikipedia Flutter'),
        ),
        body: const Center(
          child: Text('Check console for article data'),
        ),
      ),
    );
  }
}
```

Hot reload your app and check your console output. You should see
either an article title or an error message, which confirms that your
Model and ViewModel are wired up correctly.

[ChangeNotifier]: {{site.api}}/flutter/foundation/ChangeNotifier-class.html
[try-catch block]: https://dart.dev/language/error-handling
