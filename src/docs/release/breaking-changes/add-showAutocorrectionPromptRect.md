---
title: New method `showAutocorrectionPromptRect` added to `TextInputClient` 
description: A new method `void showAutocorrectionPromptRect(int start, int end)` was added to the `TextInputClient` interface
---


## Summary

A new method `void showAutocorrectionPromptRect(int start, int end)` was added to the `TextInputClient` interface.

## Context

In order to display the iOS autocorrection highlight, the iOS text input plugin needed a way to inform the Flutter framework of 
the highlight's start and end position.

## Description of change

A new method `void showAutocorrectionPromptRect(int start, int end)` was added to the `TextInputClient` interface. This method will
be called by iOS when it finds a new potential autocorrect candidate in the current user input, or when the range of a previously highlighted candidate changes.

## Migration guide

If your application does not implement or subclass `TextInputClient`, no migration is needed.
If your application does not target iOS, or the class that implemented the `textInputClient` interface does not 
support autocorrect, you only need to add an empty implementation for the new method:

<!-- skip -->
```dart
class CustomTextInputClient implements TextInputClient {
  void showAutocorrectionPromptRect(int start, int end) {}
}
```

Otherwise, if your app targets iOS and supports autocorrect on iOS, it is recommended to add a sensible implementation of `void showAutocorrectionPromptRect(int start, int end)` 
to your `TextInputClient` subclass. 

Code after migration:

<!-- skip -->
```dart
// Assume your `TextInputClient` is a `State` subclass, and it has a variable 
// `_currentPromptRectRange` that controls the autocorrection highlight.
class CustomTextInputClient extends State<...> implements TextInputClient {
  @override
  void updateEditingValue(TextEditingValue value) {
    // When the text changes, the highlight needs to be dismissed.
    if (value.text != _value.text) {
      setState(() {
        _currentPromptRectRange = null;
      });
    }
  }

  void _handleFocusChanged() {
    // When this text input loses focus, the autocorrection highlight needs
    // to be dismissed.
    if (!_hasFocus) {
      setState(() {
        _currentPromptRectRange = null;
      });
    }
  }

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    // Updates the range of the highlight, as iOS requested.
    // This method will not be called when iOS decides to
    // dismiss the highlight.
    setState(() {
      _currentPromptRectRange = TextRange(start: start, end: end);
    });
  }
}
```

## Timeline

This change landed in 1.18.0.

## References

API documentation:
* [`TextInputClient`]: https://master-api.flutter.dev/flutter/services/TextInputClient-class.html

Relevant issues:
* [Issue 12920]: {{site.github}}/flutter/flutter/issues/12920

Relevant PRs:
* [iOS UITextInput autocorrection prompt]: {{site.github}}/flutter/flutter/pull/54119/
