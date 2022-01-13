---
title: Scribble Text Input Client
description: Add new methods to the TextInputClient interface to allow Scribble to insert or remove text placeholders and show the toolbar.
---

## Summary

Adds three methods, `showToolbar`, `insertTextPlaceholder`, and
`removeTextPlaceholder` to the `TextInputClient` interface to allow the iOS 14
Scribble feature to insert and remove text placeholders and show the toolbar.


## Context

As of iOS 14, iPads support the Scribble feature when using the Apple Pencil.
This feature allows users to use the pencil to interact with text fields to
add, delete, select, and modify text.


## Description of change

In native text widgets, the text toolbar is shown when a user uses the pencil
to select text on an iPad running iOS 14 or higher.
To replicate this behavior, the platform sends a `textInput` channel message
called `TextInputClient.showToolbar`.
This notifies the Dart code that the toolbar should be shown.

When a user holds the pencil down, a visual gap in the text is shown to allow
the user extra space to write.
To replicate this behavior, the platform sends `textInput` channel messages
called `TextInputClient.insertTextPlaceholder` and
`TextInputClient.removeTextPlaceholder`.
Multiline text inputs should have placeholders that provide vertical space,
while single line inputs should provide horizontal space.


## Migration guide

If you previously implemented or extended `TextEditingClient`, you may override
`showToolbar`, `insertTextPlaceholder`, and `removeTextPlaceholder` in order to
support these Scribble features.

To migrate, implement `showToolbar`, `insertTextPlaceholder`, and
`removeTextPlaceholder`.

Code before migration:

<!-- skip -->
```dart
class MyCustomTextInputClient implements TextInputClient {
  ...
}
```

Code after migration:

<!-- skip -->
```dart
class MyCustomTextInputClient implements TextInputClient {
  ...
  @override
  void showToolbar() {
    ...
  }
  
  @override
  void insertTextPlaceholder(Size size) {
    ...
  }
  
  @override
  void removeTextPlaceholder() {
    ...
  }
}
```

## Timeline

Landed in version: 2.9.0-1.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`TextInputClient`][{{site.master-api}}/flutter/services/TextInputClient-class.html]

Relevant issues:

* [Issue 61278][{{site.repo.flutter}}/issues/61278]

Relevant PRs:

* [Support Scribble Handwriting][{{site.repo.flutter}}/pull/75472]
