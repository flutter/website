// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import '../components/pages/devtools_release_notes_index.dart';
import 'glossary.dart';
import 'widget_catalog.dart';

/// All pages that should be loaded from memory rather than
/// from content loaded from the file system.
List<MemoryPage> get allMemoryPages => [
  _glossaryPage,
  _devtoolsReleasesIndex,
  ...widgetCatalogPages,
  // TODO(schultek): Remove this test page when FWE lands.
  if (kDebugMode) _fweTestingPage,
];

/// The `/resources/glossary` page which hosts the [GlossaryIndex].
MemoryPage get _glossaryPage => MemoryPage.builder(
  path: 'resources/glossary.md',
  initialData: {
    'page': <String, Object?>{
      'title': 'Glossary',
      'showBreadcrumbs': false,
      'description':
          'A glossary reference for terminology '
          'used across docs.flutter.dev.',
      'showToc': false,
      'bodyClass': 'glossary-page',
    },
  },
  builder: (_) {
    return const GlossaryIndex();
  },
);

/// The `/f/devtools-releases.json` file that DevTools consumes.
MemoryPage get _devtoolsReleasesIndex => MemoryPage.builder(
  path: 'f/devtools-releases.json',
  applyLayout: false,
  keepSuffix: true,
  initialData: {
    'page': <String, Object?>{
      'title': 'DevTools release notes index',
      'description': 'An index of DevTools release note Markdown files.',
      'sitemap': false,
    },
  },
  builder: (context) {
    context.setHeader('Content-Type', 'application/json; charset=utf-8');

    final releases = DevToolsReleaseNotesIndex.findDevToolsReleases(context);
    final releaseData = {
      'latest': releases.first.version.toString(),
      'releases': {
        for (final release in releases)
          release.version.toString(): '/${release.page.path}',
      },
    };

    const jsonEncoder = JsonEncoder.withIndent('  ');
    context.setStatusCode(200, responseBody: jsonEncoder.convert(releaseData));

    return const Component.empty();
  },
);

MemoryPage get _fweTestingPage => const MemoryPage(
  path: 'fwe.md',
  content: '''
---
title: FWE Testing Page
description: This is a test page for experimenting with First Week Experience (FWE) features.
sitemap: false
layout: tutorial
---

## Quiz

<Quiz title="Flutter and Dart Basics Quiz">
- question: What is the Effective Dart guideline for the first sentence of a documentation comment?
  options:
    - text: It should be a complete paragraph with at least two sentences to provide sufficient context.
      correct: false
      explanation: The guideline recommends a short summary sentence, not a full paragraph.
    - text: It must include the names of all parameters using square brackets.
      correct: false
      explanation: Parameter names can be included elsewhere, but the first sentence is a summary.
    - text: It should be a single-sentence summary, separated from the rest of the comment by a blank line.
      correct: true
      explanation: Effective Dart recommends starting with a single-sentence summary, followed by a blank line before details.
    - text: It should always begin with the name of the member being documented.
      correct: false
      explanation: Starting with the member name is not required; a concise summary is preferred.
- question: In Flutter, which widget is typically used to create a scrollable list of items?
  options:
    - text: Column
      correct: false
      explanation: A Column is not scrollable by default; use ListView for scrollable lists.
    - text: ListView
      correct: true
      explanation: ListView is the standard widget for creating scrollable lists in Flutter.
    - text: Row
      correct: false
      explanation: A Row arranges items horizontally and is not scrollable by default.
    - text: Stack
      correct: false
      explanation: Stack is used for overlapping widgets, not for scrollable lists.
</Quiz>

## Progress Ring

<ProgressRing progress="0.0" />
<ProgressRing progress="0.25" />
<ProgressRing progress="0.5" />
<ProgressRing progress="0.75" />
<ProgressRing progress="1.0" />

---

<ProgressRing progress="0.1" small />
<ProgressRing progress="0.6" small />
<ProgressRing progress="0.3" large />
<ProgressRing progress="0.95" large />

## Foldable Code Block

```dart foldable showLineNumbers
[* -
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';
*]

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    [* -
    return MaterialApp( // Root widget
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          [*
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  const Text('Hello, World!'),
                  [* -
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: const Text('A button'),
                  ),
                  *]
                ],
              );
            },
          ),
          *]
        ),
      ),
    );
    *]
  }
}
```

## Summary Card

<SummaryCard>
title: What you'll learn in this Flutter lesson
items:
  - title: Introduction to Flutter and Dart programming
    icon: flutter
  - title: How to build beautiful UIs with widgets
    icon: mobile_layout
  - title: Adding navigation between different screens
    icon: conversion_path
</SummaryCard>

---

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you accomplished in this lesson.
completed: true
items:
  - title: Reviewed the core concepts of Flutter
    icon: flutter
    details: >-
      Solidified understanding of Flutter's core concepts, including the widget
      tree, state management principles (Stateless vs. Stateful widgets), and
      the basic project structure. Reviewed the essentials of the Dart
      programming language.
  - title: Practiced building layouts with widgets
    icon: mobile_layout
    details: >-
      Built and experimented with common layout widgets (Row, Column,
      Stack, and Flex), learned how to use padding, alignment, and
      constraints to create responsive layouts across screen sizes.
  - title: Implemented screen navigation and routing
    icon: conversion_path
    details: >-
      Implemented navigation between screens using routes and
      Navigator patterns; learned how to pass arguments between routes
      and manage back navigation and nested navigation scenarios.
</SummaryCard>

## Stepper

<Stepper level="3">

### Confirm your Dart setup

First, make sure Dart is ready to go on your system by following these steps.

1.  Open a terminal (or command prompt).

2.  Run the following command to check your Dart SDK version:

    ```bash
    dart --version
    ```

3.  Make sure that you see output similar to this
    (the version numbers might be different):

    ```bash
    Dart SDK version: 3.9.2 (stable) (Wed Aug 27 03:49:40 2025 -0700) on "linux_x64"
    ```

    If you see an error like "command not found," refer to the
    [Dart installation guide](/get-dart) to set up your environment.

### Create a new Dart project

Now, create your first Dart command-line application.

1.  In the same terminal,
    create a new directory called `dartpedia` to hold your project.
    Then switch into that directory.

    ```bash
    mkdir dartpedia
    cd dartpedia
    ```

1.  Run the following command:

    ```bash
    dart create cli
    ```

    The `dart create` command generates a basic Dart project named
    "cli" (for Command Line Interface).
    It sets up the essential files and directories you need.

1.  You should see output similar to this, confirming the project creation:

    ```bash
    Creating cli using template console...

      .gitignore
      analysis_options.yaml
      CHANGELOG.md
      pubspec.yaml
      README.md
      bin/cli.dart
      lib/cli.dart
      test/cli_test.dart

    Running pub get...                     1.2s
      Resolving dependencies...
      Downloading packages...
      Changed 49 dependencies!

    Created project cli in cli! In order to get started, run the following commands:

      cd cli
      dart run
    ```

    :::note
    The `dart create` command created a number of files.
    Don't worry about these now.
    Their specifics will be covered in future chapters.
    :::

### Run your first Dart program

Next, run your program to test it out.

1.  In the terminal, navigate into your new project directory:

    ```bash
    cd cli
    ```

1.  Run the default application:

    ```bash
    dart run
    ```

    This command tells Dart to execute your program.

1.  You should see the following output:

    ```bash
    Building package executable...
    Built cli:cli.
    Hello world: 42!
    ```

    Congratulations! You've successfully run your first Dart program!

### Make your first code change

Next, modify the code that generated `Hello world: 42!`.

1.  In a code editor, open the `bin/cli.dart` file.

    The `bin/` directory is where your executable code lives.
    `cli.dart` is the entry point of your application.

    Inside, you'll see the `main` function.
    Every Dart program [starts executing from its `main` function](/language#hello-world).

1.  Check to make sure that your `bin/cli.dart` looks like this:

    ```dart title="bin/cli.dart"
    import 'package:cli/cli.dart' as cli;

    void main(List<String> arguments) {
      print('Hello world: \${cli.calculate()}!');
    }
    ```

1.  Simplify the output for now.
    Delete the first line (you don't need this import statement), and change the
    `print` statement to display a simple greeting: 

    ```dart title="bin/cli.dart" highlightLines=1,4
    import 'package:cli/cli.dart' as cli; // Delete this entire line

    void main(List<String> arguments) {
      print('Hello, Dart!'); // Change this line
    }
    ```

2.  Save your file. Then in the terminal, run your program again:

    ```bash
    dart run
    ```

3.  Check to make sure that you see the following:

    ```bash
    Building package executable...
    Built cli:cli.
    Hello, Dart!
    ```

    You've successfully modified and re-run your first Dart program!

</Stepper>

''',
);
