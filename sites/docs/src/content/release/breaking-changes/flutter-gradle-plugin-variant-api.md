---
title: Flutter Gradle Plugin uses the Android Gradle Plugin Variant API
description: >-
  The Flutter Gradle Plugin now builds Android apps, modules, and plugins
  with only public Android Gradle Plugin APIs. Some build behaviors changed,
  and build scripts that use the legacy variant API should migrate now.
---

{% render "docs/breaking-changes.md" %}

## Summary

In Flutter 3.50, the Flutter Gradle Plugin (FGP) stopped using the
legacy Android Gradle Plugin (AGP) variant API
(`android.applicationVariants`, `android.libraryVariants`,
`variant.outputs`, and `versionCodeOverride`)
and AGP internals.
It now configures Android builds through AGP's public
[Variant API][] (`androidComponents.onVariants`) and the new DSL.

For most apps, nothing changes:
`flutter run`, `flutter build apk`, `flutter build appbundle`,
`flutter build aar`, and add-to-app builds produce the same outputs
at the same paths.
You're affected if your Gradle build script, a plugin, or a host app
does one of the following:

* Renames or copies APKs with `applicationVariants.all`.
* Sets a per-ABI or per-variant `versionCode` and uses
  `flutter build apk --split-per-abi`.
* Defines custom build types (such as `staging`) and uses plugins
  with native (C++/JNI) code.
* Looks up Flutter's Gradle tasks by name and type.
* Sets `flutter.hostAppProjectName` in an add-to-app module.
* Declares `android.publishing.singleVariant` in a module or plugin
  that's built with `flutter build aar`.

:::note
Flutter 3.50 still sets `android.newDsl=false` in `gradle.properties`
(new projects get it from the template,
existing projects get it from Flutter's migrator),
so **your own** build script code that uses the legacy variant API
keeps working in this release.
That opt-out goes away in a future Flutter release,
and AGP 10 removes the legacy APIs entirely.
Migrate your build scripts now while both APIs still work.
:::

[Variant API]: {{site.android-dev}}/build/extend-agp

## Context

AGP 9 deprecated the legacy DSL and variant APIs behind the
`android.newDsl=false` Gradle property,
and AGP 10 removes them together with access to AGP internals.
Flutter 3.44 started adding `android.newDsl=false` to projects
so that they would keep building on AGP 9,
as described in
[Migrating Flutter Android projects to built-in Kotlin][].

That opt-out only bought time.
To keep building Flutter apps on AGP 10 and later,
the FGP itself had to stop using the legacy APIs.
Flutter 3.50 completes that migration for the FGP's app, add-to-app,
and `flutter build aar` code paths.
Removing the `android.newDsl=false` opt-out from templates and
the migrator is the next step; it's tracked in [Issue 180137][].

Built-in Kotlin isn't affected by this change.
`android.builtInKotlin=false` is still added and still works.
To learn more, refer to
[Migrating Flutter Android projects to built-in Kotlin][].

[Migrating Flutter Android projects to built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin

## Description of change

### APKs are copied by a task

The FGP copies the APKs that AGP builds into
`build/app/outputs/flutter-apk/`.
Previously it did this in a `doLast` block on the variant's
`assemble` task.
Now a `copyFlutterApks<Variant>` task (for example, `copyFlutterApksRelease`)
does the copy, and `assemble<Variant>` depends on it.
The task reads AGP's `SingleArtifact.APK` artifact and
its `output-metadata.json` file.

The copied file names and paths are unchanged:
`app[-<abi>][-<flavor>]-<mode>.apk`.
The new task appears in `./gradlew tasks` output.

If a plugin or your build script transforms the APK artifact,
the transform must keep the metadata file and one APK per variant output
with the same ABI filter.
Otherwise the build fails with an error that names `SingleArtifact.APK`.
Build logic that only reads the APK, or that writes extra APKs
somewhere else after `assemble`, isn't affected.

### Per-ABI `versionCode` is set from the DSL

When you build with `flutter build apk --split-per-abi`,
Flutter gives each APK a distinct `versionCode`:
`abiOffset * 1000 + versionCode`, with offsets
1 for `armeabi-v7a`, 2 for `arm64-v8a`, and 4 for `x86_64`.

Previously Flutter set `versionCodeOverride` on each output
after the rest of the build script had run,
using the merged `versionCode` (including one from `AndroidManifest.xml`).
Now Flutter sets `output.versionCode` in its own `onVariants` callback,
using the `versionCode` declared in your `android {}` block
(`defaultConfig`, or the first product flavor in dimension order
that sets one).
Two consequences:

* A `versionCode` that's set only in `AndroidManifest.xml`
  is no longer offset.
  Flutter's templates set `versionCode = flutter.versionCode`
  in `defaultConfig`, so template-based apps aren't affected.
  If no DSL `versionCode` is found, Flutter prints a warning that
  Google Play won't accept the split APKs together.
* Because the FGP is applied in the `plugins {}` block,
  Flutter's callback runs **before** an `androidComponents.onVariants`
  block in your app's build script.
  If your block derives a value from `output.versionCode`,
  it now starts from Flutter's already-offset value.
  To learn how to adjust it, refer to
  [Setting a per-ABI or per-variant versionCode][versioncode-guide].

Flutter reads the DSL `versionCode` in its own `finalizeDsl` callback,
so a value that your build script changes in a later `finalizeDsl`
callback isn't seen.
`-P force-version-code-ignoring-abi=true` still disables the offset.

### Custom build types are copied to plugins with `initWith`

The FGP copies your app's custom build types
(for example, `staging`) onto each Flutter plugin project
so that Gradle can resolve them.
Previously the plugin received the app's live build type object;
now it receives an `initWith` copy made through the public DSL.
`matchingFallbacks` is copied.

The public API has no way to mark a library build type as debuggable.
As a result, a plugin's `BuildConfig.DEBUG` and its native (C++/JNI) code
can compile in release mode for a custom build type
that your app treats as debuggable.
Variant matching still works, but native debugging of plugin code
in custom build types doesn't.

### Flutter assets are a generated source directory

Flutter's `flutter_assets` directory is now added to each variant as a
generated assets source directory.
Previously it was copied over the merged assets after AGP's merge step.
If your app ships its own Android asset at the same path
(for example, `src/main/assets/flutter_assets/...`),
AGP's source-set priority decides which one wins
instead of Flutter always winning.

### Flutter tasks are registered lazily

Flutter's Gradle tasks are now registered as lazy `TaskProvider`s
inside `onVariants`, and the `copyFlutterAssets<Variant>` tasks
are a Flutter task type (`CopyFlutterAssetsTask`)
instead of `org.gradle.api.tasks.Copy`.
Build scripts that look up Flutter tasks eagerly, or with a type,
fail. To learn how to update them, refer to
[Looking up Flutter tasks](#looking-up-flutter-tasks).

### Add-to-app modules

A Flutter module (`flutter create --template=module`)
now configures its Flutter tasks in its own `onVariants` callback
and adds its assets and native libraries to each of its library variants.
Your host app consumes them like any other Android library.
Flutter no longer looks up or configures the host `:app` project.

* `flutter.hostAppProjectName` in `gradle.properties` has no effect.
  If it's set, Flutter logs a warning when the host app builds
  from Gradle or Android Studio. Remove it.
* The Flutter build mode comes from the module variant your host consumes:
  the module's `debug` variant builds debug Flutter artifacts,
  `profile` builds profile, and `release` builds release.
  Host `debug`, `profile`, and `release` build types consume the module
  variant of the same name.
  For a custom host build type, AGP picks the module variant through
  the build type's `matchingFallbacks`.
  Previously the Flutter build mode followed the host build type's
  debuggable flag, which could disagree with the module variant that
  AGP consumed and produce an APK without Flutter assets.
  Now the two always agree, so list the module build type you want
  first in `matchingFallbacks`.
* Every module variant is configured regardless of which task you run,
  because `matchingFallbacks`, not the task name,
  decides which module variant a host task consumes.
  Registration is lazy, so only the consumed variant builds.

### `flutter build aar`

`flutter build aar` publishes one variant for each requested build mode
(named from `--flavor` and the mode, for example `demoRelease`)
from the module and from each Android plugin it uses.

* If a module's or plugin's build file declares
  `android.publishing.singleVariant(...)` for a variant,
  Flutter keeps that declaration and adds publishing
  (with sources and javadoc jars) for the other variants.
* The requested variant must exist in the module and in every plugin.
  If a plugin doesn't declare it, the build fails.
  Pass `--flavor` to build a variant that all of them declare.

### Other changes

* The warning that a plugin's `compileSdk` is newer than the app's
  now compares versions numerically, including preview versions,
  instead of comparing strings.
* Flutter's dependency version checks run before the FGP reads any
  Android DSL or registers tasks, so an unsupported Gradle, Java, AGP,
  or Kotlin version reports a clear message instead of an API error.
  To learn more, refer to
  [Raised minimum Android build tool versions][].

[Raised minimum Android build tool versions]: /release/breaking-changes/android-build-tool-minimum-versions
[versioncode-guide]: #setting-a-per-abi-or-per-variant-versioncode

## Migration guide

The examples use the Kotlin DSL (`build.gradle.kts`),
which Flutter's templates use.
The same `androidComponents` block works in Groovy (`build.gradle`);
refer to Kotlin `object`s such as `SingleArtifact.APK`
as `SingleArtifact.APK.INSTANCE` there.

### Renaming or copying APKs

Before (legacy variant API):

```groovy title="<flutter-project>/android/app/build.gradle"
android {
    applicationVariants.all { variant ->
        variant.outputs.all { output ->
            outputFileName = "myapp-${variant.versionName}.apk"
        }
    }
}
```

The Variant API doesn't expose `outputFileName`.
Instead, copy the built APKs with a task that reads the APK artifact.
`androidComponents` is a top-level block, next to `android {}`:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.artifact.SingleArtifact

androidComponents {
    onVariants(selector().all()) { variant ->
        val variantName = variant.name.replaceFirstChar { it.uppercase() }
        val copyApks = tasks.register<Copy>("copy${variantName}RenamedApks") {
            from(variant.artifacts.get(SingleArtifact.APK))
            include("*.apk")
            into(layout.buildDirectory.dir("renamed-apk/${variant.name}"))
            rename { it.replace("app-", "myapp-") }
        }
        tasks.matching { it.name == "assemble$variantName" }.configureEach {
            dependsOn(copyApks)
        }
    }
}
```

Flutter's own copy still places the APKs at
`build/app/outputs/flutter-apk/app[-<abi>][-<flavor>]-<mode>.apk`,
so `flutter build apk` output and tooling that reads it are unchanged.

### Setting a per-ABI or per-variant `versionCode`

Before (legacy variant API):

```groovy title="<flutter-project>/android/app/build.gradle"
android.applicationVariants.all { variant ->
    variant.outputs.each { output ->
        def abi = output.getFilter(OutputFile.ABI)
        output.versionCodeOverride = abiCodes.get(abi) * 1000 + variant.versionCode
    }
}
```

After:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.variant.FilterConfiguration

val abiCodes = mapOf("armeabi-v7a" to 1, "arm64-v8a" to 2, "x86_64" to 4)

androidComponents {
    onVariants(selector().all()) { variant ->
        variant.outputs.forEach { output ->
            val abi = output.filters
                .find { it.filterType == FilterConfiguration.FilterType.ABI }
                ?.identifier
            output.versionCode.set((abiCodes[abi] ?: 0) * 1000 + flutter.versionCode)
        }
    }
}
```

Compute the value from a base you already know,
such as `flutter.versionCode` (the value Flutter's templates put in
`defaultConfig`) or your product flavor's `versionCode`,
rather than by reading `output.versionCode`.
AGP disallows reading `output.versionCode` during configuration
when its compatibility mode (`android.compatibility.enableLegacyApi`)
is off, which is the direction AGP is heading.

If your block previously multiplied Flutter's offset value,
the resulting `versionCode`s change.
For example, an app that multiplies by 10000 and builds with
`--build-number 42` gets these values:

| ABI (offset) | Before: `offset * 1000 + 42 * 10000` | After: `(offset * 1000 + 42) * 10000` |
| :--- | :--- | :--- |
| `armeabi-v7a` (1) | 421000 | 10420000 |
| `arm64-v8a` (2) | 422000 | 20420000 |
| `x86_64` (4) | 424000 | 40420000 |

The new values are still distinct, keep the same order, and only go up,
so Google Play accepts them as upgrades.
Going back to an older Flutter release would make them go down.
To keep producing the "before" numbers,
compute them from your own base instead of from `output.versionCode`:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
output.versionCode.set((abiCodes[abi] ?: 0) * 1000 + flutter.versionCode * 10000)
```

To verify, inspect a built APK:

```console
$ apkanalyzer manifest version-code build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

### Custom build types

If your app defines a custom build type, set `matchingFallbacks` on it
so that plugins and other Android libraries that don't define it
can resolve.
The first entry that the library defines wins:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
android {
    buildTypes {
        create("staging") {
            initWith(getByName("debug"))
            matchingFallbacks += listOf("debug", "release")
        }
    }
}
```

If you debug a plugin's native code in a custom build type,
use the `debug` build type for that work instead,
because library build types can't be marked debuggable
through the public API.

### Looking up Flutter tasks

Look up Flutter tasks lazily and without a type:

```kotlin diff title="<flutter-project>/android/app/build.gradle.kts"
- tasks.named("copyFlutterAssetsDebug", Copy::class) { ... }
+ tasks.named("copyFlutterAssetsDebug") { ... }
```

Don't assume a Flutter task exists at configuration time.
If you need Flutter's outputs, prefer wiring through
Variant API artifacts (for example, `SingleArtifact.APK` or
`variant.sources.assets`) over depending on task names.

### Add-to-app host apps

1. Remove `flutter.hostAppProjectName` from the module's
   `.android/gradle.properties` and from your host app's
   `gradle.properties` if you set it. It has no effect.
1. If your host app has a custom build type,
   list the Flutter module build type you want in `matchingFallbacks`
   first. For example, to get debug Flutter artifacts in a `staging` host
   build:

   ```kotlin title="<host-app>/app/build.gradle.kts"
   android {
       buildTypes {
           create("staging") {
               initWith(getByName("debug"))
               matchingFallbacks += listOf("debug", "release")
           }
       }
   }
   ```

1. If your host build script configures the module's
   `copyFlutterAssets<Variant>` tasks with the `Copy` type,
   update it as described in
   [Looking up Flutter tasks](#looking-up-flutter-tasks).

### Flutter plugin authors

* Don't read `android.applicationVariants` or `android.libraryVariants`
  in your plugin's `build.gradle(.kts)`; use `androidComponents.onVariants`.
  The Flutter team is auditing popular plugins for this usage in
  [Issue 190845][].
* Don't assume Flutter's tasks exist at configuration time or
  have a particular type.
* If your plugin's example app has a custom build type,
  set `matchingFallbacks` on it.
* Test your plugin's example app with AGP 9.1.1 or later with
  `android.newDsl=true` and `android.builtInKotlin=true` in
  `gradle.properties` (the new DSL requires built-in Kotlin,
  because KGP rejects it),
  so that it keeps working when Flutter removes the opt-outs.

### Keep the opt-out, or opt in early

If you can't migrate your build scripts yet,
you don't need to do anything in Flutter 3.50:
`android.newDsl=false` is still present.
If the `android.newDsl` line is missing from
`android/gradle.properties`, Flutter's migrator adds it back
(set to `false`) on the next build.
Treat it as a short-term unblock:
AGP 10 removes the legacy APIs, and the opt-out stops working with it.

To verify your migrated build scripts against the new DSL now,
set both properties to `true` by hand
(the migrator never changes an existing line):

```properties title="<flutter-project>/android/gradle.properties"
android.newDsl=true
android.builtInKotlin=true
```

The new DSL requires built-in Kotlin, because KGP rejects
`android.newDsl=true`.
If a plugin you use still needs KGP, keep both set to `false`.

## Timeline

Landed in version: 3.50.0-0.1.pre<br>
In stable release: 3.50

## References

Relevant issues:

* [Issue 166550][]: Migrate the Flutter Gradle Plugin to the Variant API
* [Issue 180137][]: Migrate from the old to the new AGP DSL
* [Issue 190845][]: Audit plugins for legacy variant API usage
* [Issue 193713][]: Publish this guide

Relevant pull requests:

* [PR 190957][]: Extract internal utilities
* [PR 191218][]: Add `buildModeFor` overloads and
  wire Flutter dependencies through the new DSL
* [PR 191606][]: Replace plugin build-type copy with `initWith`
  on the public DSL
* [PR 192116][]: Delete `getLegacyAndroidExtension` and
  migrate the NDK fallback to the public DSL
* [PR 192488][]: Deliver Flutter assets as a generated assets
  source directory
* [PR 193693][]: Migrate the `flutter-apk` copy and
  per-ABI `versionCode` to the Variant API
* [PR 193717][]: Unify add-to-app module wiring on the Variant API
* [PR 195640][]: Move `aar_init_script` to public AGP APIs

Contributor documentation:

* [Migrating the Flutter Gradle Plugin to the AGP public API surface][]

[Issue 166550]: {{site.repo.flutter}}/issues/166550
[Issue 180137]: {{site.repo.flutter}}/issues/180137
[Issue 190845]: {{site.repo.flutter}}/issues/190845
[Issue 193713]: {{site.repo.flutter}}/issues/193713
[PR 190957]: {{site.repo.flutter}}/pull/190957
[PR 191218]: {{site.repo.flutter}}/pull/191218
[PR 191606]: {{site.repo.flutter}}/pull/191606
[PR 192116]: {{site.repo.flutter}}/pull/192116
[PR 192488]: {{site.repo.flutter}}/pull/192488
[PR 193693]: {{site.repo.flutter}}/pull/193693
[PR 193717]: {{site.repo.flutter}}/pull/193717
[PR 195640]: {{site.repo.flutter}}/pull/195640
[Migrating the Flutter Gradle Plugin to the AGP public API surface]: {{site.repo.flutter}}/blob/master/docs/platforms/android/Migrating-Flutter-Gradle-Plugin-to-AGP-public-API.md
