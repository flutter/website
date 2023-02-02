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
Flutter is in the process of migrating to Material 3.

{{site.alert.note}}
  A few facts about Material 3 (M3),
  the next generation of Material Design:

  * Most Flutter widgets are already migrated to M3,
    but you can follow progress on the
    [Material 3 Flutter GitHub project][] and the
    [GitHub umbrella issue][].
  * You can opt in to
    Material 3 using the [`useMaterial3`][] flag.
    However, your UI might be inconsistent until
    _all_ of Flutter _and_ your code are migrated.
  * For the latest list of Flutter's widgets that
    are affected by the [`useMaterial3`][] flag, see
    [Affected widgets][].
  * The vast majority of Flutter widgets have similar
    behavior in M2 and M3, so those widget names are unchanged.
    However, a couple widgets have substantially different
    behavior in M3, so new widgets have been created.
  * Once migration is complete, Material 3 will
    become the Material library's default look and feel.
  * Support for Material 2 will eventually be removed according
    to Flutter's [deprecation policy][].
{{site.alert.end}}

[Affected widgets]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html#affected-widgets
[deprecation policy]: {{site.url}}/resources/compatibility
[GitHub umbrella issue]: {{site.github}}//flutter/flutter/issues/91605
[demo]: https://flutter.github.io/samples/web/material_3_demo/#/
[Material 3 Flutter GitHub project]: {{site.github}}/orgs/flutter/projects/19/views/22
[`useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html

Explore the updated components, typography, color system,
and elevation support with the
[interactive Material 3 demo][demo]:

<iframe src="https://flutter.github.io/samples/web/material_3_demo/#/"
        width="100%" height="600px" title="Material 3 Demo App"></iframe>


## More information
{:.no_toc}

To learn more about Material Design and Flutter,
check out:    

* [Material.io developer documentation][]
* [Migrating a Flutter app to Material 3][] blog post by Taha Tesser


[Material.io developer documentation]: https://m3.material.io/develop/flutter
[Migrating a Flutter app to Material 3]: https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/
