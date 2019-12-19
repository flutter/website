---
title: New field on TextInputClient - currentTextEditingValue
description: Add a new field to the TextInputClient interface to get the current
TextEditingValue from a client.
---

# Add `currentTextEditingValue` to `TextInputClient`

## Context

The `TextInputClient` class is used by the Flutter framework to communicate with
platform code about the current state of text input widgets like `EditableText`.

The platform side can lose its state, such as when an Android app goes to the
background. In these cases, it can ask the framework for the last known state.
In order to get this state, `TextInputClient`s need to surface their
`TextEditingValue`.

## Description of change

On some supported platforms, the application can go into a background state
where it is expected to consume fewer resources. For example, a backgrounded
application on Android should avoid consuming unnecessary memory and has no
need to retain references to views. In such a case, the Android specific
platform code can lose state that it had about any text editing fields that will
be displayed again when it comes to the foreground. For example, text entered
in a `TextField` widget is lost to the Java code, but it is still known in the
Dart code.

In such a case, the platform side can send a `textInput` channel message called
`TextInput.requestExistingState`. This notifies the Dart code that it should
re-establish any text input connections and notify the platform of their most
recently known editing state.

The `TextInput` class interacts with client widgets via the `TextInputClient`
interface. This interface current provides no insight into the current value
that a client has. To allow the `TextInput` class to appropriately respond to
`TextInput.requestExistingState`, we are adding a new getter to
`TextInputClient` called `currentTextEditingValue`. We cannot safely use the
last value passed to `TextInputConnection.setEditingState`, since the client
only calls that method under specific circumstances, such as when Dart code
directly modifies the value of a `TextEditingController` in a way that does not
directly mirror the platform's native handling of a response to a key input
event. This is how `TextInputFormatter`s generally work, or what happens when
Dart code directly sets `TextEditingController.value`.

## Migration guide

If you previously implemented or extended `TextEditingClient`, you will now
have to add the appropriate override for `currentTextEditingValue`.

This value may be null.

If you want to migrate _before_ this change lands, you can make your class
implement a class like this:

```dart
abstract class _TemporaryTextEditingClient {
  TextEditingValue get currentTextEditingValue;
}
```

which will allow you to add the new member with an `@override` annotation
before the change lands in the framework, and then later just remove the
temporary interface definition.

### Before

```dart
class _MyCustomTextWidgetState extends State<MyCustomWidget> implements TextEditingClient {
  ...

  @override
  void updateEditingValue(TextEditingValue value) {
    ...
  }

  @override
  void performAction(TextInputAction action) {
    ...
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    ...
  }
}
```

### After

```dart
class _MyCustomTextWidgetState extends State<MyCustomWidget> implements TextEditingClient {
  ...

  @override
  TextEditingValue get currentTextEditingState => widget.textEditingController.value;

  @override
  void updateEditingValue(TextEditingValue value) {
    ...
  }

  @override
  void performAction(TextInputAction action) {
    ...
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    ...
  }
}
```

## Timeline

This change is planned for December of 2019.

## References

API documentation:

* [TextInput](https://api.flutter.dev/flutter/services/TextInput-class.html)
* [TextInputClient](https://api.flutter.dev/flutter/services/TextInputClient-class.html)
* [EditableText](https://api.flutter.dev/flutter/widgets/EditableText-class.html)
* [SystemChannels.textInput](https://api.flutter.dev/flutter/services/SystemChannels/textInput-constant.html)

Relevant issues:

* [#47137](https://github.com/flutter/flutter/issues/47137)

Relevant PRs:

* [Fix requestExistingInputState response](https://github.com/flutter/flutter/pull/47472)
