---
title: Material
description: Learn about Material Design for Flutter.
---

Material is a design system created by Google to
help teams build high-quality digital experiences
for Android, iOS, Flutter, desktop, and the web.

{{site.alert.note}}
  A few facts about Material 3 (M3),
  the next generation of Material Design:

  * Most Flutter widgets are already migrated to M3,
    but you can follow progress on the
    [Material 3 Flutter GitHub project][] and the
    [GitHub umbrella issue][].
  * For the latest list of Flutter's widgets that
    are new and migrated to Material 3, see
    [Affected widgets][].
  * Until migration is complete, you can opt in to
    Material 3 using the [`useMaterial3`][] property.
    However, your UI might be inconsistent until
    _all_ of Flutter _and_ your code is migrated.
  * Some Flutter widgets have similar behavior in M2 and
    M3, so those widget names are unchanged.
    However, other widgets have substantially different
    behavior in M3, so new widgets have been created.
  * Once migration is complete, Material 3 will
    become Flutter's default look and feel.
  * Material 2 will eventually be removed according
    to Flutter's [deprecation policy][].
{{site.alert.end}}

[Affected widgets]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html#affected-widgets
[deprecation policy]: {{site.url}}/resources/compatibility
[GitHub umbrella issue]: {{site.github}}//flutter/flutter/issues/91605
[demo]: https://flutter.github.io/samples/web/material_3_demo/#/
[Material 3/Flutter GitHub project]: {{site.github}}/orgs/flutter/projects/19/views/22
[`useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html

To play with the Material widgets, check out the
[interactive Material & Flutter showcase][demo]:

<iframe src="https://flutter.github.io/samples/web/material_3_demo/#/"
        title="Material 3 Demo App"></iframe>


## More information

To learn more about Material Design and Flutter,
check out:    

* [Flutter Material blog and announcements][]
* [Migrating a Flutter app to Material 3][] blog post by Taha Tesser


