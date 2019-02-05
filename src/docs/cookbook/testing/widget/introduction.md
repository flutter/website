---
title: An introduction to widget testing
short-title: Introduction
prev:
  title: Mock dependencies using Mockito
  path: /docs/cookbook/testing/unit/mocking
next:
  title: Finding widgets
  path: /docs/cookbook/testing/widget/finders
---

{% assign api = site.api | append: '/flutter' -%}

In the [introduction to unit testing](/docs/cookbook/testing/unit/introduction) recipe, we
learned how to test Dart classes using the `test` package. In order to test
Widget classes, we'll need a few additional tools provided by the
[`flutter_test`]({{api}}/flutter_test/flutter_test-library.html)
package, which ships with the Flutter SDK.

The `flutter_test` package provides the following tools for testing Widgets:

  * The [`WidgetTester`]({{api}}/flutter_test/WidgetTester-class.html),
  which allows us to build and interact with Widgets in a test environment.
  * The [`testWidgets`]({{api}}/flutter_test/testWidgets.html)
  function. This function will automatically create a new `WidgetTester` for
  each test case, and is used in place of the normal `test` function.
  * [`Finder`]({{api}}/flutter_test/Finder-class.html)
  classes. These allow us to search for Widgets in the test environment.
  * Widget-specific [`Matcher`]({{api}}/package-matcher_matcher/Matcher-class.html)
  constants, which help us verify whether a `Finder` locates a Widget or
  multiple Widgets in the test environment.

If this sounds overwhelming, don't worry! We'll see how all of these pieces fit
together throughout this recipe.

### Directions

  1. Add the `flutter_test` dependency
  2. Create a Widget to test
  3. Create a `testWidgets` test
  4. Build the Widget using the `WidgetTester`
  5. Search for our Widget using a `Finder`
  6. Verify our Widget is working using a `Matcher`

### 1. Add the `flutter_test` dependency

Before we can begin writing tests, we'll need to include the `flutter_test`
dependency in the `dev_dependencies` section of our `pubspec.yaml` file. If
you create a new Flutter project with the command line tools or code editor,
this dependency should already be in place!

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

### 2. Create a Widget to test

Next, we'll need to create a Widget that we can test! For this recipe, we'll
create a Widget that displays a `title` and `message`.

```dart
class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
```

### 3. Create a `testWidgets` test

Now that we have a Widget to test, we can begin writing our first test! To get
started, we'll use the
[`testWidgets`]({{api}}/flutter_test/testWidgets.html)
function provided by the `flutter_test` package to define a test. The
`testWidgets` function will allow us to define a Widget test and will create a
`WidgetTester` for us to work with.

Our test will verify that `MyWidget` displays a given title and message.

<!-- skip -->
```dart
void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Test code will go here!
  });
}
```

### 4. Build the Widget using the `WidgetTester`

Next, we'll want to build `MyWidget` inside the test environment. To do so, we
can use the
[`pumpWidget`]({{api}}/flutter_test/WidgetTester/pumpWidget.html)
method provided by the `WidgetTester`. The `pumpWidget` method will build and
render the Widget we provide.

In this case, we'll create a `MyWidget` instance that displays "T" as the title
and "M" as the message.

<!-- skip -->
```dart
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
  });
}
```

#### Note

After the initial call to `pumpWidget`, the `WidgetTester` provides additional
ways to rebuild the same Widget. This is useful if you're working with a
`StatefulWidget` or animations.

For example, if we tap a button, and this button calls `setState`, Flutter will
not automatically rebuild your Widget in the test environment. We need to use
one of the following methods to ask Flutter to build our Widget once again.

  - [tester.pump()]({{api}}/flutter_test/TestWidgetsFlutterBinding/pump.html)
  : Triggers a rebuild of the Widget after a given duration.
  - [tester.pumpAndSettle()]({{api}}/flutter_test/WidgetTester/pumpAndSettle.html)
  : Repeatedly calls pump with the given duration until there are no longer any frames scheduled. This essentially waits for all animations to complete.

These methods provide fine-grained control over the build lifecycle, which is
particularly useful while testing.

### 5. Search for our Widget using a `Finder`

Now that we've built our Widget in the test environment, we'll want to search
through the Widget tree for the `title` and `message` Text Widgets using a
`Finder`. This will allow us to verify that we're displaying these Widgets
correctly!

In this case, we'll use the top-level [`find`]({{api}}/flutter_test/find-constant.html)
method provided by the `flutter_test` package to create our `Finders`. Since we
know we're looking for `Text` widgets, we can use the
[`find.text`]({{api}}/flutter_test/CommonFinders-class.html)
method.

For more information about `Finder` classes, please see the
[Finding Widgets in a Widget Test](/docs/cookbook/testing/widget/finders)
recipe.

<!-- skip -->
```dart
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create our Finders
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
  });
}
```

### 6. Verify our Widget is working using a `Matcher`

Finally, we can verify the title and message `Text` Widgets appear on screen
using the `Matcher` constants provided by `flutter_test`. `Matcher` classes are
a core part of the `test` package, and provide a common way to verify a given
value meets our expectations.

In this case, we want to ensure our Widgets appear on screen exactly one time.
Therefore, we can use the
[`findsOneWidget`]({{api}}/flutter_test/findsOneWidget-constant.html)
`Matcher`.

<!-- skip -->
```dart
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

#### Additional Matchers

In addition to `findsOneWidget`, `flutter_test` provides additional matchers for
common cases.

  * [findsNothing]({{api}}/flutter_test/findsNothing-constant.html)
  : verifies that no Widgets are found
  * [findsWidgets]({{api}}/flutter_test/findsWidgets-constant.html)
  : verifies one or more Widgets are found
  * [findsNWidgets]({{api}}/flutter_test/findsNWidgets.html)
  : verifies a specific number of Widgets are found

### Complete example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create our Finders
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
```
