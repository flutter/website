---
title: Set up your project
description: Instructions on how to create a new Flutter app.
layout: tutorial
sitemap: false
---

<TutorialLesson>
<TutorialIntro>

Preview the Wikipedia reader app you'll build and set up the initial project with required packages.

<YouTubeEmbed id="jckqXR5CrPI" title="Decoding Flutter: Unbounded height and width"></YouTubeEmbed>

<SummaryCard>
title: What you'll accomplish
items:
  - title: Preview the Wikipedia reader app you'll build
    icon: preview
  - title: Add packages for handling HTTP requests and Wikipedia data
    icon: inventory_2
  - title: Set up the initial project structure
    icon: code
</SummaryCard>

</TutorialIntro>

<TutorialSteps>

### Introduction

In the next few lessons, you'll learn how to work with data in a Flutter app.
You'll build an app that fetches and displays article summaries from
the [Wikipedia API][].

<img src="/assets/images/docs/tutorial/wikipedia_app.png" width="320px" height="500px"
style="border:1px solid black" alt="A screenshot of the completed
Wikipedia reader app showing an article with image, title,
description, and extract text.">

These lessons explore:

- Making HTTP requests in Flutter.
- Managing application state with `ChangeNotifier`.
- Using the MVVM architecture pattern.
- Creating responsive user interfaces that
  update automatically when data changes.

This tutorial assumes you've completed the
[Getting started with Dart][] and the [Introduction to Flutter UI][] tutorials,
and therefore doesn't explain concepts like HTTP, JSON, or widget basics.

:::recommend Support Wikipedia

[Wikipedia][] is a valuable resource, providing free
access to human knowledge through millions of articles written
collaboratively by volunteers worldwide.
Consider [donating to Wikipedia][] to help keep this incredible resource
free and accessible to everyone.

:::

[Wikipedia API]: https://en.wikipedia.org/api/rest_v1/
[Getting started with Dart]: {{site.dart-site}}/tutorial
[Introduction to Flutter UI]: /learn/tutorial/create-an-app
[Wikipedia]: https://wikipedia.org/
[donating to Wikipedia]: https://donate.wikimedia.org/

### Create a new Flutter project

Create a new Flutter project using the [Flutter CLI][].
In your preferred terminal, run the following command to
create a minimal Flutter app:

```console
$ flutter create wikipedia_reader --empty
```

[Flutter CLI]: /reference/flutter-cli

### Add required dependencies

Your app needs two [packages][] to work with HTTP requests and
Wikipedia data. Add them to your project:

```console
$ cd wikipedia_reader && flutter pub add http dartpedia
```

The [`http` package][] provides tools for making HTTP requests, while
the `dartpedia` package contains data models for working with
Wikipedia's API responses.

[packages]: /packages-and-plugins/using-packages
[`http` package]: {{site.pub}}/packages/http

### Examine the starter code

Open `lib/main.dart` and replace the existing code with
this basic structure, which adds required imports that the app uses:

```dart title="lib/main.dart"
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

This code provides a basic app structure with
a title bar and placeholder content.
The imports at the top include everything you need for
HTTP requests, JSON parsing, and Wikipedia data models.

### Run your app

Test that everything works by running your app:

```console
$ flutter run -d chrome
```

You should see a simple app with "Wikipedia Flutter" in the app bar
and "Loading..." in the center of the screen.

### Review

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Previewed the Wikipedia reader app
    icon: preview
    details: >-
      You're starting a new tutorial section focused on working with data.
      You'll learn HTTP requests, state management with `ChangeNotifier`,
      and the MVVM architectural pattern.
  - title: Added the http and dartpedia packages
    icon: inventory_2
    details: >-
      You used `flutter pub add` to install packages for making HTTP requests
      and working with Wikipedia data models.
      Packages let you leverage existing code built by the community
      instead of building everything from scratch.
  - title: Set up the initial project structure
    icon: code
    details: >-
      Your app has the basic structure with all necessary imports for
      HTTP requests, JSON parsing, and Wikipedia data.
      You're ready to start fetching real data from the Wikipedia API!
</SummaryCard>

### Test yourself

<Quiz title="Project Setup Quiz">
- question: "What does the `--empty` flag do when running `flutter create`?"
  options:
    - text: Creates a project with no files at all.
      correct: false
      explanation: The project still has essential files; it just uses a minimal template.
    - text: Creates a minimal Flutter project with less boilerplate code.
      correct: true
      explanation: "The `--empty` flag generates a minimal starter template without the default counter app."
    - text: Creates a project without any dependencies.
      correct: false
      explanation: The project still includes core Flutter dependencies.
    - text: Creates a project that can only run on web.
      correct: false
      explanation: The flag doesn't restrict platforms; it only affects the starter template.
- question: What command is used to add a package dependency to a Flutter project?
  options:
    - text: "`flutter install [package_name]`"
      correct: false
      explanation: "The correct command uses `pub add`, not `install`."
    - text: "`flutter pub add [package_name]`"
      correct: true
      explanation: "Running `flutter pub add` adds the package to pubspec.yaml and downloads it."
    - text: "`dart get [package_name]`"
      correct: false
      explanation: "The command for adding packages is `flutter pub add` or editing pubspec.yaml."
    - text: "`flutter package install [package_name]`"
      correct: false
      explanation: "There is no `flutter package` command; use `flutter pub add`."
</Quiz>

</TutorialSteps>
</TutorialLesson>
