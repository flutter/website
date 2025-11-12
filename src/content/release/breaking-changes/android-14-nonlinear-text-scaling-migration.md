---
title: Android 14 nonlinear font scaling enabled
description: >-
  Android 14's new nonlinear font scaling feature is
  enabled in Flutter after v3.14.
---

{% render "docs/breaking-changes.md" %}

## Summary

Android 14 introduced nonlinear font scaling up to 200%.
It may change how your app looks when the user changes
the accessibility text scaling in system preferences.

## Background

The [Android 14 nonlinear font scaling][] feature prevents
excessive accessibility font scaling by scaling larger text at a lesser rate
when the user increases the text scaling value in system preferences.

## Migration guide

As the
[Android 14 feature overview][Android 14 nonlinear font scaling] suggests,
test your UI with the maximum font size enabled (`200%`).
This should verify that your app can apply the font sizes correctly
and can accommodate larger font sizes without impacting usability.

To adopt nonlinear font scaling in your app and custom widgets,
consider migrating from `textScaleFactor` to `TextScaler`.
To learn how to migrate to `TextScaler`,
check out the
[Deprecate `textScaleFactor` in favor of `TextScaler`][] migration guide.

**Temporarily Opting Out**

To opt-out of nonlinear text scaling on Android 14 until you migrate your app,
add a modified `MediaQuery` at the top of your app's widget tree:

```dart
runApp(
  Builder(builder: (context) {
    final mediaQueryData = MediaQuery.of(context);
    final mediaQueryDataWithLinearTextScaling = mediaQueryData
      .copyWith(textScaler: TextScaler.linear(mediaQueryData.textScaler.textScaleFactor));
    return MediaQuery(data: mediaQueryDataWithLinearTextScaling, child: realWidgetTree);
  }),
);
```

This uses the deprecated `textScaleFactor` API.
It will stop working once that API is removed from the Flutter API.

## Timeline

Landed in version: 3.14.0-11.0.pre<br>
In stable release: 3.16

## References

API documentation:

* [`TextScaler`][]

Relevant issues:

* [New font scaling system (Issue 116231)][]

Relevant PRs:

* [Implementing TextScaler for nonlinear text scaling][]

See also:

* [Deprecate `textScaleFactor` in favor of `TextScaler`][]

[Android 14 nonlinear font scaling]: {{site.android-dev}}/about/versions/14/features#non-linear-font-scaling
[Deprecate `textScaleFactor` in favor of `TextScaler`]: /release/breaking-changes/deprecate-textscalefactor
[`TextScaler`]: {{site.api}}/flutter/painting/TextScaler-class.html
[New font scaling system (Issue 116231)]: {{site.repo.flutter}}/issues/116231
[Implementing TextScaler for nonlinear text scaling]: {{site.repo.engine}}/pull/44907
