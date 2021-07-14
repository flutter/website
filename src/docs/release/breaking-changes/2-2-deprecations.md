---
title: Deprecated API removed after v2.2
description: After reaching end of life, the following deprecated APIs were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
2.2 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration. A
[quick reference sheet][] is available as well.


[Deprecation Policy]: {{site.github}}/flutter/flutter/wiki/Tree-hygiene#deprecation
[quick reference sheet]: /go/deprecations-removed-after-2-2

## Changes

This section lists the deprecations, listed by the affected class.

### `hasFloatingPlaceholder` of `InputDecoration` & `InputDecorationTheme`

Supported by Flutter Fix: yes

`hasFloatingPlaceholder` was deprecated in v1.13.2.
Use `floatingLabelBehavior` instead.
Where `useFloatingPlaceholder` was true, replace with `FloatingLabelBehavior.auto`.
Where `useFloatingPlaceholder` was false, replace with `FloatingLabelBehavior.never`.
This change allows more behaviors to be specified beyond the original binary
choice, adding `FloatingLabelBehavior.always` as an additional option.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
// InputDecoration
// Base constructor
InputDecoration(hasFloatingPlaceholder: true);
InputDecoration(hasFloatingPlaceholder: false);

// collapsed constructor
InputDecoration.collapsed(hasFloatingPlaceholder: true);
InputDecoration.collapsed(hasFloatingPlaceholder: false);

// Field access
inputDecoration.hasFloatingPlaceholder;

// InputDecorationTheme
// Base constructor
InputDecorationTheme(hasFloatingPlaceholder: true);
InputDecorationTheme(hasFloatingPlaceholder: false);

// Field access
inputDecorationTheme.hasFloatingPlaceholder;

// copyWith
inputDecorationTheme.copyWith(hasFloatingPlaceholder: false);
inputDecorationTheme.copyWith(hasFloatingPlaceholder: true);
```

Code after migration:
<!-- skip -->
```dart
// InputDecoration
// Base constructor
InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.auto);
InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.never);

// collapsed constructor
InputDecoration.collapsed(floatingLabelBehavior: FloatingLabelBehavior.auto);
InputDecoration.collapsed(floatingLabelBehavior: FloatingLabelBehavior.never);

// Field access
inputDecoration.floatingLabelBehavior;

// InputDecorationTheme
// Base constructor
InputDecorationTheme(floatingLabelBehavior: FloatingLabelBehavior.auto);
InputDecorationTheme(floatingLabelBehavior: FloatingLabelBehavior.never);

// Field access
inputDecorationTheme.floatingLabelBehavior;

// copyWith
inputDecorationTheme.copyWith(floatingLabelBehavior: FloatingLabelBehavior.never);
inputDecorationTheme.copyWith(floatingLabelBehavior: FloatingLabelBehavior.auto);
```

**References**

API documentation:
* [`InputDecoration`][]
* [`InputDecorationTheme`][]
* [`FloatingLabelBehavior`][]

Relevant issues:
* [InputDecoration: option to always float label][]

Relevant PRs:
* Deprecated in [#46115][]
* Removed in [#83923][]

[`InputDecoration`]: {{site.api}}/flutter/material/InputDecoration-class.html
[`InputDecorationTheme`]: {{site.api}}/flutter/material/InputDecorationTheme-class.html
[`FloatingLabelBehavior`]: {{site.api}}/flutter/material/FloatingLabelBehavior-class.html
[InputDecoration: option to always float label]: {{site.github}}/flutter/flutter/issues/30664
[#46115]: {{site.github}}/flutter/flutter/pull/46115
[#83923]: {{site.github}}/flutter/flutter/pull/83923

---

### `TextTheme`

Supported by Flutter Fix: yes

Several `TextStyle` properties of `TextTheme` were deprecated in v1.13.8. They
are listed in the following table alongside the appropriate replacement in the
new API.

| Deprecation | New API |
|---|---|
| display4 | headline1 |
| display3 | headline2 |
| display2 | headline3 |
| display1 | headline4 |
| headline | headline5 |
| title | headline6 |
| subhead | subtitle1 |
| body2 | bodyText1 |
| body1 | bodyText2 |
| subtitle | subtitle2 |

**Migration guide**

Code before migration:
<!-- skip -->
```dart
// TextTheme
// Base constructor
TextTheme(
  display4: displayStyle4,
  display3: displayStyle3,
  display2: displayStyle2,
  display1: displayStyle1,
  headline: headlineStyle,
  title: titleStyle,
  subhead: subheadStyle,
  body2: body2Style,
  body1: body1Style,
  caption: captionStyle,
  button: buttonStyle,
  subtitle: subtitleStyle,
  overline: overlineStyle,
);

// copyWith
TextTheme.copyWith(
  display4: displayStyle4,
  display3: displayStyle3,
  display2: displayStyle2,
  display1: displayStyle1,
  headline: headlineStyle,
  title: titleStyle,
  subhead: subheadStyle,
  body2: body2Style,
  body1: body1Style,
  caption: captionStyle,
  button: buttonStyle,
  subtitle: subtitleStyle,
  overline: overlineStyle,
);

// Getters
TextStyle style;
style = textTheme.display4;
style = textTheme.display3;
style = textTheme.display2;
style = textTheme.display1;
style = textTheme.headline;
style = textTheme.title;
style = textTheme.subhead;
style = textTheme.body2;
style = textTheme.body1;
style = textTheme.caption;
style = textTheme.button;
style = textTheme.subtitle;
style = textTheme.overline;
```

Code after migration:
<!-- skip -->
```dart
// TextTheme
// Base constructor
TextTheme(
  headline1: displayStyle4,
  headline2: displayStyle3,
  headline3: displayStyle2,
  headline4: displayStyle1,
  headline5: headlineStyle,
  headline6: titleStyle,
  subtitle1: subheadStyle,
  bodyText1: body2Style,
  bodyText2: body1Style,
  caption: captionStyle,
  button: buttonStyle,
  subtitle2: subtitleStyle,
  overline: overlineStyle,
);

TextTheme.copyWith(
  headline1: displayStyle4,
  headline2: displayStyle3,
  headline3: displayStyle2,
  headline4: displayStyle1,
  headline5: headlineStyle,
  headline6: titleStyle,
  subtitle1: subheadStyle,
  bodyText1: body2Style,
  bodyText2: body1Style,
  caption: captionStyle,
  button: buttonStyle,
  subtitle2: subtitleStyle,
  overline: overlineStyle,
);

TextStyle style;
style = textTheme.headline1;
style = textTheme.headline2;
style = textTheme.headline3;
style = textTheme.headline4;
style = textTheme.headline5;
style = textTheme.headline6;
style = textTheme.subtitle1;
style = textTheme.bodyText1;
style = textTheme.bodyText2;
style = textTheme.caption;
style = textTheme.button;
style = textTheme.subtitle2;
style = textTheme.overline;
```

**References**

Design document:
* [Update the TextTheme API][]

API documentation:
* [`TextTheme`][]

Relevant issues:
* [Migrate TextTheme to 2018 APIs][]

Relevant PRs:
* Deprecated in [#48547][]
* Removed in [#83924][]

[Update the TextTheme API]: /go/update-text-theme-api
[`TextTheme`]: {{site.api}}/flutter/material/TextTheme-class.html
[Migrate TextTheme to 2018 APIs]: {{site.github}}/flutter/flutter/issues/45745
[#48547]: {{site.github}}/flutter/flutter/pull/48547
[#83924]: {{site.github}}/flutter/flutter/pull/83924

---

### Default `Typography`

Supported by Flutter Fix: no

The default `Typography` was deprecated in v1.13.8.
The prior default returned the text stylings of the 2014 Material Design specification.
This will now result in `TextStyle`s reflecting the 2018 Material Design specification.
For the former, use the `material2014` constructor.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
// Formerly returned 2014 TextStyle spec
Typography();
```

Code after migration:
<!-- skip -->
```dart
// Use 2018 TextStyle spec, either by default or explicitly.
Typography();
Typography.material2018();

// Use 2014 spec from former API
Typography.material2014();
```

**References**

Design document:
* [Update the TextTheme API][]

API documentation:
* [`Typography`][]

Relevant issues:
* [Migrate TextTheme to 2018 APIs][]

Relevant PRs:
* Deprecated in [#48547][]
* Removed in [#83924][]

[Update the TextTheme API]: /go/update-text-theme-api
[`TextTheme`]: {{site.api}}/flutter/material/Typography-class.html
[Migrate TextTheme to 2018 APIs]: {{site.github}}/flutter/flutter/issues/45745
[#48547]: {{site.github}}/flutter/flutter/pull/48547
[#83924]: {{site.github}}/flutter/flutter/pull/83924


---

## Timeline

In stable release: TBD
