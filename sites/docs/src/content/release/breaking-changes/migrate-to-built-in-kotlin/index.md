---
title: Migrating Flutter Android projects to built-in Kotlin
description: >-
  Update your Flutter Android Gradle files to use built-in Kotlin support.
  Essential for migrating projects to Android Gradle Plugin 9.0.0+.
---

## Summary

To build a Flutter app for Android, the Android Gradle Plugin (AGP)
must be applied. As of AGP 9.0.0,
the following migrations are required to successfully use AGP 9.0.0+.

First, built-in Kotlin is the new default on AGP 9+, meaning any apps
using the `kotlin-android` plugin (also known as the Kotlin Gradle Plugin
or KGP) will not build successfully [Issue #181383][].
However, the Flutter team has added temporary support for the legacy
Kotlin Gradle Plugin (KGP) in AGP 9.0.0+ [Issue #183909][].
This allows app and plugin developers to safely build their projects
regardless of their migration state.

Second, AGP 9.0.0+ will only use the new AGP DSL interfaces.
This means any old DSL types will not be recognized.
The Flutter team is working on migrating old DSL types
to use the new DSL: [Issue #180137][].
In the meantime, the Flutter team has configured the AGP DSL to be compatible
with the legacy old AGP DSL types [Issue #184838][].
This ensures app and plugin developers can safely upgrade to AGP 9+.

To ensure compatibility, all apps and plugins must be manually migrated
from the legacy Kotlin Gradle Plugin (KGP) to built-in Kotlin.
In a future Flutter version, support for applying KGP will be removed
[Issue #184837][].

To learn more about Android Gradle Plugin,
see the [Android Gradle Plugin docs][AGP block].

[AGP block]: {{site.android-dev}}/build/releases/gradle-plugin

## Migrate

**For app developers:**
Follow the [app developer migration guide][app-migration-guide].

**For plugin authors:**
Follow the [plugin author migration guide][plugin-migration-guide].

[app-migration-guide]: /release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers
[plugin-migration-guide]: /release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors

## Next steps

- **Remove Support for KGP:** In a future version of Flutter,
  support for applying KGP will be removed [Issue #184837][]. Developers must
  migrate their projects (apps, plugins, host app projects) or they will be
  unable to build.

- **Remove DSL Gradle Property:** Once the Flutter team
  completes the migration to the new AGP DSL,
  the Flutter team will remove support for the old DSL [Issue #184839][].

## Timeline

Landed in version: 3.44.0-0.1.pre<br>
In stable release: 3.44

## References

Relevant issues:

- [Issue #180137][]: Migrate from old to new AGP DSL
- [Issue #181383][]: Flutter plugins should support AGP 9.0.0
- [Issue #183909][]: Add support for KGP in AGP+
- [Issue #184837][]: Remove support for KGP
- [Issue #184838][]: Disable new AGP DSL flag by default
- [Issue #184839][]: Remove support for old AGP DSL types

The Gradle build files in your app vary based on the Flutter version
used when your app was created.
Consider staying up to date with the latest version
of the build files by periodically running `flutter upgrade`
in your app's directory.

[Issue #180137]: {{site.repo.flutter}}/issues/180137
[Issue #181383]: {{site.repo.flutter}}/issues/181383
[Issue #183909]: {{site.repo.flutter}}/issues/183909
[Issue #184837]: {{site.repo.flutter}}/issues/184837
[Issue #184838]: {{site.repo.flutter}}/issues/184838
[Issue #184839]: {{site.repo.flutter}}/issues/184839
