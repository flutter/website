---
title: Rebuild UI when state changes
description: Instructions on how to manage state with ChangeNotifiers.
permalink: /tutorial/listenables/
sitemap: false
---

The view layer is your UI, and in Flutter, that refers to your app's
widgets. As it pertains to this tutorial, the important part is wiring
up your UI to respond to data changes from the ViewModel.
[`ListenableBuilder`][] is a widget that can "listen" to a
`ChangeNotifier`, and automatically rebuilds when it's provided
`ChangeNotifier` calls `notifyListeners()`.

## Create the ArticleView widget

Create the `ArticleView` widget that manages the overall page layout
and state handling. Start with the basic class structure and widgets:

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

## Create the ViewModel

Create the ViewModel in this widget.

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

## Add ListenableBuilder

Wrap your UI in a `ListenableBuilder` to listen for state changes, and
pass it a `ChangeNotifier` object. In this case, the
`ArticleViewModel` extends `ChangeNotifier`.

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

`ListenableBuilder` uses the *builder* pattern, which requires a
callback rather than a `child` widget to build the widget tree below
it. These widgets are flexible because you can perform operations
within the callback.


## Handle all states with switch expression

Recall the `ArticleViewModel`, which has three properties that the UI
is interested in:
* `Summary? summary`
* `bool loading`
* `String? errorMessage`

The UI needs to display different widgets based on the combination of
states of all three of those properties. Use Dart's switch expressions
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
            // summary must be non-null in this swich case
            (false, Summary _, null) => ArticlePage(
              summary: viewModel.summary!,
              onPressed: viewModel.getRandomArticleSummary,
            ),
          };
        },
      ),
    );
  }
}
```

This is an excellent example of how a declarative, reactive framework
like Flutter and a pattern like MVVM work together: The UI is rendered
based on the state, and updates when a state changes demands it, but
it doesn't manage any state or the process of updating itself. The
business logic and rendering are completely separate from each other.


## Complete the UI

The only thing remaining is to use the properties and methods provided
by the ViewModel.

Now create the `ArticlePage` widget that displays the actual article
content. This reusable widget takes summary
data and a callback function.

Create a simple widget that accepts the required parameters:

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

## Add scrollable layout

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

## Add article content and button

Complete the layout with the article widget and navigation button:

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

## Create the ArticleWidget

The `ArticleWidget` handles the display of the actual article content
with proper styling and conditional rendering.

## Create the basic ArticleWidget structure

Start with the widget that accepts a summary parameter:

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

## Add padding and column layout

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

## Add conditional image display

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

## Complete with styled text content

Replace the placeholder with properly styled title, description, and
extract:

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

This widget demonstrates these important UI concepts:

- **Conditional rendering**: The `if` statements show content only
  when available.
- **Text styling**: Different text styles create visual hierarchy
  using Flutter's theme system.
- **Proper spacing**: The `spacing` parameter provides consistent
  vertical spacing.
- **Overflow handling**: `TextOverflow.ellipsis` prevents text from
  breaking the layout.

## Update MainApp to use ArticleView

Connect everything together by updating your `MainApp` to use the
complete `ArticleView`.

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

## Run the complete app

Hot reload your app one final time. You should now see:

1. A loading spinner while the initial article loads
2. The article content with title, description, and full text
3. An image (if the article has one)
4. A button to load another random article

Click the "Next random article" button to see the reactive UI in
action. The app shows a loading state, fetches new data, and updates
the display automatically.

[`ListenableBuilder`]: https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html
[widget]: https://docs.flutter.dev/ui/widgets-intro
[`ListView`]: https://api.flutter.dev/flutter/widgets/ListView-class.html
[try-catch block]: https://dart.dev/language/error-handling
