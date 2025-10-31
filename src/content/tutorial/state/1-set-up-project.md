---
title: Set up your project
description: Instructions on how to create a new Flutter app.
permalink: /tutorial/set-up-state-app/
sitemap: false
---

In this tutorial, you'll learn how to work with data in a Flutter app.
You'll build an app that fetches and displays article summaries from
the [Wikipedia API][].

<img src="/assets/images/docs/tutorial/wikipedia_app.png" height="500px"
style="border:1px solid black" alt="A screenshot of the completed
Wikipedia reader app showing an article with image, title,
description, and extract text.">

This tutorial explores:

* Making HTTP requests in Flutter
* Managing application state with `ChangeNotifier`
* Using the MVVM architecture pattern
* Creating responsive user interfaces that update automatically when
  data changes


This tutorial assumes you've completed the [Dart Getting Started
tutorial][] and the [introductory Flutter tutorial][], and therefore
doesn't explain concepts like HTTP, JSON, or widget basics.

:::note Support Wikipedia
Wikipedia is a valuable resource, providing free
access to human knowledge through millions of articles written
collaboratively by volunteers worldwide. Consider [donating to
Wikipedia][] to help keep this incredible resource free and accessible
to everyone.
:::

## Create a new Flutter project

Create a new Flutter project using the [Flutter CLI][]. In your
terminal, run the following command to create a minimal Flutter app:

```bash
$ flutter create wikipedia_reader --empty
```

## Add required dependencies

Your app needs two [packages][] to work with HTTP requests and
Wikipedia data. Add them to your project:

```shell
$ cd wikipedia_reader
$ flutter pub add http dartpedia
```

The [`http` package][] provides tools for making HTTP requests, while
the `dartpedia` package contains data models for working with
Wikipedia's API responses.

## Examine the starter code

Open `lib/main.dart` and replace the existing code with this basic
structure, which adds required imports that the app uses.

```dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wikipedia/wikipedia.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wikipedia Flutter'),
        ),
        body: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
```

This code provides a basic app structure with a title bar and
placeholder content. The imports at the top include everything you
need for HTTP requests, JSON parsing, and Wikipedia data models.

## Run your app

Test that everything works by running your app:

```bash
$ flutter run -d chrome
```

You should see a simple app with "Wikipedia Flutter" in the app bar
and "Loading..." in the center of the screen.

[Wikipedia API]: https://en.wikipedia.org/api/rest_v1/
[donating to Wikipedia]: https://donate.wikimedia.org/
[introductory Flutter tutorial]: /tutorial/create-an-app/
[Dart Getting Started tutorial]: {{site.dart-site}}/tutorial
[Flutter CLI]: /reference/flutter-cli
[packages]: /packages-and-plugins/using-packages
[`http` package]: {{site.pub}}/packages/http
