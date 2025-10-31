---
title: Deprecated ExpansionTileController
description: >
  `ExpansionTileController` is deprecated and replaced by
  `ExpansibleController`.
---

{% render "docs/breaking-changes.md" %}

## Summary

`ExpansionTileController` is deprecated. The same functionality can be
achieved by using `ExpansibleController` instead.

## Background

`ExpansionTileController` programmatically expands and collapses an `ExpansionTile`. A new `Expansible` widget has been added to the widgets library, which contains logic for expanding and collapsing behavior without being tied to the Material library. `ExpansibleController` complements `Expansible` and has the same functionality as `ExpansionTileController`. Additionally, `ExpansibleController` also supports adding and notifying listeners when its expansion state changes.

Apps that use `ExpansionTileController` display the following error when run
in debug mode: "Use `ExpansibleController` instead.". Specifically, this means that users should replace usage of `ExpansionTileController` with `ExpansibleController`.

## Migration guide

To migrate, replace the `controller` parameter of an `ExpansionTile` from an `ExpansionTileController` to an `ExpansibleController`. Unlike `ExpansionTileController`, `ExpansibleController` is a `ChangeNotifier`, so remember to dispose the new `ExpansibleController`.

Code before migration:

```dart
class _MyWidgetState extends State<MyWidget> {
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
    );
  }
}
```

Code after migration:

```dart
class _MyWidgetState extends State<MyWidget> {
  final ExpansibleController controller = ExpansibleController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
    );
  }
}
```

## Timeline

Landed in version: 3.31.0-0.1.pre<br>
In stable release: 3.32

## References

API documentation:

* [`ExpansionTileController`][]
* [`ExpansibleController`][]
* [`ExpansionTile.controller`][]
* [`Expansible.controller`][]

Relevant issues:

* [Codeshare between ExpansionTile and its Cupertino variant][]
* [Deprecate ExpansionTileController in favor of ExpansibleController][]

Relevant PRs:

* [Introduce Expansible, a base widget for ExpansionTile][]
* [Deprecate ExpansionTileController][]

[`ExpansionTileController`]: {{site.api}}/flutter/material/ExpansionTileController-class.html
[`ExpansibleController`]: {{site.api}}/flutter/widgets/ExpansibleController-class.html
[`ExpansionTile.controller`]: {{site.api}}/flutter/material/ExpansionTile/controller.html
[`Expansible.controller`]: {{site.api}}/flutter/widgets/Expansible/controller.html

[Codeshare between ExpansionTile and its Cupertino variant]: {{site.repo.flutter}}/issues/163552
[Deprecate ExpansionTileController in favor of ExpansibleController]: {{site.repo.flutter}}/issues/165511
[Introduce Expansible, a base widget for ExpansionTile]: {{site.repo.flutter}}/pull/164049
[Deprecate ExpansionTileController]: {{site.repo.flutter}}/pull/166368
