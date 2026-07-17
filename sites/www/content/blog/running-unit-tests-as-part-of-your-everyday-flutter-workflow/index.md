---
title: "Running unit tests as part of your everyday Flutter workflow"
description: >-
  So you have gotten started with Flutter, have your app prototype up and
  running, and have started thinking about how you’d test your app…
publishDate: 2018-03-06
author: devoncarew
image: images/1GKGBr7v55mRKhQyOkNaFoA.webp
category: tutorial
layout: blog
---

So you have gotten started with Flutter, have your app prototype up and running, and have started thinking about how you’d test your app. This guide will give you the quick and dirty of how to run and debug your tests.

The good news is that you already have a helpful starting example of a Flutter unit test! The **flutter create** template ships with a sample unit test:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foo_bar/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

```

You can see that it verifies the behavior of the counter for the sample app. You may not have noticed the ‘run’ icons in the editor’s gutter:

<DashImage figure src="images/1V_EILJ0CmVIDWCBbK-VmtQ.webp" />

This is the Flutter plugin parsing your unit test code and inserting handy ‘run test’ actions directly into your editor. From IntelliJ or Android Studio, click on the ‘run’ icon and select either the option to run or debug your test:

<DashImage figure src="images/1pDCMYhDu_XxFEzUNRreupA.webp" />

The tests will run, and the results will be displayed in the standard IntelliJ test result view:

<DashImage figure src="images/1GKGBr7v55mRKhQyOkNaFoA.webp" />

To debug your test, just set a breakpoint where you’d like to pause the test and select the **Debug ‘test…’** option from the editor’s gutter run action. Your test will run and break at the breakpoint, letting you inspect variables and step through the code.

<DashImage figure src="images/1lCTc5ZARrw1ops8H6zA37A.webp" />

## VS Code

If you develop with VS Code, follow issue [#636](https://github.com/Dart-Code/Dart-Code/issues/636) to track progress in adding support for **flutter test** tests there. You can also show your interest by added a thumbs up to the issues! It’ll help with prioritizing among feature requests.

## For more info…

That’s it! For more info about testing your Flutter apps, see:

* [flutter.io/testing](https://flutter.io/testing) — a guide to both unit testing your widgets with **flutter test**, and integration testing your app with **flutter drive**

* [Test Flutter apps on Travis](https://medium.com/flutter-io/test-flutter-apps-on-travis-3fd5142ecd8c) — an article about running your Flutter tests on Travis, by [Yegor Jbanov](https://medium.com/@yegorj?source=post_header_lockup)
