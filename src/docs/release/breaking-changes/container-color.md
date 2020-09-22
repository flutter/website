---
title: Container with color optimization
description: A container with a color and no other background decoration no longer builds the same child widgets.
---

## Summary

A new `ColoredBox` widget has been added to the framework,
and the `Container` widget has been optimized to use it
if a user specifies a `color` instead of a `decoration`.

## Context

It is very common to use the `Container` widget as follows:

<!-- skip -->
```dart
return Container(color: Colors.red);
```

Previously, this code resulted in a widget heirarchy that used a
`BoxDecoration` to actually paint the background color.
The `BoxDecoration` widget covers many cases other than
just painting a background color,
and is not as efficient as the new `ColoredBox` widget,
which only paints a background color.

Widget tests that wanted to assert based on the color
of a container in the widget tree would previously have
to find the `BoxDecoration` to actually get
the color of the container.
Now, they are able to check the `color` property
on the `Container` itself, unless a `BoxDecoration`
was explicitly provided as the `decoration` property.
It is still an error to supply both `color` and
`decoration` to `Container`.

## Migration guide

Tests that assert on the color of a `Container`
or that expected it to create a
`BoxDecoration` need to be modified.

Code before migration:

<!-- skip -->
```dart
testWidgets('Container color', (WidgetTester tester) async {
  await tester.pumpWidget(Container(color: Colors.red));

  final Container container = tester.widgetList<Container>().first;
  expect(container.decoration.color, Colors.red);
  // Or, a test may have specifically looked for the BoxDecoration, e.g.:
  expect(find.byType(BoxDecoration), findsOneWidget);
});
```

Code after migration:

<!-- skip -->
```dart
testWidgets('Container color', (WidgetTester tester) async {
  await tester.pumpWidget(Container(color: Colors.red));

  final Container container = tester.widgetList<Container>().first;
  expect(container.color, Colors.red);
  // If your test needed to work directly with the BoxDecoration, it should
  // instead look for the ColoredBox, e.g.:
  expect(find.byType(BoxDecoration), findsNothing);
  expect(find.byType(ColoredBox), findsOneWidget);
});
```

## Timeline

Landed in version: 1.15.4<br>
In stable release: 1.17

## References

API documentation:
* [`Container`][]
* [`ColoredBox`][]
* [`BoxDecoration`][]

Relevant issues:
* [Issue 9672][]
* [Issue 28753][]

Relevant PRs:
* [Colored box and container optimization #50979][]

[`Container`]: {{site.api}}/flutter/widgets/Container-class.html
[`ColoredBox`]: {{site.api}}/flutter/widgets/ColoredBox-class.html
[`BoxDecoration`]: {{site.api}}/flutter/widgets/BoxDecoration-class.html
[Issue 9672]: {{site.github}}/flutter/flutter/issues/9672
[Issue 28753]: {{site.github}}/flutter/flutter/issues/28753
[Colored box and container optimization #50979]: {{site.github}}/flutter/flutter/pull/50979
