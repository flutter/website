---
layout: page
title: "Create and style a text field"
permalink: /cookbook/forms/text-input/
---

Text fields allow users to type text into our apps. Text fields can be used to 
build forms, messaging apps, search experiences, and more! In this recipe, 
we'll explore how to create and style text fields.

Flutter provides two text fields out of the box: [`TextField`](https://docs.flutter.io/flutter/material/TextField-class.html)
and [`TextFormField`](https://docs.flutter.io/flutter/material/TextFormField-class.html).

## `TextField`

[`TextField`](https://docs.flutter.io/flutter/material/TextField-class.html)
is the most commonly used text input widget.

By default, a `TextField` is decorated with an underline. We can add a label,
an icon, inline hint text, and error text by supplying an
[`InputDecoration`](https://docs.flutter.io/flutter/material/InputDecoration-class.html)
as the [`decoration`](https://docs.flutter.io/flutter/material/TextField/decoration.html)
property of the `TextField`. To remove the decoration entirely (including the
underline and the space reserved for the label), set the `decoration` to null
explicitly.

<!-- skip -->
```dart
new TextField(
  decoration: new InputDecoration(
    border: InputBorder.none,
    hintText: 'Please enter a search term'
  ),
);
```

## `TextFormField`

[`TextFormField`](https://docs.flutter.io/flutter/material/TextFormField-class.html)
wraps a `TextField` and integrates it with the enclosing
[`Form`](https://docs.flutter.io/flutter/widgets/Form-class.html). This provides
additional functionality, such as validation and integration with other
[`FormField`](https://docs.flutter.io/flutter/widgets/FormField-class.html)
widgets.

<!-- skip -->
```dart
new TextFormField(
  decoration: new InputDecoration(
    labelText: 'Enter your username'
  ),
);
```

For more information on input validation, please see the 
[Building a form with validation](/cookbook/forms/validation/) recipe.
