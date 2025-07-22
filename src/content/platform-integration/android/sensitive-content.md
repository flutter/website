---
title: Protect your app's sensitive content
short-title: Sensitive content
description: >-
  Learn how to protect sensitive content in your Flutter app.
---

This feature has landed in Flutter 3.35 and is available on Android API 35+.  You can try it out by using the [`SensitiveContent`] widget; see the guide below for details.

## About the `SensitiveContent` widget

You might use the `SensitiveContent` widget in your app to set the content sensitivity
of a child `Widget`, which will have one of the following [`ContentSensitivity`]
values: `notSensitive`, `sensitive`, or `autoSensitive`.
The mode that you choose helps to determine the overall content sensitivity of your app,
which is then used to determine whether the device screen should be obscured
(blacked out) during media projection to protect users’ sensitive data.
Specifically, setting the `sensitive` mode ensures that the screen is obscured
during media projection. This feature is available on Android API 35+
and has no effect on lower API versions.

:::note
The `autoSensitive` value isn't supported as of
Flutter 3.35 and behaves the same as `notSensitive`.
See the [tracking issue][] for more information.
:::
You can have as many `SensitiveContent` widgets in your app as you wish,
but if _any _ single widget has a `sensitive` content value,
the screen will be obscured during media projection.
Thus, for most use cases, using multiple `SensitiveContent` widgets provides
no advantage over having one `SensitiveContent` widget in your app’s widget tree.


## Using the `SensitiveContent` widget

Given some content that you want to protect from media screen share, e.g. some `MySensitiveContent()` widget, you can wrap it with the `SensitiveContent` widget like so:

```dart
class MyWidget extends StatelessWidget {
  ...
  Widget build(BuildContext context) {
    return SensitiveContent(
      sensitivivity: ContentSensitivity.sensitive,
      child: MySensitiveContent(),
    );
  }
}
```

## For more information

You can find more information about the [`SensitiveContent`] widget in its docs and more about the available content sensitivity modes in the [`ContentSensitivity`] docs.

[`SensitiveContent`]: {{site.api}}/flutter/widgets/SensitiveContent-class.html
[`ContentSensitivity`]: {{site.api}}/flutter/services/ContentSensitivity.html
[tracking issue]: {{site.github}}/flutter/flutter/issues/160879
