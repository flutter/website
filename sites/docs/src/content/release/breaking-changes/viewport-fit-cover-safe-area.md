---
title: Web viewport-fit=cover SafeArea support
description: >-
  Flutter web now respects viewport-fit=cover in index.html and populates
  FlutterView.viewPadding from CSS env(safe-area-inset-*) values.
---

{% render "docs/breaking-changes.md" %}

## Summary

Flutter web now honors `viewport-fit=cover` in your `web/index.html`
`<meta name="viewport">` tag and populates [`FlutterView.viewPadding`][],
[`MediaQuery.paddingOf`][], and [`SafeArea`][] from the browser's CSS
`env(safe-area-inset-*)` values.

If an existing web application already includes `viewport-fit=cover` in
`web/index.html`, it now renders edge-to-edge behind mobile device cutouts,
notches, and home indicators instead of having `viewport-fit=cover` stripped by
the web engine.

## Context

Previously, when initializing in full-page mode, the Flutter web engine
replaced any `<meta name="viewport">` tag in `web/index.html` with a default
viewport tag that omitted `viewport-fit=cover`, and always reported
[`FlutterView.viewPadding`][] as `ViewPadding.zero`.

To let mobile web applications render edge-to-edge on devices with display
cutouts and notches, Flutter web now inspects the `<meta name="viewport">` tag
in `web/index.html` before replacing it:

* When `viewport-fit=cover` is **not** set (the default), Flutter web renders
  within the browser's safe area (`viewport-fit=contain`) and reports
  `ViewPadding.zero`.
* When `viewport-fit=cover` **is** set in `web/index.html`, Flutter web
  preserves `viewport-fit=cover` on the active `<meta flt-viewport>` tag,
  measures the browser's CSS `env(safe-area-inset-top)`,
  `env(safe-area-inset-right)`, `env(safe-area-inset-bottom)`, and
  `env(safe-area-inset-left)` values, and exposes them through
  [`FlutterView.viewPadding`][], [`MediaQuery.paddingOf`][], and
  [`SafeArea`][].

## Migration guide

You are **affected** only if your existing `web/index.html` file already
specifies `viewport-fit=cover` in its `<meta name="viewport">` tag.

### Option 1: Keep edge-to-edge rendering and wrap UI in `SafeArea`

If you want your web app to render edge-to-edge behind notches and home
indicators, wrap your interactive content in a [`SafeArea`][] widget (or read
[`MediaQuery.paddingOf`][]) so controls are not obscured by system cutouts:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: MyAppContent(),
    ),
  );
}
```

### Option 2: Revert to `viewport-fit=contain` (default)

If you do not want edge-to-edge rendering on mobile browsers, remove
`viewport-fit=cover` from `<meta name="viewport">` in `web/index.html`:

Code before migration:

```html title="web/index.html"
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
```

Code after migration:

```html title="web/index.html"
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

## Timeline

In stable release: 3.50

## References

API documentation:

* [`FlutterView.viewPadding`][]
* [`MediaQuery.paddingOf`][]
* [`SafeArea`][]

Relevant issues:

* [Issue 84833][]

Relevant PRs:

* [PR 191647][]

[`FlutterView.viewPadding`]: {{site.api}}/flutter/dart-ui/FlutterView/viewPadding.html
[`MediaQuery.paddingOf`]: {{site.api}}/flutter/widgets/MediaQuery/paddingOf.html
[`SafeArea`]: {{site.api}}/flutter/widgets/SafeArea-class.html
[Issue 84833]: {{site.repo.flutter}}/issues/84833
[PR 191647]: {{site.repo.flutter}}/pull/191647
