---
title: Protect your app's sensitive content
shortTitle: Sensitive content
description: >-
  Learn how to protect sensitive content in your Flutter app.
---

The [`SensitiveContent`] widget allows you to prevent
screens that contain sensitive content (such as passwords)
from being projected. To learn more,
check out the following two-minute Widget of the Week video:

<YouTubeEmbed id="WnzHARTIZww"
  title="SensitiveContent | Flutter widget of the week"></YouTubeEmbed>

## About the `SensitiveContent` widget

You can use the `SensitiveContent` widget in your app to set the content
sensitivity of a child `Widget` to one of the following [`ContentSensitivity`]
values: `notSensitive`, `sensitive`, or `autoSensitive`.
Your chosen mode determines if the device screen should be obscured
(blacked out) during media projection to protect sensitive data.

You can have as many `SensitiveContent` widgets in your app as you wish,
but if _any_ one of those widgets has a `sensitive` content value, then the
entire screen is obscured during media projection. Thus, for most use cases,
using multiple `SensitiveContent` widgets provides no advantage over having
one `SensitiveContent` widget in your app’s widget tree.

This feature is available on Android API 35+
and has no effect on lower API versions or other platforms.

:::note
The `autoSensitive` value isn't supported as of Flutter 3.35 and behaves
the same as `notSensitive`. See [Issue #160879][] for more information.
:::

[Issue #160879]: {{site.github}}/flutter/flutter/issues/160879

## Using the `SensitiveContent` widget

Given some content that you want to protect from media screen share
(for example, a `MySensitiveContent()` widget), you can wrap it with the
`SensitiveContent` widget as shown in the following example:

```dart
class MyWidget extends StatelessWidget {
  ...
  Widget build(BuildContext context) {
    return SensitiveContent(
      sensitivity: ContentSensitivity.sensitive,
      child: MySensitiveContent(),
    );
  }
}
```

When running on Android API 34 and below, the screen won't be obscured
during media projection. The widget will exist in the tree but has no other
effect, and you don't need to avoid usages of `SensitiveContent` on platforms
that don't support this feature.

## For more information

For more information, visit the [`SensitiveContent`][]
and [`ContentSensitivity`][] API docs.

[`SensitiveContent`]: {{site.api}}/flutter/widgets/SensitiveContent-class.html
[`ContentSensitivity`]: {{site.api}}/flutter/services/ContentSensitivity.html
