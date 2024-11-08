---
title: Localized messages are generated into source, not a synthetic package.
description: >-
  When using `package:flutter_localizations`, the default generated location
  (and eventually, only possible location) is within your source (`lib/`)
  directory, and not the synthetic package `package:flutter_gen`.
---

## Summary

The `flutter` tool will no longer generate a synthetic `package:flutter_gen`
or modify the `package_config.json` of the application. Applications or tools
that previously referenced `package:flutter_gen` will instead reference source
files generated into the application directly.

## Background

`flutter_gen` is a virtual (synthetic) package that is created by the `flutter`
command-line tool to allow developers to import that package to access generated
symbols and functionality, such as for
[internationalization][Internationalizing Flutter apps]. As the package is not
listed in an app's `pubspec.yaml`, and is created via re-writing the (generated)
`package_config.json`, numerous problems have been created.

## Migration Guide

This change only effects users that have the following in their `pubspec.yaml`:

```yaml
flutter:
  generate: true
```

A synthetic package (`package:flutter_gen`) is created and referenced by the
application:

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ...
const MaterialApp(
  title: 'Localizations Sample App',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
);
```

There are two ways to migrate away from importing `package:flutter_gen`:

1. Specify `synthetic-package: false` in the accompanying [l10n.yaml][] file:

    ```yaml
    synthetic-package: false

    # The files are generated into the path specified by `arb-dir`
    arb-dir: lib/i18n

    # Or, specifically provide an output path:
    output-dir: lib/src/generated/i18n
    ```

2. Pass `--no-implicit-pubspec-resolution` to invocations of the `flutter` tool:

    ```sh
    flutter run --no-implicit-pubspec-resolution
    ```

## Timeline

Not released

Not released + 1, `package:flutter_gen` support will be removed.

## References

Relevant Issues:

- [Issue 73870][], where `package:flutter_gen` pub problems are first found.
- [Issue 102983][], where `package:flutter_gen` problems are outlined.
- [Issue 157819][], where `--implicit-pubspec-resolution` is discussed.

Relevant Articles:

- [Internationalizing Flutter apps][], the canonical documentation for the
  feature.

[l10n.yaml]: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#configuring-the-l10n-yaml-file
[Issue 73870]: https://github.com/flutter/flutter/issues/73870
[Issue 102983]: https://github.com/flutter/flutter/issues/102983
[Issue 157819]: https://github.com/flutter/flutter/issues/157819
[Internationalizing Flutter apps]: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#adding-your-own-localized-messages
