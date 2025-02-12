---
title: SystemContextMenuController.show Deprecated
description: >
  `SystemContextMenuController`'s `show` method is deprecated and replaced by
  its `showWithItems` method.
---

## Summary

`SystemContextMenuController.show` is deprecated. The same functionality can be
achieved by passing `SystemContextMenu.getDefaultItems` to
`SystemContextMenuController.showWithItems`.

## Background

The iOS-drawn `SystemContextMenu` feature was originally added without the
ability to control which items are shown in the menu. The platform would decide
which items to show based on the active [TextInputConnection].

The problem with this approach is that an "Autofill" button is often shown, but
Flutter does not have the ability to respond to this button. So in many cases,
users see an "Autofill" button that does nothing when tapped, and Flutter app
developers have no way to hide the button.

This problem is solved by introducing a new method,
`SystemContextMenuController.showWithItems`, which requires a list of `items` to
be passed.

Developers that have no preference which items are shown can call the new method
`SystemContextMenu.getDefaultItems` to get the default items based on the given
`EditableTextState`. For example, if the `EditableTextState` indicates that
there is nothing selected, then the "Copy" button will not be included, since it
requires a selection to copy.

## Migration guide

Most users use the system context menu through the `SystemContextMenu` widget,
and in this case there will be no change required. The `SystemContextMenu`
widget automatically gets the default items under the hood.

No migration is needed:

```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    TextField(
      contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
        return SystemContextMenu.editableText(
          editableTextState: editableTextState,
        );
      }
    );
  }
}
```

For advanced users that directly work with `SystemContextMenuController`,
migrate to the new method `SystemContextMenuController.showWithItems`. The
default can be obtained from `SystemContextMenu.getDefaultItems` as a list of
`IOSSystemContextMenuItem`s, which can be converted to the format required by
`showWithItems` through `IOSSystemContextMenuItem.getData`.

Code before migration:

```dart
_controller.show(selectionRect);
```

Code after migration:

```dart
final List<IOSSystemContextMenuItem> defaultItems =
    SystemContextMenu.getDefaultItems(editableTextState);
final WidgetsLocalizations localizations =
    WidgetsLocalizations.of(context);
final List<IOSSystemContextMenuItemData> defaultItemDatas =
    defaultItems
        .map((IOSSystemContextMenuItem item) =>
            item.getData(localizations))
        .toList();
_controller.showWithItems(selectionRect, defaultItemDatas);
```

## Timeline

Landed in version: 3.29.0-0.3.pre<br>
In stable release: not yet

## References

// TODO(justinmc): Fill this out.
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

[`TextInputConnection`]: {{site.api}}/flutter/services/TextInputConnection-class.html
[`DropdownMenu`]: {{site.api}}/flutter/material/DropdownMenu-class.html
[`FocusNode.canRequestFocus`]: {{site.api}}/flutter/widgets/FocusNode/canRequestFocus.html
[`TextField.canRequestFocus`]: {{site.api}}/flutter/material/TextField/canRequestFocus.html
[`TextField.focusNode`]: {{site.api}}/flutter/material/TextField/focusNode.html

[Native ios context menu]: {{site.repo.flutter}}/pull/143002
[Secure paste milestone 2]: {{site.repo.flutter}}/pull/159013
[[ios][secure_paste]show menu item based on info sent from framework]: {{sites.repo.engine}}/pull/161103
