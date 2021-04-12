---
title: Build a form with validation
description: How to build a form that validates input.
prev:
  title: Work with tabs
  path: /docs/cookbook/design/tabs
next:
  title: Create and style a text field
  path: /docs/cookbook/forms/text-input
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/forms/validation"?>

Apps often require users to enter information into a text field.
For example, you might require users to log in with an email address
and password combination.

To make apps secure and easy to use, check whether the
information the user has provided is valid. If the user has correctly filled
out the form, process the information. If the user submits incorrect
information, display a friendly error message letting them know what went
wrong.

In this example, learn how to add validation to a form that has
a single text field using the following steps:

  1. Create a `Form` with a `GlobalKey`.
  2. Add a `TextFormField` with validation logic.
  3. Create a button to validate and submit the form.

## 1. Create a `Form` with a `GlobalKey`

First, create a [`Form`][].
The `Form` widget acts as a container for grouping
and validating multiple form fields.

When creating the form, provide a [`GlobalKey`][].
This uniquely identifies the `Form`,
and allows validation of the form in a later step.

<?code-excerpt "lib/form.dart"?>
```dart
import 'package:flutter/material.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
```

{{site.alert.tip}}
  Using a `GlobalKey` is the recommended way to access a form.
  However, if you have a more complex widget tree,
  you can use the [`Form.of()`][] method to
  access the form within nested widgets.
{{site.alert.end}}

## 2. Add a `TextFormField` with validation logic

Although the `Form` is in place,
it doesn't have a way for users to enter text.
That's the job of a [`TextFormField`][].
The `TextFormField` widget renders a material design text field
and can display validation errors when they occur.

Validate the input by providing a `validator()` function to the
`TextFormField`. If the user's input isn't valid,
the `validator` function returns a `String` containing
an error message.
If there are no errors, the validator must return null.

For this example, create a `validator` that ensures the
`TextFormField` isn't empty. If it is empty,
return a friendly error message.

<?code-excerpt "lib/main.dart (TextFormField)"?>
```dart
TextFormField(
  // The validator receives the text that the user has entered.
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
),
```

## 3. Create a button to validate and submit the form

Now that you have a form with a text field,
provide a button that the user can tap to submit the information.

When the user attempts to submit the form, check if the form is valid.
If it is, display a success message.
If it isn't (the text field has no content) display the error message.

<?code-excerpt "lib/main.dart (ElevatedButton)" replace="/^child\: //g"?>
```dart
ElevatedButton(
  onPressed: () {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  },
  child: Text('Submit'),
),
```

### How does this work?

To validate the form, use the `_formKey` created in
step 1. You can use the `_formKey.currentState()`
method to access the [`FormState`][],
which is automatically created by Flutter when building a `Form`.

The `FormState` class contains the `validate()` method.
When the `validate()` method is called, it runs the `validator()`
function for each text field in the form.
If everything looks good, the `validate()` method returns `true`.
If any text field contains errors, the `validate()` method
rebuilds the form to display any error messages and returns `false`.

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/form-validation.gif" alt="Form Validation Demo" class="site-mobile-screenshot" />
</noscript>


[`Form`]: {{site.api}}/flutter/widgets/Form-class.html
[`Form.of()`]: {{site.api}}/flutter/widgets/Form/of.html
[`FormState`]: {{site.api}}/flutter/widgets/FormState-class.html
[`GlobalKey`]: {{site.api}}/flutter/widgets/GlobalKey-class.html
[`TextFormField`]: {{site.api}}/flutter/material/TextFormField-class.html
