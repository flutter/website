---
title: Create lists with different types of items
description: How to implement a list that contains different types of assets.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/lists/mixed_list/"?>

You might need to create lists that display different types of content.
For example, you might be working on a list that shows a heading
followed by a few items related to the heading, followed by another heading,
and so on.

Here's how you can create such a structure with Flutter:

  1. Create a data source with different types of items.
  2. Convert the data source into a list of widgets.

## 1. Create a data source with different types of items

### Types of items

To represent different types of items in a list, define
a class for each type of item.

In this example, create an app that shows a header followed by five
messages. Therefore, create three classes: `ListItem`, `HeadingItem`,
and `MessageItem`.

<?code-excerpt "lib/main.dart (ListItem)"?>
```dart
/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
```

### Create a list of items

Most of the time, you would fetch data from the internet or a local
database and convert that data into a list of items.

For this example, generate a list of items to work with. The list
contains a header followed by five messages. Each message has one
of 3 types: `ListItem`, `HeadingItem`, or `MessageItem`.

<?code-excerpt "lib/main.dart (Items)" replace="/^items:/final items =/g;/^\),$/);/g"?>
```dart
final items = List<ListItem>.generate(
  1000,
  (i) =>
      i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'),
);
```

## 2. Convert the data source into a list of widgets

To convert each item into a widget,
use the [`ListView.builder()`][] constructor.

In general, provide a builder function that checks for what type
of item you're dealing with, and returns the appropriate widget
for that type of item.

<?code-excerpt "lib/main.dart (builder)" replace="/^body: //g;/^\),$/)/g"?>
```dart
ListView.builder(
  // Let the ListView know how many items it needs to build.
  itemCount: items.length,
  // Provide a builder function. This is where the magic happens.
  // Convert each item into a widget based on the type of item it is.
  itemBuilder: (context, index) {
    final item = items[index];

    return ListTile(
      title: item.buildTitle(context),
      subtitle: item.buildSubtitle(context),
    );
  },
)
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter create mixed lists hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: List<ListItem>.generate(
        1000,
        (i) =>
            i % 6 == 0
                ? HeadingItem('Heading $i')
                : MessageItem('Sender $i', 'Message body $i'),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/mixed-list.png" alt="Mixed list demo" class="site-mobile-screenshot" />
</noscript>


[`ListView.builder()`]: {{site.api}}/flutter/widgets/ListView/ListView.builder.html
