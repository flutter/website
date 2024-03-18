---
title: Accessibility for responsive apps
description: >
  xxx
short-title: Accessibility
---

{% include docs/yt_shims.liquid %}

Aside from standard advice on creating an
[accessible app][], there are some special
considerations to keep in mind when designing
an accessible _and_ responsive app,
particularly on large screen devices.

[accessible app]: accessibility-and-internationalization/accessibility

## Visual density

Different input devices offer various levels of precision,
which necessitate differently sized hit areas.
Flutter's `VisualDensity` class makes it easy to adjust the
density of your views across the entire application,
for example, by making a button larger
(and therefore easier to tap) on a touch device.

When you change the `VisualDensity` for
your `MaterialApp`, `MaterialComponents`
that support it animate their densities to match.
By default, both horizontal and vertical densities
are set to 0.0, but you can set the densities to any
negative or positive value that you want.
By switching between different
densities, you can easily adjust your UI.

![Adaptive scaffold](/assets/images/docs/development/ui/layout/adaptive_scaffold.gif){:width="100%"}

To set a custom visual density,
inject the density into your `MaterialApp` theme:

<?code-excerpt "lib/main.dart (VisualDensity)"?>
```dart
double densityAmt = touchMode ? 0.0 : -1.0;
VisualDensity density =
    VisualDensity(horizontal: densityAmt, vertical: densityAmt);
return MaterialApp(
  theme: ThemeData(visualDensity: density),
  home: MainAppScaffold(),
  debugShowCheckedModeBanner: false,
);
```

To use `VisualDensity` inside your own views,
you can look it up:

<?code-excerpt "lib/pages/adaptive_reflow_page.dart (VisualDensityOwnView)"?>
```dart
VisualDensity density = Theme.of(context).visualDensity;
```

Not only does the container react automatically to changes
in density, it also animates when it changes.
This ties together your custom components,
along with the built-in components,
for a smooth transition effect across the app.

As shown, `VisualDensity` is unit-less,
so it can mean different things to different views.
In the following example, 1 density unit equals 6 pixels,
but this is totally up to your views to decide.
The fact that it is unit-less makes it quite versatile,
and it should work in most contexts.

It's worth noting that the Material Components generally
use a value of around 4 logical pixels for each
visual density unit. For more information about the
supported components, see the [`VisualDensity`][] API.
For more information about density principles in general,
see the [Material Design guide][].

[Material Design guide]: {{site.material2}}/design/layout/applying-density.html#usage
[`VisualDensity`]: {{site.api}}/flutter/material/VisualDensity-class.html
