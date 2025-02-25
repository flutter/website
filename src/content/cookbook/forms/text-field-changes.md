---
title: Handle changes to a text field
description: How to detect changes to a text field.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/forms/text_field_changes/"?>

In some cases, it's useful to run a callback function every time the text
in a text field changes. For example, you might want to build a search
screen with autocomplete functionality where you want to update the
results as the user types.

How do you run a callback function every time the text changes?
With Flutter, you have two options:

  1. Supply an `onChanged()` callback to a `TextField` or a `TextFormField`.
  2. Use a `TextEditingController`.

## 1. Supply an `onChanged()` callback to a `TextField` or a `TextFormField`

The simplest approach is to supply an [`onChanged()`][] callback to a
[`TextField`][] or a [`TextFormField`][].
Whenever the text changes, the callback is invoked.

In this example, print the current value and length of the text field 
to the console every time the text changes.

It's important to use [characters][] when dealing with user input,
as text may contain complex characters.
This ensures that every character is counted correctly
as they appear to the user.

<?code-excerpt "lib/main.dart (TextField1)"?>
```dart
TextField(
  onChanged: (text) {
    print('First text field: $text (${text.characters.length})');
  },
),
```

## 2. Use a `TextEditingController`

A more powerful, but more elaborate approach, is to supply a
[`TextEditingController`][] as the [`controller`][]
property of the `TextField` or a `TextFormField`.

To be notified when the text changes, listen to the controller
using the [`addListener()`][] method using the following steps:

  1. Create a `TextEditingController`.
  2. Connect the `TextEditingController` to a text field.
  3. Create a function to print the latest value.
  4. Listen to the controller for changes.

### Create a `TextEditingController`

Create a `TextEditingController`:

<?code-excerpt "lib/main_step1.dart (Step1)" remove="return Container();"?>
```dart
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
  }
}
```

:::note
Remember to dispose of the `TextEditingController` when it's no
longer needed. This ensures that you discard any resources used
by the object.
:::

### Connect the `TextEditingController` to a text field

Supply the `TextEditingController` to either a `TextField`
or a `TextFormField`. Once you wire these two classes together,
you can begin listening for changes to the text field.

<?code-excerpt "lib/main.dart (TextField2)"?>
```dart
TextField(controller: myController),
```

### Create a function to print the latest value

You need a function to run every time the text changes.
Create a method in the `_MyCustomFormState` class that prints
out the current value of the text field.

<?code-excerpt "lib/main.dart (printLatestValue)"?>
```dart
void _printLatestValue() {
  final text = myController.text;
  print('Second text field: $text (${text.characters.length})');
}
```

### Listen to the controller for changes

Finally, listen to the `TextEditingController` and call the
`_printLatestValue()` method when the text changes. Use the
[`addListener()`][] method for this purpose.

Begin listening for changes when the
`_MyCustomFormState` class is initialized,
and stop listening when the `_MyCustomFormState` is disposed.

<?code-excerpt "lib/main.dart (init-state)"?>
```dart
@override
void initState() {
  super.initState();

  // Start listening to changes.
  myController.addListener(_printLatestValue);
}
```

<?code-excerpt "lib/main.dart (dispose)"?>
```dart
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  myController.dispose();
  super.dispose();
}
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter text field change hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                print('First text field: $text (${text.characters.length})');
              },
            ),
            TextField(controller: myController),
          ],
        ),
      ),
    );
  }
}
```

[`addListener()`]: {{site.api}}/flutter/foundation/ChangeNotifier/addListener.html
[`controller`]: {{site.api}}/flutter/material/TextField/controller.html
[`onChanged()`]: {{site.api}}/flutter/material/TextField/onChanged.html
[`TextField`]: {{site.api}}/flutter/material/TextField-class.html
[`TextEditingController`]: {{site.api}}/flutter/widgets/TextEditingController-class.html
[`TextFormField`]: {{site.api}}/flutter/material/TextFormField-class.html
[characters]: {{site.pub}}/packages/characters
