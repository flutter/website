---
layout: page
title: "Retrieve the value of a text field"
permalink: /cookbook/forms/retrieve-input/
---

In this recipe, we'll see how to retrieve the text a user has typed into a text 
field.

## Directions

  1. Create a `TextEditingController`
  2. Supply the `TextEditingController` to a `TextField`
  3. Display the current value of the text field

## 1. Create a `TextEditingController`

In order to retrieve the text a user has typed into a text field, we need to 
create a  [`TextEditingController`](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html).
We will then supply the `TextEditingController` to a `TextField` in the next 
steps.

Once a `TextEditingController` is supplied to a `TextField` or `TextFormField`,
we can use it to retrieve the text a user has typed into that text field.

Note: It is also important to `dispose` of the `TextEditingController` when we 
are finished using it. This will ensure we discard any resources used by the 
object.

<!-- skip -->
```dart
// Define a Custom Form Widget
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyFormState extends State<MyForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We will fill this out in the next step!
  }
}
```

## 2. Supply the `TextEditingController` to a `TextField`

Now that we have a `TextEditingController` to work with, we need to wire it up
to a specific text field. To do this, we'll supply the `TextEditingController` 
to a `TextField` or `TextFormField` Widget as the `controller` property.

<!-- skip -->
```dart
new TextField(
  controller: myController,
);
```

## 3. Display the current value of the text field

After we've supplied the `TextEditingController` to our text field, we can begin
reading values! We will use the [`text`](https://docs.flutter.io/flutter/widgets/TextEditingController/text.html) 
method provided by the `TextEditingController` to retrieve the String of text 
the user has typed into the text field.

In this example, we will display an alert dialog with the current value of
the text field when the user taps on a floating action button.  

<!-- skip -->
```dart
new FloatingActionButton(
  // When the user presses the button, show an alert dialog with the 
  // text the user has typed into our text field.
  onPressed: () {
    return showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          // Retrieve the text the user has typed in using our
          // TextEditingController
          content: new Text(myController.text),
        );
      },
    );
  },
  tooltip: 'Show me the value!',
  child: new Icon(Icons.text_fields),
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Retrieve Text Input',
      home: new MyForm(),
    );
  }
}

// Define a Custom Form Widget
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyFormState extends State<MyForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Retrieve Text Input'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController
                content: new Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: new Icon(Icons.text_fields),
      ),
    );
  }
}
```

![Retrieve Text Input Demo](/images/cookbook/retrieve-input.gif)
