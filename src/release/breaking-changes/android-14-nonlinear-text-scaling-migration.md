---
title: Android 14 nonlinear font scaling enabled after v3.14
description: >
  New Android 14 nonlinear font scaling feature is enabled in Flutter after v3.14.
---

## Summary

Android 14 introduced nonlinear font scaling to 200%. It may change how your app 
looks when the user changes the accessiblity text scaling in system preferences.

## Background

The [Android 14 nonlinear font scaling][] feature prevents excessive accessibility 
font scaling by scaling larger text at a lesser rate when the user increases the 
text scaling value in system preferences.

## Migration guide

As suggested by the 
[Android 14 feature overview][Android 14 nonlinear font scaling], perform UI 
testing with the maximum font size enabled (200%) to ensure that your app 
applies the font sizes correctly and can accommodate larger font sizes without
impacting usability.

Consider migrating from `textScaleFactor` to `TextScaler` following this 
migration guide: [Deprecate `textScaleFactor` in favor of `TextScaler`][], to
adopt nonlinear font scaling in your app and custom widgets.

**Temporarily Opting Out**
If you want to temporarily opt-out of nonlinear text scaling on Android 14 until 
your app is fully migrated, put a modified `MediaQuery` at the top of your app's 
widget tree:

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
This trick uses the deprecated `textScaleFactor` API and will stop working once
it's removed from the Flutter API.

## Timeline

Landed in version: 3.14.0-11.0.pre<br>
In stable release: not yet (Not in 3.13)

## References

API documentation:

* [`TextScaler`][]

Relevant issues:

* [New font scaling system (Issue 116231)][]

Relevant PRs:

* [Implementing TextScaler for nonlinear text scaling][]

Seealso: 

* [Deprecate `textScaleFactor` in favor of `TextScaler`][]

[Android 14 nonlinear font scaling]: https://developer.android.com/about/versions/14/features#non-linear-font-scaling
[Deprecate `textScaleFactor` in favor of `TextScaler`]: {{site.url}}/release/breaking-changes/deprecate-textscalefactor
[`TextScaler`]: {{site.master-api}}/flutter/painting/TextScaler-class.html
[`New font scaling system`]: {{site.repo.flutter}}/issues/116231
[Implementing TextScaler for nonlinear text scaling]: {{site.repo.engine}}/pull/44907
