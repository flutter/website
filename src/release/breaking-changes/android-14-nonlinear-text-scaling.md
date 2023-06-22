---
title: Deprecate textScaleFactor in favor of TextScaler
description: The `textScaleFactor` scalar is replaced by `TextScaler` in preparation for Android 14 nonlinear text scaling support.
---

## Summary

In preparation for adopting the [Android 14 nonlinear font scaling][] feature, 
all occurrences of `textScaleFactor` in the Flutter framework have been 
deprecated and replaced by `TextScaler`. 

## Context

Many platforms allow users to scale textual contents up or down globally in
system preferences. In the past, the scaling strategy was captured as a single 
`double` value named `textScaleFactor`, as text scaling was proportional: 
`scaledFontSize = textScaleFactor x unScaledFontSize`. For example, when 
`textScaleFactor` is 2.0 and the developer-specified font size is 14.0, the 
actual font size is 2.0 x 14.0 = 28.0.

With the introduction of [Android 14 nonlinear font scaling][], larger text gets
scaled at a lesser rate as compared to smaller text, to prevent excessive scaling
of text that is already large. The `textScaleFactor` scalar value used by 
"proportional" scaling is not enough to represent this new scaling strategy.

## Description of change

Introducing a new interface `TextScaler`, which represents a text scaling strategy.

```dart
abstract class TextScaler { 
  double scale(double fontSize);
  double get textScaleFactor; // Deprecated. 
}
```

The `scale` method should be used to scale font sizes in lieu of `textScaleFactor`.
The `textScaleFactor` getter provides an estimated `textScaleFactor` value, for 
backward compatibility purposes. It is already marked as "deprecated", but is 
expected to have a longer lifetime than any other deprecations in this migration 
guide.

The new class has replaced 
`double TextScaleFactor` (`double textScaleFactor` -> `TextScaleFactor textScaleFactor`),
in the following APIs:

### Painting library

| Affected APIs                                                                     | Error Message                                          |
|-----------------------------------------------------------------------------------|--------------------------------------------------------|
| `InlineSpan.build({ double textScaleFactor = 1.0 })` argument                     | The named parameter 'textScaleFactor' isn't defined.   |
| `TextStyle.getParagraphStyle({ double TextScaleFactor = 1.0 })` argument          | The named parameter 'textScaleFactor' isn't defined.  |
| `TextStyle.getTextStyle({ double TextScaleFactor = 1.0 })`  argument              | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter({ double TextScaleFactor = 1.0 })` constructor argument              | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter.textScaleFactor` getter and setter                                   | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter.computeWidth({ double TextScaleFactor = 1.0 })` argument             | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter.computeMaxIntrinsicWidth({ double TextScaleFactor = 1.0 })` argument | 'textScaleFactor' is deprecated and shouldn't be used. |

### Rendering library

| Affected APIs                                                            | Error Message                                          |
|--------------------------------------------------------------------------|--------------------------------------------------------|
| `RenderEditable({ double TextScaleFactor = 1.0 })` constructor argument  | 'textScaleFactor' is deprecated and shouldn't be used. |
| `RenderEditable.textScaleFactor` getter and setter                       | 'textScaleFactor' is deprecated and shouldn't be used. |
| `RenderParagraph({ double TextScaleFactor = 1.0 })` constructor argument | 'textScaleFactor' is deprecated and shouldn't be used. |
| `RenderParagraph.textScaleFactor` getter and setter                      | 'textScaleFactor' is deprecated and shouldn't be used. |

### Widgets library

| Affected APIs                                                           | Error Message                                                 |
|-------------------------------------------------------------------------|---------------------------------------------------------------|
| `MediaQueryData({ double TextScaleFactor = 1.0 })` constructor argument | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `MediaQueryData.textScaleFactor` getter                                 | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `MediaQueryData.copyWith({ double? TextScaleFactor })` argument         | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `MediaQuery.maybeTextScaleFactorOf(BuildContext context)` static method | 'maybeTextScaleFactorOf' is deprecated and shouldn't be used. |
| `MediaQuery.textScaleFactorOf(BuildContext context)` static method      | 'textScaleFactorOf' is deprecated and shouldn't be used.      |
| `RichText({ double TextScaleFactor = 1.0 })` constructor argument       | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `RichText.textScaleFactor` getter                                       | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `Text({ double? TextScaleFactor = 1.0 })` constructor argument          | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `Text.rich({ double? TextScaleFactor = 1.0 })` constructor argument     | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `Text.textScaleFactor` getter                                           | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `EditableText({ double? TextScaleFactor = 1.0 })` constructor argument  | 'textScaleFactor' is deprecated and shouldn't be used.        |
| `EditableText.textScaleFactor` getter                                   | 'textScaleFactor' is deprecated and shouldn't be used.        |

### Material library

| Affected APIs                                                                 | Error Message                                          |
|-------------------------------------------------------------------------------|--------------------------------------------------------|
| `SelectableText({ double? TextScaleFactor = 1.0 })` constructor argument      | 'textScaleFactor' is deprecated and shouldn't be used. |
| `SelectableText.rich({ double? TextScaleFactor = 1.0 })` constructor argument | 'textScaleFactor' is deprecated and shouldn't be used. |
| `SelectableText.textScaleFactor` getter                                       | 'textScaleFactor' is deprecated and shouldn't be used. |

## Migration guide

Widgets provided by the Flutter framework are already migrated. Migration is 
needed only if you're using any of the deprecated symbols listed above. 

However, the new Android 14 nonlinear scaling feature changes the UI of existing 
apps, even if your app does not directly use any of the deprecated APIs. If your 
app targets Android 14 devices, it is **strongly recommended** to test your app 
on Android 14 devices at different scaling levels, to make sure the UI is usable 
and functional, no matter whether the codebase needs migration or not. Please 
refer to the [Ensure Android 14 compatibility][] guide for steps to make sure 
your app is Android 14 compatible.

As an example, the following widget might not look great on Android 14 at 200% 
scaling:

```dart 
// It's not good for tooltips to be cutoff vertically, or to take too much space 
// on screen as it blocks contents.
MyTooltipBox( 
  size: tooltipBoxSize * textScaleFactor,
  child: RichText(..., style: TextStyle(fontSize: 20)),
)
```

With nonlinear scaling at 200%, the actual font size used by the `RichText` 
widget is 21 (instead of 40), and the `MyTooltipBox` widget would take 
significantly more screen space than needed, potentially making the tooltip 
annoying. On the other hand, at a smaller font size, the tooltip's text could be 
cutoff due to insufficient vertical space.

Adopting nonlinear text scaling might not be an easy task. If you're unsure about 
how to migrate certian `textScaleFactor` usages, or when it is going to take an
extended period of time (for example, when the UI has to be redesigned), 
consider replacing `textScaleFactor` with `TextScaler.textScaleFactor` first. The 
`TextScaler.textScaleFactor` getter was added for backward compatibility during 
the migration process and is expected to have a longer lifetime than other 
`textScaleFactor` deprecations. 

### Migrating your APIs that expose `textScaleFactor`

Before:
```dart 
abstract class _MyCustomPaintDelegate { 
  void paint(PaintingContext context, Offset offset, double textScaleFactor) { 
  }
}
```

After:
```dart 
abstract class _MyCustomPaintDelegate { 
  void paint(PaintingContext context, Offset offset, TextScaler textScaler) { 
    // For now, implementers can still access the `textScaleFactor`.
    // scalar via textScaler.textScaleFactor. 
  }
}
```

### Migrating code that consumes `textScaleFactor`

If you're not currently using `textScaleFactor` directly, but rather passing it 
to a different API that receives a `textScaleFactor`, and the receiver API has 
already been migrated, then it's relateively straightforward:

Before:
```dart 
RichText( 
  textScaleFactor: MediaQuery.textScaleFactorOf(context),
  ...
)
```

After:
```dart 
RichText( 
  textScaler: MediaQuery.textScalerOf(context),
  ...
)
```

If the receiver API hasn't been migrated yet, optionally, you could migrate your 
code like so:

Before:
```dart 
UnmigratedTextWidget( 
  textScaleFactor: MediaQuery.textScaleFactorOf(context),
  ...
)
```

After:
```dart 
UnmigratedTextWidget( 
  textScaleFactor: MediaQuery.textScalerOf(context).textScaleFactor,
  ...
)
```

If you wish to compute the scaled font size yourself, use `TextScaler.scale` 
instead of the `*` binary operator:

Before:
```dart 
final scaledFontSize = textStyle.fontSize * MediaQuery.textScaleFactorOf(context);
```

After:
```dart 
final scaledFontSize = MediaQuery.textScalerOf(context).scale(textStyle.fontSize);
```


If the API that provides `textScaleFactor` hasn't been migrated, consider 
waiting for the migrated version.

If you are using `textScaleFactor` to scale dimensions that are not font sizes, 
there are no generic rules for migrating the code to nonlinear scaling, and it 
might require the UI to be implemented differently. Reusing the `MyTooltipBox` 
example:
```dart 
MyTooltipBox( 
  size: chatBoxSize * textScaleFactor,
  child: RichText(..., style: TextStyle(fontSize: 20)),
)
```
You could choose to use the "effective" text scale factor by applying the 
`TextScaler` on the font size 20: `chatBoxSize * textScaler.scale(20) / 20`, or
redesign the UI and let the widget assume its own intrinsic size.

### Overriding the text scaling strategy in a widget subtree

To override the existing `TextScaler` used in a widget subtree, override the 
`MediaQuery` like so:

Before:
```dart
MediaQuery( 
  data: MediaQuery.of(context).copyWith(textScaleFactor: 2.0),
  child: child,
)
```

After:
```dart
MediaQuery( 
  data: MediaQuery.of(context).copyWith(textScaler: _myCustomTextScaler),
  child: child,
)
```

However it's rarely needed to create a custom `TextScaler` subclass.
`MediaQuery.disableTextScaling` (which creates a widget that disables text scaling 
altogether for its child subtree), and `MediaQuery.disableTextScaling` (which 
creates a widget that restricts the scaled font size to within the range 
`[minScaleFactor * fontSize, maxScaleFactor * fontSize]`), are convenience methods 
that cover common cases where the text scaling strategy needs to be overridden. 

#### Examples

**Disabling Text Scaling For Icon Fonts**
Before:
```dart 
MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
  child: IconTheme(
    data: ..,
    child: icon,
  ),
)
```

After 
```dart 
MediaQuery.disableTextScaling(
  child: IconTheme(
    data: ...
    child: icon,
  ),
)
```

**Preventing Contents From Overscaling**
Before:
```dart 
final mediaQueryData = MediaQuery.of(context);
MediaQuery(
  data: mediaQueryData.copyWith(textScaleFactor: math.min(mediaQueryData.textScaleFactor, _kMaxTitleTextScaleFactor),
  child: child,
)
```

After
```dart 
MediaQuery.withClampedTextScaling(
  maxScaleFactor: _kMaxTitleTextScaleFactor,
  child: title,
)
```

## Timeline

Landed in version: xxx<br>
In stable release: not yet

## References

API documentation:

* [`TextScaler`][]
* [`MediaQuery.textScalerOf`][]
* [`MediaQuery.maybeTextScalerOf`][]
* [`MediaQuery.disableTextScaling`][]
* [`MediaQuery.withClampedTextScaling`][] 

Relevant issues:

* [New font scaling system (Issue 116231)][]

Relevant PRs:

* [Replaces `textScaleFactor` with `TextScaler`][]


[Ensure Android 14 compatibility]: https://developer.android.com/about/versions/14/migration#compat_testing
[Android 14 nonlinear font scaling]: https://developer.android.com/about/versions/14/features#non-linear-font-scaling
[`TextScaler`]: {{site.master-api}}/flutter/painting/TextScaler-class.html
[`MediaQuery.textScalerOf`]: {{site.master-api}}/flutter/widgets/MediaQuery/textScalerOf.html
[`MediaQuery.maybeTextScalerOf`]: {{site.master-api}}/flutter/widgets/MediaQuery/maybeTextScalerOf.html
[`MediaQuery.disableTextScaling`]: {{site.master-api}}/flutter/widgets/MediaQuery/disableTextScaling.html
[`MediaQuery.withClampedTextScaling`]: {{site.master-api}}/flutter/widgets/MediaQuery/withClampedTextScaling.html

[New font scaling system (Issue 116231)]: {{site.repo.flutter}}/issues/116231
[Replaces `textScaleFactor` with `TextScaler`]: {{site.repo.flutter}}/pull/128522

