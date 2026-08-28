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
application icon, API endpoint, asset set, and logging configuration
applies to a build.

On Windows, Flutter uses [CMake][] to configure and build
the native desktop runner.
When you run `flutter run` or `flutter build` with the `--flavor` flag,
Flutter writes the flavor name into
`windows/flutter/ephemeral/generated_config.cmake` as the
`FLUTTER_APP_FLAVOR` variable, and isolates the build outputs
in a flavor-specific directory.

:::important
The `generated_config.cmake` file is included from
`windows/flutter/CMakeLists.txt`, so `FLUTTER_APP_FLAVOR`
only becomes visible in your top-level `CMakeLists.txt` **after**
the `add_subdirectory(${FLUTTER_MANAGED_DIR})` line.
Any `if(DEFINED FLUTTER_APP_FLAVOR)` block placed before that line
is silently skipped.
:::

The following table illustrates the build directories that Flutter creates
when a project defines two flavors (`staging`, `production`)
and two build modes (`debug`, `release`):

| Flavor     | Build mode | Output directory                                        |
|------------|------------|---------------------------------------------------------|
| staging    | debug      | `build/windows/<arch>/staging/runner/Debug/`            |
| production | debug      | `build/windows/<arch>/production/runner/Debug/`         |
| staging    | release    | `build/windows/<arch>/staging/runner/Release/`          |
| production | release    | `build/windows/<arch>/production/runner/Release/`       |
{:.table .table-striped}

[CMake]: https://cmake.org/
[Android]: /deployment/flavors
[iOS and macOS]: /deployment/flavors-ios
[Linux]: /deployment/flavors-linux

## Create and run flavors {: #create-and-run-flavors }

Passing `--flavor` works on Windows without any CMake configuration.
Existing Flutter projects support flavors with no template updates
or configuration changes required.
When you pass `--flavor`, Flutter isolates the build directory,
populates `appFlavor`, and filters flavor-specific assets automatically.

To try flavors with a sample project,
complete the following steps:

1.  Create a new Flutter project called `flavors_example`:

    ```console title="console"
    $ flutter create flavors_example
    $ cd flavors_example
    ```

1.  Verify that your flavors run correctly:

    Run the `staging` flavor:

    ```console title="console"
    $ flutter run -d windows --flavor staging
    ```

    Run the `production` flavor:

    ```console title="console"
    $ flutter run -d windows --flavor production
    ```

To customize native runner settings for each flavor—such as
the window title or application icon—refer to
[Customize configurations](#customize-configurations).

## Launch a flavor {: #launch-a-flavor }

After you define flavors for your app,
run, build, or test a specific flavor using the `--flavor` flag
with the Flutter CLI.

### Run a flavor in debug mode {: #run-a-flavor }

To run a specific flavor during development,
pass the `--flavor` option to `flutter run`:

```console title="console"
$ flutter run -d windows --flavor <flavor_name>
```

Replace `<flavor_name>` with the name of your flavor
(for example, `staging` or `production`).

### Build a release binary {: #build-a-flavor }

To build a release executable for a specific flavor,
pass the `--flavor` option to `flutter build`:

```console title="console"
$ flutter build windows --flavor <flavor_name>
```

Flutter outputs the compiled executable to
`build/windows/<arch>/<flavor_name>/runner/Release/`.

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

To differentiate the native Windows runner per flavor—such as
giving each flavor a unique window title or application icon—configure
CMake to generate the runner source and resource files
using `configure_file`.

### Configure CMake for native settings {: #configure-cmake-native }

CMake evaluates `windows/runner/CMakeLists.txt` after `FLUTTER_APP_FLAVOR`
is defined.
You can inspect this variable to configure flavor-specific values,
then use `configure_file` to substitute them into template files
for the C++ runner (`main.cpp`) and the Windows resource script (`Runner.rc`).

In `windows/runner/CMakeLists.txt`, add the following block
before the `add_executable(${BINARY_NAME} ...)` line:

```cmake title="windows/runner/CMakeLists.txt"
# Configure flavor-specific settings.
if(DEFINED FLUTTER_APP_FLAVOR)
  if(FLUTTER_APP_FLAVOR STREQUAL "staging")
    set(RUNNER_APP_ICON "staging.ico")
    set(WINDOW_TITLE "Staging App")
  elseif(FLUTTER_APP_FLAVOR STREQUAL "production")
    set(RUNNER_APP_ICON "production.ico")
    set(WINDOW_TITLE "Production App")
  endif()
else()
  set(RUNNER_APP_ICON "app_icon.ico")
  set(WINDOW_TITLE "${BINARY_NAME}")
endif()

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp.in"
  "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp"
  @ONLY
)

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/Runner.rc.in"
  "${CMAKE_CURRENT_SOURCE_DIR}/Runner.rc"
  @ONLY
)
```

:::note
Because `configure_file` generates `main.cpp` and `Runner.rc`
in the source directory at build time,
add both generated files to your project's `.gitignore`:

```gitignore title=".gitignore"
windows/runner/main.cpp
windows/runner/Runner.rc
```

Commit the `.in` template files to version control instead.
:::

### Create distinct window titles {: #create-distinct-window-titles }

To display a flavor-specific window title when the app launches:

1.  Rename `windows/runner/main.cpp` to `windows/runner/main.cpp.in`.

1.  In `windows/runner/main.cpp.in`, find where `window.Create` is called
    and replace the hardcoded title with `@WINDOW_TITLE@`:

    ```cpp title="windows/runner/main.cpp.in"
      if (!window.Create(L"@WINDOW_TITLE@", origin, size)) {
        return EXIT_FAILURE;
      }
    ```

    At configure time, CMake substitutes `@WINDOW_TITLE@`
    with the title configured for the active flavor.

### Create distinct app icons {: #create-distinct-app-icons }

To provide unique desktop icons for each flavor:

1.  Prepare your icon files in `.ico` format
    (for example, `staging.ico` and `production.ico`)
    and place them in `windows/runner/resources/`
    alongside the default `app_icon.ico`.

1.  Rename `windows/runner/Runner.rc` to `windows/runner/Runner.rc.in`.

1.  In `windows/runner/Runner.rc.in`, locate the `IDI_APP_ICON` line
    and update the icon path to use `@RUNNER_APP_ICON@`:

    ```rc title="windows/runner/Runner.rc.in"
    IDI_APP_ICON            ICON                    "resources\\@RUNNER_APP_ICON@"
    ```

    You can also update the metadata strings, such as `FileDescription`
    and `ProductName`, to use `@WINDOW_TITLE@`:

    ```rc title="windows/runner/Runner.rc.in"
    VALUE "FileDescription", "@WINDOW_TITLE@" "\0"
    VALUE "ProductName",     "@WINDOW_TITLE@" "\0"
    ```

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
* [Set up Flutter flavors for Linux][Linux]
* [Build and release a Windows desktop app][]

[Build and release a Windows desktop app]: /deployment/windows
