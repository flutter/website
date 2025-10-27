---
title: Customizing tabs alignment using the new TabBar.tabAlignment property
description: Introducing the TabBar.tabAlignment property.
---

{% render "docs/breaking-changes.md" %}

## Summary

Using `TabBar.tabAlignment` to customize the alignment of tabs in a `TabBar`.

## Context

The `TabBar.tabAlignment` property sets where a Material 3 `TabBar` places tabs.
The `TabAlignment` enum has the following values:

* `TabAlignment.start`: Aligns the tabs to the start of the scrollable `TabBar`.
* `TabAlignment.startOffset`: Aligns the tabs to the start of the
   scrollable `TabBar` with an offset of `52.0` pixels.
* `TabAlignment.center`: Aligns the tabs to the center of the `TabBar`.
* `TabAlignment.fill`: Aligns the tabs to the start and stretches the tabs
   to fill the fixed `TabBar`.

The scrollable `TabBar` supports the following alignments:

* `TabAlignment.start`
* `TabAlignment.startOffset`
* `TabAlignment.center`

The fixed `TabBar` supports the following alignments:

* `TabAlignment.fill`
* `TabAlignment.center`

When you set `ThemeData.useMaterial3` to `true`,
a scrollable `TabBar` aligns tabs as `TabAlignment.startOffset` by default.
To change this alignment, set the
`TabBar.tabAlignment` property for widget level customization.
Or, set the `TabBarThemeData.tabAlignment` property for app level customization.

## Description of change

When you set `TabBar.isScrollable` and `ThemeData.useMaterial3` to `true`,
the tabs in a scrollable `TabBar` defaults to `TabAlignment.startOffset`.
This aligns the tabs to the start of the
scrollable `TabBar` with an offset of `52.0` pixels.
This changes the previous behavior.
The tabs were aligned to the start of the scrollable `TabBar`
when more tabs needed to display than the width allowed.

## Migration guide

A Material 3 scrollable `TabBar` uses `TabAlignment.startOffset` as
the default tab alignment.
This aligns the tabs to the start of the
scrollable `TabBar` with an offset of `52.0` pixels.

To align the tabs to the start of the
scrollable `TabBar`, set `TabBar.tabAlignment` to `TabAlignment.start`.
This change also removed the `52.0` pixel offset.
The following code snippets show how to use `TabBar.tabAlignment` to
align tabs to the start of the scrollable `TabBar`:

Code before migration:

```dart
TabBar(
  isScrollable: true,
  tabs: List<Tab>.generate(
    count,
    (int index) => Tab(text: 'Tab $index'),
  ).toList(),
);
```

Code after migration:

```dart
TabBar(
  tabAlignment: TabAlignment.start,
  isScrollable: true,
  tabs: List<Tab>.generate(
    count,
    (int index) => Tab(text: 'Tab $index'),
  ).toList(),
);
```

## Timeline

Landed in version: 3.13.0-17.0.pre<br>
In stable release: 3.16

## References

API documentation:

* [`TabBar`][]
* [`TabBar.tabAlignment`][]
* [`TabAlignment`][]

Relevant PRs:

* [Introduce `TabBar.tabAlignment`][]
* [Fix Material 3 Scrollable `TabBar`][]

[`TabBar`]: {{site.api}}/flutter/material/TabBar-class.html
[`TabBar.tabAlignment`]: {{site.api}}/flutter/material/TabBar/tabAlignment.html
[`TabAlignment`]: {{site.api}}/flutter/material/TabAlignment.html

[Introduce `TabBar.tabAlignment`]: {{site.repo.flutter}}/pull/125036
[Fix Material 3 Scrollable `TabBar`]: {{site.repo.flutter}}/pull/131409
