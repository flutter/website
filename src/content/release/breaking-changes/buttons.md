---
title: New Buttons and Button Themes
description: The basic material button classes have been replaced.
---

## Summary

A new set of basic material button widgets and themes have been added
to Flutter. The original classes have been deprecated and will
eventually be removed. The overall goal is to make buttons more
flexible, and easier to configure via constructor parameters or
themes.

The `FlatButton`, `RaisedButton` and `OutlineButton` widgets have been
replaced by `TextButton`, `ElevatedButton`, and `OutlinedButton`
respectively. Each new button class has its own theme:
`TextButtonTheme`, `ElevatedButtonTheme`, and
`OutlinedButtonTheme`. The original `ButtonTheme` class is no longer
used. The appearance of buttons is specified by a `ButtonStyle`
object, instead of a large set of widget parameters and
properties. This is roughly comparable to the way that the appearance
of text is defined with a `TextStyle` object. The new button themes
are also configured with a `ButtonStyle` object. A `ButtonStyle` is
itself just a collection of visual properties. Many of these
properties are defined with `MaterialStateProperty`, which means that
their value can depend on the button's state.


## Context

Rather than try and evolve the existing button classes and their theme
in-place, we have introduced new replacement button widgets and
themes. In addition to freeing us from the backwards compatibility
labyrinth that evolving the existing classes in-place would entail,
the new names sync Flutter back up with the Material Design spec,
which uses the new names for the button components.

| Old Widget      | Old Theme     | New Widget       | New Theme             |
|-----------------|---------------|------------------|-----------------------|
| `FlatButton`    | `ButtonTheme` | `TextButton`     | `TextButtonTheme`     |
| `RaisedButton`  | `ButtonTheme` | `ElevatedButton` | `ElevatedButtonTheme` |
| `OutlineButton` | `ButtonTheme` | `OutlinedButton` | `OutlinedButtonTheme` |

{:.table .table-striped .nowrap}

The new themes follow the "normalized" pattern that Flutter adopted
for new Material widgets about a year ago. Theme properties and widget
constructor parameters are null by default. Non-null theme properties
and widget parameters specify an override of the component's default
value. Implementing and documenting default values is the sole
responsibility of the button component widgets. The defaults
themselves are based primarily on the overall Theme's colorScheme and
textTheme.

Visually, the new buttons look a little different, because they match
the current Material Design spec and because their colors are
configured in terms of the overall Theme's ColorScheme. There are
other small differences in padding, rounded corner radii, and the
hover/focus/pressed feedback.

Many applications will be able to just substitute the new class names
for the old ones. Apps with golden image tests or with buttons whose
appearance has been configured with constructor parameters or with the
original `ButtonTheme` may need to consult the migration guide and the
introductory material that follows.

## API Change: ButtonStyle instead of individual style properties

Except for simple use cases, the APIs of the new button classes are
not compatible with the old classes. The visual attributes of the new
buttons and themes are configured with a single `ButtonStyle` object,
similar to how a `TextField` or a `Text` widget can be configured with a
`TextStyle` object. Most of the `ButtonStyle` properties are defined with
`MaterialStateProperty`, so that a single property can represent
different values depending on the button's pressed/focused/hovered/etc
state.

A button's `ButtonStyle` doesn't define the button's visual properties,
it defines overrides of the buttons default visual properties,
where the default properties are computed by the button widget
itself. For example, to override a `TextButton`'s default foreground
(text/icon) color for all states, one could write:

```dart
TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
  ),
  onPressed: () { },
  child: Text('TextButton'),
)
```

This kind of override is common; however, in many cases what's also
needed are overrides for the overlay colors that the text button uses
to indicate its hovered/focus/pressed state.  This can be done by
adding the `overlayColor` property to the `ButtonStyle`.

```dart
TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.blue.withValues(alpha: 0.04);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.blue.withValues(alpha: 0.12);
        return null; // Defer to the widget's default.
      },
    ),
  ),
  onPressed: () { },
  child: Text('TextButton')
)
```

A color `MaterialStateProperty` only needs to return a value for the
colors whose default should be overridden. If it returns null, the
widget's default will be used instead. For example, to just override
the text button's focus overlay color:

```dart
TextButton(
  style: ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused))
          return Colors.red;
        return null; // Defer to the widget's default.
      }
    ),
  ),
  onPressed: () { },
  child: Text('TextButton'),
)
```

### The `styleFrom()` ButtonStyle utility methods

The Material Design spec defines buttons' foreground and overlay colors in
terms of the color scheme's primary color. The primary color is
rendered at different opacities, depending on the button's state. To
simplify creating a button style that includes all of the properties
that depend on color scheme colors, each button class includes a
static styleFrom() method which constructs a `ButtonStyle` from a simple
set of values, including the `ColorScheme` colors it depends on.

This example creates a button that overrides its foreground color, as
well as its overlay color, using the specified primary color and the
opacities from the Material Design spec.

```dart
TextButton(
  style: TextButton.styleFrom(
    primary: Colors.blue,
  ),
  onPressed: () { },
  child: Text('TextButton'),
)
```

The `TextButton` documentation indicates that the foreground color when
the button is disabled is based on the color scheme's `onSurface`
color. To override that as well, using styleFrom():

```dart
TextButton(
  style: TextButton.styleFrom(
    primary: Colors.blue,
    onSurface: Colors.red,
  ),
  onPressed: null,
  child: Text('TextButton'),
)
```

Using the `styleFrom()` method is the preferred way to create a
`ButtonStyle` if you're trying to create a Material Design
variation. The most flexible approach is defining a `ButtonStyle`
directly, with `MaterialStateProperty` values for the states whose
appearance you want to override.

## ButtonStyle defaults

Widgets like the new button classes _compute_ their default values
based on the overall theme's `colorScheme` and `textTheme` as well as
button's current state. In a few cases they also consider if the
overall theme's color scheme is light or dark.  Each button has a
protected method that computes its default style as needed. Although
apps won't call this method directly, its API doc explains what all
of the defaults are.  When a button or button theme specifies
`ButtonStyle`, only the button style's non-null properties override the
computed defaults. The button's `style` parameter overrides non-null
properties specified by the corresponding button theme. For example if
`foregroundColor` property of a `TextButton`'s style is non-null, it
overrides the same property for the `TextButonTheme`'s style.

As explained earlier, each button class includes a static method
called `styleFrom` which constructs a ButtonStyle from a simple set of
values, including the `ColorScheme` colors it depends on. In many common
cases, using `styleFrom` to create a one-off `ButtonStyle` that
overrides the defaults, is simplest. This is particularly true when
the custom style's objective is to override one of the color scheme
colors, like `primary` or `onPrimary` that the default style depends
on.  For other cases you can create a `ButtonStyle` object
directly. Doing so enables you to control the value of visual
properties, like colors, for all of the button's possible states -
like pressed, hovered, disabled, and focused.


## Migration guide

Use the following information to migrate your buttons to the
new API.

### Restoring the original button visuals

In many cases it's possible to just switch from the old button class
to the new one.  That's assuming that the small changes in size/shape
and the likely bigger change in colors, aren't a concern.

To preserve the original buttons' appearance in these cases, one can
define button styles that match the original as closely as you
like. For example, the following style makes a `TextButton` look
like a default `FlatButton`:

```dart
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

TextButton(
  style: flatButtonStyle,
  onPressed: () { },
  child: Text('Looks like a FlatButton'),
)
```

Similarly, to make an `ElevatedButton` look like a default `RaisedButton`:

```dart
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.grey[300],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
ElevatedButton(
  style: raisedButtonStyle,
  onPressed: () { },
  child: Text('Looks like a RaisedButton'),
)
```

The `OutlineButton` style for `OutlinedButton` is a little more
complicated because the outline's color changes to the primary color
when the button is pressed. The outline's appearance is defined by a
`BorderSide` and you'll use a `MaterialStateProperty` to define the pressed
outline color:

```dart
final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
).copyWith(
  side: MaterialStateProperty.resolveWith<BorderSide?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        );
      }
      return null;
    },
  ),
);

OutlinedButton(
  style: outlineButtonStyle,
  onPressed: () { },
  child: Text('Looks like an OutlineButton'),
)
```

To restore the default appearance for buttons throughout an
application, you can configure the new button themes in the
application's theme:

```dart
MaterialApp(
  theme: ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
    textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
  ),
)
```

To restore the default appearance for buttons in part of an
application you can wrap a widget subtree with `TextButtonTheme`,
`ElevatedButtonTheme`, or `OutlinedButtonTheme`. For example:

```dart
TextButtonTheme(
  data: TextButtonThemeData(style: flatButtonStyle),
  child: myWidgetSubtree,
)
```

### Migrating buttons with custom colors

The following sections cover use of the following `FlatButton`,
`RaisedButton`, and `OutlineButton` color parameters:

```dart
textColor
disabledTextColor
color
disabledColor
focusColor
hoverColor
highlightColor*
splashColor
```

The new button classes do not support a separate highlight color
because it's no longer part of the Material Design.

#### Migrating buttons with custom foreground and background colors

Two common customizations for the original button classes are a custom
foreground color for `FlatButton`, or custom foreground and background
colors for `RaisedButton`.  Producing the same result with the new
button classes is simple:

```dart
FlatButton(
  textColor: Colors.red, // foreground
  onPressed: () { },
  child: Text('FlatButton with custom foreground/background'),
)

TextButton(
  style: TextButton.styleFrom(
    primary: Colors.red, // foreground
  ),
  onPressed: () { },
  child: Text('TextButton with custom foreground'),
)
```

In this case the `TextButton`'s foreground (text/icon) color as well as
its hovered/focused/pressed overlay colors will be based on
`Colors.red`. By default, the `TextButton`'s background fill color is
transparent.

Migrating a `RaisedButton` with custom foreground and background colors:

```dart
RaisedButton(
  color: Colors.red, // background
  textColor: Colors.white, // foreground
  onPressed: () { },
  child: Text('RaisedButton with custom foreground/background'),
)

ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: Colors.red, // background
    onPrimary: Colors.white, // foreground
  ),
  onPressed: () { },
  child: Text('ElevatedButton with custom foreground/background'),
)
```

In this case the button's use of the color scheme's primary color is
reversed relative to the `TextButton`: primary is button's background
fill color and `onPrimary` is the foreground (text/icon) color.

#### Migrating buttons with custom overlay colors

Overriding a button's default focused, hovered, highlighted, or splash
colors is less common. The `FlatButton`, `RaisedButton`, and `OutlineButton`
classes have individual parameters for these state-dependent
colors. The new `TextButton`, `ElevatedButton`, and `OutlinedButton` classes
use a single `MaterialStateProperty<Color>` parameter instead. The new
buttons allow one to specify state-dependent values for all of the
colors, the original buttons only supported specifying what's now
called the "overlayColor".

```dart
FlatButton(
  focusColor: Colors.red,
  hoverColor: Colors.green,
  splashColor: Colors.blue,
  onPressed: () { },
  child: Text('FlatButton with custom overlay colors'),
)

TextButton(
  style: ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused))
          return Colors.red;
        if (states.contains(MaterialState.hovered))
            return Colors.green;
        if (states.contains(MaterialState.pressed))
            return Colors.blue;
        return null; // Defer to the widget's default.
    }),
  ),
  onPressed: () { },
  child: Text('TextButton with custom overlay colors'),
)
```

The new version is more flexible although less compact. In the
original version, the precedence of the different states is
implicit (and undocumented) and fixed, in the new version, it's
explicit.  For an app that specified these colors frequently, the
easiest migration path would be to define one or more `ButtonStyles`
that match the example above - and just use the style parameter - or
to define a stateless wrapper widget that encapsulated the three color
parameters.

#### Migrating buttons with custom disabled colors

This is a relatively rare customization.  The `FlatButton`,
`RaisedButton`, and `OutlineButton` classes have `disabledTextColor` and
`disabledColor` parameters that define the background and foreground
colors when the button's `onPressed` callback is null.

By default, all of the buttons use the color scheme's `onSurface` color,
with opacity 0.38 for the disabled foreground color. Only
`ElevatedButton` has a non-transparent background color and its default
value is the `onSurface` color with opacity 0.12. So in many cases one
can just use the `styleFrom` method to override the disabled colors:

```dart
RaisedButton(
  disabledColor: Colors.red.withValues(alpha: 0.12),
  disabledTextColor: Colors.red.withValues(alpha: 0.38),
  onPressed: null,
  child: Text('RaisedButton with custom disabled colors'),
),

ElevatedButton(
  style: ElevatedButton.styleFrom(onSurface: Colors.red),
  onPressed: null,
  child: Text('ElevatedButton with custom disabled colors'),
)
```

For complete control over the disabled colors, one must define the
`ElevatedButton`'s style explicitly, in terms of
`MaterialStateProperties`:

```dart
RaisedButton(
  disabledColor: Colors.red,
  disabledTextColor: Colors.blue,
  onPressed: null,
  child: Text('RaisedButton with custom disabled colors'),
)

ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled))
          return Colors.red;
        return null; // Defer to the widget's default.
    }),
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled))
          return Colors.blue;
        return null; // Defer to the widget's default.
    }),
  ),
  onPressed: null,
  child: Text('ElevatedButton with custom disabled colors'),
)
```

As with the previous case, there are obvious ways to make the new
version more compact in an app where this migration comes up often.

#### Migrating buttons with custom elevations

This is also a relatively rare customization. Typically, only
`ElevatedButton`s (originally called `RaisedButtons`)
include elevation changes. For elevations that are proportional
to a baseline elevation (per the Material Design specification),
one can override all of them quite simply.

By default, a disabled button's elevation is 0, and the remaining
states are defined relative to a baseline of 2:

```dart
disabled: 0
hovered or focused: baseline + 2
pressed: baseline + 6
```

So to migrate a `RaisedButton` for which all elevations have been
defined:

```dart
RaisedButton(
  elevation: 2,
  focusElevation: 4,
  hoverElevation: 4,
  highlightElevation: 8,
  disabledElevation: 0,
  onPressed: () { },
  child: Text('RaisedButton with custom elevations'),
)

ElevatedButton(
  style: ElevatedButton.styleFrom(elevation: 2),
  onPressed: () { },
  child: Text('ElevatedButton with custom elevations'),
)
```

To arbitrarily override just one elevation, like the pressed
elevation:

```dart
RaisedButton(
  highlightElevation: 16,
  onPressed: () { },
  child: Text('RaisedButton with a custom elevation'),
)

ElevatedButton(
  style: ButtonStyle(
    elevation: MaterialStateProperty.resolveWith<double?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return 16;
        return null;
      }),
  ),
  onPressed: () { },
  child: Text('ElevatedButton with a custom elevation'),
)
```

#### Migrating buttons with custom shapes and borders

The original `FlatButton`, `RaisedButton`, and `OutlineButton` classes all
provide a shape parameter which defines both the button's shape and
the appearance of its outline. The corresponding new classes and their
themes support specifying the button's shape and its border
separately, with `OutlinedBorder shape` and `BorderSide side` parameters.

In this example the original `OutlineButton` version specifies the same
color for border in its highlighted (pressed) state as for other
states.

```dart
OutlineButton(
  shape: StadiumBorder(),
  highlightedBorderColor: Colors.red,
  borderSide: BorderSide(
    width: 2,
    color: Colors.red
  ),
  onPressed: () { },
  child: Text('OutlineButton with custom shape and border'),
)

OutlinedButton(
  style: OutlinedButton.styleFrom(
    shape: StadiumBorder(),
    side: BorderSide(
      width: 2,
      color: Colors.red
    ),
  ),
  onPressed: () { },
  child: Text('OutlinedButton with custom shape and border'),
)
```

Most of the new `OutlinedButton` widget's style parameters, including
its shape and border, can be specified with `MaterialStateProperty`
values, which is to say that they can have different values depending
on the button's state. To specify a different border color when the
button is pressed, do the following:

```dart
OutlineButton(
  shape: StadiumBorder(),
  highlightedBorderColor: Colors.blue,
  borderSide: BorderSide(
    width: 2,
    color: Colors.red
  ),
  onPressed: () { },
  child: Text('OutlineButton with custom shape and border'),
)

OutlinedButton(
  style: ButtonStyle(
    shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
    side: MaterialStateProperty.resolveWith<BorderSide>(
      (Set<MaterialState> states) {
        final Color color = states.contains(MaterialState.pressed)
          ? Colors.blue
          : Colors.red;
        return BorderSide(color: color, width: 2);
      }
    ),
  ),
  onPressed: () { },
  child: Text('OutlinedButton with custom shape and border'),
)
```

## Timeline

Landed in version: 1.20.0-0.0.pre<br>
In stable release: 2.0.0

## References

API documentation:

* [`ButtonStyle`][]
* [`ButtonStyleButton`][]
* [`ElevatedButton`][]
* [`ElevatedButtonTheme`][]
* [`ElevatedButtonThemeData`][]
* [`OutlinedButton`][]
* [`OutlinedButtonTheme`][]
* [`OutlinedButtonThemeData`][]
* [`TextButton`][]
* [`TextButtonTheme`][]
* [`TextButtonThemeData`][]

Relevant PRs:

* [PR 59702: New Button Universe][]
* [PR 73352: Deprecated obsolete Material classes: FlatButton, RaisedButton, OutlineButton][]


[`ButtonStyle`]: {{site.api}}/flutter/material/ButtonStyle-class.html
[`ButtonStyleButton`]: {{site.api}}/flutter/material/ButtonStyleButton-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`ElevatedButtonTheme`]: {{site.api}}/flutter/material/ElevatedButtonTheme-class.html
[`ElevatedButtonThemeData`]: {{site.api}}/flutter/material/ElevatedButtonThemeData-class.html
[`OutlinedButton`]: {{site.api}}/flutter/material/OutlinedButton-class.html
[`OutlinedButtonTheme`]: {{site.api}}/flutter/material/OutlinedButtonTheme-class.html
[`OutlinedButtonThemeData`]: {{site.api}}/flutter/material/OutlinedButtonThemeData-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`TextButtonTheme`]: {{site.api}}/flutter/material/TextButtonTheme-class.html
[`TextButtonThemeData`]: {{site.api}}/flutter/material/TextButtonThemeData-class.html

[PR 59702: New Button Universe]: {{site.repo.flutter}}/pull/59702
[PR 73352: Deprecated obsolete Material classes: FlatButton, RaisedButton, OutlineButton]: {{site.repo.flutter}}/pull/73352
