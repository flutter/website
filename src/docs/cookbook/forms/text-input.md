---
title: Create and style a text field
description: How to implement a text field.
prev:
  title: Build a form with validation
  path: /docs/cookbook/forms/validation
next:
  title: Handle changes to a text field
  path: /docs/cookbook/forms/text-field-changes
---

Text fields allow users to type text into an app.
They are used to build forms,
send messages, create search experiences, and more.
In this recipe, explore how to create and style text fields.

Flutter provides two text fields:
[`TextField`][] and [`TextFormField`][].

## `TextField`

[`TextField`][] is the most commonly used text input widget.

By default, a `TextField` is decorated with an underline.
You can add a label, icon, inline hint text, and error text by supplying an
[`InputDecoration`][] as the [`decoration`][]
property of the `TextField`.
To remove the decoration entirely (including the
underline and the space reserved for the label),
set the `decoration` to null.

<!-- skip -->
```dart
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: 'Enter a search term'
  ),
);
```

To retrieve the value when it changes,
see the [Handle changes to a text field][] recipe.

## `TextFormField`

[`TextFormField`][] wraps a `TextField` and integrates it
with the enclosing [`Form`][].
This provides additional functionality,
such as validation and integration with other
[`FormField`][] widgets.

<!-- skip -->
```dart
TextFormField(
  decoration: InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Enter your username'
  ),
);
```

## Interactive example

```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Styling Demo';
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

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
      ],
    );
  }
}
```

For more information on input validation, see the
[Building a form with validation][] recipe.


[Building a form with validation]: /docs/cookbook/forms/validation/
[`decoration`]: {{site.api}}/flutter/material/TextField/decoration.html
[`Form`]: {{site.api}}/flutter/widgets/Form-class.html
[`FormField`]: {{site.api}}/flutter/widgets/FormField-class.html
[Handle changes to a text field]: /docs/cookbook/forms/text-field-changes/
[`InputDecoration`]: {{site.api}}/flutter/material/InputDecoration-class.html
[`TextField`]: {{site.api}}/flutter/material/TextField-class.html
[`TextFormField`]: {{site.api}}/flutter/material/TextFormField-class.html
