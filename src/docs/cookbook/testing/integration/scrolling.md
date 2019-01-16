---
title: Scrolling
prev:
  title: Performance profiling
  path: /docs/cookbook/testing/integration/profiling
next:
  title: An introduction to unit testing
  path: /docs/cookbook/testing/unit/introduction
---

Many apps feature lists of content, from email clients to music apps and beyond.
In order to verify that lists contain the content we expect using integration
tests, we need a way to scroll through lists to search for particular items.

In order to scroll through lists via integration tests, we can use the methods
provided by the
[`FlutterDriver`]({{site.api}}/flutter/flutter_driver/FlutterDriver-class.html)
class, which is included in the
[`flutter_driver`]({{site.api}}/flutter/flutter_driver/flutter_driver-library.html)
package:

In this recipe, we'll learn how to scroll through a list of items in order to
verify a specific Widget is being displayed, and discuss the pros on cons of
different approaches. If you're just getting started with integration testing,
please read through the [Introduction to integration
testing](/docs/cookbook/testing/integration) recipe.

### Directions

  1. Create an app with a list of items
  2. Instrument the app
  3. Write a test that scrolls through the list
  4. Run the test

### 1. Create an app with a list of items

In this recipe, we'll build an app that shows a long list of items. In order to
keep this recipe focused on testing, we'll use the app we created in the
[Working with long lists](/docs/cookbook/lists/long-lists) recipe. If you're unsure
of how to work with lists of content, please see that recipe for an
introduction.

As we did in the [Introduction to integration
testing](/docs/cookbook/testing/integration) recipe, we'll also add keys to the
widgets we want to interact with inside our integration tests.

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

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          // Add a key to the ListView. This allows us to find the list and
          // scroll through it in our tests
          key: Key('long_list'),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${items[index]}',
                // Add a key to the Text Widget for each item. This allows
                // us to look for a particular item in the list and verify the
                // text is correct
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

Next, we'll need to create an instrumented version of our app. This code lives
in a file called `test_driver/app.dart`.

<!-- skip -->
```dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:scrollable_app/main.dart' as app;

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  app.main();
}
```

### 3. Write a test that scrolls through the list

Now, we can write our test! In this example, we need to scroll through the list
of items and verify that a particular item exists in the list. The
[`FlutterDriver`]({{site.api}}/flutter/flutter_driver/FlutterDriver-class.html)
class provides three methods for scrolling through lists:

  - The
  [`scroll`]({{site.api}}/flutter/flutter_driver/FlutterDriver/scroll.html)
  method allows us to scroll through a specific list by a given amount.
  - The
  [`scrollIntoView`]({{site.api}}/flutter/flutter_driver/FlutterDriver/scrollIntoView.html)
  method finds a specific Widget that's already been rendered, and will scroll
  it completely into view. Some Widgets, such as
  [`ListView.builder`]({{site.api}}/flutter/widgets/ListView/ListView.builder.html),
  render items on-demand.
  - The
  [`scrollUntilVisible`]({{site.api}}/flutter/flutter_driver/FlutterDriver/scrollUntilVisible.html)
  method scrolls through a list until a specific Widget is visible.

While all three methods work for specific use-cases, `scrollUntilVisible` is
oftentimes the most robust option. Why?

  1. If we use the `scroll` method alone, we might incorrectly assume the height
  of each item in the list. This could lead to scrolling too much or too little.
  2. If we use the `scrollIntoView` method, we assume the Widget has been
  instantiated and rendered. In order to verify our apps work on a broad range
  of devices, we might run our integration tests against devices with different
  screen sizes. Since `ListView.builder` will render items on-demand,
  whether or not a particular Widget has been rendered can depend
  on the size of the screen.

Therefore, rather than assuming we know the height of all the items in a list,
or that a particular Widget will be rendered on all devices, we can use the
`scrollUntilVisible` method to repeatedly scroll through a list of items until
we find what we're looking for!

Let's see how we can use the `scrollUntilVisible` method to look through the
list for a particular item! This code lives in a file called
`test_driver/app_test.dart`.

```dart
// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('verifies the list contains a specific item', () async {
      // Create two SerializableFinders. We will use these to locate specific
      // Widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys we provided to our Widgets in step 1.
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      await driver.scrollUntilVisible(
        // Scroll through this list
        listFinder,
        // Until we find this item
        itemFinder,
        // In order to scroll down the list, we need to provide a negative
        // value to dyScroll. Ensure this value is a small enough increment to
        // scroll the item into view without potentially scrolling past it.
        //
        // If you need to scroll through horizontal lists, provide a dxScroll
        // argument instead
        dyScroll: -300.0,
      );

      // Verify the item contains the correct text
      expect(
        await driver.getText(itemFinder),
        'Item 50',
      );
    });
  });
}
```

### 4. Run the test

Finally, we can run the test using the following command from the root of the
project:

```
flutter drive --target=test_driver/app.dart
```
