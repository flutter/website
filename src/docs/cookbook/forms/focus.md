---
title: Focus and text fields
description: How focus works with text fields.
prev:
  title: Retrieve the value of a text field
  path: /docs/cookbook/forms/retrieve-input
next:
  title: Add Material touch ripples
  path: /docs/cookbook/gestures/ripples
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/forms/focus/"?>

When a text field is selected and accepting input,
it is said to have "focus."
Generally, users shift focus to a text field by tapping,
and developers shift focus to a text field programmatically by
using the tools described in this recipe.

Managing focus is a fundamental tool for creating forms with an intuitive
flow. For example, say you have a search screen with a text field.
When the user navigates to the search screen,
you can set the focus to the text field for the search term.
This allows the user to start typing as soon as the screen
is visible, without needing to manually tap the text field.

In this recipe, learn how to give the focus
to a text field as soon as it's visible,
as well as how to give focus to a text field
when a button is tapped.

## Focus a text field as soon as it's visible

To give focus to a text field as soon as it's visible,
use the `autofocus` property.

<!-- skip -->
```dart
TextField(
  autofocus: true,
);
```

For more information on handling input and creating text fields,
see the [Forms][] section of the cookbook.

## Focus a text field when a button is tapped

Rather than immediately shifting focus to a specific text field,
you might need to give focus to a text field at a later point in time.
In the real world, you might also need to give focus to a specific
text field in response to an API call or a validation error.
In this example, give focus to a text field after the user
presses a button using the following steps:

  1. Create a `FocusNode`.
  2. Pass the `FocusNode` to a `TextField`.
  3. Give focus to the `TextField` when a button is tapped.

### 1. Create a `FocusNode`

First, create a [`FocusNode`][].
Use the `FocusNode` to identify a specific `TextField` in Flutter's
"focus tree." This allows you to give focus to the `TextField`
in the next steps.

Since focus nodes are long-lived objects, manage the lifecycle
using a `State` object. Use the following instructions to create
a `FocusNode` instance inside the `initState()` method of a
`State` class, and clean it up in the `dispose()` method:

<?code-excerpt "lib/starter.dart (Starter)" remove="return Container();"?>
```dart
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
  }
}
```

### 2. Pass the `FocusNode` to a `TextField`

Now that you have a `FocusNode`,
pass it to a specific `TextField` in the `build()` method.

<!-- skip -->
```dart
class _MyCustomFormState extends State<MyCustomForm> {
  // Code to create the Focus node...

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: myFocusNode,
    );
  }
}
```

### 3. Give focus to the `TextField` when a button is tapped

Finally, focus the text field when the user taps a floating
action button. Use the [`requestFocus()`][] method to perform
this task.

<!-- skip -->
```dart
FloatingActionButton(
  // When the button is pressed, give focus to the text field using
  // myFocusNode.
  onPressed: () => myFocusNode.requestFocus(),
);
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Field Focus',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Field Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // The first text field is focused on as soon as the app starts.
            TextField(
              autofocus: true,
            ),
            // The second text field is focused on when a user taps the
            // FloatingActionButton.
            TextField(
              focusNode: myFocusNode,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the button is pressed,
        // give focus to the text field using myFocusNode.
        onPressed: () => myFocusNode.requestFocus(),
        tooltip: 'Focus Second Text Field',
        child: Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/focus.gif" alt="Text Field Focus Demo" class="site-mobile-screenshot" />
</noscript>


[fix has landed]: {{site.github}}/flutter/flutter/pull/50372
[`FocusNode`]: {{site.api}}/flutter/widgets/FocusNode-class.html
[Forms]: /docs/cookbook#forms
[flutter/flutter@bf551a3]: {{site.github}}/flutter/flutter/commit/bf551a31fe7ef45c854a219686b6837400bfd94c
[Issue 52221]: {{site.github}}/flutter/flutter/issues/52221
[`requestFocus()`]: {{site.api}}/flutter/widgets/FocusNode/requestFocus.html
[workaround]: {{site.github}}/flutter/flutter/issues/52221#issuecomment-598244655
