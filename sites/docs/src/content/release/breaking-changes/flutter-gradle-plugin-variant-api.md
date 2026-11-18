---
title: Flutter Gradle Plugin uses the Android Gradle Plugin Variant API
description: >-
  The Flutter Gradle Plugin configures Android builds with public
  Android Gradle Plugin APIs.
  Learn whether your Flutter 3.50 Android build needs updates.
---

{% render "docs/breaking-changes.md" %}

## Summary

Android Gradle Plugin (AGP) 9 deprecated its legacy variant APIs,
and the [AGP migration timeline][] schedules their removal for AGP 10.
To prepare, the Flutter Gradle Plugin (FGP) in Flutter 3.50 uses AGP's public
[Variant API][] (`androidComponents.onVariants`).
FGP no longer calls `android.applicationVariants`, `android.libraryVariants`,
`variant.outputs`, or `versionCodeOverride`.

You don't need to edit your Gradle scripts in Flutter 3.50.1 or later
if your project meets all of the following conditions:

- Uses standard `flutter run`, `flutter build apk`,
  `flutter build appbundle`, `flutter build aar`, or add-to-app builds.
  These builds produce the same outputs at the same file paths.
- Sets `versionCode = flutter.versionCode` in `defaultConfig`
  (the Flutter template default),
  or sets a positive decimal integer `android:versionCode` in
  `src/main/AndroidManifest.xml`.
- Doesn't read or customize `versionCode` in `onVariants` or
  `applicationVariants`, hook into Flutter's Gradle tasks or
  `merge<Variant>Assets/` paths, or use custom add-to-app settings.

AGP still exposes `android.applicationVariants` in Flutter 3.50 while
`android.newDsl=false` is the default.
However, FGP's `onVariants` callback runs before `applicationVariants`,
so `--split-per-abi` scripts reading `variant.versionCode` or
`output.versionCode` are affected immediately.
In those scripts, `variant.versionCode` returns the already-offset first split
(inflating `versionCodeOverride` formulas) or fails at configuration on
manifest-only apps.
Refer to [Customize version codes in Gradle build scripts][vc-custom] or
[Opt in to the new AGP DSL early][opt-in].

:::important Use Flutter 3.50.1 or later
Upgrade directly to Flutter 3.50.1 or later when adopting Flutter 3.50.
Flutter 3.50.1 fixes three Android regressions from 3.50.0 and enforces
valid version codes for split APKs:

- **Plugin build-type errors fixed:**
  In 3.50.0, apps with plugins failed when `profile` or a custom build type set
  certain properties ([Issue 196412][], [Issue 196696][]).
  Affected properties were `applicationIdSuffix`, `isShrinkResources`,
  `buildConfigField`, and `resValue`.
  Gradle reported errors such as
  `Library projects cannot set applicationIdSuffix` and
  `Resource shrinker cannot be used for libraries`.
- **Manifest version codes fixed:**
  In 3.50.0, `flutter build apk --split-per-abi` skipped per-ABI
  `versionCode` offsets when `android:versionCode` was set only in
  `src/main/AndroidManifest.xml` ([Issue 196559][]).
- **Hidden-file assets fixed:**
  In 3.50.0, Android builds omitted assets with dot-prefixed filenames
  (such as `.env`) or underscore-prefixed directory names ([Issue 196444][]).
- **Invalid split-APK version codes fail:**
  In 3.50.1 and later, `--split-per-abi` fails when `android {}` sets no
  `versionCode` and `src/main/AndroidManifest.xml` lacks a positive decimal
  `android:versionCode`, including with
  `-P force-version-code-ignoring-abi=true`.
  Without that property, builds also fail when `abiOffset * 1000 + versionCode`
  overflows `Int`.
  Earlier releases built APKs with no `versionCode`,
  which Android reads as `0`.
  Google Play rejects those APKs, and updating a versioned build fails with
  `INSTALL_FAILED_VERSION_DOWNGRADE`.
  Set `versionCode = flutter.versionCode` in `defaultConfig`
  (refer to [Fix split-per-ABI version code errors][vc-split]).
:::

Use the following table to find the migration section for your role,
build pattern, or Gradle error:

| Role | Symptom, build pattern, or error | Migration section |
| :--- | :--- | :--- |
| App developer | Computes custom `versionCode` values in `onVariants`, `applicationVariants`, or `versionCodeOverride` | [Customize version codes in Gradle build scripts][vc-custom] |
| App developer | Hits `Querying the mapped value ... resolveManifestVersionCode<Variant>` or `CircularEvaluationException` on `versionCode` | [Customize version codes in Gradle build scripts][vc-custom] |
| App developer | Fails `--split-per-abi` with `Flutter cannot give ... variant '<name>' a versionCode` or `Circular dependency ... resolveManifestVersionCode<Variant>` (with or without `-P force-version-code-ignoring-abi=true`) | [Fix split-per-ABI version code errors][vc-split] |
| App developer | Sets `outputFileName`, copies APKs, or fails naming `SingleArtifact.APK` | [Rename, copy, or transform APK outputs][apk-outputs] |
| App developer | Hits `UnknownTaskException` or `ClassCastException` on `copyFlutterAssets<Variant>`, or reads `merge<Variant>Assets/` | [Configure Flutter Gradle tasks in build scripts][flutter-tasks] |
| App developer | Enables `android.newDsl=true` to test without legacy AGP APIs | [Opt in to the new AGP DSL early][opt-in] |
| Add-to-app or AAR | Logs a `flutter.hostAppProjectName` warning, uses custom host build types, or runs `flutter build aar --flavor` | [Update add-to-app projects and AAR builds][add-to-app] |
| Plugin author | Calls `android.libraryVariants`, `android.applicationVariants`, or Flutter's tasks in a plugin | [Migrate Android plugins][plugins] |

## Migration guide

The following examples use the Kotlin DSL (`build.gradle.kts`),
which Flutter's project templates generate.
The same `androidComponents` API works in Groovy (`build.gradle`).
In Groovy, append `.INSTANCE` to Kotlin `object` references
such as `SingleArtifact.APK.INSTANCE`.

### Customize version codes in Gradle build scripts

With `flutter build apk --split-per-abi`, Flutter sets each ABI output's
`versionCode` to `abiOffset * 1000 + versionCode`
(`1` for `armeabi-v7a`, `2` for `arm64-v8a`, and `4` for `x86_64`).
If that default numbering fits your app,
you don't need a custom `versionCode` block.
When you apply FGP in `plugins {}`, Flutter's `androidComponents.onVariants`
callback runs before both your app's `onVariants` block and legacy
`android.applicationVariants` callbacks.
By the time your build script runs, `output.versionCode` and legacy
`variant.versionCode` already include the per-ABI offset.

Compute custom `versionCode` values from a base input you control,
such as `flutter.versionCode`, a product flavor's `versionCode`,
or your own Gradle `Provider`.
Don't read or map `output.versionCode` or legacy `variant.versionCode`:

- On manifest-only `--split-per-abi` builds, calling `output.versionCode.get()`,
  `output.versionCode.orNull`, or legacy `variant.versionCode` or
  `output.versionCode` fails at configuration with
  `Querying the mapped value ... resolveManifestVersionCode<Variant>`.
- Calling `output.versionCode.set(output.versionCode.map { ... })` fails with
  Gradle's `CircularEvaluationException`.
- Disabling `android.compatibility.enableLegacyApi` also blocks
  configuration-time reads of `output.versionCode` when `defaultConfig` sets
  `versionCode`.

Code before migration:

```groovy title="<flutter-project>/android/app/build.gradle"
def abiCodes = ['armeabi-v7a': 1, 'arm64-v8a': 2, 'x86_64': 4]

android.applicationVariants.all { variant ->
    variant.outputs.each { output ->
        def abiOffset = abiCodes.get(output.getFilter(OutputFile.ABI))
        if (abiOffset != null) {
            output.versionCodeOverride = abiOffset * 1000 + variant.versionCode * 10000
        }
    }
}
```

Code after migration
(add the `import` at the top of `build.gradle.kts`,
and place `androidComponents {}` next to `android {}`):

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.variant.FilterConfiguration

val abiCodes = mapOf("armeabi-v7a" to 1, "arm64-v8a" to 2, "x86_64" to 4)

android {
    defaultConfig {
        // Set a DSL versionCode so manifest resolution isn't needed.
        versionCode = flutter.versionCode
    }
}

androidComponents {
    onVariants(selector().all()) { variant ->
        variant.outputs.forEach { output ->
            // Read the ABI filter from AGP's public Variant API.
            val abi = output.filters
                .find { it.filterType == FilterConfiguration.FilterType.ABI }
                ?.identifier
            // Skip non-split builds and universal APK outputs (abi == null).
            val abiOffset = abiCodes[abi] ?: return@forEach
            // Compute from flutter.versionCode instead of output.versionCode.
            output.versionCode.set(abiOffset * 1000 + flutter.versionCode * 10000)
        }
    }
}
```

Reading `variant.versionCode` in an unmigrated `applicationVariants` block
or reading `output.versionCode` in `onVariants` starts from Flutter's
already-offset value (`1042` on `armeabi-v7a` for `--build-number 42`).
The following table compares the resulting `versionCode` values for
`--build-number 42`:

| ABI (`abiOffset`) | `flutter.versionCode`: `abiOffset * 1000 + 42 * 10000` | Unmigrated `variant.versionCode`: `abiOffset * 1000 + 1042 * 10000` | `onVariants` scaling `output.versionCode`: `(abiOffset * 1000 + 42) * 10000` |
| :--- | :--- | :--- | :--- |
| `armeabi-v7a` (1) | 421000 | 10421000 | 10420000 |
| `arm64-v8a` (2) | 422000 | 10422000 | 20420000 |
| `x86_64` (4) | 424000 | 10424000 | 40420000 |

Google Play accepts the larger numbers as upgrades because they remain distinct
and increase monotonically.
However, reverting to `422000`-style values later lowers `versionCode`,
which Google Play rejects.
Verify the final `versionCode` in a built APK with `apkanalyzer` before
publishing:

```bash
apkanalyzer manifest version-code build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

### Fix split-per-ABI version code errors

You need no changes here if `defaultConfig` sets
`versionCode = flutter.versionCode`, or if `src/main/AndroidManifest.xml` sets
a positive decimal integer `android:versionCode` ([Issue 196559][]).
Non-split APKs, `flutter build appbundle`, and `flutter run` are also
unaffected.
If you set `android:versionCode` only in `src/main/AndroidManifest.xml`,
`--build-number` has no effect because that flag updates `flutter.versionCode`
only.

When `android {}` omits `versionCode`, Flutter matches AGP and reads
`android:versionCode` only from the main manifest
(`src/main/AndroidManifest.xml` by default).
Build-type, product-flavor, and generated overlay manifests aren't read.
In Flutter 3.50.1 and later, `--split-per-abi` (or `-Psplit-per-abi=true`)
fails when `android {}` omits `versionCode` and the main manifest lacks a
positive decimal `android:versionCode`.
This check runs both by default and with
`-P force-version-code-ignoring-abi=true`:

```plaintext noHighlight
Flutter cannot give the split APKs of variant 'release' a versionCode: its
android {} block sets no versionCode, and
<flutter-project>/android/app/src/main/AndroidManifest.xml does not set
android:versionCode. Android reads an APK without a versionCode as versionCode
0. Google Play rejects such APKs, and they cannot be installed over a build of
the app that has a versionCode. Set versionCode = flutter.versionCode in
defaultConfig (or on each product flavor).
```

Common triggers include omitting `versionCode` everywhere, setting a value
`<= 0`, or using `${vc}` placeholders, `@integer/...` resources, or `0x...` hex
literals.
Without `-P force-version-code-ignoring-abi=true`, builds also fail if
`abiOffset * 1000 + versionCode` exceeds `2,147,483,647`
(the highest base `versionCode` across all three ABIs is `2,147,479,647`).
To fix missing, non-positive, or non-decimal manifest values, set
`versionCode = flutter.versionCode` in `defaultConfig` (or per flavor) and
remove `android:versionCode` from `AndroidManifest.xml`.
To share an existing positive `versionCode` across split APKs outside Google
Play, refer to [Keep a single version code across split APKs][vc-single].

Code before migration:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
android {
    defaultConfig {
        // Omitted versionCode, or relied on a ${vc} manifest placeholder.
        versionName = flutter.versionName
    }
}
```

Code after migration:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
android {
    defaultConfig {
        // Set a base versionCode so Flutter offsets each ABI APK.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
}
```

If a task registered with `variant.sources.manifests.addGeneratedManifestFile`
also reads `output.versionCode` as an input, manifest-only `--split-per-abi`
builds fail with
`Circular dependency between ... resolveManifestVersionCode<Variant>`.
This cycle occurs with or without `-P force-version-code-ignoring-abi=true`.
Set `versionCode = flutter.versionCode` in `defaultConfig` so Flutter uses the
DSL value without registering `resolveManifestVersionCode<Variant>`.

#### Keep a single version code across split APKs

:::caution Google Play and missing version codes
Enabling `force-version-code-ignoring-abi=true` gives every split APK the same
`versionCode`, which Google Play rejects when multiple APKs share a release.
Use this property only outside Google Play when `android {}` or
`src/main/AndroidManifest.xml` already sets a positive decimal integer
`versionCode`.
Passing this property doesn't bypass the manifest check when `android {}`
omits `versionCode`.
If `src/main/AndroidManifest.xml` omits `android:versionCode` or sets `<= 0`,
`${vc}`, `@integer/...`, or `0x...`, the build fails with the
`resolveManifestVersionCode<Variant>` error.
Earlier releases built APKs with no `versionCode`, which Android reads as `0`.
Google Play rejects those APKs,
and updating a versioned build fails with `INSTALL_FAILED_VERSION_DOWNGRADE`.
:::

To skip per-ABI `versionCode` offsets across split APKs,
set the `force-version-code-ignoring-abi=true` Gradle project property:

- **Command line:** Pass `-P force-version-code-ignoring-abi=true`:

  ```bash
  flutter build apk --split-per-abi -P force-version-code-ignoring-abi=true
  ```

- **Project configuration:** Add the property to `android/gradle.properties`:

  ```properties title="<flutter-project>/android/gradle.properties"
  # Keep a single versionCode across --split-per-abi outputs.
  force-version-code-ignoring-abi=true
  ```

### Rename, copy, or transform APK outputs

AGP's public Variant API doesn't expose `outputFileName` on variant outputs.
In legacy `applicationVariants` blocks, reading `variant.versionCode` or
`output.versionCode` during `--split-per-abi` builds also returns an
already-offset split or fails on manifest-only apps.
To produce renamed copies of your APKs,
register a `Copy` task that reads `SingleArtifact.APK`
(in Groovy `build.gradle`, use `SingleArtifact.APK.INSTANCE`).

Code before migration:

```groovy title="<flutter-project>/android/app/build.gradle"
android {
    applicationVariants.all { variant ->
        variant.outputs.all { output ->
            outputFileName = outputFileName.replace("app-", "myapp-${variant.versionName}-")
        }
    }
}
```

Code after migration
(add the `import` at the top of `android/app/build.gradle.kts`,
and place `androidComponents {}` next to `android {}`):

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.artifact.SingleArtifact

androidComponents {
    onVariants(selector().all()) { variant ->
        val variantName = variant.name.replaceFirstChar { it.uppercase() }
        val copyApks = tasks.register<Copy>("copy${variantName}RenamedApks") {
            // Read the built APK directory from AGP's Variant API.
            from(variant.artifacts.get(SingleArtifact.APK))
            include("*.apk")
            into(layout.buildDirectory.dir("renamed-apk/${variant.name}"))
            rename { it.replace("app-", "myapp-${flutter.versionName}-") }
        }
        // Run the copy task whenever this variant is assembled.
        tasks.matching { it.name == "assemble$variantName" }.configureEach {
            dependsOn(copyApks)
        }
    }
}
```

Flutter still writes standard APKs to `build/app/outputs/flutter-apk/` with
unchanged filenames (such as `app-release.apk` or
`app-arm64-v8a-release.apk`),
so `flutter build apk` and scripts reading that directory keep working.

If a plugin or custom task transforms `SingleArtifact.APK` in place,
preserve `output-metadata.json` and emit one APK per variant output with the
matching ABI filter.
Otherwise, Gradle fails the build with an error naming `SingleArtifact.APK`.

### Configure Flutter Gradle tasks in build scripts

FGP registers tasks such as `copyFlutterAssets<Variant>` lazily inside
`androidComponents.onVariants`, after Gradle evaluates the top level of your
build script.
Those tasks use `CopyFlutterAssetsTask` instead of `org.gradle.api.tasks.Copy`.
When a single `assemble<Variant>` task runs in an app project,
Flutter registers tasks only for the requested variant,
so `tasks.named(...)` throws `UnknownTaskException` even inside `onVariants`.

Configure Flutter's tasks lazily by name with `tasks.matching`,
and remove any cast to `Copy`.

Code before migration:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
tasks.named("copyFlutterAssetsDebug", Copy::class) {
    // Custom task configuration.
}
```

Code after migration:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
// Match lazily without casting CopyFlutterAssetsTask to Copy.
tasks.matching { it.name == "copyFlutterAssetsDebug" }.configureEach {
    // Custom task configuration.
}
```

#### Read merged assets from Variant API artifacts

In Flutter 3.50.1 and later, `CopyFlutterAssetsTask` transforms
`SingleArtifact.ASSETS` after AGP merges Android assets ([Issue 196444][]).
As a result, `merge<Variant>Assets/` under `build/app/intermediates/` no longer
contains `flutter_assets/`.
Wire custom tasks to `SingleArtifact.ASSETS`
(or `SingleArtifact.ASSETS.INSTANCE` in Groovy),
or read packaged assets from the built APK or AAB.

Code before migration:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
tasks.register("inspectDebugAssets") {
    inputs.dir(layout.buildDirectory.dir("intermediates/assets/debug/mergeDebugAssets"))
}
```

Code after migration:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.artifact.SingleArtifact

androidComponents {
    onVariants(selector().withName("debug")) { variant ->
        tasks.register("inspectDebugAssets") {
            // Includes both merged Android assets and flutter_assets/.
            inputs.dir(variant.artifacts.get(SingleArtifact.ASSETS))
        }
    }
}
```

### Update add-to-app projects and AAR builds

If you embed a Flutter module in an Android host app or run
`flutter build aar`, check these three configurations.

#### Remove the hostAppProjectName property

Because the `:flutter` module attaches assets and JNI libraries to its own
variants in `onVariants`, host apps of any name consume `:flutter` without
cross-project configuration.
Leaving `flutter.hostAppProjectName` set logs a warning without failing the
build.
Delete `flutter.hostAppProjectName` from your host app's `gradle.properties`
file and from the Flutter module's `.android/gradle.properties` file if
present.

Code before migration:

```properties title="<host-app>/gradle.properties"
org.gradle.jvmargs=-Xmx4G
flutter.hostAppProjectName=my_host_app
```

Code after migration:

```properties title="<host-app>/gradle.properties"
org.gradle.jvmargs=-Xmx4G
# Remove flutter.hostAppProjectName; Flutter resolves module assets per variant.
```

#### Set matchingFallbacks on custom host build types

If your host app defines a custom build type such as `staging`,
list the target Flutter build mode first in `matchingFallbacks`.
Choose `debug`, `profile`, or `release` so AGP and Flutter select the same
module build mode.

Code before migration:

```kotlin title="<host-app>/app/build.gradle.kts"
android {
    buildTypes {
        create("staging") {
            initWith(getByName("debug"))
        }
    }
}
```

Code after migration:

```kotlin title="<host-app>/app/build.gradle.kts"
android {
    buildTypes {
        create("staging") {
            initWith(getByName("debug"))
            // Put the target build mode ("debug", "profile", or "release") first.
            matchingFallbacks += listOf("debug", "release")
        }
    }
}
```

#### Match product flavors in AAR builds

When you run `flutter build aar --flavor <name>`,
define that product flavor in the Flutter module and in every Android plugin
the module uses.
Missing plugin variants fail the build, while custom
`android.publishing.singleVariant(...)` declarations stay intact.

### Migrate Android plugins

If you maintain an Android plugin, update its Gradle build script for AGP's
public Variant API:

- Replace `android.libraryVariants` and `android.applicationVariants` in your
  plugin's `build.gradle(.kts)` file with `androidComponents.onVariants`.
- Don't look up Flutter's tasks at the top level of a build script or cast
  `copyFlutterAssets<Variant>` to `Copy`.
  For lazy task patterns,
  refer to [Configure Flutter Gradle tasks in build scripts][flutter-tasks].
- Test your plugin's example app on AGP `9.1.1` or later with both
  `android.newDsl=true` and `android.builtInKotlin=true` in
  `gradle.properties`.

Code before migration:

```groovy title="<flutter-plugin>/android/build.gradle"
android.libraryVariants.all { variant ->
    // Custom per-variant plugin configuration.
}
```

Code after migration:

```kotlin title="<flutter-plugin>/android/build.gradle.kts"
androidComponents {
    // Configure library variants through AGP's public Variant API.
    onVariants(selector().all()) { variant ->
        // Custom per-variant plugin configuration.
    }
}
```

### Opt in to the new AGP DSL early

AGP 9 enables the [new AGP DSL][] by default and deprecates the legacy DSL and
variant APIs behind `android.newDsl=false`.
The [AGP migration timeline][] schedules the removal of `android.newDsl=false`
and the legacy variant APIs for AGP 10.
Flutter 3.50 sets `android.newDsl=false` by default,
keeping `android.applicationVariants` available unless a `--split-per-abi`
script reads `variant.versionCode` or `output.versionCode`.
For `--split-per-abi` migration details,
refer to [Customize version codes in Gradle build scripts][vc-custom].

Before enabling `android.newDsl=true`, verify two prerequisites:

- Your app and plugins use `androidComponents.onVariants` instead of legacy
  variant APIs.
- Your app and every Android plugin in your build have migrated off the
  `kotlin-android` plugin to
  [built-in Kotlin][Migrating Flutter Android projects to built-in Kotlin].
  The `kotlin-android` plugin rejects `android.newDsl=true`;
  if any plugin still applies `kotlin-android`, keep both properties set to
  `false`.

Once your project meets both prerequisites, test against the new AGP DSL in
`android/gradle.properties`
(Flutter's migrator preserves an existing `android.newDsl` setting):

```properties title="<flutter-project>/android/gradle.properties"
# Opt in to the new AGP DSL after migrating off legacy variant APIs and KGP.
android.newDsl=true
android.builtInKotlin=true
```

## Timeline

In stable release: 3.50

## References

- [Extend the Android Gradle Plugin][Variant API]: Official Android
  documentation for configuring builds and artifacts with
  `androidComponents.onVariants`.
- [Migrating Flutter Android projects to built-in Kotlin][]: Companion guide to
  migrating off the Kotlin Gradle Plugin before enabling
  `android.newDsl=true`.
- [Issue 180137][]: Tracking issue for enabling `android.newDsl=true` by
  default and removing `android.newDsl=false` from Flutter's project
  templates.
- [Issue 190845][]: Tracking issue for migrating Android plugins off the
  legacy variant API.

[add-to-app]: #update-add-to-app-projects-and-aar-builds
[AGP migration timeline]: {{site.android-dev}}/build/releases/gradle-plugin-roadmap#agp-10
[apk-outputs]: #rename-copy-or-transform-apk-outputs
[flutter-tasks]: #configure-flutter-gradle-tasks-in-build-scripts
[Issue 180137]: {{site.repo.flutter}}/issues/180137
[Issue 190845]: {{site.repo.flutter}}/issues/190845
[Issue 196412]: {{site.repo.flutter}}/issues/196412
[Issue 196444]: {{site.repo.flutter}}/issues/196444
[Issue 196559]: {{site.repo.flutter}}/issues/196559
[Issue 196696]: {{site.repo.flutter}}/issues/196696
[Migrating Flutter Android projects to built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[new AGP DSL]: {{site.android-dev}}/build/releases/agp-9-0-0-release-notes#android-gradle-plugin-new-dsl
[opt-in]: #opt-in-to-the-new-agp-dsl-early
[plugins]: #migrate-android-plugins
[Variant API]: {{site.android-dev}}/build/extend-agp
[vc-custom]: #customize-version-codes-in-gradle-build-scripts
[vc-single]: #keep-a-single-version-code-across-split-apks
[vc-split]: #fix-split-per-abi-version-code-errors
