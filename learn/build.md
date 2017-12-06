---
layout: page
title: Learn Flutter; rendering widgets with build()

permalink: /learn/build/
---

This page teaches the basic concept of how widgets are rendered.

* Placeholder for TOC
{:toc}

## Widgets

All rendering in Flutter is conctrolled by widgets. Some widgets correspond to ‘controls’, for example `FlatButton` and `Text`. Other widgets control the layout of other Widgets, for example `Center` and `Row`.

## build() methods

Widgets ‘put pixels on the screen’ inside their build() method. This method is called by the Flutter framework when the widget is part of the current rendering tree, and when any of the dependencies of the widget change.

Build methods often render content by instantiating other widgets. Actually, this is a very common pattern in Flutter: Widgets are rendered by composing them from existing widgets. As a concrete example, consider this build() method for the FlatButton:

```dart
Widget build(BuildContext context) {
    return new MaterialButton(
      onPressed: onPressed,
      color: _getColor(context),
      highlightColor: highlightColor ?? Theme.of(context).highlightColor,
      splashColor: splashColor ?? Theme.of(context).splashColor,
      elevation: enabled ? elevation : disabledElevation,
      highlightElevation: enabled ? highlightElevation : disabledElevation,
      colorBrightness: colorBrightness,
      child: child,
    );
  }
```

As you can see this simple instantiates a MaterialButton, and configures it to have the desired apperance for a “flat” button.

## Next step

Now that you understand the basics of rendering a widget with build(), let’s move on to [rendering widgets that contain state](/learn/state/).
