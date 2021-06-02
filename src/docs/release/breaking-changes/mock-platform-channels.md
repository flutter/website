---
title: Transition of platform channel test interfaces to flutter_test package
description: The setMockMessageHandler method related APIs have moved from package:flutter to package:flutter_test
---

## Summary

The following methods have been replaced by APIs in the `flutter_test` package: `BinaryMessenger.checkMessageHandler`, `BinaryMessenger.setMockMessageHandler`, `BinaryMessenger.checkMockMessageHandler`, `BasicMessageChannel.setMockMessageHandler`, `MethodChannel.checkMethodCallHandler`, `MethodChannel.setMockMethodCallHandler`, and `MethodChannel.checkMockMethodCallHandler`. The `onPlatformMessage` callback is no longer used by the Flutter framework.

## Context

As part of a refactoring of the low-level plugin communications architecture, we have moved from the previous `onPlatformMessage`/`handlePlatformMessage` logic to a per-channel buffering system implemented in the engine in the `ChannelBuffers` class. To maintain compatibility with existing code, the existing `BinaryMessenger.setMessageHandler` API has been refactored to use the new `ChannelBuffers` API.

One difference between the `ChannelBuffers` API and the previous API is that the new API is more consistent in its approach to asynchrony. As a side-effect, the APIs around message passing are now entirely asynchronous.

This posed a problem for the implementation of the legacy testing APIs which, for historical reasons, were previously in the `flutter` package. Since they relied on the underlying logic being partly synchronous, they required refactoring. To avoid adding even more test logic into the `flutter` package, a decision was made to move this logic to the `flutter_test` package.

## Description of change

Specifically, the following APIs were affected:

* `BinaryMessenger.checkMessageHandler`: Obsolete.
* `BinaryMessenger.setMockMessageHandler`: Replaced by `TestDefaultBinaryMessenger.setMockMessageHandler`.
* `BinaryMessenger.checkMockMessageHandler`: Replaced by `TestDefaultBinaryMessenger.checkMockMessageHandler`.
* `BasicMessageChannel.setMockMessageHandler`: Replaced by `TestDefaultBinaryMessenger.setMockDecodedMessageHandler`.
* `MethodChannel.checkMethodCallHandler`: Obsolete.
* `MethodChannel.setMockMethodCallHandler`: Replaced by `TestDefaultBinaryMessenger.setMockMethodCallHandler`.
* `MethodChannel.checkMockMethodCallHandler`: Replaced by `TestDefaultBinaryMessenger.checkMockMessageHandler`.

These replacements are only available to code using the new `TestDefaultBinaryMessengerBinding` (such as any code using `testWidgets` in a `flutter_test` test). There is no replacement for production code that was using these APIs, as they were not intended for production code use.

Tests using `checkMessageHandler` have no equivalent in the new API, since message handler registration is handled directly by the `ChannelBuffers` object, which does not expose the currently registered listener for a channel. (Tests verifying handler registration appear to be rare.)

Code that needs migrating may see errors such as the following:

```
  error - The method 'setMockMessageHandler' isn't defined for the type 'BinaryMessenger' at test/sensors_test.dart:64:8 - (undefined_method)

  error • The method 'setMockMethodCallHandler' isn't defined for the type 'MethodChannel' • test/widgets/editable_text_test.dart:5623:30 • undefined_method

[error] The method 'setMockMessageHandler' isn't defined for the type 'BasicMessageChannel' (test/material/feedback_test.dart:37:36)
```

In addition, the `onPlatformMessage` callback, which previously was hooked by the framework to receive messages from plugins, is no longer used (and will be removed in due course). As a result, calling this callback to inject messages into the framework no longer has an effect.

## Migration guide

The `flutter_test` package provides some shims so that uses of the obsolete `setMock...` and `checkMock...` methods will continue to work. Tests that previously did not import `package:flutter_test/flutter_test.dart` can do so to enable these shims; this should be sufficient to migrate most code.

These shim APIs are deprecated, however. Instead, in code using `WidgetTester` (e.g. using `testWidgets`), it is recommended to use the following patterns to replace calls to those methods (where `tester` is the `WidgetTester` instance):

<!-- skip -->
```dart
// old code
ServicesBinding.defaultBinaryMessenger.setMockMessageHandler(...);
ServicesBinding.defaultBinaryMessenger.checkMockMessageHandler(...);
// new code
tester.binding.defaultBinaryMessenger.setMockMessageHandler(...);
tester.binding.defaultBinaryMessenger.checkMockMessageHandler(...);
```

<!-- skip -->
```dart
// old code
myChannel.setMockMessageHandler(...);
myChannel.checkMockMessageHandler(...);
// new code
tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler(myChannel, ...);
tester.binding.defaultBinaryMessenger.checkMockMessageHandler(myChannel, ...);
```

<!-- skip -->
```dart
// old code
myMethodChannel.setMockMethodCallHandler(...);
myMethodChannel.checkMockMethodCallHandler(...);
// new code
tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(myMethodChannel, ...);
tester.binding.defaultBinaryMessenger.checkMockMessageHandler(myMethodChannel, ...);
```

Tests that use `package:test` and `test()` can be changed to use `package:flutter_test` and `testWidgets()` to get access to a `WidgetTester`.

Code that does not have access to a `WidgetTester` can refer to `TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger` instead of `tester.binding.defaultBinaryMessenger`.

Tests that do not use the default test widgets binding (`AutomatedTestWidgetsFlutterBinding`, which is initialized by `testWidgets`) can mix the `TestDefaultBinaryMessengerBinding` mixin into their binding to get the same results.

Tests that manipulate `onPlatformMessage` will no longer function as designed. To send mock messages to the framework, consider using `ChannelBuffers.push`. There is no mechanism to intercept messages from the plugins and forward them to the framework in the new API. If your use case requires such a mechanism, please file a bug.

## Timeline

Landed in version: 2.3.0-17.0.pre.1<br>
In stable release: not yet

## References

{% include master-api.md %}

API documentation:
* [`TestDefaultBinaryMessenger`][]
* [`TestDefaultBinaryMessengerBinding`][]

Relevant PRs:
* [PR #76288: Migrate to ChannelBuffers.push][]

<!-- Master channel link: -->
[`TestDefaultBinaryMessenger`]: https://master-api.flutter.dev/flutter/[link_to_relevant_page].html
[`TestDefaultBinaryMessengerBinding`]: https://master-api.flutter.dev/flutter/[link_to_relevant_page].html

[PR #76288: Migrate to ChannelBuffers.push]: {{site.github}}/flutter/flutter/pull/76288]
