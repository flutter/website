---
title: TextField.canRequestFocus Deprecated
description: >
  `TextField`'s `canRequestFocus` parameter is deprecated and replaced by the
  `canRequestFocus` parameter of its `FocusNode`.
---

## Summary

`TextField.canRequestFocus` is deprecated. The same functionality can be
achieved by setting the `canRequestFocus` parameter of the `TextField`'s
`FocusNode`.

## Background

`TextField.canRequestFocus` was added in order to support `DropdownMenu`, which
has a TextField that sometimes is not interactive. However, the same
functionality can be achieved by setting the `canRequestFocus` parameter of a
`TextField`'s `FocusNode`. `DropdownMenu` has been migrated to this approach,
and other use cases should follow the same pattern.

Apps that use `TextField.canRequestFocus` display the following error when run
in debug mode: "Use `focusNode` instead.". Specifically, this means that users
should pass a `FocusNode` to `TextField.focusNode` with the
`FocusNode.canRequestFocus` parameter set.

## Migration guide

To migrate, remove the `TextField.canRequestFocus` parameter. Create a
`FocusNode` with the `FocusNode.canRequestFocus` parameter set to the desired
value, and pass that to `TextField.focusNode`.

Code before migration:

```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    TextField(
      canRequestFocus: false,
    );
  }
}
```

Code after migration:

```dart
class _MyWidgetState extends State<MyWidget> {
  final FocusNode _focusNode = FocusNode(canRequestFocus: false);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
    );
  }
}
```

## Timeline

Landed in version: 3.13.0-15.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`DropdownMenu`][]
* [`FocusNode.canRequestFocus`][]
* [`TextField.canRequestFocus`][]
* [`TextField.focusNode`][]

Relevant issues:

* [Broken selection on TextField if canRequestFocus: false][]
* [DropdownMenu Disable text input][]

Relevant PRs:

* [Add requestFocusOnTap to DropdownMenu][]
* [Replace TextField.canRequestFocus with TextField.focusNode.canRequestFocus][]

[`DropdownMenu`]: {{site.api}}/flutter/material/DropdownMenu-class.html
[`FocusNode.canRequestFocus`]: {{site.api}}/flutter/widgets/FocusNode/canRequestFocus.html
[`TextField.canRequestFocus`]: {{site.api}}/flutter/material/TextField/canRequestFocus.html
[`TextField.focusNode`]: {{site.api}}/flutter/material/TextField/focusNode.html

[Broken selection on TextField if canRequestFocus: false]: {{site.repo.flutter}}/issues/130011
[DropdownMenu Disable text input]: {{site.repo.flutter}}/issues/116587
[Replace TextField.canRequestFocus with TextField.focusNode.canRequestFocus]: {{site.repo.flutter}}/pull/130164
[Add requestFocusOnTap to DropdownMenu]: {{site.repo.flutter}}/pull/117504
