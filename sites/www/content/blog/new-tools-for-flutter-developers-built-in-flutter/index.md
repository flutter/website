---
title: "New tools for Flutter developers, built in Flutter"
description: "Why we rebuilt Dart DevTools from scratch in Flutter"
publishDate: 2020-06-24
author: filiph
image: images/0VLibsxLD9Wv35Pr8.webp
category: announcement
layout: blog
---

By: Filip Hracek & Chris Sells

Today, we’re releasing a new version of Dart DevTools, our suite of tools for debugging and performance analysis for Dart and Flutter code. It has been rebuilt from scratch in Flutter. This version adds several improvements, such as updates to the performance and memory pages, and a completely new network page.

Many people know Flutter for its hot reload feature that lets you make changes to your mobile app while it’s running. But hot reload is but one of a suite of tools that we provide to help you write, test, debug, and analyze your app.

<DashImage figure src="images/0VLibsxLD9Wv35Pr8.webp" />


Let’s first take a moment to discuss why we rebuilt DevTools in the first place. The short answer is productivity and quality. The Flutter team understands the productivity benefits of Flutter when building beautiful, high performance UIs — and we want those benefits for ourselves. This productivity has enabled us to not only rebuild DevTools but also to add big new features along the way.

We chose to ship DevTools as a web application, since it is easy for us to integrate into the existing tooling experience across all of our target platforms and IDEs. Building with the web in mind has also enabled us to walk in the shoes of our customers; in doing so, we’ve learned about (and fixed) some performance issues, such as scrolling performance.

We have also been evaluating the benefits of shipping DevTools as compiled desktop apps and so far the results are promising. One major benefit of choosing Flutter is that selecting a distribution model is something we can do *after* we’ve written the code, rather than the first decision we have to make. Many customers also tell us that this is an attractive capability of Flutter.

Now that we’ve discussed a little bit about the near past and new future of DevTools, let’s dive into a quick overview of *all* of the major tools available to every Flutter developer. Because DevTools is not the only tool worthy of your attention.

## The basics

Of course, there’s the `flutter` tool, which runs your app in debug mode, performs hot reload, builds APKs and IPAs, and more. The `flutter` tool is written in Dart, and runs on the command line, so that you can use Flutter no matter which operating system or editor you prefer.

<DashImage figure src="images/0iVa4x2t2lP9ohPN4.webp" />


The Dart analysis server provides static analysis and intelligence in a variety of IDEs. This means that you get code completion …

<DashImage figure src="images/0JElGgGi_Kf6KM7nx.webp" alt="This happens to be VS Code, but all the examples here work in Android Studio as well, of course." caption="This happens to be VS Code, but all the examples here work in Android Studio as well, of course." />


… error highlights that link to documentation on [how to fix them](https://dart.dev/tools/diagnostic-messages) …

<DashImage figure src="images/1KRIuvikDtgXpHSIgGe9a9Q.webp" alt="For the most common static errors, IDEs link to a longer version of the error message, including example code and common fixes." caption="For the most common static errors, IDEs link to a longer version of the error message, including example code and common fixes." />


… and smart lints.

<DashImage figure src="images/1VqwAbaGamLPA-v6icQJOVQ.webp" alt="Here, the analyzer detects that a Sink is created but is never closed — a possible memory leak." caption="Here, the analyzer detects that a Sink is created but is never closed — a possible memory leak." />


The analysis server can also use the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/), which means all the developer tools that use it (and there are [many](https://microsoft.github.io/language-server-protocol/implementors/tools/)) can easily support it.

## UI code helpers

With Flutter, you build UI in code by creating widget trees. This means that a lot of Dart code is in the form of nested constructors like the following:

```dart
return MaterialApp(
  title: 'My app',
  home: Scaffold(
    appBar: AppBar(
      title: Text('Welcome'),
    ),
    body: Column(
      ...
    ),
  ),
);
```


Flutter tooling makes it easier to work with code like this. UI guides highlight the widget tree that you are building.

<DashImage figure src="images/1iG8tpvV34F3XOXyzLC2U0Q.webp" alt="The lines on the left, called UI guides, explicitly visualize the widget tree." caption="The lines on the left, called UI guides, explicitly visualize the widget tree." />


Trailing comments can show which closing bracket belongs to which widget.

<DashImage figure src="images/1e2q4GYtedlU7b-TKLgnRyg.webp" alt="The comments here are shown by the IDE but are not actually part of the file." caption="The comments here are shown by the IDE but are not actually part of the file." />


Smart refactoring helps you modify the tree in a few strokes, such as wrapping a part of it with a new parent …

<DashImage figure src="images/1sVn-oXHO2jW9sWpxG82njg.gif" alt="Wrapping an IconButton with a SizedBox." caption="Wrapping an IconButton with a SizedBox." />


… and moving widgets around.

<DashImage figure src="images/1umZpq9lqGCrOyBJiTPKHsw.gif" />


## DevTools

And then there are DevTools, a standalone suite of tools that run in the browser. They provide additional telemetry and functionality that isn’t practical to show in the IDE.

<DashImage figure src="images/1hcoGwr98wOif8v6rNJajUw.webp" alt="DevTools open in a browser window." caption="DevTools open in a browser window." />


The DevTools we’re launching this week are written in Flutter. (They were previously written in Dart, but not using the Flutter framework.) This was a complete rewrite from scratch, which brought opportunities to improve the UI and add completely new features.

<DashImage figure src="images/1Z7TXqke4-9T7EaTKgNSTsw.webp" />


The first tab is the [Flutter Inspector](https://flutter.dev/docs/development/tools/devtools/inspector), which is a tool for visualizing and exploring Flutter widget trees. From here, you can select widgets in your running app, slow down all animations, see text baselines, and more.

One of the new features is the Layout Explorer, which you can find in the Flutter Inspector tab next to the Details Tree. The Layout Explorer lets you inspect Flutter’s flex layout model. This can be a lifesaver when you’re unsure why a row of widgets doesn’t look the way you expected, for example, or why you’re getting the “RenderFlex overflowed by 42 pixels” error.

<DashImage figure src="images/12trBIvd2s8ToANRxsA8FIg.webp" />


Next to the Flutter Inspector tab, you’ll find three tabs dedicated to performance profiling: the Timeline view, the Memory view, and the Performance view.

The [Timeline view](https://flutter.dev/docs/development/tools/devtools/timeline) now shows build times for each frame as well as a flame chart. This makes it easy to identify problematic frames while seeing them in context.

<DashImage figure src="images/18AbvqZly0A4dixM5yq6iQg.webp" />


The Timeline pane also has the new Track Widget Builds button, which adds build times of all widgets in your app to the timeline (at the expense of performance of your profile build — which is why it’s not on by default). This is handy when you’re trying to find out which widgets, exactly, are behind a slow frame.

The [Memory view](https://flutter.dev/docs/development/tools/devtools/memory) lets you peek at how your app is using memory at a given moment. This view now shows a heatmap of the allocated memory, and allows tracking platform memory as well.

<DashImage figure src="images/1syZl4n3gicB-CknSTb6X_A.webp" />


The [Performance view](https://flutter.dev/docs/development/tools/devtools/performance) is a traditional CPU profiler. It lets you record a session of your app, and see in which functions the CPU spent most of its time, overall. This is generally used to decide where to spend optimization efforts.

<DashImage figure src="images/1CE2_scmNy11X1Fl3zj7bGA.webp" />


DevTools even includes its own [Debugger](https://flutter.dev/docs/development/tools/devtools/debugger). This can be useful if you are not using an IDE for development, but still want the option to add breakpoints, step through the code, peek at variable values, and so on.

<DashImage figure src="images/1BPb2b4wqKgGsitAaKuShUw.webp" />


The next tab is completely new. The [Network view](https://flutter.dev/docs/development/tools/devtools/network) lets you inspect, you guessed it, network traffic. You can see the whole history of requests that your app made since it started, and detailed information about each one. This frees you from having to log these events on your own when trying to debug a network issue. The Network tab currently shows HTTP traffic; future improvements include showing [general socket I/O traffic](https://github.com/flutter/devtools/issues/2044).

<DashImage figure src="images/1hdjm79pT22-sAwjQhFYr8A.webp" />


You’ll now also find network requests in the Timeline view, so that you can see them in context.

The [Logging view](https://flutter.dev/docs/development/tools/devtools/logging) shows events from your app and the framework. With it, you can easily filter messages (for example, you can specify `-gc` to filter out Garbage Collector events, or `flutter.frame` to only show frame events). In Dart, logging messages [can be structured](https://api.dart.dev/stable/dart-developer/log.html), and the Logging view makes use of that.

<DashImage figure src="images/1s-H2qFeoTWmdEnJOhG39Vw.webp" />


DevTools work for mobile apps, desktop apps, *and* web apps.

<DashImage figure src="images/1eIyRlQ_O5COR9cGuMubUZw.webp" />


The rewrite of DevTools to Flutter has many benefits: increased productivity, walking in the shoes of our customers, and freedom of choice of target platforms. One benefit we haven’t mentioned: rebuilding DevTools in Flutter invites the community to contribute more easily. DevTools was always [developed in the open](https://github.com/flutter/devtools/tree/master/packages/devtools_app), but today, most users will be familiar with its structure (starting with `runApp(DevToolsApp(…)`) in [`lib/main.dart`](https://github.com/flutter/devtools/blob/master/packages/devtools_app/lib/main.dart#L14-L16)).

<DashImage figure src="images/0BHpYeXRNy6du98np.webp" />


## Summary

Tooling is vitally important for the Flutter developer experience. We invest heavily in making it better every day. But we can only do this with your feedback.

So upgrade to the newest DevTools today, and test it out on your app. Read the [documentation](https://flutter.dev/docs/development/tools/devtools/overview) to learn about all the hidden gems. File bugs if you find them, or vote for new features [on GitHub](https://github.com/flutter/devtools/issues).

We hope the new DevTools make your Flutter development experience more enjoyable.