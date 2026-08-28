---
title: Set up Flutter flavors for Linux
shortTitle: Flavors (Linux)
description: >-
  How to create Flutter flavors for Linux desktop apps.
---

This guide shows you how to create Flutter flavors for
Linux desktop apps.

:::note
To create app flavors for other platforms,
visit the pages on setting up flavors for:

* [Android][]
* [iOS and macOS][]
* [Windows][]
:::

## Overview {: #overview }

A Flutter flavor represents a collection of settings that define
how a specific version of your app builds and runs.
For example, a flavor can determine which window title,
application ID, API endpoint, asset set, and logging configuration
applies to a build.

On Linux, Flutter uses [CMake][] to configure and build
the native desktop runner.
When you run `flutter run` or `flutter build` with the `--flavor` flag,
Flutter writes the flavor name into
`linux/flutter/ephemeral/generated_config.cmake` as the
`FLUTTER_APP_FLAVOR` variable, and isolates the build outputs
in a flavor-specific directory.

:::important
The `generated_config.cmake` file is included from
`linux/flutter/CMakeLists.txt`, so `FLUTTER_APP_FLAVOR`
only becomes visible in your top-level `CMakeLists.txt` **after**
the `add_subdirectory(${FLUTTER_MANAGED_DIR})` line.
Any `if(DEFINED FLUTTER_APP_FLAVOR)` block placed before that line
is silently skipped.
:::

The following table illustrates the build directories that Flutter creates
when a project defines two flavors (`staging`, `production`)
and two build modes (`debug`, `release`):

| Flavor     | Build mode | Output directory                                     |
|------------|------------|------------------------------------------------------|
| staging    | debug      | `build/linux/<arch>/staging/debug/bundle/`           |
| production | debug      | `build/linux/<arch>/production/debug/bundle/`        |
| staging    | release    | `build/linux/<arch>/staging/release/bundle/`         |
| production | release    | `build/linux/<arch>/production/release/bundle/`       |
{:.table .table-striped}

[CMake]: https://cmake.org/
[Android]: /deployment/flavors
[iOS and macOS]: /deployment/flavors-ios
[Windows]: /deployment/flavors-windows

## Configure CMake for flavors (optional) {: #configure-cmake }

Passing `--flavor` works on Linux without any project configuration.
Existing Flutter projects support flavors with no template updates
or configuration changes required.
When you pass `--flavor`, Flutter isolates the build directory,
populates `appFlavor`, and filters flavor-specific assets automatically.

Complete the following optional steps only if you want to
differentiate the native runner per flavor—for example,
its GTK application ID or window title.
This example configures two flavors called `staging` and `production`.

1.  Create a new Flutter project called `flavors_example`:

    ```console title="console"
    $ flutter create flavors_example
    $ cd flavors_example
    ```

1.  Configure flavor-specific application IDs in `linux/CMakeLists.txt`:

    Open `linux/CMakeLists.txt` and find the
    `add_subdirectory(${FLUTTER_MANAGED_DIR})` line.
    Set the `APPLICATION_ID` per flavor immediately after that line:

    ```cmake title="linux/CMakeLists.txt"
    # Flutter library and tool build rules.
    set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
    add_subdirectory(${FLUTTER_MANAGED_DIR})

    if(DEFINED FLUTTER_APP_FLAVOR)
      if(FLUTTER_APP_FLAVOR STREQUAL "staging")
        set(APPLICATION_ID "com.example.staging")
      elseif(FLUTTER_APP_FLAVOR STREQUAL "production")
        set(APPLICATION_ID "com.example.production")
      endif()
    endif()
    ```

    `APPLICATION_ID` must be configured after
    `add_subdirectory(${FLUTTER_MANAGED_DIR})` because
    `FLUTTER_APP_FLAVOR` only becomes available at this point,
    and before `add_subdirectory("runner")` where `APPLICATION_ID` is consumed.

    :::important
    Leave `set(BINARY_NAME ...)` unchanged.
    The Flutter CLI resolves the executable path by parsing that line literally,
    so renaming the binary per flavor prevents `flutter run`
    from launching the app.
    :::

1.  Verify that your flavors run correctly:

    Run the `staging` flavor:

    ```console title="console"
    $ flutter run -d linux --flavor staging
    ```

    Run the `production` flavor:

    ```console title="console"
    $ flutter run -d linux --flavor production
    ```

## Launch a flavor {: #launch-a-flavor }

After you configure flavors for your app,
run, build, or test a specific flavor using the `--flavor` flag
with the Flutter CLI.

### Run a flavor in debug mode {: #run-a-flavor }

To run a specific flavor during development,
pass the `--flavor` option to `flutter run`:

```console title="console"
$ flutter run -d linux --flavor <flavor_name>
```

Replace `<flavor_name>` with the name of your flavor
(for example, `staging` or `production`).

### Build a release binary {: #build-a-flavor }

To build a release executable for a specific flavor,
pass the `--flavor` option to `flutter build`:

```console title="console"
$ flutter build linux --flavor <flavor_name>
```

Flutter outputs the compiled bundle to
`build/linux/<arch>/<flavor_name>/release/bundle/`.

### Run tests with a flavor {: #test-a-flavor }

The `--flavor` option also works with `flutter test` and `flutter drive`,
allowing you to run unit, widget, or integration tests
against a specific flavor configuration:

```console title="console"
$ flutter test --flavor <flavor_name>
```

## Use flavors in Flutter code {: #use-flavors-in-code }

After adding flavors,
you can adjust app behavior—such as selecting API endpoints,
toggling features, or setting analytics keys—based on the active flavor.

The Flutter framework provides the `appFlavor` constant in the `services`
library, which retrieves the flavor name passed to the `--flavor` flag
during `flutter run` or `flutter build`.

1.  **Import the services library:**

    Add the following import to your Dart file:

    ```dart
    import 'package:flutter/services.dart';
    ```

1.  **Read the flavor value:**

    Use the `appFlavor` constant in your application logic
    (often in `main()`) to handle flavor-specific configuration:

    ```dart
    void main() {
      if (appFlavor == 'production') {
        Config.apiUrl = 'https://api.example.com';
      } else if (appFlavor == 'staging') {
        Config.apiUrl = 'https://staging.api.example.com';
      }

      runApp(const MyApp());
    }
    ```

    :::note
    The value of `appFlavor` matches the string passed to the `--flavor` flag.
    If you run or build without specifying a flavor,
    `appFlavor` returns `null` and the build uses the
    [default flavor](#set-default-flavor).
    :::

## Customize configurations {: #customize-configurations }

After adding flavors,
you can customize native settings and assets for each configuration.

### Create distinct window titles {: #create-distinct-window-titles }

To help distinguish between different flavors at runtime,
customize the native window title for each flavor.

1.  In `linux/runner/CMakeLists.txt`, pass `FLUTTER_APP_FLAVOR`
    as a preprocessor definition directly after the existing
    `APPLICATION_ID` definition:

    ```cmake title="linux/runner/CMakeLists.txt"
    # Add preprocessor definitions for the application ID.
    add_definitions(-DAPPLICATION_ID="${APPLICATION_ID}")

    if(DEFINED FLUTTER_APP_FLAVOR AND NOT FLUTTER_APP_FLAVOR STREQUAL "")
      add_definitions(-DFLUTTER_APP_FLAVOR="${FLUTTER_APP_FLAVOR}")
    endif()
    ```

1.  In `linux/runner/my_application.cc`, update the window title
    in the `my_application_activate` function:

    ```c title="linux/runner/my_application.cc"
      const gchar* window_title = "flavors_example";
    #ifdef FLUTTER_APP_FLAVOR
      if (g_strcmp0(FLUTTER_APP_FLAVOR, "staging") == 0) {
        window_title = "Staging App";
      } else if (g_strcmp0(FLUTTER_APP_FLAVOR, "production") == 0) {
        window_title = "Production App";
      }
    #endif
    ```

    Then update `my_application_activate` to use `window_title`
    instead of the hardcoded string literals:

    ```c title="linux/runner/my_application.cc"
        gtk_header_bar_set_title(header_bar, window_title);
        ...
        gtk_window_set_title(window, window_title);
    ```

### Configure app icons {: #configure-app-icons }

On Linux, application icons are not embedded directly in the compiled
executable binary.
Instead, the desktop environment resolves app icons through
`.desktop` launcher files and installed icon themes.

To provide different icons or launcher entries for each flavor,
configure your Linux package format—such as Snap, Flatpak, or Debian
packages—to install distinct desktop entries and icon assets.
To learn more about packaging Linux apps, refer to
[Build and release a Linux desktop app][].

### Bundle assets by flavor {: #bundle-assets }

If you have assets that only apply to a specific flavor,
configure Flutter to only bundle those assets when building that flavor.
This prevents unused assets from increasing your application bundle size.

To bundle assets conditionally,
add the `flavors` list to an asset entry in `pubspec.yaml`:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - assets/common/
    - path: assets/staging/
      flavors:
        - staging
    - path: assets/production/
      flavors:
        - production
```

To learn more, consult the [`assets` field][] in [Flutter pubspec options][].

[`assets` field]: /tools/pubspec#assets
[Flutter pubspec options]: /tools/pubspec

### Set a default flavor {: #set-default-flavor }

To specify a flavor to use when running or building
without the `--flavor` flag,
add the `default-flavor` property to `pubspec.yaml`:

```yaml title="pubspec.yaml"
flutter:
  default-flavor: staging
```

To learn more, consult the [`default-flavor` field][] in
[Flutter pubspec options][].

[`default-flavor` field]: /tools/pubspec#default-flavor-field

## More information {: #more-information }

For more information on flavors and desktop deployment,
consult the following resources:

* [Set up Flutter flavors for Android][Android]
* [Set up Flutter flavors for iOS and macOS][iOS and macOS]
* [Set up Flutter flavors for Windows][Windows]
* [Build and release a Linux desktop app][]

[Build and release a Linux desktop app]: /deployment/linux
[Set up Flutter flavors for Android]: /deployment/flavors
[Set up Flutter flavors for iOS and macOS]: /deployment/flavors-ios
[Set up Flutter flavors for Windows]: /deployment/flavors-windows
