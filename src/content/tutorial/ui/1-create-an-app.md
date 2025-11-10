---
title: Create an app
description: Instructions on how to create a new Flutter app.
permalink: /tutorial/create-an-app/
sitemap: false
---

{%- comment %}
<!-- TODO(ewindmill) embed video -->
{%- endcomment %}

In this first section of the Flutter tutorial, you’ll build the core UI of an
app called ‘Birdle’, a game similar to [Wordle, the popular New York Times
game][].

By the end of this tutorial, you’ll have learned the fundamentals of building
Flutter UIs, and your app will look like the following screenshot (and it’ll
even mostly work 😀).

<img src='/assets/images/docs/tutorial/birdle.png' width="100%" alt="A screenshot that resembles the popular game Wordle.">

## Create a new Flutter project

The first step to building Flutter apps is to create a new project. You create
new apps with the [Flutter CLI tool][], installed as part of the Flutter SDK.

Open your terminal or command prompt and run the following command to create a
new Flutter project:

```shell
$ flutter create birdle --empty
```

This creates a new Flutter project using the minimal “empty” template.

## Examine the code

In your IDE, open the file at `lib/main.dart`. Starting from the top, you’ll see
this code.

```dart
import 'package:flutter/material.dart'; // imports Flutter

void main() {
  runApp(const MainApp());
}
// ...
```

The `main` function is the entry point to any Dart program, and a Flutter app is
just a **Dart** program. The `runApp` method is part of the Flutter SDK, and it
takes a **widget** as an argument. (Most of this tutorial is about widgets, but
in the simplest terms a widget is a Dart object that describes a piece of UI.)
In this case, an instance of the `MainApp` widget is being passed in.

Just below the `main` function, you’ll find the `MainApp` class declaration.

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

```

`MainApp` is the **root widget**, as it’s the widget that’s passed into
`runApp`. Within this widget, there’s a `build` method, which returns another
widget called `MaterialApp`.  Essentially, this is what a Flutter app is: a
composition of Widgets that make up a tree structure called the **widget tree.**
Your job as a Flutter developer is to compose widgets from the SDK into larger,
custom widgets that display a UI.

At the moment, the widget tree is quite simple:

<img src='/assets/images/docs/tutorial/initial_widget_tree.png' alt="A screenshot that resembles the popular game Wordle.">

## Run your app

In your terminal at the root of your Flutter app, run:

```shell
$ cd birdle
$ flutter run -d chrome
```

The app will build and launch in a new instance of Chrome.

<img src='/assets/images/docs/tutorial/hello_world.png' alt="A screenshot that resembles the popular game Wordle.">

## Use hot reload

**Stateful hot reload**, if you haven't heard of it, allows a running Flutter
app to re-render updated business logic or UI code in less than a second - all
without losing your place in the app.

In your IDE, open the `main.dart` file and navigate to line ~15 and find this
code:

```dart
child: Text('Hello World!'),
```

Change the text inside the string to anything you want. Then, hot-reload your
app by pressing `r` in your terminal where the app is running. The running app
should instantly show your updated text.


[Flutter CLI tool]: /reference/flutter-cli
[Wordle, the popular New York Times game]: https://www.nytimes.com/games/wordle/index.html
[read more about using pub packages]: {{site.dart-site}}/tools/pub/packages
[`flutter_gse`]: {{site.pub}}/packages/flutter_gse
