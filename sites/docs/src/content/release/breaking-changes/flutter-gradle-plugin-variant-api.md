---
title: Flutter Gradle Plugin uses the Android Gradle Plugin Variant API
description: >-
  The Flutter Gradle Plugin now configures Android apps, modules, and plugins
  with public Android Gradle Plugin APIs. Some build behaviors changed, and
  build scripts that use the legacy variant API should migrate now.
---

{% render "docs/breaking-changes.md" %}

## Summary

In Flutter 3.50, the Flutter Gradle Plugin (FGP) stopped using the legacy
Android Gradle Plugin (AGP) variant API (`android.applicationVariants`,
`android.libraryVariants`, `variant.outputs`, and `versionCodeOverride`) and
internal AGP classes.
The plugin now configures Android builds through AGP's public
[Variant API][] (`androidComponents.onVariants`) and the new AGP DSL.

For most apps, nothing changes:
`flutter run`, `flutter build apk`, `flutter build appbundle`,
`flutter build aar`, and add-to-app builds produce the same outputs
at the same file paths.

You're affected in Flutter 3.50 if your app, module, plugin, or host app
does any of the following:

- Builds with `flutter build apk --split-per-abi` and sets `versionCode`
  only in `AndroidManifest.xml`, omits `versionCode`, or computes
  `output.versionCode` in Gradle on top of Flutter's offset.
- Transforms AGP's `SingleArtifact.APK` artifact without preserving
  `output-metadata.json` and ABI filters.
- Looks up Flutter's Gradle tasks at the top level of a build script
  or casts `copyFlutterAssets<Variant>` to `org.gradle.api.tasks.Copy`.
- Defines custom build types (such as `staging`) without `matchingFallbacks`,
  or sets `flutter.hostAppProjectName` in an add-to-app project.
- Runs `flutter build aar` when an Android plugin lacks the requested flavor
  variant, or customizes `android.publishing.singleVariant`.

:::note Legacy variant APIs in your own build scripts
Flutter 3.50 still sets `android.newDsl=false` in `gradle.properties`
(new projects get this property from the template, and existing projects get it
from Flutter's migrator).
Your own build script code that calls `android.applicationVariants` or
`versionCodeOverride`—such as renaming APKs with `outputFileName`—keeps working
in Flutter 3.50.
Because a future Flutter release will remove the `android.newDsl=false` opt-out
and AGP 10 removes the legacy APIs altogether,
migrate those build scripts to `androidComponents.onVariants` now.
:::

[Variant API]: {{site.android-dev}}/build/extend-agp

## Context

AGP 9 deprecated the legacy DSL and variant APIs behind the
`android.newDsl=false` Gradle property,
and AGP 10 removes both those APIs and access to AGP internals.
In Flutter 3.44, Flutter started adding `android.newDsl=false` to keep existing
build files working on AGP 9.
For background, consult
[Migrating Flutter Android projects to built-in Kotlin][].

To support AGP 10 in a future release, the Flutter Gradle Plugin itself had to
stop calling the legacy AGP APIs.
Flutter 3.50 completes that migration across FGP's app, add-to-app module,
and `flutter build aar` code paths.
Removing the `android.newDsl=false` opt-out from project templates and
Flutter's migrator is tracked separately in [Issue 180137][].

Built-in Kotlin isn't affected by this change:
`android.builtInKotlin=false` is still added by default and continues to work.
For details, consult
[Migrating Flutter Android projects to built-in Kotlin][].

[Migrating Flutter Android projects to built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin

## Description of change

### APKs are copied by a task

FGP copies the APKs built by AGP into `build/app/outputs/flutter-apk/`.
Previously, the plugin copied these files in a `doLast` action on the
variant's `assemble` task.
Now a dedicated `copyFlutterApks<Variant>` task
(for example, `copyFlutterApksRelease`) performs the copy,
and `assemble<Variant>` depends on that task.
The task reads AGP's `SingleArtifact.APK` directory and its
`output-metadata.json` file.

The output filenames and paths are unchanged
(such as `app-release.apk`, `app-arm64-v8a-release.apk`, or
`app-arm64-v8a-prod-release.apk`).
Because `copyFlutterApks<Variant>` sets no task group,
it appears in `./gradlew tasks --all` rather than `./gradlew tasks`.

If a plugin or your build script transforms `SingleArtifact.APK`,
the transform must preserve `output-metadata.json` and produce one APK per
variant output with the matching ABI filter.
Otherwise, the build fails with a Flutter error naming `SingleArtifact.APK`.
Build logic that only reads the built APK, or that copies extra APKs elsewhere
after `assemble`, isn't affected.

### Per-ABI `versionCode` is set from the DSL

With `flutter build apk --split-per-abi`, Flutter gives each ABI output a
distinct `versionCode` using `abiOffset * 1000 + versionCode`.
The ABI offsets are `1` for `armeabi-v7a`, `2` for `arm64-v8a`,
and `4` for `x86_64`.

Previously, Flutter set `versionCodeOverride` after build scripts ran,
reading the merged `versionCode` (including one from `AndroidManifest.xml`).
Now Flutter reads the `android {}` DSL `versionCode` (`defaultConfig` or the
first product flavor in dimension order) during `finalizeDsl`, and sets
`output.versionCode` in `onVariants`.

This change has two main effects:

- **Missing DSL `versionCode` (including manifest-only `versionCode`):**
  Apps created from Flutter's templates set `versionCode = flutter.versionCode`
  in `defaultConfig` and aren't affected.
  In Flutter 3.50.0, if your `android {}` block declares no `versionCode`
  (for example, `android:versionCode` is set only in `AndroidManifest.xml`,
  or omitted everywhere), Flutter skips the per-ABI offset.
  Every split APK receives the same `versionCode`, and Gradle warns that Google
  Play won't accept the split APKs together ([Issue 196559][]).
  To fix this or disable the ABI offset intentionally, refer to
  [Fix split-per-ABI `versionCode` warnings or errors][split-abi-fix].

  :::important
  **TODO(reidbaker):** Confirm whether [PR 196561][] (fixing [Issue 196559][])
  is cherry-picked into a Flutter `3.50.x` hotfix or deferred to a later
  release.
  Keep only the matching behavior below before removing draft status:

  - **If [PR 196561][] is cherry-picked to `3.50.x`:**
    When the `android {}` block declares no `versionCode`, Flutter reads an
    integer `android:versionCode` from the highest-priority manifest and
    applies the `abiOffset * 1000` offset (matching Flutter 3.47).
    Split APK builds (`flutter build apk --split-per-abi` or
    `-Psplit-per-abi=true`) **fail to build** when the `android {}` block
    declares no `versionCode` and any of the following apply:
    - No manifest sets `android:versionCode`.
    - The highest-priority manifest uses a non-integer value such as `${vc}`.
    - A higher-priority manifest sets `tools:remove="android:versionCode"` or a
      `tools:node` other than `merge` on `<manifest>`.
    - A manifest file can't be parsed (for example, it contains `DOCTYPE`).

    ```plaintext noHighlight
    Flutter cannot give each split APK of variant 'release' a distinct versionCode:
    its android {} block declares no versionCode, and no manifest sets one.
    Google Play does not accept split APKs that share a versionCode.
    Set versionCode = flutter.versionCode in defaultConfig (or on each product
    flavor), or pass -P force-version-code-ignoring-abi=true to keep one
    versionCode.
    ```

    The error triggers lazily only when building split APKs of that variant.
    Non-split APKs, `flutter build appbundle`, and `flutter run` are
    unaffected.
  - **If [PR 196561][] is not cherry-picked to `3.50.x`:**
    Delete this `:::important` block so only the `3.50.0` warning behavior
    remains here, and move the build-failure note to the release where
    [PR 196561][] ships.
  :::

- **Ordering with your own `onVariants` callbacks:**
  When FGP is applied in `plugins {}`, Flutter's `onVariants` callback runs
  before your app's `androidComponents.onVariants` block.
  If your callback derives a new value from `output.versionCode`,
  that calculation now starts from Flutter's already-offset number.
  To adjust custom `versionCode` calculations, refer to
  [Set per-ABI or per-variant `versionCode` values][versioncode-guide].

Flutter reads the DSL `versionCode` in its own `finalizeDsl` callback.
Values mutated in a later `finalizeDsl` callback in your build script aren't
used by Flutter's offset calculation.
Passing `-P force-version-code-ignoring-abi=true` still disables Flutter's
per-ABI offset completely.

### Custom build types are copied to plugins with `initWith`

FGP copies your app's custom build types (such as `staging`) onto each
Flutter plugin project so that Gradle can resolve variant dependencies.
Previously, library plugins received a newly created build type that copied
only `isDebuggable` and `isMinifyEnabled`, without copying `matchingFallbacks`.
(Only app-type plugin subprojects received the live build type object.)
Now each plugin receives an `initWith` copy created through the public AGP DSL,
which copies `matchingFallbacks` as well.

In the public AGP DSL, `LibraryBuildType` doesn't expose `isDebuggable`
directly, so Flutter relies on `initWith` rather than setting `isDebuggable`
explicitly on library plugins.

### Flutter assets are a generated source directory

Flutter's `flutter_assets` directory is now registered on each variant as a
generated assets source directory.
Previously, Flutter copied these files over the merged assets directory after
AGP's asset merge step.
If your app bundles its own Android asset at a colliding path
(such as `src/main/assets/flutter_assets/...`),
AGP's source-set priority decides which file takes precedence.
Flutter's asset no longer unconditionally overwrites the app's copy.

### Flutter tasks are registered in `onVariants`

Previously, FGP registered its Gradle tasks inside
`applicationVariants.configureEach`, and `copyFlutterAssets<Variant>` had type
`org.gradle.api.tasks.Copy`.
Now FGP registers its tasks as lazy `TaskProvider` instances inside
`androidComponents.onVariants` (after top-level build script evaluation),
and `copyFlutterAssets<Variant>` uses `CopyFlutterAssetsTask`.

Build scripts that look up these tasks at the top level of `build.gradle(.kts)`
or cast them to `Copy` fail.
To update task lookups, refer to
[Look up Flutter tasks](#look-up-flutter-tasks).

### Add-to-app modules

A Flutter module (`flutter create --template=module`) now configures tasks in
`onVariants` and registers assets and native libraries on its library variants.
Your host app consumes the module like any standard Android library,
and Flutter no longer looks up or mutates the host `:app` project:

- `flutter.hostAppProjectName` in `gradle.properties` has no effect.
  If this property is set, Flutter logs a warning when the host app builds from
  Gradle or Android Studio.
- The Flutter build mode matches the module variant consumed by your host app
  (`debug`, `profile`, or `release`).
  For a custom host build type, AGP selects the module variant using
  `matchingFallbacks`.
  Previously, the Flutter build mode followed the host build type's debuggable
  flag, which could mismatch AGP's selected variant and omit Flutter assets.
  Now both always match, so list your desired module build type first in
  `matchingFallbacks`.
- Every module variant is configured lazily regardless of which Gradle task you
  invoke, because `matchingFallbacks`—not the task name—determines which module
  variant a host build consumes.
  Only the consumed variant's tasks execute.

### `flutter build aar` publishing

`flutter build aar` publishes one variant per requested build mode
(such as `demoRelease` when `--flavor demo` is passed)
from the module and each Android plugin:

- If a module or plugin declares `android.publishing.singleVariant(...)` for a
  variant, Flutter preserves that declaration.
  Flutter then configures publishing (with sources and Javadoc JARs) for the
  remaining variants.
- The requested variant must exist in the module and in every Android plugin.
  If any plugin lacks that variant, the build fails.
  Pass `--flavor` to select a flavor variant defined across the module and its
  plugins.

### Other changes

- The warning logged when a plugin's `compileSdk` exceeds the app's
  `compileSdk` now compares integer API levels numerically instead of
  lexicographically.
  Any preview `compileSdk` counts as higher than any integer API level,
  and two preview `compileSdk` values aren't compared against each other.
- Flutter's dependency version checks now run before FGP accesses Android DSL
  extensions or registers tasks.
  Unsupported Gradle, Java, AGP, or KGP versions fail with a version error
  instead of an API exception.
  For details, consult [Raised minimum Android build tool versions][].

[Raised minimum Android build tool versions]: /release/breaking-changes/android-build-tool-minimum-versions
[split-abi-fix]: #fix-split-per-abi-versioncode-warnings-or-errors
[versioncode-guide]: #set-per-abi-or-per-variant-versioncode-values

## Migration guide

The following examples use the Kotlin DSL (`build.gradle.kts`),
which Flutter's project templates generate.
The same `androidComponents` API works in Groovy (`build.gradle`);
in Groovy, append `.INSTANCE` when referencing Kotlin `object` declarations
such as `SingleArtifact.APK.INSTANCE`.

### Rename or copy APKs

Code before migration (legacy variant API):

```groovy title="<flutter-project>/android/app/build.gradle"
android {
    applicationVariants.all { variant ->
        variant.outputs.all { output ->
            outputFileName = "myapp-${variant.versionName}.apk"
        }
    }
}
```

The public Variant API doesn't expose `outputFileName`.
Instead, register a `Copy` task that reads `SingleArtifact.APK`.
Place `androidComponents` at the top level of your build file, next to
`android {}`:

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

Flutter's own copy task continues placing APKs in
`build/app/outputs/flutter-apk/` with unchanged filenames
(such as `app-release.apk` or `app-arm64-v8a-release.apk`),
so `flutter build apk` and scripts that read that directory keep working.

### Fix split-per-ABI `versionCode` warnings or errors

Declare `versionCode` in your `android {}` DSL block when building with
`flutter build apk --split-per-abi`.
This step is needed if your app sets `android:versionCode` only in
`AndroidManifest.xml`, uses a manifest placeholder, or omits `versionCode`.
Set `versionCode = flutter.versionCode` in `defaultConfig`
(or set `versionCode` on each product flavor) in your
`android/app/build.gradle.kts` file, and remove `android:versionCode` from
`AndroidManifest.xml`:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
android {
    defaultConfig {
        // ...
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
}
```

:::important
**TODO(reidbaker):** Match the conditions above to the [PR 196561][] `3.50.x`
cherry-pick decision before removing draft status.
Without [PR 196561][], manifest-only and missing-`versionCode` apps both log a
warning and share one `versionCode`.
With [PR 196561][], manifest-only integer `versionCode` apps work without
changes, while apps without a readable integer `versionCode` fail the build.
:::

#### Escape hatch: disable the per-ABI `versionCode` offset

If you intentionally want every split APK to keep the same `versionCode`
(without Flutter's `abiOffset * 1000` prefix), pass the Gradle project property
`force-version-code-ignoring-abi=true`.
This property works in Flutter 3.50.0 both from the command line and from
`gradle.properties`:

- **Command line:** Pass `-P force-version-code-ignoring-abi=true` to
  `flutter build apk`:

  ```bash
  flutter build apk --split-per-abi -P force-version-code-ignoring-abi=true
  ```

  `-P` (an alias for `--android-project-arg`) is a hidden Flutter CLI option
  listed in `flutter build apk -h -v`.

- **Project configuration:** Add the property to your
  `android/gradle.properties` file:

  ```properties title="<flutter-project>/android/gradle.properties"
  force-version-code-ignoring-abi=true
  ```

:::caution Google Play upload restriction
When `force-version-code-ignoring-abi=true` is enabled, all split APKs share
one `versionCode`, so Google Play rejects them if you upload them together in
the same release.
Use this property only when you distribute each ABI APK separately rather than
uploading the set to Google Play.
:::

### Set per-ABI or per-variant `versionCode` values

Code before migration (legacy variant API):

```groovy title="<flutter-project>/android/app/build.gradle"
android.applicationVariants.all { variant ->
    variant.outputs.each { output ->
        def abi = output.getFilter(OutputFile.ABI)
        output.versionCodeOverride = abiCodes.get(abi) * 1000 + variant.versionCode
    }
}
```

Code after migration:

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

Compute the new value from a base you already control—such as
`flutter.versionCode` (from `defaultConfig`) or a product flavor's
`versionCode`—rather than reading `output.versionCode`.
AGP disallows reading `output.versionCode` during configuration when legacy API
compatibility mode (`android.compatibility.enableLegacyApi`) is disabled.

If your build script previously multiplied Flutter's `versionCode`,
the resulting `versionCode` values change because Flutter's callback now runs
first.
For example, an app that multiplies by `10000` and builds with
`--build-number 42` produces these values:

| ABI (offset) | Before: `offset * 1000 + 42 * 10000` | After: `(offset * 1000 + 42) * 10000` |
| :--- | :--- | :--- |
| `armeabi-v7a` (1) | 421000 | 10420000 |
| `arm64-v8a` (2) | 422000 | 20420000 |
| `x86_64` (4) | 424000 | 40420000 |

The new values remain distinct, preserve ABI ordering, and increase
monotonically, so Google Play accepts the new APKs as upgrades.
Downgrading to an earlier Flutter release lowers those values, which Google
Play rejects.
To keep producing the `422000`-style numbers instead, compute them directly
from `flutter.versionCode`:

```kotlin title="<flutter-project>/android/app/build.gradle.kts"
output.versionCode.set((abiCodes[abi] ?: 0) * 1000 + flutter.versionCode * 10000)
```

To verify the final `versionCode`, inspect a built APK:

```bash
apkanalyzer manifest version-code build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

### Configure custom build types

When defining a custom build type, declare `matchingFallbacks` so plugins and
Android libraries without that build type resolve a fallback variant.
AGP selects the first build type in the list that each library defines:

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

If you run into issues debugging a plugin's native (C++/JNI) code in a custom
build type, use the standard `debug` build type for native debugging instead.

### Look up Flutter tasks

FGP now registers tasks inside `androidComponents.onVariants` (after top-level
`build.gradle.kts` evaluation), and `copyFlutterAssets<Variant>` uses
`CopyFlutterAssetsTask` instead of `org.gradle.api.tasks.Copy`.
As a result, top-level `tasks.named("copyFlutterAssetsDebug")` calls and typed
`Copy::class` lookups both fail.

Configure Flutter tasks lazily by name with `tasks.matching`, without
specifying the `Copy` task type:

```kotlin diff title="<flutter-project>/android/app/build.gradle.kts"
- tasks.named("copyFlutterAssetsDebug", Copy::class) {
+ tasks.matching { it.name == "copyFlutterAssetsDebug" }.configureEach {
      // ...
  }
```

Alternatively, call `tasks.named("copyFlutterAssetsDebug")` inside your own
`androidComponents.onVariants` block, which runs after FGP's callback when FGP
is applied in `plugins {}`.
When you need Flutter's build outputs, prefer wiring through Variant API
artifacts (such as `SingleArtifact.APK` or `variant.sources.assets`) instead of
depending on task names.

### Update add-to-app host apps

- Remove `flutter.hostAppProjectName` from the Flutter module's
  `.android/gradle.properties` file and from your host app's
  `gradle.properties` file if present.
  The property has no effect.
- If your host app defines a custom build type, list the desired Flutter module
  build type first in `matchingFallbacks`.
  For example, to consume debug Flutter artifacts in a `staging` host build:

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

- If your host script configures `copyFlutterAssets<Variant>` with `Copy` or
  top-level `tasks.named`, update it using
  [Look up Flutter tasks](#look-up-flutter-tasks).

### Update Flutter plugins

- Replace `android.applicationVariants` and `android.libraryVariants` in your
  plugin's `build.gradle(.kts)` file with `androidComponents.onVariants`.
  The ecosystem audit for legacy variant API usage is tracked in
  [Issue 190845][].
- Don't assume Flutter's tasks exist during top-level build script evaluation
  or implement `org.gradle.api.tasks.Copy`.
- If your plugin's example app defines a custom build type, set
  `matchingFallbacks` on that build type.
- Test your plugin's example app on AGP `9.1.1` or later with both
  `android.newDsl=true` and `android.builtInKotlin=true` in
  `gradle.properties`.
  The new DSL requires built-in Kotlin because KGP rejects
  `android.newDsl=true`.

### Keep the opt-out, or opt in early

If you can't migrate your own build scripts yet, no action is required in
Flutter 3.50: `android.newDsl=false` remains enabled by default.
If the `android.newDsl` line is missing from `android/gradle.properties`,
Flutter's migrator adds `android.newDsl=false` on the next `flutter run` or
`flutter build` of your app.
Treat `android.newDsl=false` as a temporary workaround:
AGP 10 removes the legacy APIs and drops support for this property.

To test migrated build scripts against the new DSL now, set both properties to
`true` in `android/gradle.properties`.
In Flutter 3.50, the migrator doesn't modify an existing `android.newDsl` line:

```properties title="<flutter-project>/android/gradle.properties"
android.newDsl=true
android.builtInKotlin=true
```

Enabling `android.newDsl=true` also requires `android.builtInKotlin=true`,
because KGP rejects `android.newDsl=true`.
If a plugin in your app still requires KGP, keep both properties set to
`false`.

## Timeline

Landed in version: 3.50.0-0.1.pre and 3.50.0-0.4.pre<br>
In stable release: 3.50

## References

Relevant issues:

- [Issue 166550][]: Remove code that manipulates AGP tasks by discovering them
  via their name
- [Issue 180137][]: Migrate from the old to the new AGP DSL
- [Issue 190845][]: Audit plugins for legacy variant API usage
- [Issue 193713][]: Publish this migration guide
- [Issue 196559][]: `--split-per-abi` gives every split APK the same
  `versionCode` when `versionCode` is set only in `AndroidManifest.xml`

Relevant pull requests:

- [PR 190957][]: Extract internal utilities
- [PR 191218][]: Add `buildModeFor` overloads and wire Flutter dependencies
  through the new DSL
- [PR 191606][]: Replace plugin build-type copy with `initWith` on the public
  DSL
- [PR 192116][]: Delete `getLegacyAndroidExtension` and migrate the NDK
  fallback to the public DSL
- [PR 192488][]: Deliver Flutter assets as a generated assets source directory
- [PR 193693][]: Migrate the `flutter-apk` copy and per-ABI `versionCode` to
  the Variant API
- [PR 193717][]: Unify add-to-app module wiring on the Variant API
- [PR 193962][] (cherry-picked to 3.50 in [PR 195640][]): Move
  `aar_init_script` to public AGP APIs
- [PR 196561][]: Offset split-APK `versionCode` values from a manifest-only
  `versionCode` (TODO(reidbaker): remove or keep based on 3.50.x cherry-pick)

Contributor documentation:

- [Migrating the Flutter Gradle Plugin to the AGP public API surface][]

[Issue 166550]: {{site.repo.flutter}}/issues/166550
[Issue 180137]: {{site.repo.flutter}}/issues/180137
[Issue 190845]: {{site.repo.flutter}}/issues/190845
[Issue 193713]: {{site.repo.flutter}}/issues/193713
[Issue 196559]: {{site.repo.flutter}}/issues/196559
[PR 190957]: {{site.repo.flutter}}/pull/190957
[PR 191218]: {{site.repo.flutter}}/pull/191218
[PR 191606]: {{site.repo.flutter}}/pull/191606
[PR 192116]: {{site.repo.flutter}}/pull/192116
[PR 192488]: {{site.repo.flutter}}/pull/192488
[PR 193693]: {{site.repo.flutter}}/pull/193693
[PR 193717]: {{site.repo.flutter}}/pull/193717
[PR 193962]: {{site.repo.flutter}}/pull/193962
[PR 195640]: {{site.repo.flutter}}/pull/195640
[PR 196561]: {{site.repo.flutter}}/pull/196561
[Migrating the Flutter Gradle Plugin to the AGP public API surface]: {{site.repo.flutter}}/blob/master/docs/platforms/android/Migrating-Flutter-Gradle-Plugin-to-AGP-public-API.md
