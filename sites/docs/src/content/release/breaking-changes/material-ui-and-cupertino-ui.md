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
Starting in Flutter 3.47, developers could opt in to these packages ahead of
the formal deprecation of the in-framework design libraries in Flutter 3.50.

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

Contributions to Material and Cupertino packages inside the core SDK
were frozen starting in Flutter 3.44.
The initial 1.0.0 versions of `package:material_ui` and `package:cupertino_ui`
match the frozen framework code to provide a seamless transition.
Future releases of the packages will use semantic versioning for major, minor,
and patch updates.
The in-framework design libraries are formally deprecated in Flutter 3.50.

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

#### Resolve ambiguous imports

The `migrate_design_widgets` fix updates your design library imports,
but it doesn't remove or modify existing imports of
`package:flutter_localizations/flutter_localizations.dart`.
That library exports its own, now deprecated,
`GlobalMaterialLocalizations` and `GlobalCupertinoLocalizations` classes,
which conflict with the ones exported by `material_ui` and `cupertino_ui`.
Any file that imports both reports an `ambiguous_import` error
wherever those classes are referenced.

To fix the error, remove the `flutter_localizations` import from
files that no longer need it.
If a file still needs `GlobalWidgetsLocalizations`,
which is only available from `flutter_localizations`,
restrict the import to that class instead:

```dart
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart';
```

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
        // ignore: deprecated_member_use
        return MaterialUiCompatibilityBridge(child: child!);
      },
      home: const HomeScreen(),
    );
  }
}
```

:::note
`MaterialUiCompatibilityBridge` and `CupertinoUiCompatibilityBridge`
are temporary migration utilities and are annotated as deprecated,
so using them triggers a `deprecated_member_use` diagnostic.
This is expected.
Suppress the diagnostic with an `// ignore: deprecated_member_use` comment,
and remove the bridge once all of your dependencies have migrated
to the standalone packages.
:::

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

#### Localizations for CupertinoApp

If your app is built on `CupertinoApp` and only uses Cupertino widgets,
use `GlobalCupertinoLocalizations.delegates` from `package:cupertino_ui`,
which includes the Cupertino and Widgets delegates.

However, if your `CupertinoApp` also renders Material widgets from
`package:material_ui`, use `GlobalMaterialLocalizations.delegates` instead.
`GlobalCupertinoLocalizations.delegates` doesn't include a
`MaterialLocalizations` delegate, and unlike `MaterialApp`,
`CupertinoApp` doesn't add a default one.
Without it, Material widgets fail with a
"No MaterialLocalizations found" error.

```dart
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

// ...
CupertinoApp(
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  // ...
);
```

#### Apps that use gen-l10n

As of Flutter 3.50, the `flutter gen-l10n` tool hasn't yet been updated
for the standalone packages.
The generated `app_localizations.dart` file still imports
`package:flutter_localizations/flutter_localizations.dart` and
populates the generated `AppLocalizations.localizationsDelegates` list
with the deprecated delegates.
This has two consequences for a migrated app:

* The generated file triggers `deprecated_member_use` diagnostics
  during analysis.
* The deprecated delegates don't provide the `MaterialLocalizations` and
  `CupertinoLocalizations` types that `material_ui` and `cupertino_ui`
  widgets look up, so any locale other than English fails to resolve
  at runtime if you rely on `AppLocalizations.localizationsDelegates`.

Until the fix tracked in [Issue 191072][] and [PR 194500][] lands in a
stable release, work around both problems as follows:

1.  Instead of `AppLocalizations.localizationsDelegates`,
    build the delegate list from `AppLocalizations.delegate` and
    `GlobalMaterialLocalizations.delegates`:

    ```dart
    import 'package:material_ui/material_ui.dart';

    import 'l10n/app_localizations.dart';

    // ...
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // ...
    );
    ```

1.  Silence the deprecation diagnostics in the generated files by
    adding a `header` to your `l10n.yaml`:

    ```yaml title="l10n.yaml"
    header: '// ignore_for_file: deprecated_member_use'
    ```

    Remove this header once you upgrade to a Flutter release
    that includes the `gen-l10n` fix.

### Guidance for package authors

If you maintain an open source package or plugin in the Flutter ecosystem,
migrating to `package:material_ui` or `package:cupertino_ui` introduces
a breaking change for consumers who haven't updated their dependencies.
While the symbols and class names remain the same,
they are technically referenced from an entirely new library.
Treat this migration as a major version bump for your package.

## Timeline

Landed in version: 3.49.0-1.0.pre-295<br>
In stable release: 3.50

## References

Package documentation:

* [`package:material_ui`][]
* [`package:cupertino_ui`][]

Relevant issues:

* [Issue 191448][]
* [Issue 191072][]

Relevant PRs:

* [PR 192957][]
* [PR 194500][]

Relevant blog posts and announcements:

* [What's new in Flutter 3.47][]
* [Flutter's Material and Cupertino code freeze][]

Related changes in `package:material_ui`:

* [Added enabled to DropdownButtonFormField and made onChanged optional][]

[Added enabled to DropdownButtonFormField and made onChanged optional]: /release/breaking-changes/dropdownbuttonformfield-enabled-parameter
[`flutter/packages`]: {{site.repo.packages}}
[Issue 191448]: {{site.repo.flutter}}/issues/191448
[Issue 191072]: {{site.repo.flutter}}/issues/191072
[PR 192957]: {{site.repo.flutter}}/pull/192957
[PR 194500]: {{site.repo.flutter}}/pull/194500
[`package:cupertino_ui`]: {{site.pub-pkg}}/cupertino_ui
[`package:material_ui`]: {{site.pub-pkg}}/material_ui
[Flutter's Material and Cupertino code freeze]: {{site.main-url}}/blog/flutters-material-and-cupertino-code-freeze
[What's new in Flutter 3.47]: {{site.main-url}}/blog/whats-new-in-flutter-3-47
