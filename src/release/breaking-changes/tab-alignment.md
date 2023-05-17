---
title: Customizing tabs alignment using the new TabBar.tabAlignment property
description: Introducing the TabBar.tabAlignment property.
---

## Summary

Using `TabBar.tabAlignment` to customize the alignment of tabs in a `TabBar`.

## Context

The `TabBar.tabAlignment` property is introduced to customize the alignment of tabs in a Material 3 `TabBar`. The `TabAlignment` enum has the following values:

* `TabAlignment.start`: Aligns the tabs to the start of the scrollable `TabBar`.
* `TabAlignment.startOffset`: Aligns the tabs to the start of the scrollable `TabBar` with an offset of `52.0` pixels.
* `TabAlignment.center`: Aligns the tabs to the center of the `TabBar`.
* `TabAlignment.fill`: Aligns the tabs to the start and stretches the tabs to fill the fixed `TabBar`.

When `ThemeData.useMaterial3` are set to `true`, the default tab alignment for a scrollable `TabBar` is `TabAlignment.startOffset`. This can be changed by setting the `TabBar.tabAlignment` property.

## Description of change

When the `TabBar.isScrollable` and `ThemeData.useMaterial3` are set to `true`, the tabs in a scrollable `TabBar` defaults to `TabAlignment.startOffset` which aligns the tabs to the start of the scrollable `TabBar` with an offset of `52.0` pixels. This is a change from the previous behavior, where the tabs were aligned to the start of the scrollable `TabBar` when there are more tabs to display than the available width.

## Migration guide

A Material 3 scrollable `TabBar` uses `TabAlignment.startOffset` as the default tab alignment which aligns the tabs to the start of the scrollable `TabBar` with an offset of `52.0` pixels.

To align the tabs to the start of the scrollable `TabBar`, without an offset of `52.0` pixels, set `TabBar.tabAlignment` to `TabAlignment.start`.
The following code snippets show how to use `TabBar.tabAlignment` to align the tabs to the start of the scrollable `TabBar`:

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

Landed in version: 3.11.0-0.0.pre<br>
In stable release: TBD

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
[Fix Material 3 Scrollable `TabBar`]: {{site.repo.flutter}}/pull/125974
