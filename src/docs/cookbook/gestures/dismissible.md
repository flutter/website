---
title: Implement swipe to dismiss
description: How to implement swiping to dismiss or delete.
diff2html: true
prev:
  title: Handle taps
  path: /docs/cookbook/gestures/handling-taps
next:
  title: Display images from the internet
  path: /docs/cookbook/images/network-image
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/gestures/dismissible"?>

The "swipe to dismiss" pattern is common in many mobile apps.
For example, when writing an email app,
you might want to allow a user to swipe away
email messages to delete them from a list.

Flutter makes this task easy by providing the
[`Dismissible`][] widget.
Learn how to implement swipe to dismiss with the following steps:

  1. Create a list of items.
  2. Wrap each item in a `Dismissible` widget.
  3. Provide "leave behind" indicators.

## 1. Create a list of items

First, create a list of items. For detailed
instructions on how to create a list,
follow the [Working with long lists][] recipe.

### Create a data source

In this example,
you want 20 sample items to work with.
To keep it simple, generate a list of strings.

<!-- skip -->
```dart
final items = List<String>.generate(20, (i) => "Item ${i + 1}");
```

### Convert the data source into a list

Display each item in the list on screen. Users won't
be able to swipe these items away just yet.

<?code-excerpt "lib/step1.dart (ListView)" replace="/^body: //g;/,$//g"?>
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(title: Text('${items[index]}'));
  },
)
```

## 2. Wrap each item in a Dismissible widget

In this step,
give users the ability to swipe an item off the list by using the
[`Dismissible`][] widget.

After the user has swiped away the item,
remove the item from the list and display a snackbar.
In a real app, you might need to perform more complex logic,
such as removing the item from a web service or database.

Update the `itemBuilder()` function to return a `Dismissible` widget:

<?code-excerpt "lib/step2.dart (Dismissible)"?>
```dart
itemBuilder: (context, index) {
  final item = items[index];
  return Dismissible(
    // Each Dismissible must contain a Key. Keys allow Flutter to
    // uniquely identify widgets.
    key: Key(item),
    // Provide a function that tells the app
    // what to do after an item has been swiped away.
    onDismissed: (direction) {
      // Remove the item from the data source.
      setState(() {
        items.removeAt(index);
      });

      // Then show a snackbar.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$item dismissed')));
    },
    child: ListTile(title: Text('$item')),
  );
},
```

## 3. Provide "leave behind" indicators

As it stands,
the app allows users to swipe items off the list, but it doesn't
give a visual indication of what happens when they do.
To provide a cue that items are removed,
display a "leave behind" indicator as they
swipe the item off the screen. In this case,
the indicator is a red background.

To add the indicator,
provide a `background` parameter to the `Dismissible`.

<?code-excerpt "lib/{step2,main}.dart (Dismissible)"?>
```diff
--- lib/step2.dart (Dismissible)
+++ lib/main.dart (Dismissible)
@@ -16,6 +16,8 @@
       ScaffoldMessenger.of(context)
           .showSnackBar(SnackBar(content: Text('$item dismissed')));
     },
+    // Show a red background as the item is swiped away.
+    background: Container(color: Colors.red),
     child: ListTile(title: Text('$item')),
   );
 },
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          },
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/dismissible.gif" alt="Dismissible Demo" class="site-mobile-screenshot" />
</noscript>


[`Dismissible`]: {{site.api}}/flutter/widgets/Dismissible-class.html
[Working with long lists]: /docs/cookbook/lists/long-lists
