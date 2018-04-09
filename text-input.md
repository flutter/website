---
layout: page
title: Handling Text Input
permalink: /text-input/
---

* TOC Placeholder
{:toc}

## Introduction

This page describes how to set up basic text input for Flutter applications.

## Choosing a widget

[`TextField`](https://docs.flutter.io/flutter/material/TextField-class.html)
is the most commonly used text input widget.

By default, a `TextField` is decorated with an underline. You can add a label,
an icon, inline hint text, and error text by supplying an
[`InputDecoration`](https://docs.flutter.io/flutter/material/InputDecoration-class.html)
as the [`decoration`](https://docs.flutter.io/flutter/material/TextField/decoration.html)
property of the `TextField`. To remove the decoration entirely (including the
underline and the space reserved for the label), set the `decoration` to null
explicitly.

[`TextFormField`](https://docs.flutter.io/flutter/material/TextFormField-class.html)
wraps a `TextField` and integrates it with the enclosing
[`Form`](https://docs.flutter.io/flutter/widgets/Form-class.html). Use a
`TextFormField` when you want to supply a validator function to check whether
the user's input satisfies some constraint (e.g., is a phone number) or when you
wish to integrate a `TextField` with other
[`FormField`](https://docs.flutter.io/flutter/widgets/FormField-class.html)
widgets.

## Retrieving user input

There are two main approaches for retrieving the user's input: (a) handling
the [`onChanged`](https://docs.flutter.io/flutter/material/TextField/onChanged.html)
callback and (b) supplying a
[`TextEditingController`](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html).

### onChanged

Whenever the user types into the `TextField`, the `TextField` will call its
[`onChanged`](https://docs.flutter.io/flutter/material/TextField/onChanged.html)
callback. You can handle this callback to watch what the user types. For
example, if you're implementing a search field, you might want to update the
search results as the user types their query.

### TextEditingController

A more powerful (but more elaborate) approach is supply a
[`TextEditingController`](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html)
as the [`controller`](https://docs.flutter.io/flutter/material/TextField/controller.html)
property of the `TextField`. The controller's
[`text`](https://docs.flutter.io/flutter/widgets/TextEditingController/text.html)
and [`selection`](https://docs.flutter.io/flutter/widgets/TextEditingController/selection.html)
properties are updated continuously as the user types in the `TextField`. To be
notified when these properties change, you listen to the controller using its
[`addListener`](https://docs.flutter.io/flutter/foundation/ChangeNotifier/addListener.html)
method. (If you add a listener, remember to remove the listener during your
[`State`](https://docs.flutter.io/flutter/widgets/State-class.html) object's
[`dispose`](https://docs.flutter.io/flutter/widgets/State/dispose.html) method).

The `TextEditingController` also lets you control the contents of the
`TextField`. If you modify the `text` or `selection` properties of the
controller, the `TextField` will update to display the modified text or
selection. For example, you can use this feature to implement inline
autocomplete by adding the suggested text as a selected suffix to the text the
user has typed.

## Examples

Below is an example of using a
[`TextEditingController`](https://docs.flutter.io/flutter/widgets/TextEditingController-class.html)
to read the value the user has typed into a
[`TextField`](https://docs.flutter.io/flutter/material/TextField-class.html):

```dart
/// Opens an [AlertDialog] showing what the user typed.
class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key key}) : super(key: key);

  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState();
}

/// State for [ExampleWidget] widgets.
class _ExampleWidgetState extends State<ExampleWidget> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
          controller: _controller,
          decoration: new InputDecoration(
            hintText: 'Type something',
          ),
        ),
        new RaisedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text('What you typed'),
                    content: new Text(_controller.text),
                  ),
            );
          },
          child: new Text('DONE'),
        ),
      ],
    );
  }
}
```
