---
title: Semantics roles update for the menu system
description: >-
  Menu-related button widgets should only be used as children of `MenuAnchor` or
  `MenuBar`.
---

## Summary

To support accessibility and ensure that screen readers announce roles correctly
on the web, `MenuAnchor`, `MenuBar`, `MenuItemButton`, `SubmenuButton`, 
`CheckboxMenuButton`, and `RadioMenuButton` have been wired up to `ARIA` menu 
roles. These menu button widgets should only be used as children of menu-related
widgets, such as `MenuAnchor` and `MenuBar`.

## Background

The `MenuAnchor` and `MenuBar` widgets are used to show menus or sub-menus. 
The children of these widgets are composed of menu items, such as 
`MenuItemButton`, `SubmenuButton`, `CheckboxMenuButton`, and `RadioMenuButton`.

After these widgets are wired up to the `ARIA` menu roles, widgets with menu 
item roles should only be used as children of widgets with `menu` or `menuBar` 
roles.

## Migration guide

This change added a check for menu buttons.
An error messages similar to "A menu item must be a child of a menu or a menu
bar" might appear if the menu item buttons are used directly instead 
of using them within widgets with a role of `SemanticsRole.menu` or 
`SemanticsRole.menuBar`. Menu item buttons include: `MenuItemButton`, 
`SubmenuButton`, `CheckboxMenuButton` and `RadioMenuButton`.

Before migration:

The following example uses a menu button outside of a menu context:

```dart
MaterialApp(
  home: Material(
    child: Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Button 0')),
        OutlinedButton(onPressed: () {}, child: const Text('Button 1')),
        MenuItemButton(onPressed: () {}, child: const Text('Button 2')),
      ]
    )
  )
)
```

After migration:

The previous code now throws an exception and displays an error message. To 
fix the error, replace the menu button widgets with other standard buttons:

```dart
MaterialApp(
  home: Material(
    child: Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Button 0')),
        OutlinedButton(onPressed: () {}, child: const Text('Button 1')),
        TextButton(onPressed: () {}, child: const Text('Button 2')),
      ]
    )
  )
)
```

If an app has its own custom menu or menu bar widgets and needs to use the menu
button widgets within them, the custom widgets should be assigned 
`SemanticsRole.menu` and `SemanticsRole.menuBar` accordingly.

For example, code before the migration:

```dart
MaterialApp(
  home: CustomMenu(
    children: [
      MenuItemButton(onPressed: () {}, child: const Text('Menu item 0')),
      MenuItemButton(onPressed: () {}, child: const Text('Menu item 1')),
      SubmenuButton(
        onPressed: () {}, 
        child: const Text('Submenu 0'),
      ),
    ],
  ),
);
```

Code after the migration:

```dart
MaterialApp(
  home: Semantics(
    // Use `SemanticsRole.menuBar` if this is a custom menu bar.
    role: SemanticsRole.menu,
    child: CustomMenu(
      children: [
        MenuItemButton(onPressed: () {}, child: const Text('Menu item 0')),
        MenuItemButton(onPressed: () {}, child: const Text('Menu item 1')),
        SubmenuButton(
          onPressed: () {}, 
          child: const Text('Submenu 0'),
        ),
      ],
    ),
  ),
);
```

An example test, before migration:

```dart
await tester.pumpWidget(
  MaterialApp(
    home: CheckboxMenuButton(
      onPressed: () {},
      child: const Text('Menu Button'),
    ),
  )
);
```

The same test, after migration:

```dart
await tester.pumpWidget(
  MaterialApp(
    home: Semantics(
      role: SemanticsRole.menu, // or `SemanticsRole.menuBar`,
      child: CheckboxMenuButton(
        onPressed: () {},
        child: const Text('Menu Button'),
      ),
    ),
  )
);
```

## Timeline

Landed in version: TBD
In stable release: TBD

## References

API documentation:

* [`MenuAnchor`][]
* [`MenuBar`][]
* [`MenuItemButton`][]
* [`SubmenuButton`][]
* [`CheckboxMenuButton`][]
* [`RadioMenuButton`][]

Relevant PRs:

* [Add aria menu roles to menu-related widgets][]
* [Wire up MenuAnchor, MenuBar, MenuItem-related widgets to aria roles][]

[`MenuAnchor`]: {{site.api}}/flutter/material/MenuAnchor-class.html
[`MenuBar`]: {{site.api}}/flutter/material/MenuBar-class.html
[`MenuItemButton`]: {{site.api}}/flutter/material/MenuItemButton-class.html
[`SubmenuButton`]: {{site.api}}/flutter/material/SubmenuButton-class.html
[`CheckboxMenuButton`]: {{site.api}}/flutter/material/CheckboxMenuButton-class.html
[`RadioMenuButton`]: {{site.api}}/flutter/material/RadioMenuButton-class.html
[Add aria menu roles to menu-related widgets]: {{site.repo.flutter}}/pull/164741
[Wire up MenuAnchor, MenuBar, MenuItem-related widgets to aria roles]: {{site.repo.flutter}}/pull/165596
