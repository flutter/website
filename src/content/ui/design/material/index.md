---
title: Material Design for Flutter
description: Learn about Material Design for Flutter.
---

Material Design is an open-source design system built
and supported by Google designers and developers.

The latest version, Material 3, enables personal,
adaptive, and expressive experiences—from dynamic color
and enhanced accessibility, to foundations for
large screen layouts, and design tokens.

:::warning
As of the Flutter 3.16 release, **Material 3 is
enabled by default**. For now, you can opt out
of Material 3 by setting the [`useMaterial3`][] property
to `false`. But be aware that the `useMaterial3`
property and support for Material 2
will eventually be deprecated according to
Flutter's [deprecation policy][].
:::

For _most_ Flutter widgets, upgrading to Material 3
is seamless. But _some_ widgets couldn't be
updated—entirely new implementations were needed,
such as [`NavigationBar`][].
You must make these changes to your code manually.
Until your app is entirely updated,
the UI might look or act a bit strange.
You can find the entirely new Material components by
visiting the [Affected widgets][] page.

[Affected widgets]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html#affected-widgets
[deprecation policy]: /release/compatibility-policy#deprecation-policy
[demo]: {{site.github}}/flutter/samples/blob/main/material_3_demo/
[`NavigationBar`]: {{site.api}}/flutter/material/NavigationBar-class.html
[`useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html

Explore the updated components, typography, color system,
and elevation support with the
[Material 3 demo][demo].

## More information {:.no_toc}

To learn more about Material Design and Flutter,
check out:

* [Material.io developer documentation][]
* [Migrating a Flutter app to Material 3][] blog post by Taha Tesser
* [Umbrella issue on GitHub][]

[Material.io developer documentation]: {{site.material}}/develop/flutter
[Migrating a Flutter app to Material 3]: https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/
[Umbrella issue on GitHub]: {{site.github}}/flutter/flutter/issues/91605
