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
and two build modes (`debug`, `release`):

| Flavor     | Build mode | Output directory |
|------------|------------|------------------|
| staging    | debug      | `build/linux/&lt;arch&gt;/staging/debug/bundle/`      |
| production | debug      | `build/linux/&lt;arch&gt;/production/debug/bundle/`   |
| staging    | release    | `build/linux/&lt;arch&gt;/staging/release/bundle/`    |
| production | release    | `build/linux/&lt;arch&gt;/production/release/bundle/` |
{:.table .table-striped}

[CMake]: https://cmake.org/
[Android]: /deployment/flavors
[iOS and macOS]: /deployment/flavors-ios
[Windows]: /deployment/flavors-windows

## Configure CMake for flavors [OPTIONAL] {: #configure-cmake }

Passing `--flavor` works on Linux without any project configuration.
Flutter isolates the build directory, populates `appFlavor`,
and filters flavor-specific assets automatically.

Complete the following optional steps only if you want to
differentiate the **native** runner per flavor—for example its
window title, application ID, or app icon.

This example configures two flavors called `staging` and `production`.

1.  Create a new Flutter project called `flavors_example`:

    ```console title="console"
    $ flutter create flavors_example
    $ cd flavors_example
    ```

1. Configure the CMake build files for your target platform:

    Open `linux/CMakeLists.txt` and locate the `set(BINARY_NAME ...)` and
    `set(APPLICATION_ID ...)` lines.
    Update the configuration to append the flavor name to the binary name
    and application ID when a flavor is specified:

    ```cmake title="linux/CMakeLists.txt"
    # The name of the executable created for the application.
    set(BINARY_NAME "flavors_example")
    # The unique GTK application identifier for this application.
    set(APPLICATION_ID "com.example.flavors_example")

    if(DEFINED FLUTTER_APP_FLAVOR AND NOT FLUTTER_APP_FLAVOR STREQUAL "")
      set(BINARY_NAME "${BINARY_NAME}_${FLUTTER_APP_FLAVOR}")
      set(APPLICATION_ID "${APPLICATION_ID}.${FLUTTER_APP_FLAVOR}")
    endif()
    ```

3. Verify that your flavors run correctly:

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
launch or build a specific flavor using the `--flavor` flag
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
    `appFlavor` returns `null`.
    :::

## Customize configurations {: #customize-configurations }

After adding flavors,
you can customize native settings and assets for each configuration.

### Create distinct window titles {: #create-distinct-window-titles }

To help distinguish between different flavors at runtime,
you can customize the native window title for each flavor.

1. Open `linux/runner/CMakeLists.txt` and pass `FLUTTER_APP_FLAVOR`
   as a preprocessor definition:

    ```cmake title="linux/runner/CMakeLists.txt"
    if(DEFINED FLUTTER_APP_FLAVOR AND NOT FLUTTER_APP_FLAVOR STREQUAL "")
      target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_APP_FLAVOR=\"${FLUTTER_APP_FLAVOR}\"")
    endif()
    ```

2. Open `linux/runner/my_application.cc` and update the window title
   in the `my_application_activate` function:

    ```c title="linux/runner/my_application.cc"
    #if defined(FLUTTER_APP_FLAVOR)
      const char* title = "flavors_example (" FLUTTER_APP_FLAVOR ")";
    #else
      const char* title = "flavors_example";
    #endif

    if (use_header_bar) {
      GtkHeaderBar* header_bar = GTK_HEADER_BAR(gtk_header_bar_new());
      gtk_widget_show(GTK_WIDGET(header_bar));
      gtk_header_bar_set_title(header_bar, title);
      gtk_header_bar_set_show_close_button(header_bar, TRUE);
      gtk_window_set_titlebar(window, GTK_WIDGET(header_bar));
    } else {
      gtk_window_set_title(window, title);
    }
    ```

### Create distinct app icons {: #create-distinct-app-icons }

You can provide unique icons for each flavor.

1. Prepare PNG icons for each flavor
   (for example, `app_icon_staging.png` and `app_icon_production.png`).

1. Create corresponding `.desktop` files for each flavor
   (for example, `flavors_example_staging.desktop` and
   `flavors_example_production.desktop`)
   that reference the respective icon and executable binary name.

1. Update `linux/CMakeLists.txt` to install the correct `.desktop` file
   and icon based on `FLUTTER_APP_FLAVOR`.

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

* [Set up Flutter flavors for Android][]
* [Set up Flutter flavors for iOS and macOS][]
* [Set up Flutter flavors for Windows][]
* [Build and release a Linux app to the Snap Store][]

[Build and release a Linux app to the Snap Store]: /deployment/linux
[Set up Flutter flavors for Android]: /deployment/flavors
[Set up Flutter flavors for iOS and macOS]: /deployment/flavors-ios
[Set up Flutter flavors for Windows]: /deployment/flavors-windows

