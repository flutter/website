---
title: Retrieve the value of a text field
description: How to retrieve text from a text field.
prev:
  title: Create an expandable FAB
  path: /docs/cookbook/effects/expandable-fab
next:
  title: Focus and text fields
  path: /docs/cookbook/forms/focus
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/forms/retreive_input"?>

{% comment %}
prev:
  title: Handle changes to a text field
  path: /docs/cookbook/forms/text-field-changes
{% endcomment %}

In this recipe,
learn how to retrieve the text a user has entered into a text field
using the following steps:

  1. Create a `TextEditingController`.
  2. Supply the `TextEditingController` to a `TextField`.
  3. Display the current value of the text field.

## 1. Create a `TextEditingController`

To retrieve the text a user has entered into a text field,
create a [`TextEditingController`][]
and supply it to a `TextField` or `TextFormField`.

{{site.alert.secondary}}
  **Important:** Call `dispose` of the `TextEditingController` when
  you've finished using it. This ensures that you discard any resources
  used by the object.
{{site.alert.end}}

<?code-excerpt "lib/starter.dart (Starter)" remove="return Container();"?>
```dart
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
  }
}
```

## 2. Supply the `TextEditingController` to a `TextField`

Now that you have a `TextEditingController`, wire it up
to a text field using the `controller` property:

<!-- skip -->
```dart
TextField(
  controller: myController,
);
```

## 3. Display the current value of the text field

After supplying the `TextEditingController` to the text field,
begin reading values. Use the [`text()`][]
method provided by the `TextEditingController` to retrieve the
String that the user has entered into the text field.

The following code displays an alert dialog with the current
value of the text field when the user taps a floating action button.

<!-- skip -->
```dart
FloatingActionButton(
  // When the user presses the button, show an alert dialog containing the
  // text that the user has entered into the text field.
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has entered by using the
          // TextEditingController.
          content: Text(myController.text),
        );
      },
    );
  },
  tooltip: 'Show me the value!',
  child: Icon(Icons.text_fields),
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
      title: 'Retrieve Text Input',
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
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/retrieve-input.gif" alt="Retrieve Text Input Demo" class="site-mobile-screenshot" />
</noscript>


[`text()`]: {{site.api}}/flutter/widgets/TextEditingController/text.html
[`TextEditingController`]: {{site.api}}/flutter/widgets/TextEditingController-class.html
