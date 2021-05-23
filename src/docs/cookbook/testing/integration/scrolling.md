---
title: Handle scrolling
description: How to handle scrolling in an integration test.
prev:
  title: An introduction to integration testing
  path: /docs/cookbook/testing/integration/introduction
next:
  title: Performance profiling
  path: /docs/cookbook/testing/integration/profiling
---

<?code-excerpt path-base="../null_safety_examples/cookbook/testing/integration/scrolling/"?>

{{site.alert.note}}
  The integration_test package is now the recommended way to write integration
  tests. See the [Integration testing](/docs/testing/integration-tests/) page
  for details.
{{site.alert.end}}

Many apps feature lists of content,
from email clients to music apps and beyond.
To verify that lists contain the expected content
using integration tests,
you need a way to scroll through lists to search for particular items.

To scroll through lists via integration tests,
use the methods provided by the [`FlutterDriver`][] class,
which is included in the [`flutter_driver`][] package:

In this recipe, learn how to scroll through a list of items to
verify a specific widget is being displayed, and discuss the pros on cons of
different approaches. If you're just getting started with integration testing,
read through the [Introduction to integration testing][] recipe.

This recipe uses the following steps:

  1. Create an app with a list of items.
  2. Instrument the app.
  3. Write a test that scrolls through the list.
  4. Run the test.

### 1. Create an app with a list of items

This recipe builds an app that shows a long list of items.
To keep this recipe focused on testing, use the app created in the
[Work with long lists][] recipe.
If you're unsure of how to work with long lists,
see that recipe for an introduction.

As you did in the [Introduction to integration testing][] recipe,
add keys to the widgets you want to interact with
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

### 2. Instrument the app

Next, create an instrumented version of the app. This code lives
in a file called `test_driver/app.dart`.

<?code-excerpt "test_driver/app.dart"?>
```dart

import 'package:flutter_driver/driver_extension.dart';
import 'package:scrolling/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
```

### 3. Write a test that scrolls through the list

Now, you can write a test. In this example, scroll through the list
of items and verify that a particular item exists in the list.
The [`FlutterDriver`][] class provides three methods for
scrolling through lists:

* The [`scroll()`][] method scrolls through
  a specific list by a given amount.
* The [`scrollIntoView()`][] method finds a
  specific widget that's already been rendered,
  and scrolls it completely into view.
  Some widgets, such as [`ListView.builder`][],
  render items on-demand.
* The [`scrollUntilVisible()`][] method scrolls
  through a list until a specific widget is visible.

While all three methods work for specific use-cases,
`scrollUntilVisible` is oftentimes the most robust option. Why?

  1. If using the `scroll()` method alone, you might incorrectly assume
     the height of each item in the list. This could lead to scrolling
     too much or too little.
  2. If using the `scrollIntoView()` method, you might assume that the
     widget has been instantiated and rendered. To verify that an app
     works on a broad range of devices, run integration tests against
     devices with different screen sizes. Since `ListView.builder`
     renders items on-demand, whether a particular widget has been
     rendered can depend on the size of the screen.

Therefore, rather than assuming that you know the height of all the items
in a list, or that a particular widget is rendered on all devices,
use the `scrollUntilVisible()` method to repeatedly scroll through
a list of items until you find what you're looking for.

The following code shows how to use the `scrollUntilVisible()` method
to look through the list for a particular item. This code lives in a
file called `test_driver/app_test.dart`.

<?code-excerpt "test_driver/app_test.dart"?>
```dart

// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      await driver.close();
    });

    test('verifies the list contains a specific item', () async {
      // Create two SerializableFinders and use these to locate specific
      // widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys provided to the widgets in step 1.
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      await driver.scrollUntilVisible(
        // Scroll through the list
        listFinder,
        // Until finding this item
        itemFinder,
        // To scroll down the list, provide a negative value to dyScroll.
        // Ensure that this value is a small enough increment to
        // scroll the item into view without potentially scrolling past it.
        //
        // To scroll through horizontal lists, provide a dxScroll
        // property instead.
        dyScroll: -300.0,
      );

      // Verify that the item contains the correct text.
      expect(
        await driver.getText(itemFinder),
        'Item 50',
      );
    });
  });
}
```

### 4. Run the test

Run the test using the following command from the root of the project:

```
flutter drive --target=test_driver/app.dart
```


[`flutter_driver`]: {{site.api}}/flutter/flutter_driver/flutter_driver-library.html
[`FlutterDriver`]: {{site.api}}/flutter/flutter_driver/FlutterDriver-class.html
[Introduction to integration testing]: /docs/cookbook/testing/integration
[`ListView.builder`]: {{site.api}}/flutter/widgets/ListView/ListView.builder.html
[`scroll()`]: {{site.api}}/flutter/flutter_driver/FlutterDriver/scroll.html
[`scrollIntoView()`]: {{site.api}}/flutter/flutter_driver/FlutterDriver/scrollIntoView.html
[`scrollUntilVisible()`]: {{site.api}}/flutter/flutter_driver/FlutterDriver/scrollUntilVisible.html
[Work with long lists]: /docs/cookbook/lists/long-lists
