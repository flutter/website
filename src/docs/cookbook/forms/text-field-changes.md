---
title: Handling changes to a text field
prev:
  title: Focus on a Text Field
  path: /docs/cookbook/forms/focus
next:
  title: Retrieve the value of a text field
  path: /docs/cookbook/forms/retrieve-input
---

In some cases, it can be handy to run a callback function every time the text
in a text field changes. For example, we might want to build a search screen
with autocomplete functionality. In this case, we would want to update the
results as the user types.

How can we run a callback function every time the text changes? With Flutter,
we have two options:

  1. Supply an `onChanged` callback to a `TextField`
  2. Use a `TextEditingController`

## 1. Supply an `onChanged` callback to a `TextField`

The simplest approach is to supply an
[`onChanged`]({{site.api}}/flutter/material/TextField/onChanged.html)
callback to a
[`TextField`]({{site.api}}/flutter/material/TextField-class.html).
Whenever the text changes, the callback will be invoked. One downside to this
approach is it does not work with `TextFormField` Widgets.

In this example, we will print the current value of the text field to the
console every time the text changes.

<!-- skip -->
```dart
TextField(
  onChanged: (text) {
    print("First text field: $text");
  },
);
```

## 2. Use a `TextEditingController`

A more powerful, but more elaborate approach, is to supply a
[`TextEditingController`]({{site.api}}/flutter/widgets/TextEditingController-class.html)
as the
[`controller`]({{site.api}}/flutter/material/TextField/controller.html)
property of the `TextField` or a `TextFormField`.

To be notified when the text changes, we can listen to the controller using its
[`addListener`]({{site.api}}/flutter/foundation/ChangeNotifier/addListener.html)
method.

### Directions

  - Create a `TextEditingController`
  - Supply the `TextEditingController` to a `TextField`
  - Create a function to print the latest value
  - Listen to the controller for changes

### Create a `TextEditingController`

First, we'll need to create a `TextEditingController`. In the subsequent steps,
we will supply the `TextEditingController` to a `TextField`. Once we've wired
these two classes together, we can listen for changes to the text field!

<!-- skip -->
```dart
// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We will fill this out in the next step!
  }
}
```

Note: Please remember to `dispose` the `TextEditingController` when it is no
longer needed. This will ensure we discard any resources used by the object.

### Supply the `TextEditingController` to a `TextField`

In order to work, the `TextEditingController` must be supplied to either a
`TextField` or a `TextFormField`. Once it's wired up, we can begin listening
for changes to the text field.

<!-- skip -->
```dart
TextField(
  controller: myController,
);
```

### Create a function to print the latest value

Now, we'll need a function that should run every time the text changes! In this
example, we'll create a method that prints out the current value of the text
field.

This method will live inside our `_MyCustomFormState` class.

<!-- skip -->
```dart
_printLatestValue() {
  print("Second text field: ${myController.text}");
}
```

### Listen to the controller for changes

Finally, we need to listen to the `TextEditingController` and run the
`_printLatestValue` method whenever the text changes. We will use the
[`addListener`]({{site.api}}/flutter/foundation/ChangeNotifier/addListener.html)
method to achieve this task.

In this example, we will begin listening for changes when the
`_MyCustomFormState` class is initialized, and stop listening when the
`_MyCustomFormState` is disposed.

<!-- skip -->
```dart
class _MyCustomFormState extends State<MyCustomForm> {
  @override
  void initState() {
    super.initState();

    // Start listening to changes
    myController.addListener(_printLatestValue);
  }
}
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // This also removes the _printLatestValue listener
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) {
                print("First text field: $text");
              },
            ),
            TextField(
              controller: myController,
            ),
          ],
        ),
      ),
    );
  }
}
```
