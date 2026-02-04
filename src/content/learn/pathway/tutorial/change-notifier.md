---
title: State management in Flutter
description: Instructions on how to manage state with ChangeNotifiers.
layout: tutorial
---

Learn to create a ViewModel with ChangeNotifier and manage loading, success, and error states.

<SummaryCard>
title: What you'll accomplish
items:
  - title: Create a ViewModel with ChangeNotifier
    icon: layers
  - title: Manage loading, success, and error states
    icon: toggle_on
  - title: Signal UI updates with notifyListeners
    icon: notifications_active
</SummaryCard>

---

### Introduction

When developers talk about state-management in Flutter,
they're essentially referring to the pattern by which your app
updates the data it needs to render correctly and then
tells Flutter to re-render the UI with that new data.

In MVVM, this responsibility falls to the ViewModel layer,
which sits between and connects your UI to your Model layer.
In Flutter, ViewModels use Flutter's `ChangeNotifier` class to
notify the UI when data changes.

To use [`ChangeNotifier`][], extend it in your state management class to
gain access to the `notifyListeners()` method,
which triggers UI rebuilds when called.

[`ChangeNotifier`]: {{site.api}}/flutter/foundation/ChangeNotifier-class.html

### Create the basic view model structure

Create the `ArticleViewModel` class with its
basic structure and state properties:

```dart
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model);
}
```

The `ArticleViewModel` holds three pieces of state:

- `summary`: The current Wikipedia article data.
- `errorMessage`: Any error that occurred during data fetching.
- `loading`: A flag to show progress indicators.

### Add constructor initialization

Update the constructor to automatically fetch content when the
`ArticleViewModel` is created:

```dart
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }

  // Methods will be added next.
}
```

This constructor initialization provides immediate content when
a `ArticleViewModel` object is created.
Because constructors can't be asynchronous,
it delegates initial content fetching to a separate method.

### Set up the `getRandomArticleSummary` method

Add the `getRandomArticleSummary` that fetches data and manages state updates:

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

The ViewModel updates the `loading` property and
calls `notifyListeners()` to inform the UI of the update.
When the operation completes, it toggles the property back.
When you build the UI, you'll use this `loading` property to
show a loading indicator while fetching a new article.

### Retrieve an article from the `ArticleModel`

Complete the `getRandomArticleSummary` method to fetch an article summary.
Use a [try-catch block][] to gracefully handle network errors and
store error messages that the UI can display to users.
The method clears previous errors on success and
clears the previous article summary on error to maintain a consistent state.

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
      errorMessage = null; // Clear any previous errors.
    } on HttpException catch (error) {
      errorMessage = error.message;
      summary = null;
    }
    loading = false;
    notifyListeners();
  }
}
```

[try-catch block]: {{site.dart-site}}/language/error-handling#catch

### Test the ViewModel

Before building the full UI, test that your HTTP requests work by
printing results to the console.
First, update the `getRandomArticleSummary` method to
print the results:

```dart
Future<void> getRandomArticleSummary() async {
  loading = true;
  notifyListeners();
  try {
    summary = await model.getRandomArticleSummary();
    print('Article loaded: ${summary!.titles.normalized}'); // Temporary
    errorMessage = null; // Clear any previous errors.
  } on HttpException catch (error) {
    print('Error loading article: ${error.message}'); // Temporary
    errorMessage = error.message;
    summary = null;
  }
  loading = false;
  notifyListeners();
}
```

Then, update the `MainApp` widget to create the `ArticleViewModel`,
which calls the `getRandomArticleSummary` method on creation:

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate your `ArticleViewModel` to test its HTTP requests.
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

Hot reload your app and check your console output.
You should see either an article title or an error message,
which confirms that your Model and ViewModel are wired up correctly.

### Review

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Created the ArticleViewModel with ChangeNotifier
    icon: layers
    details: >-
      The ViewModel sits between your UI and Model,
      managing state and connecting the two layers.
      By extending `ChangeNotifier`, your ViewModel gains the ability to
      notify listeners when data changes.
  - title: Managed loading, success, and error states
    icon: toggle_on
    details: >-
      Your ViewModel tracks three pieces of state:
      `loading`, `summary`, and `errorMessage`.
      Using `try` and `catch`, you handle network errors gracefully and
      maintain consistent state for each possible outcome.
  - title: Used notifyListeners to signal UI updates
    icon: notifications_active
    details: >-
      Calling `notifyListeners()` tells any listening widgets to rebuild.
      You call it after setting `loading = true` and again
      after the operation completes.
      This is how you can implement reactive UI updates in Flutter.
</SummaryCard>

### Test yourself

<Quiz title="State Management Quiz">
- question: What is a ChangeNotifier?
  options:
    - text: A widget that displays notifications to the user.
      correct: false
      explanation: ChangeNotifier is not a widget; it's a class for managing state.
    - text: A class that can notify listeners when its data changes, enabling reactive UI updates.
      correct: true
      explanation: ChangeNotifier provides the notifyListeners method to signal widgets to rebuild when state changes.
    - text: A built-in Dart class for sending push notifications.
      correct: false
      explanation: ChangeNotifier is for in-app state management, not push notifications.
    - text: A type of animation controller in Flutter.
      correct: false
      explanation: Animation controllers are separate; ChangeNotifier is for state management.
- question: "What does calling `notifyListeners()` do in a ChangeNotifier?"
  options:
    - text: Saves the current state to local storage.
      correct: false
      explanation: "`notifyListeners()` signals UI updates; persistence requires separate implementation."
    - text: Tells any listening widgets to rebuild and reflect the new state.
      correct: true
      explanation: "Calling `notifyListeners()` triggers a rebuild of all widgets listening to this ChangeNotifier."
    - text: Logs the state change to the console for debugging.
      correct: false
      explanation: It doesn't log anything; it signals listeners to rebuild.
    - text: Resets all state properties to their default values.
      correct: false
      explanation: "`notifyListeners()` doesn't modify state; it just signals that state has changed."
</Quiz>
