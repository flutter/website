---
title: Migrate to standalone material_ui and cupertino_ui packages
description: >-
  The Material and Cupertino design libraries are now available as
  standalone packages, decoupling design systems from the Flutter SDK.
---

{% render "docs/breaking-changes.md" %}

## Summary

The Material and Cupertino design libraries are now available as
standalone packages: [`package:material_ui`][] and [`package:cupertino_ui`][].
In Flutter 3.47, developers can opt in to these packages ahead of
the formal deprecation of the in-framework design libraries.

## Background

Historically, Flutter's Material (`package:flutter/material.dart`)
and Cupertino (`package:flutter/cupertino.dart`) widget libraries
were bundled directly inside the core Flutter SDK.
While this made it easy to get started with pixel-perfect widgets,
bundling design systems inside the core framework presented several challenges:

* Widget updates, bug fixes, and new components were tied to
  quarterly Flutter SDK releases.
* Contributions and iteration on design libraries moved slower
  than standalone Dart packages.
* Applications couldn't update design libraries independently of
  the engine and framework.

To resolve these challenges, the design systems are now decoupled
from the core framework.
Starting in Flutter 3.47, version 1.0 of the standalone
`material_ui` and `cupertino_ui` packages is published on `pub.dev`.

Decoupling the design systems provides several benefits:

* **Independent release cycles**:
  The packages can ship bug fixes, improvements, and new components
  on their own release schedules (planned for weekly releases),
  without requiring a full Flutter SDK upgrade.
* **Faster contributions**:
  Community members can contribute directly to the libraries in the
  [`flutter/packages`][] repository.
* **Style-neutral core**:
  Decoupling lays the groundwork for a style-neutral Flutter core widget
  catalog, making it easier to build and maintain custom design systems.

Contributions to `package:flutter/material.dart` and
`package:flutter/cupertino.dart` inside the core SDK were frozen
starting in Flutter 3.44.
The initial 1.0.0 versions of `package:material_ui` and `package:cupertino_ui`
match the frozen framework code to provide a seamless transition.
Future releases of the packages will use semantic versioning for major, minor,
and patch updates.
The in-framework design libraries are scheduled for formal deprecation
in an upcoming stable release.

## Migration guide

To migrate your project from the in-framework design libraries to the
standalone packages, you can use the automated `dart fix` tool
or perform the migration manually.

### Automated migration with dart fix

The quickest way to migrate is using the `migrate_design_widgets` fix rule
with `dart fix`:

```console
$ dart fix --apply --code=migrate_design_widgets
```

This command automatically updates your imports from
`package:flutter/material.dart` and `package:flutter/cupertino.dart`
to the corresponding standalone package imports.

:::note
If `dart fix` doesn't automatically add the new packages to your
`pubspec.yaml` dependencies, manually add them by running
`flutter pub add material_ui` or `flutter pub add cupertino_ui` as needed.
:::

Run `dart fix` once more to ensure all other automated migrations are applied,
and lint warnings addressed, such as import sorting.

### Manual migration

To migrate manually, follow these steps:

1.  Add the standalone packages to your `pubspec.yaml` dependencies:

    ```console
    $ flutter pub add material_ui
    $ flutter pub add cupertino_ui
    ```

1.  Update the imports in your Dart files to reference the new packages.

    Code before migration:

    ```dart
    import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';
    ```

    Code after migration:

    ```dart
    import 'package:cupertino_ui/cupertino_ui.dart';
    import 'package:material_ui/material_ui.dart';
    ```

### Compatibility bridge

During the ecosystem transition, your application might depend on
third-party packages that still import the legacy in-framework libraries
(`package:flutter/material.dart` or `package:flutter/cupertino.dart`).

To allow your application to migrate to the standalone packages immediately
without waiting for all dependencies to update, `material_ui` and
`cupertino_ui` provide compatibility bridge utilities.
Wrap your app using `MaterialUiCompatibilityBridge` inside
`MaterialApp.builder`:

```dart
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return MaterialUiCompatibilityBridge(child: child!);
      },
      home: const HomeScreen(),
    );
  }
}
```

#### Bridge capabilities and limitations

`MaterialUiCompatibilityBridge` injects theme and localization data
downward into the widget tree.
This allows unmigrated child widgets and dependencies that read design state
from context
(such as `Theme.of(context)` or `MaterialLocalizations.of(context)`)
to continue functioning properly.

However, the compatibility bridge cannot resolve type mismatches
when a dependency exposes, accepts, or returns in-framework SDK types
in its public API signatures (such as passing a `FloatingActionButtonLocation`,
`ColorScheme`, or `TextTheme` as a parameter or callback return value).
Because Dart enforces static typing across distinct package imports,
values from `package:flutter/material.dart` cannot be assigned to parameters
expecting types from `package:material_ui`.
Dependencies with API-signature coupling must be migrated to the standalone
package before your application can pass modern types to them.

### Decoupled localizations

As part of this transition, `flutter_localizations` is unbundled
for design components.
Localization delegates and translated strings for Material and Cupertino
widgets now reside directly in `package:material_ui` and
`package:cupertino_ui`.

Code before migration:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ...
MaterialApp(
  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  // ...
);
```

Code after migration:

```dart
import 'package:material_ui/material_ui.dart';

// ...
MaterialApp(
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  // ...
);
```

Setting `localizationsDelegates` to `GlobalMaterialLocalizations.delegates`
automatically includes the Cupertino and Widgets delegates as well,
simplifying localization setup.

### Guidance for package authors

If you maintain an open source package or plugin in the Flutter ecosystem,
migrating to `package:material_ui` or `package:cupertino_ui` introduces
a breaking change for consumers who haven't updated their dependencies.
While the symbols and class names remain the same,
they are technically referenced from an entirely new library.
Treat this migration as a major version bump for your package.

## References

Package documentation:

* [`package:material_ui`][]
* [`package:cupertino_ui`][]

Relevant issues:

* [Issue 191448][]

Relevant blog posts and announcements:

* [What's new in Flutter 3.47][]
* [Flutter's Material and Cupertino code freeze][]

[`flutter/packages`]: {{site.repo.packages}}
[Issue 191448]: {{site.repo.flutter}}/issues/191448
[`package:cupertino_ui`]: {{site.pub-pkg}}/cupertino_ui
[`package:material_ui`]: {{site.pub-pkg}}/material_ui
[Flutter's Material and Cupertino code freeze]: {{site.main-url}}/blog/flutters-material-and-cupertino-code-freeze
[What's new in Flutter 3.47]: {{site.main-url}}/blog/whats-new-in-flutter-3-47
