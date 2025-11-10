---
title: The ThemeData.useMaterial3 flag is true by default
description: >-
   The ThemeData.useMaterial3 flag is now set to true by default.
---

{% render "docs/breaking-changes.md" %}

## Summary

The Material library has been updated to match
the latest Material Design spec.
Changes include new components, new component themes,
and updated component visuals.
As of this release, [`ThemeData.useMaterial3`][] is set `true` by default.

## Background

Flutter's Material widgets now fully support Material 3 and,
as of Flutter 3.16, Material 3 is now the default style.

The appearance of Material 3 components are primarily determined by
the values for [`ThemeData.colorScheme`][] and [`ThemeData.textTheme`][].
ColorScheme makes it easier to create dark and light schemes so that
your app is both aesthetically pleasing and
compliant with accessibility requirements.
To further customize the appearance of Material 3 components,
add component themes to your `ThemeData`,
such as [`ThemeData.segmentedButtonTheme`][] or [`ThemeData.snackBarTheme`][].

Additionally, Material 3 improves motion by using easing and duration tokens.
This means that Material 2 curves have been renamed to include
the word "legacy" and will eventually be deprecated and removed.

Check out the [Material 3 gallery][] to test out
all the new components and compare them with Material 2.

[`ThemeData.colorScheme`]: {{site.api}}/flutter/material/ThemeData/colorScheme.html
[`ThemeData.textTheme`]: {{site.api}}/flutter/material/ThemeData/textTheme.html
[`ThemeData.segmentedButtonTheme`]: {{site.api}}/flutter/material/ThemeData/segmentedButtonTheme.html
[`ThemeData.snackBarTheme`]: {{site.api}}/flutter/material/ThemeData/snackBarTheme.html

## Migration guide

Prior to the 3.16 release, the changes were "opt-in"
using the `useMaterial3` theme property on `ThemeData`.
As of this release, `useMaterial3` is `true` by default.
You can still opt out of the Material 3 version of the Material library by
specifying `useMaterial3: false` in your `MaterialApp` theme.

:::note
Support for Material 2 and configuring the `useMaterial3` property
will eventually be deprecated and removed.
:::

Also, some of the widgets couldn't merely be updated,
but needed a whole new implementation.
For this reason, your UI might look a little strange when
you see it running with Material 3.
To fix this, manually migrate to the new widgets, such as [`NavigationBar`][].

For more details, check out the [Material 3 umbrella issue][] on GitHub.

[`NavigationBar`]: {{site.api}}/flutter/material/NavigationBar-class.html

## Timeline

Landed in version: 3.13.0-4.0.pre<br>
In stable release: 3.16

## References

Documentation:

* [Material Design for Flutter][]

API documentation:

* [`ThemeData.useMaterial3`][]

Relevant issues:

* [Material 3 umbrella issue][]
* [Add support for M3 motion][]

Relevant PRs:

* [Change the default for `ThemeData.useMaterial3` to true][]
* [Updated `ThemeData.useMaterial3` API doc, default is true][]


[Material 3 gallery]: https://github.com/flutter/samples/tree/main/material_3_demo
[Material 3 umbrella issue]: {{site.repo.flutter}}/issues/91605
[Material Design for Flutter]: /ui/design/material
[`ThemeData.useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html
[Add support for M3 motion]: {{site.repo.flutter}}/issues/129942
[Change the default for `ThemeData.useMaterial3` to true]: {{site.repo.flutter}}/pull/129724
[Updated `ThemeData.useMaterial3` API doc, default is true]: {{site.repo.flutter}}/pull/130764
