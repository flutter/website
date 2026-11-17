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
and AGP 10 removes them.
In Flutter 3.50, the Flutter Gradle Plugin (FGP) migrated off
`android.applicationVariants`, `android.libraryVariants`, `variant.outputs`,
and `versionCodeOverride` to AGP's public [Variant API][]
(`androidComponents.onVariants`).

You don't need to edit your Gradle scripts in Flutter 3.50.1 or later
if your project meets all of the following conditions:

- Uses standard `flutter run`, `flutter build apk`,
  `flutter build appbundle`, `flutter build aar`, or add-to-app builds.
  These builds produce the same outputs at the same file paths.
- Sets `versionCode = flutter.versionCode` in `defaultConfig`
  (the Flutter template default),
  or sets a positive integer `android:versionCode` in
  `src/main/AndroidManifest.xml`.
- Doesn't customize `versionCode` in `onVariants`,
  hook into Flutter's Gradle tasks or `merge<Variant>Assets/` paths,
  or use custom add-to-app settings.

Existing app scripts that call `android.applicationVariants` or
`versionCodeOverride` keep working in Flutter 3.50 while
`android.newDsl=false` is the default.
For details about AGP 10 readiness,
refer to [Opt in to the new AGP DSL early][opt-in].

:::important Use Flutter 3.50.1 or later
Upgrade directly to Flutter 3.50.1 or later when adopting Flutter 3.50.
Flutter 3.50.1 fixes three Android regressions from 3.50.0 and enforces
valid version codes for split APKs:

- **Plugin build-type errors fixed:**
  In 3.50.0, apps with Android plugins failed to configure when `profile` or
  a custom build type set certain properties
  ([Issue 196412][], [Issue 196696][]).
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
- **Missing split-APK version codes fail the build:**
  In 3.50.1 and later, `flutter build apk --split-per-abi` fails when neither
  `android {}` nor `src/main/AndroidManifest.xml` sets a positive integer
  `versionCode`.
  Previously, Gradle only logged an error.
  Set a `versionCode` or pass `-P force-version-code-ignoring-abi=true`
  (refer to [Fix split-per-ABI version code errors][vc-split]).
:::

Use the following table to find the migration section for your role,
build pattern, or Gradle error:

| Role | Symptom, build pattern, or error | Migration section |
| :--- | :--- | :--- |
| App developer | Computes custom `versionCode` values in `onVariants` or `versionCodeOverride` | [Customize version codes in Gradle build scripts][vc-custom] |
| App developer | Fails `--split-per-abi` with `Flutter cannot give each split APK of variant '<name>' a distinct versionCode` | [Fix split-per-ABI version code errors][vc-split] |
| App developer | Sets `outputFileName`, copies APKs, or fails naming `SingleArtifact.APK` | [Rename, copy, or transform APK outputs][apk-outputs] |
| App developer | Hits `UnknownTaskException` or `ClassCastException` on `copyFlutterAssets<Variant>`, or reads `merge<Variant>Assets/` | [Configure Flutter Gradle tasks in build scripts][flutter-tasks] |
| App developer | Enables `android.newDsl=true` to test AGP 10 compatibility | [Opt in to the new AGP DSL early][opt-in] |
| Add-to-app or AAR | Sees a `flutter.hostAppProjectName` warning, uses custom host build types, or runs `flutter build aar --flavor` | [Update add-to-app projects and AAR builds][add-to-app] |
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
When you apply FGP in `plugins {}`, Flutter's `androidComponents.onVariants`
callback runs before your app's `onVariants` block.
As a result, `output.versionCode` already contains the per-ABI offset.

Compute custom `versionCode` values from a base input you control,
such as `flutter.versionCode` or a product flavor's `versionCode`.
Don't read `output.versionCode`:
AGP blocks configuration-time reads of `output.versionCode` when
`android.compatibility.enableLegacyApi` is disabled.

Code before migration:

```groovy title="<flutter-project>/android/app/build.gradle"
android.applicationVariants.all { variant ->
    variant.outputs.each { output ->
        def abi = output.getFilter(OutputFile.ABI)
        output.versionCodeOverride = abiCodes.get(abi) * 1000 + variant.versionCode
    }
}
```

Code after migration
(add the `import` at the top of `build.gradle.kts`,
and place `androidComponents {}` next to `android {}`):

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.variant.FilterConfiguration

val abiCodes = mapOf("armeabi-v7a" to 1, "arm64-v8a" to 2, "x86_64" to 4)

androidComponents {
    onVariants(selector().all()) { variant ->
        variant.outputs.forEach { output ->
            // Read the ABI filter from AGP's public Variant API.
            val abi = output.filters
                .find { it.filterType == FilterConfiguration.FilterType.ABI }
                ?.identifier
            // Compute from flutter.versionCode instead of output.versionCode.
            output.versionCode.set((abiCodes[abi] ?: 0) * 1000 + flutter.versionCode)
        }
    }
}
```

If an `onVariants` block reads `output.versionCode` instead of
`flutter.versionCode`, your formula starts from the already-offset number.
For example, multiplying by `10,000` with `--build-number 42` produces larger
values when reading `output.versionCode`:

| ABI (offset) | Legacy `variant.versionCode`: `offset * 1000 + 42 * 10000` | `onVariants` reading `output.versionCode`: `(offset * 1000 + 42) * 10000` |
| :--- | :--- | :--- |
| `armeabi-v7a` (1) | 421000 | 10420000 |
| `arm64-v8a` (2) | 422000 | 20420000 |
| `x86_64` (4) | 424000 | 40420000 |

Those larger values remain distinct, preserve ABI ordering, and increase
monotonically, so Google Play accepts the updated APKs as upgrades.
However, switching back to `422000`-style values lowers `versionCode`,
which Google Play rejects.

To keep `422000`-style numbers when multiplying `flutter.versionCode` by
`10,000`, compute the full expression from `flutter.versionCode`:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
// Scale flutter.versionCode directly so the ABI offset stays unscaled.
output.versionCode.set((abiCodes[abi] ?: 0) * 1000 + flutter.versionCode * 10000)
```

To verify the final `versionCode` in a built APK, run `apkanalyzer`:

```bash
apkanalyzer manifest version-code build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

### Fix split-per-ABI version code errors

You need no changes here if `defaultConfig` sets
`versionCode = flutter.versionCode`, or if `src/main/AndroidManifest.xml` sets
a positive integer `android:versionCode` ([Issue 196559][]).
Non-split APKs, `flutter build appbundle`, and `flutter run` are also
unaffected.

When `android {}` omits `versionCode`, Flutter matches AGP and reads
`android:versionCode` only from the main manifest
(`src/main/AndroidManifest.xml` by default).
Build-type, product-flavor, and generated overlay manifests aren't read.
In Flutter 3.50.1 and later, `flutter build apk --split-per-abi`
(or `-Psplit-per-abi=true`) fails when `android {}` omits `versionCode` and
the main manifest lacks a positive integer `android:versionCode`:

```plaintext noHighlight
Flutter cannot give each split APK of variant 'release' a distinct versionCode:
its android {} block sets no versionCode, and
<flutter-project>/android/app/src/main/AndroidManifest.xml does not set
android:versionCode. Google Play does not accept split APKs that share a
versionCode. Set versionCode = flutter.versionCode in defaultConfig (or on each
product flavor), or pass -P force-version-code-ignoring-abi=true to keep one
versionCode.
```

Common triggers include omitting `versionCode` everywhere, using a manifest
placeholder such as `${vc}`, or setting `android:versionCode` to `0` or less.
To keep a single `versionCode` across split APKs outside Google Play,
pass `-P force-version-code-ignoring-abi=true`
(refer to [Keep a single version code across split APKs][vc-single]).

Otherwise, set `versionCode = flutter.versionCode` in `defaultConfig`
(or on each product flavor), and remove `android:versionCode` from
`AndroidManifest.xml`.

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

#### Keep a single version code across split APKs

:::caution Google Play rejects shared version codes
Enabling `force-version-code-ignoring-abi=true` gives every split APK the same
`versionCode`.
Google Play rejects multiple APKs in the same release that share a
`versionCode`.
Use this property only when distributing split APKs outside Google Play.
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

Flutter no longer reads `flutter.hostAppProjectName` and logs a warning when
the property is set.
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

AGP 9 deprecated the legacy DSL and variant APIs behind `android.newDsl=false`,
and AGP 10 removes both `android.newDsl=false` and the legacy APIs.
Flutter 3.50 sets `android.newDsl=false` by default.
Build scripts calling `android.applicationVariants` or `versionCodeOverride`
keep working in Flutter 3.50 until you migrate them to
`androidComponents.onVariants`.

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
[apk-outputs]: #rename-copy-or-transform-apk-outputs
[flutter-tasks]: #configure-flutter-gradle-tasks-in-build-scripts
[Issue 180137]: {{site.repo.flutter}}/issues/180137
[Issue 190845]: {{site.repo.flutter}}/issues/190845
[Issue 196412]: {{site.repo.flutter}}/issues/196412
[Issue 196444]: {{site.repo.flutter}}/issues/196444
[Issue 196559]: {{site.repo.flutter}}/issues/196559
[Issue 196696]: {{site.repo.flutter}}/issues/196696
[Migrating Flutter Android projects to built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[opt-in]: #opt-in-to-the-new-agp-dsl-early
[plugins]: #migrate-android-plugins
[Variant API]: {{site.android-dev}}/build/extend-agp
[vc-custom]: #customize-version-codes-in-gradle-build-scripts
[vc-single]: #keep-a-single-version-code-across-split-apks
[vc-split]: #fix-split-per-abi-version-code-errors
