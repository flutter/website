---
title: Flutter Gradle Plugin uses the Android Gradle Plugin Variant API
description: >-
  The Flutter Gradle Plugin configures Android builds with public
  Android Gradle Plugin APIs.
  Learn which custom Gradle build scripts and Flutter 3.50 configurations
  need updates.
---

{% render "docs/breaking-changes.md" %}

## Summary

In Flutter 3.50, the Flutter Gradle Plugin (FGP) migrated from deprecated
Android Gradle Plugin (AGP) variant APIs (`android.applicationVariants`,
`android.libraryVariants`, `variant.outputs`, and `versionCodeOverride`)
to AGP's public [Variant API][] (`androidComponents.onVariants`).
Standard `flutter run`, `flutter build apk`, `flutter build appbundle`,
`flutter build aar`, and add-to-app builds produce the same outputs
at the same file paths.

:::important Use Flutter 3.50.1 or later
Upgrade to **Flutter 3.50.1** or later when adopting Flutter 3.50.
Flutter 3.50.1 fixes three Android build issues from 3.50.0 and enforces
split-per-ABI version codes:

- Apps with Android plugins failed to configure when `profile` or a custom
  build type set `applicationIdSuffix`, `isShrinkResources`,
  `buildConfigField`, or `resValue` ([Issue 196412][], [Issue 196696][]).
  Gradle reported errors such as
  `Library projects cannot set applicationIdSuffix` and
  `Resource shrinker cannot be used for libraries`.
- `flutter build apk --split-per-abi` skipped per-ABI `versionCode` offsets
  when `android:versionCode` was set only in `AndroidManifest.xml`
  ([Issue 196559][]).
- Assets with dot-prefixed filenames (such as `.env`) or underscore-prefixed
  directory names were omitted from Android builds ([Issue 196444][]).
- In 3.50.1 and later, `flutter build apk --split-per-abi` fails (instead of
  logging an error) when `android {}` sets no `versionCode` and
  `AndroidManifest.xml` sets no integer `android:versionCode`.
  Declare a `versionCode` or pass `-P force-version-code-ignoring-abi=true`
  (refer to [Fix split-per-ABI version code errors][vc-split]).
:::

Existing build scripts that use the legacy variant API
(`android.applicationVariants` or `versionCodeOverride`)
keep working in Flutter 3.50
(refer to [Opt in to the new AGP DSL early][opt-in]).

Update your Android build configuration if your project does any of the
following:

- Computes custom `versionCode` values in Gradle
  (refer to [Customize version codes in Gradle build scripts][vc-custom]).
- Runs `flutter build apk --split-per-abi` without a `versionCode` in
  `android {}` or an integer `android:versionCode` in `AndroidManifest.xml`
  (refer to [Fix split-per-ABI version code errors][vc-split]).
- Renames, copies, or transforms APK outputs in Gradle
  (refer to [Rename, copy, or transform APK outputs][apk-outputs]).
- Looks up Flutter's Gradle tasks at the top level of a build script,
  casts `copyFlutterAssets<Variant>` to `org.gradle.api.tasks.Copy`,
  or reads `merge<Variant>Assets` under `build/app/intermediates/`
  (refer to [Configure Flutter Gradle tasks in build scripts][flutter-tasks]).
- Configures an add-to-app host project or `flutter build aar` publishing
  (refer to [Update add-to-app projects and AAR builds][add-to-app]).
- Maintains an Android plugin
  (refer to [Migrate Android plugins][plugins]).
- Enables `android.newDsl=true` to test against the new AGP DSL
  (refer to [Opt in to the new AGP DSL early][opt-in]).

## Migration guide

The following examples use the Kotlin DSL (`build.gradle.kts`),
which Flutter's project templates generate.
The same `androidComponents` API works in Groovy (`build.gradle`).
In Groovy, append `.INSTANCE` when referencing Kotlin `object` declarations
such as `SingleArtifact.APK.INSTANCE`.

### Customize version codes in Gradle build scripts

With `flutter build apk --split-per-abi`, Flutter assigns each ABI output a
distinct `versionCode` using `abiOffset * 1000 + versionCode`.
The ABI offsets are `1` for `armeabi-v7a`, `2` for `arm64-v8a`,
and `4` for `x86_64`.

Flutter sets `output.versionCode` in its `androidComponents.onVariants`
callback, which runs before your app's `onVariants` block when FGP is applied
in `plugins {}`.
Because Flutter's callback runs first, `output.versionCode` already includes
the per-ABI offset.

If you replace legacy code that read `variant.versionCode` with an
`onVariants` callback that reads `output.versionCode`, your calculation starts
from the already-offset number instead of the base `versionCode`.
For example, multiplying by `10,000` with `--build-number 42` produces larger
values when reading `output.versionCode`:

| ABI (offset) | Legacy code reading `variant.versionCode`: `offset * 1000 + 42 * 10000` | `onVariants` code reading `output.versionCode`: `(offset * 1000 + 42) * 10000` |
| :--- | :--- | :--- |
| `armeabi-v7a` (1) | 421000 | 10420000 |
| `arm64-v8a` (2) | 422000 | 20420000 |
| `x86_64` (4) | 424000 | 40420000 |

The larger values remain distinct, preserve ABI ordering, and increase
monotonically, so Google Play accepts the updated APKs as upgrades.
However, reverting to a build that produces the `422000`-style values lowers
`versionCode`, which Google Play rejects.

When migrating off `versionCodeOverride` or writing custom `onVariants` logic,
compute `versionCode` directly from a base value you control,
such as `flutter.versionCode` or a product flavor's `versionCode`.
Avoid reading `output.versionCode`:
AGP disallows reading `output.versionCode` during configuration when
`android.compatibility.enableLegacyApi` is disabled.

Code before migration (legacy variant API):

```groovy title="<flutter-project>/android/app/build.gradle"
android.applicationVariants.all { variant ->
    variant.outputs.each { output ->
        def abi = output.getFilter(OutputFile.ABI)
        output.versionCodeOverride = abiCodes.get(abi) * 1000 + variant.versionCode
    }
}
```

Code after migration (place the `import` at the top of `build.gradle.kts`):

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

To keep producing `422000`-style numbers when multiplying `flutter.versionCode`
by `10000`, compute the full expression directly:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
output.versionCode.set((abiCodes[abi] ?: 0) * 1000 + flutter.versionCode * 10000)
```

To verify the resulting `versionCode` in a built APK, run `apkanalyzer`:

```bash
apkanalyzer manifest version-code build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

### Fix split-per-ABI version code errors

Apps created from Flutter's templates set `versionCode = flutter.versionCode`
in `defaultConfig` and need no changes.
In Flutter 3.50.1 and later, apps that set a literal integer
`android:versionCode` in `AndroidManifest.xml` also continue receiving per-ABI
offsets (fixing [Issue 196559][] from Flutter 3.50.0).

In Flutter 3.50.1 and later, `flutter build apk --split-per-abi`
(or `-Psplit-per-abi=true`) fails when `android {}` sets no `versionCode` and
`AndroidManifest.xml` sets no integer `android:versionCode`.
Common causes include omitting `versionCode` or using a manifest placeholder
such as `${vc}`:

```plaintext noHighlight
Flutter cannot give each split APK of variant 'release' a distinct versionCode:
its android {} block declares no versionCode, and no manifest sets one.
Google Play does not accept split APKs that share a versionCode.
Set versionCode = flutter.versionCode in defaultConfig (or on each product
flavor), or pass -P force-version-code-ignoring-abi=true to keep one
versionCode.
```

Non-split APKs, `flutter build appbundle`, and `flutter run` aren't affected.

To resolve the error, set `versionCode = flutter.versionCode` in
`defaultConfig` (or set `versionCode` on each product flavor) in your
`android/app/build.gradle.kts` file,
and remove `android:versionCode` from `AndroidManifest.xml`:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
android {
    defaultConfig {
        // ...
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
}
```

#### Keep a single version code across split APKs

If you distribute per-ABI APKs outside Google Play and want every split APK to
share one `versionCode`,
pass the `force-version-code-ignoring-abi=true` Gradle project property:

- **Command line:** Pass `-P force-version-code-ignoring-abi=true`:

  ```bash
  flutter build apk --split-per-abi -P force-version-code-ignoring-abi=true
  ```

- **Project configuration:** Add the property to your
  `android/gradle.properties` file:

  ```properties title="<flutter-project>/android/gradle.properties"
  force-version-code-ignoring-abi=true
  ```

:::caution Google Play upload restriction
When `force-version-code-ignoring-abi=true` is enabled,
all split APKs share one `versionCode`.
Google Play rejects multiple APKs in the same release that share a
`versionCode`.
:::

### Rename, copy, or transform APK outputs

AGP's public Variant API doesn't expose `outputFileName` on variant outputs.
To produce renamed copies of your APKs,
register a `Copy` task that reads `SingleArtifact.APK`.

Code before migration (legacy variant API):

```groovy title="<flutter-project>/android/app/build.gradle"
android {
    applicationVariants.all { variant ->
        variant.outputs.all { output ->
            outputFileName = outputFileName.replace("app-", "myapp-${variant.versionName}-")
        }
    }
}
```

Code after migration (add the `import` at the top of
`android/app/build.gradle.kts`, and place `androidComponents` next to
`android {}`):

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
import com.android.build.api.artifact.SingleArtifact

androidComponents {
    onVariants(selector().all()) { variant ->
        val variantName = variant.name.replaceFirstChar { it.uppercase() }
        val copyApks = tasks.register<Copy>("copy${variantName}RenamedApks") {
            from(variant.artifacts.get(SingleArtifact.APK))
            include("*.apk")
            into(layout.buildDirectory.dir("renamed-apk/${variant.name}"))
            rename { it.replace("app-", "myapp-${flutter.versionName}-") }
        }
        tasks.matching { it.name == "assemble$variantName" }.configureEach {
            dependsOn(copyApks)
        }
    }
}
```

Flutter continues placing standard APKs in `build/app/outputs/flutter-apk/`
with unchanged filenames (such as `app-release.apk` or
`app-arm64-v8a-release.apk`),
so `flutter build apk` and scripts reading that directory keep working.

If a Gradle plugin or custom task transforms `SingleArtifact.APK` in place,
preserve `output-metadata.json` and produce one APK per variant output with the
matching ABI filter.
Otherwise, the build fails with an error naming `SingleArtifact.APK`.

### Configure Flutter Gradle tasks in build scripts

FGP registers tasks such as `copyFlutterAssets<Variant>` lazily inside
`androidComponents.onVariants` (after top-level build script evaluation)
and uses `CopyFlutterAssetsTask` instead of `org.gradle.api.tasks.Copy`.
In app projects, Flutter registers tasks only for the variants being built when
a single `assemble<Variant>` task runs,
so calling `tasks.named(...)` throws `UnknownTaskException` even inside
`onVariants`.

Configure Flutter tasks lazily by name with `tasks.matching`,
without casting to `Copy`:

```kotlin diff title="<flutter-project>/android/app/build.gradle.kts"
- tasks.named("copyFlutterAssetsDebug", Copy::class) {
+ tasks.matching { it.name == "copyFlutterAssetsDebug" }.configureEach {
      // ...
  }
```

Where possible, wire custom tasks to Variant API artifacts
(such as `SingleArtifact.APK` or `SingleArtifact.ASSETS`)
instead of depending on Flutter task names or AGP `intermediates/` paths.
Starting in 3.50.1, `merge<Variant>Assets/` no longer contains
`flutter_assets/` ([Issue 196444][]);
read packaged assets from the APK or AAB.

### Update add-to-app projects and AAR builds

If you embed a Flutter module in an existing Android host app or build AARs
with `flutter build aar`:

- **Remove `flutter.hostAppProjectName`:** Delete this property from your host
  app's `gradle.properties` file and from the Flutter module's
  `.android/gradle.properties` file if present.
  Flutter no longer reads `flutter.hostAppProjectName` and logs a warning when
  the property is set.
- **Set `matchingFallbacks` on custom host build types:** List the desired
  Flutter module build type (`debug`, `profile`, or `release`) first in
  `matchingFallbacks`.
  AGP and Flutter then select the same module build mode:

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

- **Match flavors in `flutter build aar`:** When you pass `--flavor`,
  define that product flavor in the Flutter module and in every Android plugin
  the module uses.
  Missing plugin variants fail the build, and custom
  `android.publishing.singleVariant(...)` declarations are preserved.

### Migrate Android plugins

If you maintain an Android plugin:

- Replace `android.applicationVariants` and `android.libraryVariants` in your
  plugin's `build.gradle(.kts)` file with `androidComponents.onVariants`.
- Avoid looking up Flutter tasks during top-level build script evaluation or
  casting `copyFlutterAssets<Variant>` to `org.gradle.api.tasks.Copy`.
- Test your plugin's example app on AGP `9.1.1` or later with both
  `android.newDsl=true` and `android.builtInKotlin=true` in
  `gradle.properties`.

### Opt in to the new AGP DSL early

AGP 9 deprecated the legacy DSL and variant APIs behind `android.newDsl=false`,
and AGP 10 removes both `android.newDsl=false` and the legacy APIs.
Flutter 3.50 sets `android.newDsl=false` by default,
so custom build scripts that call `android.applicationVariants` or
`versionCodeOverride` keep working in Flutter 3.50 until you migrate them to
`androidComponents.onVariants`.

Once your build scripts and plugins use `androidComponents.onVariants` and
[built-in Kotlin][Migrating Flutter Android projects to built-in Kotlin],
test against the new AGP DSL by setting both properties to `true` in
`android/gradle.properties`
(Flutter's migrator preserves an existing `android.newDsl` setting):

```properties title="<flutter-project>/android/gradle.properties"
android.newDsl=true
android.builtInKotlin=true
```

Enabling `android.newDsl=true` requires `android.builtInKotlin=true`,
because the legacy `kotlin-android` plugin rejects `android.newDsl=true`.
If any plugin in your app still applies `kotlin-android`,
keep both properties set to `false`.

## Timeline

In stable release: 3.50

## References

- [Extend the Android Gradle Plugin][Variant API]: Official Android
  documentation for configuring builds and artifacts with
  `androidComponents.onVariants`.
- [Migrating Flutter Android projects to built-in Kotlin][]: Companion guide to
  migrating off the Kotlin Gradle Plugin before enabling
  `android.newDsl=true`.
- [Issue 180137][]: Tracking issue to follow for when Flutter enables
  `android.newDsl=true` by default and removes `android.newDsl=false` from
  project templates.
- [Issue 190845][]: Tracking issue for Android plugin ecosystem migration off
  the legacy variant API.

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
[vc-split]: #fix-split-per-abi-version-code-errors
