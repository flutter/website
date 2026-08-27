---
title: Set up Flutter flavors for Windows
shortTitle: Flavors (Windows)
description: >-
  How to create Flutter flavors for Windows desktop apps.
---

This guide shows you how to create Flutter flavors for
Windows desktop apps.

:::note
To create app flavors for other platforms,
visit the pages on setting up flavors for:

* [Android][]
* [iOS and macOS][]
* [Linux][]
:::

## Overview {: #overview }

A Flutter flavor represents a collection of settings that define
how a specific version of your app builds and runs.
For example, a flavor can determine which window title,
application ID, API endpoint, asset set, and logging configuration
applies to a build.

On Windows, Flutter uses [CMake][] to configure and build
the native desktop runner.
When you run `flutter run` or `flutter build` with the `--flavor` flag,
Flutter writes the flavor name into
`<platform>/flutter/ephemeral/generatd_config.cmake` as the
`FLUTTER_APP_FLAVOR` variable, and isolates the build outputs
in a flavor-specific directory.

:::important
The `generated_config.cmake` file is included from
`<platform>/flutter/CMakeLists.txt`, so `FLUTTER_APP_FLAVOR`
only becomes visible in your top-level `CMakeLists.txt` **after**
the `add_subdirectory(${FLUTTER_MANAGED_DIR})` line.
Any `if(DEFINED FLUTTER_APP_FLAVOR)` block placed before that line
is silently skipped.
:::

The following table illustrates the build directories that Flutter creates
when a project defines two flavors (`staging`, `production`)

| Flavor     | Build mode  | Output directory                                        |
|------------|-------------|---------------------------------------------------------|
| staging    | debug       | `build/windows/&lt;arch&gt;/staging/runner/Debug/`      |
| production | debug       | `build/windows/&lt;arch&gt;/production/runner/Debug/`   |
| staging    | release     | `build/windows/&lt;arch&gt;/staging/runner/Release/`    |
| production | release     | `build/windows/&lt;arch&gt;/production/runner/Release/` |
{:.table .table-striped}

[CMake]: https://cmake.org/
[Android]: /deployment/flavors
[iOS and macOS]: /deployment/flavors-ios
[Linux]: /deployment/flavors-linux

## Configure CMake for flavors [OPTIONAL] {: #configure-cmake }

Passing `--flavor` works on Windows without any project configuration.
Flutter isolates the build directory, populates `appFlavor`,
and filters flavor-specific assets automatically.

Complete the following optional steps only if you want to
differentiate the **native** runner per flavor—for example,
its window title, application ID, or app icon.

This example configures two flavors called `staging` and `production`.

1.  Create a new Flutter project called `flavors_example`:

    ```console title="console"
    $ flutter create flavors_example
    $ cd flavors_example
    ```

1. Configure the CMake build files for your target platform:

    Open `windows/CMakeLists.txt` and locate the `set(BINARY_NAME ...)` line.
    Update the configuration to append the flavor name to the binary name
    when a flavor is specified:

    ```cmake title="windows/CMakeLists.txt"
    # The name of the executable created for the application.
    set(BINARY_NAME "flavors_example")
    if(DEFINED FLUTTER_APP_FLAVOR AND NOT FLUTTER_APP_FLAVOR STREQUAL "")
      set(BINARY_NAME "${BINARY_NAME}_${FLUTTER_APP_FLAVOR}")
    endif()
    ```

3. Verify that your flavors run correctly:

    Run the `staging` flavor:

    ```console title="console"
    $ flutter run -d windows --flavor staging
    ```

    Run the `production` flavor:

    ```console title="console"
    $ flutter run -d windows --flavor production
    ```

## Launch a flavor {: #launch-a-flavor }

After you configure flavors for your app,
launch or build a specific flavor using the `--flavor` flag
with the Flutter CLI.

### Run a flavor in debug mode {: #run-a-flavor }

To run a specific flavor during development,
pass the `--flavor` option to `flutter run`:

```console title="console"
$ flutter run -d windows --flavor <flavor_name>
```

### Build a release binary {: #build-a-flavor }

To build a release executable for a specific flavor,
pass the `--flavor` option to `flutter build`:

```console title="console"
$ flutter build windows --flavor <flavor_name>
```

Flutter outputs the compiled executable to
`build/windows/<arch>/<flavor_name>/runner/Release/`.

## Use flavors in Flutter code {: #use-flavors-in-code }

After you configure your flavors,
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
you can customize the native window title for each flavor.

1. Open `windows/runner/CMakeLists.txt` and pass `FLUTTER_APP_FLAVOR`
   as a preprocessor definition:

    ```cmake title="windows/runner/CMakeLists.txt"
    if(DEFINED FLUTTER_APP_FLAVOR AND NOT FLUTTER_APP_FLAVOR STREQUAL "")
      target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_APP_FLAVOR=\"${FLUTTER_APP_FLAVOR}\"")
    endif()
    ```

2. Open `windows/runner/main.cpp` and update the window title
   to include the flavor name when defined:

    ```cpp title="windows/runner/main.cpp"
    #if defined(FLUTTER_APP_FLAVOR)
      std::wstring title = L"flavors_example (" + std::wstring(L"" FLUTTER_APP_FLAVOR) + L")";
      if (!window.Create(title.c_str(), origin, size)) {
        return EXIT_FAILURE;
      }
      #else
        if (!window.Create(L"flavors_example", origin, size)) {
          return EXIT_FAILURE;
        }
      #endif
    ```

### Create distinct app icons {: #create-distinct-app-icons }

You can provide unique icons for each flavor.

1. Prepare your icon files in `.ico` format
   (for example, `app_icon_staging.ico` and `app_icon_production.ico`)
   and place them in `windows/runner/resources/`.

1. In `windows/CMakeLists.txt`, select the appropriate icon file
   based on `FLUTTER_APP_FLAVOR`:

    ```cmake title="windows/CMakeLists.txt"
    if(FLUTTER_APP_FLAVOR STREQUAL "staging")
      set(APP_ICON_NAME "app_icon_staging.ico")
    elseif(FLUTTER_APP_FLAVOR STREQUAL "production")
      set(APP_ICON_NAME "app_icon_production.ico")
    else()
      set(APP_ICON_NAME "app_icon.ico")
    endif()
    ```

3. Configure `windows/runner/Runner.rc` or your CMake target
   to use `APP_ICON_NAME` for the application icon resource.

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

To learn more, see the [`assets` field][] in [Flutter pubspec options][].

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

To learn more, see the [`default-flavor` field][] in
[Flutter pubspec options][].

[`default-flavor` field]: /tools/pubspec#default-flavor-field

## More information {: #more-information }

For more information on flavors and desktop deployment,
consult the following resources:

* [Set up Flutter flavors for Android][Android]
* [Set up Flutter flavors for iOS and macOS][iOS and macOS]
* [Set up Flutter flavors for Linux][Linux]
* [Build and release a Windows desktop app][]

[Build and release a Windows desktop app]: /deployment/windows
