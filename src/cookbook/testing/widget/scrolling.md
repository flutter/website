---
title: Handle scrolling
description: How to handle scrolling in a widget test.
prev:
  title: Find widgets
  path: /cookbook/testing/widget/finders
next:
  title: Tap, drag, and enter text
  path: /cookbook/testing/widget/tap-drag
---

<?code-excerpt path-base="cookbook/testing/widget/scrolling/"?>

Many apps feature lists of content,
from email clients to music apps and beyond.
To verify that lists contain the expected content
using widget tests,
you need a way to scroll through lists to search for particular items.

To scroll through lists via integration tests,
use the methods provided by the [`WidgetTester`][] class,
which is included in the [`flutter_test`][] package:

In this recipe, learn how to scroll through a list of items to
verify a specific widget is being displayed, and discuss the pros on cons of
different approaches. 

This recipe uses the following steps:

1. Create an app with a list of items.
2. Write a test that scrolls through the list.
3. Run the test.

### 1. Create an app with a list of items

This recipe builds an app that shows a long list of items.
To keep this recipe focused on testing, use the app created in the
[Work with long lists][] recipe.
If you're unsure of how to work with long lists,
see that recipe for an introduction.

Add keys to the widgets you want to interact with
inside the integration tests.

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    items: List<String>.generate(10000, (i) => "Item $i"),
  ));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          // Add a key to the ListView. This makes it possible to
          // find the list and scroll through it in the tests.
          key: const Key('long_list'),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
                // Add a key to the Text widget for each item. This makes
                // it possible to look for a particular item in the list
                // and verify that the text is correct
                key: Key('item_${index}_text'),
              ),
            );
          },
        ),
      ),
    );
  }
}
```


### 2. Write a test that scrolls through the list

Now, you can write a test. In this example, scroll through the list of items and
verify that a particular item exists in the list. The [`WidgetTester`][] class
provides the [`scrollUntilVisible()`][] method, which scrolls through a list
until a specific widget is visible. This is useful because the height of the
items in the list can change depending on the device.

Rather than assuming that you know the height of all the items
in a list, or that a particular widget is rendered on all devices,
the `scrollUntilVisible()` method trepeatedly scrolls through
a list of items until it finds what it's looking for.

The following code shows how to use the `scrollUntilVisible()` method
to look through the list for a particular item. This code lives in a
file called `test/widget_test.dart`.

<?code-excerpt "test/widget_test.dart (ScrollWidgetTest)"?>
```dart

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:scrolling/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      items: List<String>.generate(10000, (i) => "Item $i"),
    ));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('item_50_text'));

    // Scroll until the item to be found appears.
    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
      scrollable: listFinder,
    );

    // Verify that the item contains the correct text.
    expect(itemFinder, findsOneWidget);
  });
}
```

### 3. Run the test

Run the test using the following command from the root of the project:

```
flutter test test/widget_test.dart
```

[`flutter_test`]: {{site.api}}/flutter/flutter_test/flutter_test-library.html
[`WidgetTester`]: {{site.api}}/flutter/flutter_test/WidgetTester-class.html
[`ListView.builder`]: {{site.api}}/flutter/widgets/ListView/ListView.builder.html
[`scrollUntilVisible()`]: {{site.api}}/flutter/flutter_test/WidgetController/scrollUntilVisible.html
[Work with long lists]: /cookbook/lists/long-lists
