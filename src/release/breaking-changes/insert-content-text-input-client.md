---
title: Insert Content Text Input Client
description: Add a new method to the TextInputClient interface to allow Android virtual keyboards to insert rich content into Flutter TextFields. 
---

## Summary

Added an `insertContent` method to the `TextInputClient` interface to allow Android's image keyboard
feature to insert content into a Flutter `TextField`.

## Context

As of Android 7.1, IMEs (input method editors or virtual keyboards) can send
images and rich content into a text editor. This allows users to insert gifs,
stickers, or context-aware rich content into a text field.

## Description of change

When the user inserts rich content in the IME, the platform sends a `TextInputClient.commitContent`
channel message, notifying the Dart code that the IME inserted rich content.
The channel message contains the mime type, URI, and bytedata for the inserted content in JSON form.

## Migration guide

If you implemented the `TextInputClient` interface earlier, override
`insertContent` to either support rich content insertion or provide an empty implementation.

To migrate, implement `insertContent`.

Code before migration:

<!-- skip -->
```dart
class MyCustomTextInputClient implements TextInputClient {
  // ...
}
```

Code after migration:

<!-- skip -->
```dart
class MyCustomTextInputClient implements TextInputClient {
  // ...
  @override
  void insertContent() {
    // ...
  }
  // ...
}
```

Your implementation of `TextInputClient` might not require the ability to receive rich content
inserted from the IME. In that case, you can leave the implementation of `insertContent` empty with 
no consequences.

<!-- skip -->
```dart
class MyCustomTextInputClient implements TextInputClient {
  // ...
  @override
  void insertContent() {}
  // ...
}
```

As an alternative, you can use a similar implementation to the default `TextInputClient`.
To learn how to do this, see the [insertContent implementation]({{site.api}}/flutter/services/TextInputClient/insertContent.html).

To prevent breaking changes to an interface, use `with TextInputClient` rather than 
`implements TextInputClient`.

## Timeline

Landed in version: 3.8.0-1.0.pre<br>
In stable release: 3.10.0

## References

API documentation:

* [`TextInputClient`]({{site.api}}/flutter/services/TextInputClient-class.html)

Relevant issues:

* [Issue 20796]({{site.repo.flutter}}/issues/20796)

Relevant PRs:

* [24224: Support Image Insertion on Android (engine)]({{site.repo.engine}}/pull/35619)
* [97437: Support Image Insertion on Android]({{site.repo.flutter}}/pull/110052)
