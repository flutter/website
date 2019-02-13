---
title: Using packages
description: Learn how to use packages in your Flutter app.
---

Flutter supports using shared packages contributed by other developers
to the Flutter and Dart ecosystems. This allows you to quickly build
your app without having to develop everything from scratch.

Existing packages enable many use cases, for example, making network requests
([`http`](/docs/cookbook/networking/fetch-data)), custom navigation/route handling
([`fluro`]({{site.pub-pkg}}/fluro)), integration with device
APIs (like [`url_launcher`]({{site.pub-pkg}}/url_launcher) &
[`battery`]({{site.pub-pkg}}/battery)),
and using third-party platform SDKs (like
[Firebase]({{site.github}}/flutter/plugins/blob/master/FlutterFire.md)).

If you are looking to develop a new package, please see
[developing packages](/docs/development/packages-and-plugins/developing-packages).

If you are looking to add assets, images, or fonts, whether stored in
files or packages, please see [Assets & images](/docs/development/ui/assets-and-images).

## Using packages

### Searching for packages

Packages are published to the [*Pub site*]({{site.pub}}).

The [Flutter landing page]({{site.pub}}/flutter) on
the Pub site displays top packages that are compatible with Flutter
(those that declare dependencies generally compatible with Flutter),
and supports searching among all published packages.

### Adding a package dependency to an app

To add a package 'css_colors' to an app:

1. Depend on it
   * Open the `pubspec.yaml` file located inside your app folder, and add
     `css_colors:` under `dependencies`.

1. Install it
   * From the terminal: Run `flutter packages get`<br/>
   **OR**
   * From Android Studio/IntelliJ: Click 'Packages Get' in the action
     ribbon at the top of `pubspec.yaml`
   * From VS Code: Click 'Get Packages' located in right side of the action
     ribbon at the top of `pubspec.yaml`

1. Import it
   * Add a corresponding `import` statement in your Dart code.

1. Stop and restart the app, if necessary
   * If the package brings platform-specific code (Java/Kotlin for Android,
     Swift/Objective-C for iOS), that code must be built into your app.
     Hot reload and hot restart do this only for the Dart code of the
     package, so you may have to do a full restart of the app to avoid
     errors like `MissingPluginException` when using the package.

The
['Installing']({{site.pub-pkg}}/css_colors#-installing-tab-)
tab available on any package page on Pub is a handy reference for these
steps.

For a complete example, see [CSS Colors example](#css-example) below.

## Developing new packages

Should a package not be available for your specific use case, you can
[develop new custom
packages](/docs/development/packages-and-plugins/developing-packages).

## Managing package dependencies & versions

### Package versions

All packages have a version number, specified in their `pubspec.yaml` file.
The current version of a package is displayed next to its name (for example,
see the
[url_launcher]({{site.pub-pkg}}/url_launcher) package), as
well as a list of all prior versions ([url_launcher
versions]({{site.pub-pkg}}/url_launcher#-versions-tab-)).

When a package is added to `pubspec.yaml` using the shorthand form `plugin1:`
this is interpreted as `plugin1: any`, i.e. any version of the package may be
used. To ensure your app does not break when a package is updated,
we recommend specifying a version range using one of the following formats:

* Range constraints: Specify a minimum and maximim version. For example:

  ```
  dependencies:
    url_launcher: '>=0.1.2 <0.2.0'
  ```

* Range constraint with [*caret
  syntax*]({{site.dart-site}}/tools/pub/dependencies#caret-syntax)
  is similar to regular range constraints:

  ```
  dependencies:
    collection: '^0.1.2'
  ```

For additional details, see the [Pub versioning
guide]({{site.dart-site}}/tools/pub/versioning).

### Updating package dependencies

When you run `flutter packages get` ('Packages Get' in IntelliJ) for
the first time after adding a package, Flutter saves the concrete package
version found in the `pubspec.lock`
[lockfile]({{site.dart-site}}/tools/pub/glossary#lockfile).
This ensures that you get the same version again if you, or another
developer on your team, run `flutter packages get`.

If you want to upgrade to a new version of the package,
for example to use new features in that package, run
`flutter packages upgrade` ('Upgrade dependencies'
in IntelliJ). This retrieves the highest available version of the package
that is allowed by the version constraint you have specified in
`pubspec.yaml`.

### Dependencies on unpublished packages

Packages can be used even when not published on Pub. For private plugins not
intended for public publishing, or for packages not yet ready for publishing,
additional dependency options are avaialble:

* **Path** dependency: A Flutter app can depend on a plugin via a file system
  `path:` dependency. The path can be either relative, or absolute.
  For example, to depend on a plugin 'plugin1' located in a directory
  next to the app, use this syntax:

  ```
  dependencies:
    plugin1:
      path: ../plugin1/
  ```

* **Git** dependency: You can also depend on a package stored in a Git
  repository. If the package is located in the root of the repo, use this
  syntax:
  ```
  dependencies:
    plugin1:
      git:
        url: git://github.com/flutter/plugin1.git
  ```

* **Git** dependency on a package in a folder: By default Pub assumes the
  package is located in the root of the Git repository. If that is not the
  case, you can specify the location with the `path` argument. For example:
  ```
  dependencies:
    package1:
      git:
        url: git://github.com/flutter/packages.git
        path: packages/package1
  ```

  Finally, you can use the `ref` argument to pin the dependency to a
  specific git commit, branch, or tag. For more details, see
  [Pub Dependencies]({{site.dart-site}}/tools/pub/dependencies).

## Examples

### Example: Using the CSS Colors package {#css-example}

The [`css_colors`]({{site.pub-pkg}}/css_colors) package
defines color constants for the CSS colors, allowing you to use them
wherever the Flutter framework expects the `Color` type.

To use this package:

1. Create a new project called 'cssdemo'

1. Open `pubspec.yaml`, and replace:
   ```
   dependencies:
     flutter:
       sdk: flutter
   ```
   with:

   ```
   dependencies:
     flutter:
       sdk: flutter
     css_colors: ^1.0.0
   ```

1. Run `flutter packages get` in the terminal, or click 'Packages get' in
   IntelliJ

1. Open `lib/main.dart` and replace its full contents with:

```dart
import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: CSSColors.orange));
  }
}
```

1. Run the app. When you click the 'Show Flutter homepage' you should see the
   phone's default browser open, and the Flutter homepage appear.


### Example: Using the URL Launcher package to launch the browser {#url-example}

The [URL Launcher]({{site.pub-pkg}}/url_launcher) plugin
package enables you to open the default browser on the mobile platform to
display a given URL. It demonstrates how packages may also contain
platform-specific code (we call these packages 'plugins').
It is supported on both Android and iOS.

To use this plugin:

1. Create a new project called 'launchdemo'

1. Open `pubspec.yaml`, and replace:
   ```
   dependencies:
     flutter:
       sdk: flutter
   ```
   with:

   ```
   dependencies:
     flutter:
       sdk: flutter
     url_launcher: ^0.4.1
   ```

1. Run `flutter packages get` in the terminal, or click 'Packages get' in
   IntelliJ

1. Open `lib/main.dart` and replace its full contents with:

```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  launchURL() {
    launch('https://flutter.io');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: launchURL,
          child: Text('Show Flutter homepage'),
        ),
      ),
    );
  }
}
```

1. Run the app (or stop and restart it, if you already had it running
   before adding the plugin). When you click the 'Show Flutter homepage'
   you should see the phone's default browser open, and the Flutter
   homepage appear.
