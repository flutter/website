---
layout: page
title: Text Input
sidebar: home_sidebar
permalink: /text-input/
---

* TOC Placeholder
{:toc}

## Introduction

This page describe how to setup basic text input for Flutter applications.

The [`Input`](https://docs.flutter.io/flutter/material/Input-class.html) widget under [Material](https://docs.flutter.io/flutter/material/material-library.html) will probably satisfy most text-input use cases. However, `Input` is coupled with the Material Design style so there might be cases where you want to use [`RawInputLine`](https://docs.flutter.io/flutter/widgets/RawInputLine-class.html) to achieve desired interfaces outside of the Material Design language.


Using the Input Widget
---------

Assuming that the input is already in focus, the basic data flow for retrieving user input will be:

1. User begins to type into the `Input` widget
2. The `OnChanged` callback is called which passed in the current 'value' of the input
3. Perform any necessary logic/validation on the current input value
4. Update the `Input` widget accordingly.

For most cases, you will probably want to use a `Input` within a [`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html) since you want to save the and operate on the current state of the input. If you are unfamiliar with the `StatefulWidget` and managing state in Flutter, you should look at the [managing state guide](https://flutter.io/widgets-intro/#managing-state) first.

Example
---------

This example is a `StatefulWidget` that mirrors the text inside an `Input`.
```dart
/// [StatefulWidget] that displays what is being entered in the input
class MyInput extends StatefulWidget {

  MyInput({Key key}) : super(key: key);

  @override
  _MyInputState createState() =>
          new _MyInputState();
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
