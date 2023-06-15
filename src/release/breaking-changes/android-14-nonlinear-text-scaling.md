---
title: Deprecate `textScaleFactor` in favor of `TextScaler`
description: The `textScaleFactor` scalar is replaced by `TextScaler` in preparation for Android 14 nonlinear text scaling support.
---

## Summary

In preparation for adopting the [Android 14 nonlinear font scaling][] feature, 
all occurrances of `textScaleFactor` in the Flutter framework have been 
deprecated and replaced by `TextScaler`.

## Context

Many platforms allow users to scale up / down textual contents globally in
system preferences. In the past, the scaling strategy was captured as a single 
`double` value named `textScaleFactor`, as text scaling was proportional: 
`scaledFontSize = textScaleFactor x unScaledFontSize`. For example, When 
`textScaleFactor` is 2.0 and the developer-specified font size is 14.0, the 
actual font size is 2.0 x 14.0 = 28.0.

With the introduction of [Android 14 nonlinear font scaling][], larger text gets
scaled at a lesser rate as compared to smaller text, to prevent excessive scaling
of text that is already large enough. The `textScaleFactor` scalar value used by 
"proportional" scaling is not enough to represent this new scaling strategy.

## Description of change

Introducing a new interface `TextScaler`, which represents a text scaling strategy.

```dart
abstract class TextScaler { 
  double scale(double fontSize);
  double get textScaleFactor; // Deprecated. 
}
```

where the `scale` method should be used to scale font sizes in lieu of `textScaleFactor`,
while `textScaleFactor` is an already-deprecated field that provides an estimated 
`textScaleFactor` value.

The new class has replaced `double TextScaleFactor` (`double textScaleFactor` -> `TextScaleFactor textScaleFactor`),
in the following APIs:

#### `Painting` Library

| Affected APIs                                                                     | Error Message                                          |
|-----------------------------------------------------------------------------------|--------------------------------------------------------|
| `InlineSpan.build({ double textScaleFactor = 1.0 })` argument                     | The named parameter 'textScaleFactor' isn't defined.   |
| `TextStyle.getParagraphStyle({ double TextScaleFactor = 1.0 })` argument          | The named parameter 'textScaleFactor' isn't defined".  |
| `TextStyle.getTextStyle({ double TextScaleFactor = 1.0 })`  argument              | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter({ double TextScaleFactor = 1.0 })` constructor argument              | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter.textScaleFactor` getter and setter                                   | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter.computeWidth({ double TextScaleFactor = 1.0 })` argument             | 'textScaleFactor' is deprecated and shouldn't be used. |
| `TextPainter.computeMaxIntrinsicWidth({ double TextScaleFactor = 1.0 })` argument | 'textScaleFactor' is deprecated and shouldn't be used. |

#### `Rendering` Library

| Affected APIs                                                            | Error Message                                          |
|--------------------------------------------------------------------------|--------------------------------------------------------|
| `RenderEditable({ double TextScaleFactor = 1.0 })` constructor argument  | 'textScaleFactor' is deprecated and shouldn't be used. |
| `RenderEditable.textScaleFactor` getter and setter                       | 'textScaleFactor' is deprecated and shouldn't be used. |
| `RenderParagraph({ double TextScaleFactor = 1.0 })` constructor argument | 'textScaleFactor' is deprecated and shouldn't be used. |
| `RenderParagraph.textScaleFactor` getter and setter                      | 'textScaleFactor' is deprecated and shouldn't be used. |

#### `Widgets` Library

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

#### `Material` Library

| Affected APIs                                                                 | Error Message                                          |
|-------------------------------------------------------------------------------|--------------------------------------------------------|
| `SelectableText({ double? TextScaleFactor = 1.0 })` constructor argument      | 'textScaleFactor' is deprecated and shouldn't be used. |
| `SelectableText.rich({ double? TextScaleFactor = 1.0 })` constructor argument | 'textScaleFactor' is deprecated and shouldn't be used. |
| `SelectableText.textScaleFactor` getter                                       | 'textScaleFactor' is deprecated and shouldn't be used. |

## Migration guide

Since the new Android 14 nonlinear scaling feature could change the UI of 
existing apps, if your app targets Android 14 devices, migration may have to be 
done on a case-by-case basis, and extra testing is **strongly recommended** to 
make sure the UI is usable and functional on Android 14:  

Most built-in text widgets provided by the Flutter framework are already 
migrated. Migration is usually only needed if you're:

- Calling `MediaQuery.textScaleFactorOf`, `MediaQuery.maybeTextScaleFactorOf`, 
  or accessing the `MediaQueryData.textScaleFactor` getter.
- Managing your own `TextPainter`, or `RenderParagraph`/`RenderEditable` for 
  laying out or measuring text.
- Directly using `RichText`, or overriding `textScaleFactor` in `EditableText` 
  and `SelectableText`.
- Checking the value of `textScaleFactor` getters (which is common in tests).
  
If your app targets Android 14 devices, migration may have to be done on a
case-by-case basis, and extra testing is strongly recommended to make sure the UI 
is still usable, as nonlinear scaling could invalidate some assumptions the UI 
makes. As an example, the following widget may not look great on Android 14 at 
200% scaling:

```dart 
// It's not good for tooltips to be cutoff vertically, or to take too much space 
// on screen as it blocks contents.
TooltipBox( 
  size: chatBoxSize * textScaleFactor,
  child: RichText(..., style: TextStyle(fontSize: 20)),
)
```

With nonlinear scaling at 200%, the actual font size would be 21 instead of 40,
as a result the `TooltipBox` would unfortunately take significantly more precious 
screen space than needed and potentially make the tooltip annoying. On the other
hand, at a smaller font size the tooltip's text could be cutoff due to 
insufficient vertical space.

### Migrating APIs that expose `textScaleFactor`

The `TextScaler` interface currently provides an estimated `textScaleFactor`, so 
it is generally safe to use it as a drop-in replacement of `textScaleFactor` in 
APIs. However, to support Android 14, you may need to provide more information to 
the implementer as they can no longer assume the text scales proportionally with
`textScaleFactor`.

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
    // For now, implementers will still be able to access the `textScaleFactor`
    // scalar via textScaler.textScaleFactor. 
  }
}
```

### Migrating code that consumes `textScaleFactor`

If you're not currently using `textScaleFactor` directly, but rather passing it 
to a different API that receivs a `textScaleFactor`, and the receiver API has 
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

If the receiver API hasn't been migrated yet, it's still recommended to migrate
your code like so:

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
  textScaleFactor: MediaQuery.textScalerOf(context).textScaleFactor,
  ...
)
```

If the API that provides the `textScaleFactor` hasn't been migrated, it might 
not be worth to migrate the code right away.

If you do use `textScaleFactor` to scale something that are not font sizes, 
there are no generic rules for performing such migrations. It's recommended to
test your app at various scaling levels on Android 14 to make sure the UI looks 
polished and functional. At the time of writing, Android 14 isn't released so 
testing with nonlinear scaling may not be feasible. It's recommended to 
temporarily replace `textScaleFactor` with `textScaler.textScaleFactor` if 
available. 

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
altogether for its child subtree) and `MediaQuery.disableTextScaling` (which 
creates a widget that restricts the scaled font size to within the range 
`[minScaleFactor * fontSize, maxScaleFactor * fontSize]`) are convenience methods 
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

{% comment %}
  The version # of the SDK where this change was
  introduced.  If there is a deprecation window,
  the version # to which we guarantee to maintain
  the old API. Use the following template:

  If a breaking change has been reverted in a
  subsequent release, move that item to the
  "Reverted" section of the index.md file.
  Also add the "Reverted in version" line,
  shown as optional below. Otherwise, delete
  that line.
{% endcomment %}

Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

{% comment %}
  These links are commented out because they
  cause the GitHubActions (GHA) linkcheck to fail.
  Remove the comment tags once you fill this in with
  real links. Only use the "master-api" include if
  you link to "master-api.flutter.dev".

{% include docs/master-api.md %}

API documentation:

* [`ClassName`][]

Relevant issues:

* [Issue xxxx][]
* [Issue yyyy][]

Relevant PRs:

* [PR title #1][]
* [PR title #2][]
{% endcomment %}

{% comment %}
  Add the links to the end of the file in alphabetical order.
  The following links are commented out because they make
  the GitHubActions (GHA) link checker believe they are broken links,
  but please remove the comment tags before you commit!

  If you are sharing new API that hasn't landed in
  the stable channel yet, use the master channel link.
  To link to docs on the master channel,
  include the following note and make sure that
  the URL includes the master link (as shown below).

  Here's an example of defining a stable (site.api) link
  and a master channel (master-api) link.

<!-- Stable channel link: -->
[`ClassName`]: {{site.api}}/flutter/[link_to_relevant_page].html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`ClassName`]: {{site.master-api}}/flutter/[link_to_relevant_page].html

[Issue xxxx]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[Issue yyyy]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[PR title #1]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
[PR title #2]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
[Android 14]: https://developer.android.com/about/versions/14
[Android 14 nonlinear font scaling]: https://developer.android.com/about/versions/14/features#non-linear-font-scaling
{% endcomment %}

