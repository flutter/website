---
title: Finding widgets
prev:
  title: An introduction to widget testing
  path: /docs/cookbook/testing/widget/introduction
next:
  title: Tapping, dragging and entering text
  path: /docs/cookbook/testing/widget/tap-drag
---

{% assign api = site.api | append: '/flutter' -%}

In order to locate Widgets in a test environment, we need to use `Finder`
classes. While it's possible to write our own `Finder` classes, it's generally
more convenient to locate Widgets using the tools provided by the
[`flutter_test`]({{api}}/flutter_test/flutter_test-library.html)
package.

In this recipe, we'll look at the
[`find`]({{api}}/flutter_test/find-constant.html)
constant provided by the `flutter_test` package and demonstrate how to work with
some of the `Finders` it provides. For a full list of available finders, please
consult the
[`CommonFinders` documentation]({{api}}/flutter_driver/CommonFinders-class.html).

If you're unfamiliar with Widget testing and the role of `Finder` classes,
review the [Introduction to Widget testing](/docs/cookbook/testing/integration) recipe.

### Directions

  1. Find a `Text` Widget
  2. Find a Widget with a specific `Key`
  3. Find a specific Widget instance

### 1. Find a `Text` Widget

In our tests, we often need to find Widgets that contain specific text. This is
exactly what the `find.text` method is for. It will create a `Finder` that
searches for Widgets that display a specific `String` of text.

<!-- skip -->
```dart
testWidgets('finds a Text Widget', (WidgetTester tester) async {
  // Build an App with a Text Widget that displays the letter 'H'
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Text('H'),
    ),
  ));

  // Find a Widget that displays the letter 'H'
  expect(find.text('H'), findsOneWidget);
});
```

### 2. Find a Widget with a specific `Key`

In some cases, we may want to find a Widget based on the Key that has been
provided to it. This can be handy if we're displaying multiple instances of the
same Widget. For example, we might have a `ListView` that displays several
`Text` Widgets that contain the same text.

In this case, we can provide a `Key` to each Widget in the list. This will allow
us to uniquely identify a specific Widget, making it easier to find the Widget
in the test environment.

<!-- skip -->
```dart
testWidgets('finds a Widget using a Key', (WidgetTester tester) async {
  // Define our test key
  final testKey = Key('K');

  // Build a MaterialApp with the testKey
  await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

  // Find the MaterialApp Widget using the testKey
  expect(find.byKey(testKey), findsOneWidget);
});
```

### 3. Find a specific Widget instance

Finally, we might be interested in locating a specific instance of a Widget.
For example, this can be useful when creating Widgets that take a `child`
property and we want to ensure we're rendering the `child` Widget.

<!-- skip -->
```dart
testWidgets('finds a specific instance', (WidgetTester tester) async {
  final childWidget = Padding(padding: EdgeInsets.zero);

  // Provide our childWidget to the Container
  await tester.pumpWidget(Container(child: childWidget));

  // Search for the childWidget in the tree and verify it exists
  expect(find.byWidget(childWidget), findsOneWidget);
});
```

### Summary

The `find` constant provided by the `flutter_test` package gives us several ways
to locate Widgets in the test environment. This recipe demonstrated three of
these methods, and several more methods exist for different purposes.

If the above examples do not work for a particular use-case, please see the
[`CommonFinders` documentation]({{api}}/flutter_driver/CommonFinders-class.html)
to review all available methods.

### Complete example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('finds a Text Widget', (WidgetTester tester) async {
    // Build an App with a Text Widget that displays the letter 'H'
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Find a Widget that displays the letter 'H'
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('finds a Widget using a Key', (WidgetTester tester) async {
    // Define our test key
    final testKey = Key('K');

    // Build a MaterialApp with the testKey
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp Widget using the testKey
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a specific instance', (WidgetTester tester) async {
    final childWidget = Padding(padding: EdgeInsets.zero);

    // Provide our childWidget to the Container
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
```
