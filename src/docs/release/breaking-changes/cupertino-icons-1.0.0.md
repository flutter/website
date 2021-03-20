---
title: New CupertinoIcons has icon glyph changes
description: Once you update to cupertino_icons 1.0.0, some old glyphs are automapped to the new glyphs. Consider double-checking visually.
---

## Summary

The existing cupertino_icons [0.1.3 icons][]
are based on iOS 11 aesthetics with sharp angles and thin lines.

As Apple's iconography updates with new OS versions,
the `cupertino_icons` package is also refreshed.

Generally, all previous glyphs referenced from the
[`CupertinoIcons`][] API are automatically mapped to
very similar looking icons in the new SF Symbols
style (featuring rounder, thicker lines).

Some icons that have no equivalents in the
new SF Symbols style are left as is.

Some icons that have less variation
(such as thickness, alterative looks, and so on)
are automapped and collapsed to the best matching
variation in the new SF Symbols style but should be
double checked to determine whether they preserve the
intended visual effect.

## Description of change

The new `cupertino_icons 1.0.0` font is handcrafted
to best preserve the intent and aesthetic of the
symbology through the transition. All existing
`CupertinoIcons`' static `IconData` fields
(and thus all of the font `.ttf`'s codepoints)
continue to work and point to a reasonable new icon.

The new cupertino_icons 1.0.0 package also has ~1,000
more icons to choose from.

See the [Cupertino Icons 1.0.0 gallery][]
for a list of available icons and matching
`CupertinoIcons` names.

### Unchanged icons

No SF Symbols styled alternatives exist
for the icons in the following list.
The previous cupertino_icons 0.1.3 icons
have been kept as is in 1.0.0.

* bluetooth
* bus
* car
* car_detailed
* chevron_back
* chevron_forward
* lab_flask
* lab_flask_solid
* news
* news_solid
* train_style_one
* train_style_two

### Merged icons

Icons within the same group are now the exact same
icon in 1.0.0. In other words, the distinctions
between those icon variations that existed in 0.1.3 is
lost and now renders the same SF Symbols
styled icon that represents the theme of the group.

This affects the following icon groups:

* share, share_up
* battery_charging, battery_full, battery_75_percent
* shuffle, shuffle_medium, shuffle_thick
* delete, delete_simple
* refresh, refresh_thin, refresh_thick
* clear, clear_thick
* clear_circled_solid, clear_thick_circled
* gear, gear_alt, gear_big
* loop, loop_thick
* time_solid, clock_solid
* time, clock
* tag, tags
* tag_solid, tags_solid

This is mainly due to some artistic liberties taken
when creating the original `cupertino_icons` set that
no longer match the variations diversity of the more
formal SF Symbols icon set for some of the icons.

## Migration guide

After upgrading to 1.22,
if you also upgrade the `cupertino_icons`
pubspec dependency from 0.1.3 to 1.0.0,
for example, by changing:

<!-- skip -->
```yaml
dependencies:
  ... // Other dependencies
  cupertino_icons: ^0.1.0
```

to:

```yaml
dependencies:
  ... // Other dependencies
  cupertino_icons: ^1.0.0
```

All your `CupertinoIcons` should automatically
update to the new aesthetic (except for the
[unchanged icons](#unchanged-icons) listed above).

At this point, you can also explore [`CupertinoIcons`][]
or the [Cupertino Icons 1.0.0 gallery][]
for new icons to use in your application.

You're encouraged to verify your application after
migrating to ensure that the automatically mapped
new icons are suitable for your desired aesthetics.

## Timeline

Landed in: 1.22.0-10.0.pre.65<br>
In stable release: 1.22

## References

[0.1.3 icons]: https://raw.githubusercontent.com/flutter/cupertino_icons/master/map.png
[`CupertinoIcons`]: {{site.api}}/flutter/cupertino/CupertinoIcons-class.html
[Cupertino Icons 1.0.0 gallery]: https://flutter.github.io/cupertino_icons/
