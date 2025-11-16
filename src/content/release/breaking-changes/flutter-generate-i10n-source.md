---
title: Localized messages are generated into source, not a synthetic package.
description: >-
  When using `package:flutter_localizations`, the default generated location
  (and eventually, only possible location) is within your source (`lib/`)
  directory, and not the synthetic package `package:flutter_gen`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `flutter` tool will no longer generate a synthetic `package:flutter_gen`
or modify the `package_config.json` of the app.

Applications or tools that referenced `package:flutter_gen` should instead
reference source files generated into the app's source directory directly.

In addition, the property `generate: true` is now required when using generated
l10n source.

## Background

`flutter_gen` is a virtual (synthetic) package that is
created by the `flutter` command-line tool to allow developers to
import that package to access generated symbols and functionality,
such as for [internationalization][].
As the package isn't listed in an app's `pubspec.yaml`, and
is created via re-writing the generated `package_config.json` file,
many problems have been created.

## Migration guide

This change only affects apps that have the
following entry in their `pubspec.yaml`:

```yaml
flutter:
  generate: true
```

If your app previously used `gen-l10n` without this property, it is now
required.

A synthetic package (`package:flutter_gen`) is
created and referenced by the app:

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

 1. Specify `synthetic-package: false` in the accompanying [`l10n.yaml`][] file:

    ```yaml title="l10n.yaml"
    synthetic-package: false

    # The files are generated into the path specified by `arb-dir`
    arb-dir: lib/i18n

    # Or, specifically provide an output path:
    output-dir: lib/src/generated/i18n
    ```

 2. Enable the `explicit-package-dependencies` feature flag:

    ```sh
    flutter config --explicit-package-dependencies
    ```

## Timeline

Landed in version: 3.28.0-0.0.pre<br>
Stable release: 3.32.0

**In the next stable release after this change lands,
`package:flutter_gen` support will be removed.**

## References

Relevant Issues:

- [Issue 73870][], where `package:flutter_gen` pub problems are first found.
- [Issue 102983][], where `package:flutter_gen` problems are outlined.
- [Issue 157819][], where `--implicit-pubspec-resolution` is discussed.

Relevant Articles:

- [Internationalizing Flutter apps][internationalization],
  the canonical documentation for the feature.

[`l10n.yaml`]: /ui/internationalization#configuring-the-l10n-yaml-file
[Issue 73870]: {{site.repo.flutter}}/issues/73870
[Issue 102983]: {{site.repo.flutter}}/issues/102983
[Issue 157819]: {{site.repo.flutter}}/issues/157819
[internationalization]: /ui/internationalization#adding-your-own-localized-messages
