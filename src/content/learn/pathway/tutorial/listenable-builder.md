---
title: Rebuild UI when state changes
description: Instructions on how to manage state with ChangeNotifiers.
layout: tutorial
---

Learn to use ListenableBuilder to automatically rebuild UI and handle all possible states with switch expressions.

<SummaryCard>
title: What you'll accomplish
items:
  - title: Use ListenableBuilder to rebuild UI automatically
    icon: sync
  - title: Handle all possible states with switch expressions
    icon: alt_route
  - title: Build the complete View layer with proper styling
    icon: article
</SummaryCard>

---

### Introduction

The view layer is your UI, and in Flutter,
that refers to your app's widgets.
As it pertains to this tutorial, the important part is
wiring up your UI to respond to data changes from the ViewModel.
[`ListenableBuilder`][] is a widget that can "listen" to a
[`ChangeNotifier`][], and automatically rebuilds when it's
provided `ChangeNotifier` calls `notifyListeners()`.

[`ListenableBuilder`]: {{site.api}}/flutter/widgets/ListenableBuilder-class.html
[`ChangeNotifier`]: {{site.api}}/flutter/foundation/ChangeNotifier-class.html

### Create the article view widget

Create the `ArticleView` widget that
manages the overall page layout and state handling.
Start with the basic class structure and widgets:

```dart
class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
      ),
      body: const Center(
        child: Text('UI will update here'),
      ),
    );
  }
}
```

### Create the article view model

Create the `ArticleViewModel` in this widget:

```dart
class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  final viewModel = ArticleViewModel(ArticleModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
      ),
      body: const Center(
        child: Text('UI will update here'),
      ),
    );
  }
}
```

### Listen for state changes

Wrap your UI in a [`ListenableBuilder`][] to listen for state changes,
and pass it a `ChangeNotifier` object.
In this case, the `ArticleViewModel` extends `ChangeNotifier`.

```dart
class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return const Center(child: Text('UI will update here'));
        },
      ),
    );
  }
}
```

`ListenableBuilder` uses the *builder* pattern,
which requires a callback rather than a `child` widget to
build the widget tree below it.
These widgets are flexible because you can
perform operations within the callback,
building different widgets based on the state.

[`ListenableBuilder`]: {{site.api}}/flutter/widgets/ListenableBuilder-class.html

### Handle possible view model states

Recall the `ArticleViewModel`, which has three properties that
the UI is interested in:

- `Summary? summary`
- `bool loading`
- `String? errorMessage`

Depending on the combined state of these properties,
the UI can display different widgets.
Use Dart's support for [switch expressions][]
to handle all possible combinations in a clean, readable way:

```dart
class ArticleView extends StatelessWidget {
  ArticleView({super.key});

  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
        actions: [],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return switch ((
            viewModel.loading,
            viewModel.summary,
            viewModel.errorMessage,
          )) {
            (true, _, _) => CircularProgressIndicator(),
            (false, _, String message) => Center(child: Text(message)),
            (false, null, null) => Center(
              child: Text('An unknown error has occurred'),
            ),
            // The summary must be non-null in this switch case.
            (false, Summary summary, null) => ArticlePage(
              summary: summary,
              onPressed: viewModel.getRandomArticleSummary,
            ),
          };
        },
      ),
    );
  }
}
```

This is an excellent example of how a
declarative, reactive framework like Flutter and
a pattern like MVVM work together:
The UI is rendered based on the state and updates when
a state changes demands it, but it
doesn't manage any state or the process of updating itself.
The business logic and rendering are completely separate from each other.

[switch expressions]: {{site.dart-site}}/language/branches#switch-expressions

### Complete the UI

The only thing remaining is to use the properties and methods provided
by the view model to build the UI.

Now create a `ArticlePage` widget that displays the actual article content.
This reusable widget takes summary data and a callback function:

```dart
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Article content will be displayed here'));
  }
}
```

### Add a scrollable layout

Replace the placeholder with a scrollable column layout:

```dart
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}
```

### Add article content and button

Complete the layout with an article widget and navigation button:

```dart
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.onPressed,
  });

  final Summary summary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Flexible(
            child: ArticleWidget(
              summary: summary,
            ),
          ),
          ElevatedButton(
            onPressed: nextArticleCallback,
            child: Text('Next random article'),
          ),
        ],
      ),
    );
  }
}
```

### Create the `ArticleWidget`

The `ArticleWidget` handles the display of the actual article content
with proper styling and conditional rendering.

#### Set up the basic article structure

Start with the widget that accepts a `summary` parameter:

```dart
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Text('Article content will be displayed here');
  }
}
```

#### Add padding and column layout

Wrap the content in proper padding and layout:

```dart
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        children: [
          Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}
```

#### Add conditional image display

Add the article image that only shows when available:

```dart
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        children: [
          if (summary.hasImage)
            Image.network(
              summary.originalImage!.source,
            ),
          Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}
```

#### Complete with styled text content

Replace the placeholder text with a
properly styled title, description, and extract:

```dart
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        children: [
          if (summary.hasImage)
            Image.network(
              summary.originalImage!.source,
            ),
          Text(
            summary.titles.normalized,
            overflow: TextOverflow.ellipsis,
            style: TextTheme.of(context).displaySmall,
          ),
          if (summary.description != null)
            Text(
              summary.description!,
              overflow: TextOverflow.ellipsis,
              style: TextTheme.of(context).bodySmall,
            ),
          Text(
            summary.extract,
          ),
        ],
      ),
    );
  }
}
```

This widget demonstrates a few important UI concepts:

- **Conditional rendering**:
  The `if` statements show content only when available.
- **Text styling**:
  Different text styles create visual hierarchy using Flutter's theme system.
- **Proper spacing**:
  The `spacing` parameter provides consistent vertical spacing.
- **Overflow handling**:
  `TextOverflow.ellipsis` prevents text from breaking the layout.

### Update your app to include the article view

Connect everything together by updating your `MainApp` to
include your completed `ArticleView`.

Replace your existing `MainApp` with this updated version:

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArticleView(),
    );
  }
}
```

This change switches from the console-based test to the full UI
experience with proper state management.

### Run the complete app

Hot reload your app one final time. You should now see:

1.  A loading spinner while the initial article loads.
1.  The article's title, description, and summary extract.
1.  An image (if the article has one).
1.  A button to load another random article.

To see the reactive UI in action,
click the **Next random article** button.
The app shows a loading state, fetches new data, and
updates the display automatically.

### Review

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Used ListenableBuilder to rebuild UI automatically
    icon: sync
    details: >-
      `ListenableBuilder` listens to your ViewModel and automatically rebuilds
      its children whenever `notifyListeners()` is called.
      In the MVVM pattern,
      this is the key connection between your ViewModel and View.
  - title: Handled all possible states with switch expressions
    icon: alt_route
    details: >-
      Using a switch expression, you accounted for
      the possible state combinations with an appropriate user interface,
      Conditionally displaying a loading spinner, an error message,
      or the actual article content.
      With this handling, the UI is now more robust and complete.
  - title: Built the complete View layer with proper styling
    icon: article
    details: >-
      You created `ArticleView`, `ArticlePage`, and
      `ArticleWidget` with conditional rendering, text styling,
      proper spacing, and overflow handling.
      These are core UI patterns you'll use in every Flutter app.
  - title: Completed the MVVM architecture
    icon: celebration
    details: >-
      You've built a complete app with Model (data operations),
      ViewModel (state management), and View (reactive UI) layers.
      This separation of concerns helps your code be
      more testable, maintainable, and scalable.
</SummaryCard>

### Test yourself

<Quiz title="ListenableBuilder Quiz">
- question: What is the purpose of ListenableBuilder in Flutter?
  options:
    - text: To create animations based on a ChangeNotifier.
      correct: false
      explanation: ListenableBuilder rebuilds UI on state changes, not specifically for animations.
    - text: "To listen to a ChangeNotifier and automatically rebuild its child widgets when `notifyListeners()` is called."
      correct: true
      explanation: ListenableBuilder listens to a Listenable and rebuilds its builder function when notified.
    - text: To manually control when widgets should be rebuilt.
      correct: false
      explanation: The rebuild is automatic when notifyListeners() is called; you don't control it manually.
    - text: To cache widget builds for better performance.
      correct: false
      explanation: ListenableBuilder is about reactive updates, not caching.
- question: When does ListenableBuilder rebuild its child widgets?
  options:
    - text: Every time the app's frame refreshes.
      correct: false
      explanation: ListenableBuilder only rebuilds when notified, not on every frame.
    - text: When the Listenable it's listening to calls notifyListeners().
      correct: true
      explanation: "ListenableBuilder subscribes to the Listenable and rebuilds its builder function whenever `notifyListeners()` is called."
    - text: Only when the widget is first mounted.
      correct: false
      explanation: "It rebuilds whenever `notifyListeners()` is called, not just on mount."
    - text: When the parent widget rebuilds.
      correct: false
      explanation: "ListenableBuilder rebuilds based on the Listenable, not parent rebuilds."
</Quiz>
