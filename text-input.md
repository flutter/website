---
layout: page
title: Handling Text Input
sidebar: home_sidebar
permalink: /text-input/
---

* TOC Placeholder
{:toc}

## Introduction

This page describes how to set up basic text input for Flutter applications.

The
[`Input`](https://docs.flutter.io/flutter/material/Input-class.html)
widget under
[Material](https://docs.flutter.io/flutter/material/material-library.html )
satisfies most text input use cases, and implements material design's style. If
you want an input widget that does not use material design, see
[`EditableText`](https://docs.flutter.io/flutter/widgets/EditableText-class.html)



## Retrieving User Input

Assuming that the input is already in focus, the basic data flow for retrieving
user input is:

1. User taps a character in the keyboard.
2. The
[`onChanged`](https://docs.flutter.io/flutter/material/Input/onChanged.html)
callback is called with the current
[`value`](https://docs.flutter.io/flutter/material/Input/value.html)
of the widget.
3. Perform any necessary logic/validation on the current input value.
4. Update the state of the
[`Input`](https://docs.flutter.io/flutter/material/Input-class.html)
widget accordingly through
[`setState()`](https://docs.flutter.io/flutter/widgets/State/setState.html).

For most cases, we recommend that you use the
[`Input`](https://docs.flutter.io/flutter/material/Input-class.html)
class within a
[`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)
so you can save and operate on the current value of the input.
To learn more about
[`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)
and managing state in Flutter, you can look at this helpful example of 
[managing widget state](https://flutter.io/widgets-intro/#changing-widgets-in-response-to-input).

## Example

This example is a
[`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)
that mirrors the text inside an
[`Input`](https://docs.flutter.io/flutter/material/Input-class.html).

```dart
/// [StatefulWidget] that displays what is being entered in the input
class MyInput extends StatefulWidget {
  MyInput({Key key}) : super(key: key);

  @override
  _MyInputState createState() => new _MyInputState();
}

/// State that corresponds to [MyInput]
class _MyInputState extends State<MyInput> {
  /// Track the current input state
  InputValue _currentInput;

  @override
  void initState() {
    super.initState();
    // The empty constructor for InputValue
    // will initial an InputValue with an empty string
    _currentInput = const InputValue();
  }

  /// Handle callbacks from Input, when the text is changed
  void _handleInputChange(InputValue input) {
    setState(() {
      _currentInput = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text(_currentInput.text), // Display the text of the current input
        new Input(
          onChanged: _handleInputChange,
          value: _currentInput,
        ),
      ],
    );
  }
}
```
