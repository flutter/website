---
title: "Flutter pubspec options"
description: "Describes the Flutter-only fields in the pubspec file."
---

Every project written in the Dart language,
including all Flutter apps and libraries,
includes a `pubspec.yaml` file, referred to as _the pubspec_.
Creating a new project generates a basic pubspec at the top of the
project tree that contains metadata and lists project dependencies.

**Fields common to both Dart and Flutter projects
are described in [The pubspec file][pubspec] on dart.dev.**
This page lists fields that are only valid for a Flutter project.

[Package dependency management]: /packages-and-plugins/dependency-management
[pubspec]: {{site.dart-site}}/tools/pub/pubspec

## Example

When you create a new project with the
`flutter create` command (or by using the
equivalent button in your IDE), it creates
a pubspec for a basic Flutter app.

The first time you build your project, it
also creates a `pubspec.lock` file that contains
specific versions of the included packages.
This ensures that you get the same version
the next time the project is built.
To learn more about how Flutter and Dart resolve
package dependencies, check out
[Package dependency management][].

The following example of a pubspec file
highlights fields used only in a Flutter app.
Learn more about the non-highlighted fields on
[dart.dev][pubspec].

```yaml title="pubspec.yaml"
name: <project name>
description: A new Flutter project.

publish_to: 'none'  # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1

environment:
  sdk: ^3.13.0

dependencies:
  [!flutter:!]       # Required for every Flutter project
    [!sdk: flutter!] # Required for every Flutter project
  [!flutter_localizations:!] # Required to enable localization
    [!sdk: flutter!]         # Required to enable localization

  [!cupertino_icons: ^1.0.8!] # Only required if you use Cupertino (iOS style) icons

dev_dependencies:
  [!flutter_test:!]
    [!sdk: flutter!] # Required for a Flutter project that includes tests
  [!integration_test:!]
    [!sdk: flutter!] # Required for integration tests

  [!flutter_lints: ^6.0.0!] # Contains a set of recommended lints for Flutter code

[!flutter:!]

  [!uses-material-design: true!] # Required if you use the Material icon font

  [!generate: true!] # Enables generation of localized strings from arb files

  [!config:!] # App-specific configuration flags that mirror `flutter config`
    [!enable-swift-package-manager: true!]

  [!assets:!]  # Lists assets, such as image files
    [!- images/a_dot_burr.jpeg!]
    [!- images/a_dot_ham.jpeg!]

  [!licenses:!] # Lists additional license files to be bundled with the app
    [!- assets/my_license.txt!]

  [!fonts:!]              # Required if your app uses custom fonts
    [!- family: Schyler!]
      [!fonts:!]
        [!- asset: fonts/Schyler-Regular.ttf!]
        [!- asset: fonts/Schyler-Italic.ttf!]
          [!style: italic!]
    [!- family: Trajan Pro!]
      [!fonts:!]
        [!- asset: fonts/TrajanPro.ttf!]
        [!- asset: fonts/TrajanPro_Bold.ttf!]
          [!weight: 700!]
```

## Fields

This page discusses Flutter-only pubspec fields.
Learn more about general Dart fields in
[Dart's pubspec supported fields][].

:::note
The pubspec can have additional auto-generated Flutter
fields that aren't listed here.
:::

[Dart's pubspec supported fields]: {{site.dart-site}}/tools/pub/pubspec#supported-fields

### assets field {: #assets }

A list of asset paths that your app uses. These assets are
bundled with your application. Common types of assets
include static data (for example, `JSON`),
configuration files, icons, and images (`JPEG`, `WebP`,
`GIF`, animated `WebP/GIF`, `PNG`, `BMP`, and `WBMP`).

Besides listing the images that are included in the
app package, an image asset can also refer to one or more
resolution-specific "variants". For more information,
visit the [resolution aware][] section of the
[Assets and images][] page.
For information on adding assets from package
dependencies, visit the
[asset images in package dependencies][]
section in the same page.

The `assets` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - [ path_to_file | path_to_directory ]
      [ flavor_path_field | platform_path_field | transformer_path_field ]
    [...]
```

```yaml
# path_to_file structure
- path/to/directory/file
```

```yaml
# path_to_directory structure
- path/to/directory/
```

```yaml
# flavor_path_field structure
- path: path/to/directory
  flavors:
    - flavor_name
```

```yaml
# platform_path_field structure
- path: path/to/file
  platforms:
    - platform_name
```

```yaml
# transformer_path_field structure
- path: path/to/file
  transformers:
    - package: transformer_package_name
      args: ['arg1', 'arg2'] # Optional
```

Subfields of `assets`:

* `path_to_file`: A string that represents the path to
  a file.
* `path_to_directory`: A string that represents the path to
  a directory.
* `flavor_path_field`: A path field and its flavor
  subfields.
* `platform_path_field`: A path field and its platform
  subfields.
* `transformer_path_field`: A path field and its transformer
  subfields.
* `path`: The path to an asset file or directory.
* `flavors`: A list of flutter flavors to use with assets
  at a specific path. To learn more about
  flavors, visit [Set up flavors for iOS and macOS][] and
  [Set up flavors for Android][].
* `platforms`: A list of platforms to use with assets at a
  specific path. Valid values are `android`, `ios`, `web`, `linux`,
  `macos`, and `windows`.
* `transformers`: A list of transformer packages to run on
  the asset at build time. To learn more, see
  [Transforming assets at build time][].

You can pass in a path to a file:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - assets/images/my_image_a.png
    - assets/images/my_image_b.png
```

You can pass in a path to a directory:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - assets/images/
    - assets/icons/
```

You can pass in a path to a directory for specific
flavors:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - path: assets/flavor_a_and_b/images
      flavors:
        - flavor_a
        - flavor_b
    - path: assets/flavor_c/images
      flavors:
        - flavor_c
```

You can pass in a path to a file for specific platforms:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - path: assets/web_worker.js
      platforms:
        - web
    - path: assets/desktop_icon.png
      platforms:
        - windows
        - linux
        - macos
```

You can configure build-time asset transformers:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler
          args: ['--tessellate']
```

[Set up flavors for iOS and macOS]: /deployment/flavors-ios
[Set up flavors for Android]: /deployment/flavors
[Transforming assets at build time]: /ui/assets/asset-transformation
[Assets and images]: /ui/assets/assets-and-images
[asset images in package dependencies]: /ui/assets/assets-and-images#from-packages
[resolution aware]: /ui/assets/assets-and-images#resolution-aware

### config field {: #config }

A map of keys to flags (`true` or `false`) that influences how
the `flutter` CLI is executed.

The available keys mirror those available in `flutter config --list`.

```yaml title="pubspec.yaml"
flutter:
  config:
    cli-animations: false
```

Use `flutter config --help` for a description of each flag.

Flags are only read from the current _application_ package, and have no effect
in the context of a package or dependency.

<a id="disable-swift-package-manager-field" aria-hidden="true"></a>

#### enable-swift-package-manager field {: #enable-swift-package-manager }

Control whether Flutter uses Swift Package Manager to
manage native iOS and macOS dependencies for this project.
To disable it for this project, set the field to `false`.

```yaml title="pubspec.yaml"
flutter:
  config:
    enable-swift-package-manager: false
```

:::version-note
In Flutter versions earlier than 3.44,
Swift Package Manager isn't enabled by default.

Support for disabling Swift Package Manager will be
removed in a future Flutter release.
To get started with Swift Package Manager, check out
[Swift Package Manager for app developers][] or
[Swift Package Manager for plugin authors][].
:::

[Swift Package Manager for app developers]: /packages-and-plugins/swift-package-manager/for-app-developers
[Swift Package Manager for plugin authors]: /packages-and-plugins/swift-package-manager/for-plugin-authors

### default-flavor field {: #default-flavor }

Assign a default Flutter flavor for an app.
When used, you don't need to include the name of this
flavor in the Flutter launch command.

```yaml title="pubspec.yaml"
flutter:
  default-flavor: flavor_name
```

In the following example, an Android Flutter app has a
flavor called `staging` and `production`. The `production`
flavor is the default flavor. When that flavor is run,
you don't need to include it in the launch command.

```yaml title="pubspec.yaml"
flutter:
  default-flavor: production
```

```console title="console"
# Use this command to run the default flavor (production).
$ flutter run

# Use this command to run non-default flavors (staging).
$ flutter run --flavor staging
```

To learn how to create Flutter flavors,
visit [Set up Flutter flavors for Android][] and
[Set up Flutter flavors for iOS and macOS][].

[Set up Flutter flavors for Android]: /deployment/flavors
[Set up Flutter flavors for iOS and macOS]: /deployment/flavors-ios

### deferred-components field {: #deferred-components }

Defer downloading components to reduce the initial download size
of an Android app. Most often used with large applications,
modularized applications, and applications with on-demand features.

The `deferred-components` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  deferred-components:
    - name: component_name
      libraries:
        - string_expression
        [...]
      assets:
        - string_expression
        [...]
    [...]
```

Deferred component subfields:

* `name`: The unique identifier for a specific deferred
  component.
* `libraries`: A list of Dart libraries that are part of
  the deferred component.
* `assets`: A list of asset paths that are associated with
  the deferred component.

Example:

```yaml title="pubspec.yaml"
flutter:
  deferred-components:
    - name: box_component
      libraries:
        - package:testdeferredcomponents/box.dart
    - name: gallery_feature
      libraries:
        - package:testdeferredcomponents/gallery_feature.dart
      assets:
        - assets/gallery_images/gallery_feature.png
```

To learn more about how you can use deferred components with
a Flutter Android app, see
[Deferred components for Android].

[Deferred components for Android]: /perf/deferred-components

### flutter field {: #flutter }

A field that contains Flutter-specific settings for your
app.

```yaml title="pubspec.yaml"
flutter:
  [flutter_field]
  [...]
```

### fonts field {: #fonts }

Configure and include custom fonts in your Flutter
application.

For examples of using fonts
visit the [Use a custom font][] and
[Export fonts from a package][] recipes in the
Flutter cookbook.

The `fonts` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  fonts:
    -  { font_family_field | font_asset_field }
    [...]
```

```yaml
# font_family_field structure
- family: font_name
  fonts:
    - font_asset_field
    [...]
```

```yaml
# font_asset_field structure
- asset: path/to/directory/font_name
  weight: int_expression # Optional
  style: string_expression # Optional
```

Subfields of `fonts`:

+ `family`: Optional. The font family name. Can have
  multiple font assets.
+ `asset`: The font to use.
+ `weight`: Optional. The weight of the font. This can be
  `100`, `200`, `300`, `400`, `500`, `600`, `700`, `800` or
  `900`.
+ `style`: Optional. The style of the font. This can be
  `italic`.

Use a font that is not part of a font family:

```yaml title="pubspec.yaml"
flutter:
  fonts:
    - asset: fonts/Roboto-Regular.ttf
      weight: 900 # Optional
      style: italic # Optional
```

Use a font family:

```yaml title="pubspec.yaml"
flutter:
  fonts:
    - family: Roboto # Optional
      fonts:
        - asset: fonts/Roboto-Regular.ttf
        - asset: fonts/Roboto-Bold.ttf
          weight: 700 # Optional
          style: italic # Optional
```

Alternatively, if you have a font that requires no family,
weight or style requirements, you can declare it as a simple
asset:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - fonts/Roboto-Regular.ttf
```

[Export fonts from a package]: /cookbook/design/package-fonts
[Use a custom font]: /cookbook/design/fonts

### generate field {: #generate }

Enables generation of Dart files with localized strings from `.arb` files.

Enable general localization:

```yaml title="pubspec.yaml"
flutter:
  generate: true
```

To learn more, visit [Internationalizing Flutter apps][].

[Internationalizing Flutter apps]: /ui/accessibility-and-internationalization/internationalization

### licenses field {: #licenses }

A list of additional license file paths that should be bundled with your
application. These files are typically found within your project's `assets`
directory.

The `licenses` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  licenses:
    - [path_to_file]
```

### module field {: #module }

Configure settings for a Flutter module project when adding Flutter
to an existing host Android or iOS application (Add-to-App).

The `module` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  module:
    androidPackage: com.example.my_module # Optional
    iosBundleIdentifier: com.example.myModule # Optional
```

Subfields of `module`:

* `androidX`: Optional. Specifies whether the module uses AndroidX.
* `androidPackage`: Optional. The package name used for generated Android code.
* `iosBundleIdentifier`: Optional. The bundle identifier used for
  generated iOS code.

To learn more, visit [Add Flutter to existing apps][].

[Add Flutter to existing apps]: /add-to-app

### plugin field {: #plugin }

Configure settings specifically for Flutter plugins.

The `plugin` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  plugin:
    platforms:
      android: # Optional
        package: com.example.my_plugin
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
      ios: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
        sharedDarwinSource: true
      macos: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
        sharedDarwinSource: true
      windows: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
      linux: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
      web: # Optional
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
    implements: # Optional
      - example_platform_interface
```

Subfields of `plugin`:

* `platforms`: A list of platforms that will have
  configuration settings.
* `package`: The Android package name of the plugin. This
  can be used with the Android platform and is required.
* `pluginClass`: The name of the plugin class. Optional if
  `dartPluginClass` is used for the same platform. This
  can be used with the Android, iOS, Linux macOS, and
  Windows platforms.
* `default_package`: Optional. The package that should be
  used as the default implementation of a platform
  interface. Only applicable to federated plugins, where the
  plugin's implementation is split into multiple
  platform-specific packages.
* `dartPluginClass`: Optional. The Dart class that serves
  as the entry point for a Flutter plugin. This
  can be used with the Android, iOS, Linux macOS, and
  Windows platforms.
* `sharedDarwinSource`: Optional. Indicates that the plugin
  shares native code between iOS and macOS. This
  can be used with the iOS and macOS platforms.
* `fileName`: Optional. The file that contains the plugin
  class.
* `ffiPlugin`: Optional. True if the plugin uses a
  Foreign Function Interface (FFI).
* `implements`: Optional. The platform interfaces that a
  Flutter plugin implements.

To learn more about plugins, see
[Developing packages & plugins][].

[Developing packages & plugins]: /packages-and-plugins/developing-packages

### shaders field {: #shaders }

GLSL Shaders with the `.frag` extension must be declared in
the shaders section of your project's `pubspec.yaml` file.
The Flutter command-line tool compiles the shader to its
appropriate backend format and generates its necessary
runtime metadata. The compiled shader is then included in
the application just like an asset.

The `shaders` field has the following structure:

```yaml title="pubspec.yaml"
flutter:
  shaders:
    -  { path_to_file | path_to_directory }
    [...]
```

```yaml
# path_to_file structure
- assets/shaders/file
```

```yaml
# path_to_directory structure
- assets/shaders/
```

Add specific shaders:

```yaml title="pubspec.yaml"
flutter:
  shaders:
    - assets/shaders/shader_a.frag
    - assets/shaders/shader_b.frag
```

Add a directory of shaders:

```yaml title="pubspec.yaml"
flutter:
  shaders:
    - assets/shaders/
```

Alternatively, you can add your shader directory to the
`assets` field:

```yaml title="pubspec.yaml"
flutter:
  assets:
    - assets/shaders/my_shader.frag
```

Like other assets, shaders also support `flavors` and `transformers`.

### uses-material-design field {: #uses-material-design }

Use Material Design components and icon font in your Flutter app.

```yaml title="pubspec.yaml"
flutter:
  uses-material-design: true
```

## Packages

The following Flutter-specific packages can be added to the
pubspec. If you add a package, run `flutter pub get` in your
terminal to install the package.

### flutter package {: #flutter-package }

A package that represents the Flutter SDK itself and
can be added to the `dependencies` field. Use this if
your project relies on the Flutter SDK, not a regular
package from pub.dev.

```yaml title="pubspec.yaml"
dependencies:
  flutter:
    sdk: flutter
```

### flutter_localizations package {: #flutter-localizations }

A package provided by the Flutter SDK that enables
localization of `ARB` files. Often used with the `intl` package.

```yaml title="pubspec.yaml"
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any
```

### flutter_test package {: #flutter_test }

A package provided by the Flutter SDK that contains
testing utilities for unit and widget tests for your Flutter app.

```yaml title="pubspec.yaml"
dev_dependencies:
  flutter_test:
    sdk: flutter
```

### integration_test package {: #integration_test }

A package provided by the Flutter SDK for running
integration tests on target devices or emulators.

```yaml title="pubspec.yaml"
dev_dependencies:
  integration_test:
    sdk: flutter
```

To learn more, visit [Integration testing][].

[Integration testing]: /testing/integration-tests

### flutter_lints package {: #flutter_lints }

A package that provides a set of recommended lints for
Flutter projects. This package can be added to the
`dev_dependencies` field in the pubspec.

```yaml title="pubspec.yaml"
dev_dependencies:
  flutter_lints: ^6.0.0
```

### cupertino_icons package {: #cupertino_icons }

A package that provides a set of Apple's Cupertino icons
for use in Flutter applications. This package can be added
to the `dependencies` field in the pubspec.

```yaml title="pubspec.yaml"
dependencies:
  cupertino_icons: ^1.0.8
```

## More information

For more information on packages, plugins,
and pubspec files, visit the following:

* [Add Flutter to existing apps][]
* [Creating packages][] on dart.dev
* [Glossary of package terms][] on dart.dev
* [Integration testing][]
* [Package dependency management][]
* [Package dependencies][] on dart.dev
* [Set up Flutter flavors for Android][]
* [Set up Flutter flavors for iOS and macOS][]
* [Transforming assets at build time][]
* [Using packages][]
* [What not to commit][] on dart.dev

[Creating packages]: {{site.dart-site}}/guides/libraries/create-library-packages
[Developing packages and plugins]: /packages-and-plugins/developing-packages
[Federated plugins]: /packages-and-plugins/developing-packages#federated-plugins
[Glossary of package terms]: {{site.dart-site}}/tools/pub/glossary
[Package dependencies]: {{site.dart-site}}/tools/pub/dependencies
[Using packages]: /packages-and-plugins/using-packages
[What not to commit]: {{site.dart-site}}/guides/libraries/private-files#pubspeclock
