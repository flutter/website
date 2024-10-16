---
title: Developing packages & plugins
short-title: Developing
description: How to write packages and plugins for Flutter.
---

## Package introduction

Packages enable the creation of modular code that can be shared easily.
A minimal package consists of the following:

**`pubspec.yaml`**
: A metadata file that declares the package name,
  version, author, and so on.

**`lib`**
: The `lib` directory contains the public code in
  the package, minimally a single `<package-name>.dart` file.

:::note
For a list of dos and don'ts when writing an effective plugin,
see the Medium article by Mehmet Fidanboylu,
[Writing a good plugin][].
:::

### Package types {:#types}

Packages can contain more than one kind of content:

**Dart packages**
: General packages written in Dart,
  for example the [`path`][] package.
  Some of these might contain Flutter specific
  functionality and thus have a dependency on the
  Flutter framework, restricting their use to Flutter only,
  for example the [`fluro`][] package.

**Plugin packages**
: A specialized Dart package that contains an API written in
  Dart code combined with one or more platform-specific
  implementations.

  Plugin packages can be written for Android
  (using Kotlin or Java), iOS (using Swift or Objective-C),
  web, macOS, Windows, or Linux, or any combination
  thereof.

  A concrete example is the [`url_launcher`][] plugin package.
  To see how to use the `url_launcher` package, and how it
  was extended to implement support for web,
  see the Medium article by Harry Terkelsen,
  [How to Write a Flutter Web Plugin, Part 1][].

**FFI Plugin packages**
: A specialized Dart package that contains an API written in
  Dart code combined with one or more platform-specific
  implementations that use Dart FFI([Android][Android], [iOS][iOS], [macOS][macOS]).

## Developing Dart packages {:#dart}

The following instructions explain how to write a Flutter
package.

### Step 1: Create the package

To create a starter Flutter package,
use the `--template=package` flag with `flutter create`:

```console
$ flutter create --template=package hello
```

This creates a package project in the `hello`
folder with the following content:

**LICENSE**
: A (mostly) empty license text file.

**test/hello_test.dart**
: The [unit tests][] for the package.

**hello.iml**
: A configuration file used by the IntelliJ IDEs.

**.gitignore**
: A hidden file that tells Git which files or
  folders to ignore in a project.

**.metadata**
: A hidden file used by IDEs to track the properties
  of the Flutter project.

**pubspec.yaml**
: A yaml file containing metadata that specifies
  the package's dependencies. Used by the pub tool.

**README.md**
: A starter markdown file that briefly describes
  the package's purpose.

**lib/hello.dart**
: A starter app containing Dart code for the package.

**.idea/modules.xml**, **.idea/workspace.xml**
: A hidden folder containing configuration files
  for the IntelliJ IDEs.

**CHANGELOG.md**
: A (mostly) empty markdown file for tracking
  version changes to the package.

### Step 2: Implement the package

For pure Dart packages, simply add the functionality
inside the main `lib/<package name>.dart` file,
or in several files in the `lib` directory.

To test the package, add [unit tests][]
in a `test` directory.

For additional details on how to organize the
package contents,
see the [Dart library package][] documentation.

## Developing plugin packages {:#plugin}

If you want to develop a package that calls into
platform-specific APIs,
you need to develop a plugin package.

The API is connected to the platform-specific
implementation(s) using a [platform channel][].

### Federated plugins

Federated plugins are a way of splitting support for
different platforms into separate packages.
So, a federated plugin can use one package for iOS,
another for Android, another for web,
and yet another for a car (as an example of an IoT device).
Among other benefits, this approach allows a domain expert
to extend an existing plugin to work for the platform they know best.

A federated plugin requires the following packages:

**app-facing package**
: The package that plugin users depend on to use the plugin.
  This package specifies the API used by the Flutter app.

**platform package(s)**
: One or more packages that contain the platform-specific
  implementation code. The app-facing package calls into
  these packages&mdash;they aren't included into an app,
  unless they contain platform-specific functionality
  accessible to the end user.

**platform interface package**
: The package that glues the app-facing package
  to the platform package(s). This package declares an
  interface that any platform package must implement to
  support the app-facing package. Having a single package
  that defines this interface ensures that all platform
  packages implement the same functionality in a uniform way.

#### Endorsed federated plugin

Ideally, when adding a platform implementation to
a federated plugin, you will coordinate with the package
author to include your implementation.
In this way, the original author _endorses_ your
implementation.

For example, say you write a `foobar_windows`
implementation for the (imaginary) `foobar` plugin.
In an endorsed plugin, the original `foobar` author
adds your Windows implementation as a dependency
in the pubspec for the app-facing package.
Then, when a developer includes the `foobar` plugin
in their Flutter app, the Windows implementation,
as well as the other endorsed implementations,
are automatically available to the app.

#### Non-endorsed federated plugin

If you can't, for whatever reason, get your implementation
added by the original plugin author, then your plugin
is _not_ endorsed. A developer can still use your
implementation, but must manually add the plugin
to the app's `pubspec.yaml` file:

```yaml
dependencies:
  foobar: ^1.0.0
  foobar_windows: ^1.0.0 # Non-endorsed plugin implementation
```

This approach also works for overriding an already
endorsed plugin implementation of `foobar`.

For more information on federated plugins,
why they are useful, and how they are
implemented, see the Medium article by Harry Terkelsen,
[How To Write a Flutter Web Plugin, Part 2][].

### Specifying a plugin's supported platforms {:#plugin-platforms}

Plugins can specify the platforms they support by
adding keys to the `platforms` map in the
`pubspec.yaml` file. For example,
the following pubspec file shows the
`flutter:` map for the `hello` plugin,
which supports only iOS and Android:

```yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.example.hello
        pluginClass: HelloPlugin
      ios:
        pluginClass: HelloPlugin
```

When adding plugin implementations for more platforms,
the `platforms` map should be updated accordingly.
For example, here's the map in the pubspec file
for the `hello` plugin,
when updated to add support for macOS and web:

```yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.example.hello
        pluginClass: HelloPlugin
      ios:
        pluginClass: HelloPlugin
      macos:
        pluginClass: HelloPlugin
      web:
        pluginClass: HelloPlugin
        fileName: hello_web.dart
```

#### Federated platform packages

A platform package uses the same format,
but includes an `implements` entry indicating
which app-facing package it implements. For example,
a `hello_windows` plugin containing the Windows
implementation for `hello`
would have the following `flutter:` map:

```yaml
flutter:
  plugin:
    implements: hello
    platforms:
      windows:
        pluginClass: HelloPlugin
```

#### Endorsed implementations

An app facing package can endorse a platform package by adding a
dependency on it, and including it as a `default_package` in the
`platforms:` map. If the `hello` plugin above endorsed `hello_windows`,
it would look as follows:


```yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.example.hello
        pluginClass: HelloPlugin
      ios:
        pluginClass: HelloPlugin
      windows:
        default_package: hello_windows

dependencies:
  hello_windows: ^1.0.0
```

Note that as shown here, an app-facing package can have
some platforms implemented within the package,
and others in endorsed federated implementations.

#### Shared iOS and macOS implementations

Many frameworks support both iOS and macOS with identical
or mostly identical APIs, making it possible to implement
some plugins for both iOS and macOS with the same codebase.
Normally each platform's implementation is in its own
folder, but the `sharedDarwinSource` option allows iOS
and macOS to use the same folder instead:


```yaml
flutter:
  plugin:
    platforms:
      ios:
        pluginClass: HelloPlugin
        sharedDarwinSource: true
      macos:
        pluginClass: HelloPlugin
        sharedDarwinSource: true

environment:
  sdk: ^3.0.0
  # Flutter versions prior to 3.7 did not support the
  # sharedDarwinSource option.
  flutter: ">=3.7.0"
```

When `sharedDarwinSource` is enabled, instead of
an `ios` directory for iOS and a `macos` directory
for macOS, both platforms use a shared `darwin`
directory for all code and resources. When enabling
this option, you need to move any existing files
from `ios` and `macos` to the shared directory. You
also need to update the podspec file to set the
dependencies and deployment targets for both platforms,
for example:

```ruby
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.14'
```

### Step 1: Create the package

To create a plugin package, use the `--template=plugin`
flag with `flutter create`.

Use the `--platforms=` option followed by a
comma-separated list to specify the platforms
that the plugin supports. Available platforms are:
`android`, `ios`, `web`, `linux`, `macos`, and `windows`.
If no platforms are specified, the
resulting project doesn't support any platforms.

Use the `--org` option to specify your organization,
using reverse domain name notation. This value is used
in various package and bundle identifiers in the
generated plugin code.

Use the `-a` option to specify the language for android
or the `-i` option to specify the language for ios.
Please choose **one** of the following:

```console
$ flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -a kotlin hello
```
```console
$ flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -a java hello
```
```console
$ flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -i objc hello
```
```console
$ flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -i swift hello
```

This creates a plugin project in the `hello` folder
with the following specialized content:

**`lib/hello.dart`**
: The Dart API for the plugin.

**`android/src/main/java/com/example/hello/HelloPlugin.kt`**
: The Android platform-specific implementation of the plugin API
  in Kotlin.

**`ios/Classes/HelloPlugin.m`**
: The iOS-platform specific implementation of the plugin API
  in Objective-C.

**`example/`**
: A Flutter app that depends on the plugin,
  and illustrates how to use it.

By default, the plugin project uses Swift for iOS code and
Kotlin for Android code. If you prefer Objective-C or Java,
you can specify the iOS language using `-i` and the
Android language using `-a`. For example:

```console
$ flutter create --template=plugin --platforms=android,ios -i objc hello
```
```console
$ flutter create --template=plugin --platforms=android,ios -a java hello
```

### Step 2: Implement the package {:#edit-plugin-package}

As a plugin package contains code for several platforms
written in several programming languages,
some specific steps are needed to ensure a smooth experience.

#### Step 2a: Define the package API (.dart)

The API of the plugin package is defined in Dart code.
Open the main `hello/` folder in your favorite [Flutter editor][].
Locate the file `lib/hello.dart`.

#### Step 2b: Add Android platform code (.kt/.java)

We recommend you edit the Android code using Android Studio.

Before editing the Android platform code in Android Studio,
first make sure that the code has been built at least once
(in other words, run the example app from your IDE/editor,
or in a terminal execute
`cd hello/example; flutter build apk --config-only`).

Then use the following steps:

1. Launch Android Studio.
1. Select **Open an existing Android Studio Project**
   in the **Welcome to Android Studio** dialog,
   or select **File > Open** from the menu,
   and select the `hello/example/android/build.gradle` file.
1. In the **Gradle Sync** dialog, select **OK**.
1. In the **Android Gradle Plugin Update** dialog,
   select **Don't remind me again for this project**.

The Android platform code of your plugin is located in
`hello/java/com.example.hello/HelloPlugin`.

You can run the example app from Android Studio by
pressing the run (&#9654;) button.

#### Step 2c: Add iOS platform code (.swift/.h+.m)

We recommend you edit the iOS code using Xcode.

Before editing the iOS platform code in Xcode,
first make sure that the code has been built at least once
(in other words, run the example app from your IDE/editor,
or in a terminal execute
`cd hello/example; flutter build ios --no-codesign --config-only`).

Then use the following steps:

1. Launch Xcode.
1. Select **File > Open**, and select the
   `hello/example/ios/Runner.xcworkspace` file.

The iOS platform code for your plugin is located in
`Pods/Development Pods/hello/../../example/ios/.symlinks/plugins/hello/ios/Classes`
in the Project Navigator. (If you are using `sharedDarwinSource`,
the path will end with `hello/darwin/Classes` instead.)

You can run the example app by pressing the run (&#9654;) button.

##### Add CocoaPod dependencies

:::warning
Flutter is migrating to [Swift Package Manager][]
to manage iOS and macOS native dependencies.
Flutter's support of Swift Package Manager is under development.
The implementation might change in the future.
Swift Package Manager support is only available
on Flutter's [`main` channel][].
Flutter continues to support CocoaPods.
:::

[Swift Package Manager]: https://www.swift.org/documentation/package-manager/
[`main` channel]: /release/upgrade#switching-flutter-channels

Use the following instructions to add `HelloPod` with the version `0.0.1`:

1. Specify the dependency at the end of `ios/hello.podspec`:

   ```ruby
   s.dependency 'HelloPod', '0.0.1'
   ```

   For private pods, refer to
   [Private CocoaPods][] to ensure repo access:

   ```ruby
   s.source = {
       # For pods hosted on GitHub
       :git => "https://github.com/path/to/HelloPod.git",
       # Alternatively, for pods hosted locally
       # :path => "file:///path/to/private/repo",
       :tag => s.version.to_s
     }`
   ```

[Private CocoaPods]: https://guides.cocoapods.org/making/private-cocoapods.html

2. Installing the plugin

   - Add the plugin in the project’s `pubspec.yaml` dependencies.
   - Run `flutter pub get`.
   - In the project’s `ios/` directory, run `pod install`.

The pod should appear in the installation summary.

If your plugin requires a privacy manifest, for example,
if it uses any **required reason APIs**,
update the `PrivacyInfo.xcprivacy` file to
describe your plugin's privacy impact,
and add the following to the bottom of your podspec file:

```ruby
s.resource_bundles = {'your_plugin_privacy' => ['your_plugin/Sources/your_plugin/Resources/PrivacyInfo.xcprivacy']}
```

For more information,
check out [Privacy manifest files][] on the Apple developer site.

[Privacy manifest files]: {{site.apple-dev}}/documentation/bundleresources/privacy_manifest_files

#### Step 2d: Add Linux platform code (.h+.cc)

We recommend you edit the Linux code using an IDE with
C++ integration. The instructions below are for
Visual Studio Code with the "C/C++" and "CMake" extensions
installed, but can be adjusted for other IDEs.

Before editing the Linux platform code in an IDE,
first make sure that the code has been built at least once
(in other words, run the example app from your Flutter
IDE/editor, or in a terminal execute
`cd hello/example; flutter build linux`).

Then use the following steps:

1. Launch Visual Studio Code.
1. Open the `hello/example/linux/` directory.
1. Choose **Yes** in the prompt asking:
   `Would you like to configure project "linux"?`.
   This will allow C++ autocomplete to work.

The Linux platform code for your plugin is located in
`flutter/ephemeral/.plugin_symlinks/hello/linux/`.

You can run the example app using `flutter run`.
**Note:** Creating a runnable Flutter application
on Linux requires steps that are part of the `flutter`
tool, so even if your editor provides CMake
integration building and running that way won't
work correctly.

#### Step 2e: Add macOS platform code (.swift)

We recommend you edit the macOS code using Xcode.

Before editing the macOS platform code in Xcode,
first make sure that the code has been built at least once
(in other words, run the example app from your IDE/editor,
or in a terminal execute
`cd hello/example; flutter build macos --config-only`).

Then use the following steps:

1. Launch Xcode.
1. Select **File > Open**, and select the
   `hello/example/macos/Runner.xcworkspace` file.

The macOS platform code for your plugin is located in
`Pods/Development Pods/hello/../../example/macos/Flutter/ephemeral/.symlinks/plugins/hello/macos/Classes`
in the Project Navigator. (If you are using `sharedDarwinSource`,
the path will end with `hello/darwin/Classes` instead.)

You can run the example app by pressing the run (&#9654;) button.

#### Step 2f: Add Windows platform code (.h+.cpp)

We recommend you edit the Windows code using Visual Studio.

Before editing the Windows platform code in Visual Studio,
first make sure that the code has been built at least once
(in other words, run the example app from your IDE/editor,
or in a terminal execute
`cd hello/example; flutter build windows`).

Then use the following steps:

1. Launch Visual Studio.
1. Select **Open a project or solution**, and select the
   `hello/example/build/windows/hello_example.sln` file.

The Windows platform code for your plugin is located in
`hello_plugin/Source Files` and `hello_plugin/Header Files` in
the Solution Explorer.

You can run the example app by right-clicking `hello_example` in
the Solution Explorer and selecting **Set as Startup Project**,
then pressing the run (&#9654;) button. **Important:** After
making changes to plugin code, you must select
**Build > Build Solution** before running again, otherwise
an outdated copy of the built plugin will be run instead
of the latest version containing your changes.

#### Step 2g: Connect the API and the platform code

Finally, you need to connect the API written in Dart code with
the platform-specific implementations.
This is done using a [platform channel][],
or through the interfaces defined in a platform
interface package.

### Add support for platforms in an existing plugin project

To add support for specific platforms to an
existing plugin project, run `flutter create` with
the `--template=plugin` flag again in the project directory.
For example, to add web support in an existing plugin, run:

```console
$ flutter create --template=plugin --platforms=web .
```

If this command displays a message about updating the
`pubspec.yaml` file, follow the provided instructions.

### Dart platform implementations

In many cases, non-web platform implementations only use the
platform-specific implementation language, as shown above. However,
platform implementations can also use platform-specific Dart as well.

:::note
The examples below only apply to non-web platforms. Web
plugin implementations are always written in Dart, and use
`pluginClass` and `fileName` for their Dart implementations
as shown above.
:::

#### Dart-only platform implementations

In some cases, some platforms can be
implemented entirely in Dart (for example, using FFI).
For a Dart-only platform implementation on a platform other than web,
replace the `pluginClass` in pubspec.yaml with a `dartPluginClass`.
Here is the `hello_windows` example above modified for a
Dart-only implementation:

```yaml
flutter:
  plugin:
    implements: hello
    platforms:
      windows:
        dartPluginClass: HelloPluginWindows
```

In this version you would have no C++ Windows code, and would instead
subclass the `hello` plugin's Dart platform interface class with a
`HelloPluginWindows` class that includes a static
`registerWith()` method.  This method is called during startup,
and can be used to register the Dart implementation:

```dart
class HelloPluginWindows extends HelloPluginPlatform {
  /// Registers this class as the default instance of [HelloPluginPlatform].
  static void registerWith() {
    HelloPluginPlatform.instance = HelloPluginWindows();
  }
```

#### Hybrid platform implementations

Platform implementations can also use both Dart and a platform-specific
language. For example, a plugin could use a different platform channel
for each platform so that the channels can be customized per platform.

A hybrid implementation uses both of the registration systems
described above. Here is the `hello_windows` example above modified for a
hybrid implementation:

```yaml
flutter:
  plugin:
    implements: hello
    platforms:
      windows:
        dartPluginClass: HelloPluginWindows
        pluginClass: HelloPlugin
```

The Dart `HelloPluginWindows` class would use the `registerWith()`
shown above for Dart-only implementations, while the C++ `HelloPlugin`
class would be the same as in a C++-only implementation.

### Testing your plugin

We encourage you test your plugin with automated tests
to ensure that functionality doesn't regress
as you make changes to your code.

To learn more about testing your plugins,
check out [Testing plugins][].
If you are writing tests for your Flutter app
and plugins are causing crashes,
check out [Flutter in plugin tests][].

[Flutter in plugin tests]: /testing/plugins-in-tests
[Testing plugins]: /testing/testing-plugins

## Developing FFI plugin packages {:#plugin-ffi}

If you want to develop a package that calls into native APIs using
Dart's FFI, you need to develop an FFI plugin package.

Both FFI plugin packages and non-FFI plugin packages support
bundling native code. However, FFI plugin packages don't
support method channels,
but they _do_ support method channel registration code.
To implement a plugin that uses both method channels
_and_ FFI, use a non-FFI plugin.
Each platform can use either an FFI or non-FFI platform.

### Step 1: Create the package

To create a starter FFI plugin package,
use the `--template=plugin_ffi` flag with `flutter create`:

```console
$ flutter create --template=plugin_ffi hello
```

This creates an FFI plugin project in the `hello`
folder with the following specialized content:

**lib**: The Dart code that defines the API of the plugin,
  and which calls into the native code using `dart:ffi`.

**src**: The native source code, and a `CMakeLists.txt`
  file for building that source code into a dynamic library.

**platform folders** (`android`, `ios`, `windows`, etc.): The
  build files for building and bundling the native code
  library with the platform application.

### Step 2: Building and bundling native code

The `pubspec.yaml` specifies FFI plugins as follows:

```yaml
  plugin:
    platforms:
      some_platform:
        ffiPlugin: true
```

This configuration invokes the native build
for the various target platforms and bundles
the binaries in Flutter applications using these FFI plugins.

This can be combined with `dartPluginClass`,
such as when FFI is used for the
implementation of one platform in a federated plugin:

```yaml
  plugin:
    implements: some_other_plugin
    platforms:
      some_platform:
        dartPluginClass: SomeClass
        ffiPlugin: true
```

A plugin can have both FFI and method channels:

```yaml
  plugin:
    platforms:
      some_platform:
        pluginClass: SomeName
        ffiPlugin: true
```

The native build systems that are invoked by FFI
(and method channels) plugins are:

* For Android: Gradle, which invokes the Android NDK for native builds.
  * See the documentation in `android/build.gradle`.
* For iOS and macOS: Xcode, using CocoaPods.
  * See the documentation in `ios/hello.podspec`.
  * See the documentation in `macos/hello.podspec`.
* For Linux and Windows: CMake.
  * See the documentation in `linux/CMakeLists.txt`.
  * See the documentation in `windows/CMakeLists.txt`.

### Step 3: Binding to native code

To use the native code, bindings in Dart are needed.

To avoid writing these by hand,
they are generated from the header file
(`src/hello.h`) by [`package:ffigen`][].
Reference the [ffigen docs][] for information
on how to install this package.

Regenerate the bindings by running the following:

```console
$  dart run ffigen --config ffigen.yaml
```

### Step 4: Invoking native code

Very short-running native functions can be directly
invoked from any isolate.
For an example, see `sum` in `lib/hello.dart`.

Longer-running functions should be invoked on a
[helper isolate][] to avoid dropping frames in
Flutter applications.
For an example, see `sumAsync` in `lib/hello.dart`.

## Adding documentation

It is recommended practice to add the following documentation
to all packages:

1. A `README.md` file that introduces the package
1. A `CHANGELOG.md` file that documents changes in each version
1. A [`LICENSE`] file containing the terms under which the package
   is licensed
1. API documentation for all public APIs (see below for details)

### API documentation

When you publish a package,
API documentation is automatically generated and
published to pub.dev/documentation.
For example, see the docs for [`device_info`][].

If you wish to generate API documentation locally on
your development machine, use the following commands:

<ol>
<li>

Change directory to the location of your package:

```console
cd ~/dev/mypackage
```

</li>

<li>

Tell the documentation tool where the
Flutter SDK is located (change the following commands to reflect
where you placed it):

```console
   export FLUTTER_ROOT=~/dev/flutter  # on macOS or Linux

   set FLUTTER_ROOT=~/dev/flutter     # on Windows
```
</li>

<li>Run the `dart doc` tool
    (included as part of the Flutter SDK), as follows:

```console
   $FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart doc   # on macOS or Linux

   %FLUTTER_ROOT%\bin\cache\dart-sdk\bin\dart doc  # on Windows
```
</li>
</ol>

For tips on how to write API documentation, see
[Effective Dart Documentation][].

### Adding licenses to the LICENSE file

Individual licenses inside each LICENSE file
should be separated by 80 hyphens
on their own on a line.

If a LICENSE file contains more than one
component license, then each component
license must start with the names of the
packages to which the component license applies,
with each package name on its own line,
and the list of package names separated from
the actual license text by a blank line.
(The packages need not match the names of
the pub package. For example, a package might itself contain
code from multiple third-party sources,
and might need to include a license for each one.)

The following example shows a well-organized license file:

```plaintext
package_1

<some license text>

--------------------------------------------------------------------------------
package_2

<some license text>
```

Here is another example of a well-organized license file:

```plaintext
package_1

<some license text>

--------------------------------------------------------------------------------
package_1
package_2

<some license text>
```

Here is an example of a poorly-organized license file:

```plaintext
<some license text>

--------------------------------------------------------------------------------
<some license text>
```

Another example of a poorly-organized license file:

```plaintext
package_1

<some license text>
--------------------------------------------------------------------------------
<some license text>
```

## Publishing your package {:#publish}

:::tip
Have you noticed that some of the packages and plugins
on pub.dev are designated as [Flutter Favorites][]?
These are the packages published by verified developers
and are identified as the packages and plugins you
should first consider using when writing your app.
To learn more,
see the [Flutter Favorites program][].
:::

Once you have implemented a package, you can publish it on
[pub.dev][], so that other developers can easily use it.

Prior to publishing, make sure to review the `pubspec.yaml`,
`README.md`, and `CHANGELOG.md` files to make sure their
content is complete and correct. Also, to improve the
quality and usability of your package (and to make it
more likely to achieve the status of a Flutter Favorite),
consider including the following items:

* Diverse code usage examples
* Screenshots, animated gifs, or videos
* A link to the corresponding code repository

Next, run the publish command in `dry-run` mode
to see if everything passes analysis:

```console
$ flutter pub publish --dry-run
```

The next step is publishing to pub.dev,
but be sure that you are ready because
[publishing is forever][]:

```console
$ flutter pub publish
```

For more details on publishing, see the
[publishing docs][] on dart.dev.

## Handling package interdependencies {:#dependencies}

If you are developing a package `hello` that depends on
the Dart API exposed by another package, you need to add
that package to the `dependencies` section of your
`pubspec.yaml` file. The code below makes the Dart API
of the `url_launcher` plugin available to `hello`:

```yaml
dependencies:
  url_launcher: ^5.0.0
```

You can now `import 'package:url_launcher/url_launcher.dart'`
and `launch(someUrl)` in the Dart code of `hello`.

This is no different from how you include packages in
Flutter apps or any other Dart project.

But if `hello` happens to be a _plugin_ package
whose platform-specific code needs access
to the platform-specific APIs exposed by `url_launcher`,
you also need to add suitable dependency declarations
to your platform-specific build files, as shown below.

### Android

The following example sets a dependency for
`url_launcher` in `hello/android/build.gradle`:

```groovy
android {
    // lines skipped
    dependencies {
        compileOnly rootProject.findProject(":url_launcher")
    }
}
```

You can now `import io.flutter.plugins.urllauncher.UrlLauncherPlugin`
and access the `UrlLauncherPlugin`
class in the source code at `hello/android/src`.

For more information on `build.gradle` files, see the
[Gradle Documentation][] on build scripts.

### iOS

The following example sets a dependency for
`url_launcher` in `hello/ios/hello.podspec`:

```ruby
Pod::Spec.new do |s|
  # lines skipped
  s.dependency 'url_launcher'
```

You can now `#import "UrlLauncherPlugin.h"` and
access the `UrlLauncherPlugin` class in the source code
at `hello/ios/Classes`.

For additional details on `.podspec` files, see the
[CocoaPods Documentation][].

### Web

All web dependencies are handled by the `pubspec.yaml`
file, like any other Dart package.

{% comment %}
<!-- Remove until we have better text. -->
### MacOS

PENDING
{% endcomment %}

[CocoaPods Documentation]: https://guides.cocoapods.org/syntax/podspec.html
[Dart library package]: {{site.dart-site}}/guides/libraries/create-library-packages
[`device_info`]: {{site.pub-api}}/device_info/latest
[Effective Dart Documentation]: {{site.dart-site}}/guides/language/effective-dart/documentation
[federated plugins]: #federated-plugins
[ffigen docs]: {{site.pub-pkg}}/ffigen/install
[Android]: /platform-integration/android/c-interop
[iOS]: /platform-integration/ios/c-interop
[macOS]: /platform-integration/macos/c-interop
[`fluro`]: {{site.pub}}/packages/fluro
[Flutter editor]: /get-started/editor
[Flutter Favorites]: {{site.pub}}/flutter/favorites
[Flutter Favorites program]: /packages-and-plugins/favorites
[Gradle Documentation]: https://docs.gradle.org/current/userguide/tutorial_using_tasks.html
[helper isolate]: {{site.dart-site}}/guides/language/concurrency#background-workers
[How to Write a Flutter Web Plugin, Part 1]: {{site.flutter-medium}}/how-to-write-a-flutter-web-plugin-5e26c689ea1
[How To Write a Flutter Web Plugin, Part 2]: {{site.flutter-medium}}/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
[issue #33302]: {{site.repo.flutter}}/issues/33302
[`LICENSE`]: #adding-licenses-to-the-license-file
[`path`]: {{site.pub}}/packages/path
[`package:ffigen`]: {{site.pub}}/packages/ffigen
[platform channel]: /platform-integration/platform-channels
[pub.dev]: {{site.pub}}
[publishing docs]: {{site.dart-site}}/tools/pub/publishing
[publishing is forever]: {{site.dart-site}}/tools/pub/publishing#publishing-is-forever
[supported-platforms]: #plugin-platforms
[test your plugin]: #testing-your-plugin
[unit tests]: /testing/overview#unit-tests
[`url_launcher`]: {{site.pub}}/packages/url_launcher
[Writing a good plugin]: {{site.flutter-medium}}/writing-a-good-flutter-plugin-1a561b986c9c
