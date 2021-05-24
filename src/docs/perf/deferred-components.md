---
title: Deferred components
description: How to create deferred components for improved download performance.
---

## Introduction

Flutter has the capability to build apps that can
download additional Dart code and assets at runtime.
This allows apps to reduce install apk size and download
features and assets when needed by the user.

We refer to each uniquely downloadable bundle of Dart
libraries and assets as a “deferred component”.
This is achieved by using Dart’s deferred imports,
which can be compiled into split AOT shared libraries.

{{site.alert.note}}
  This feature is currently only available on Android,
  taking advantage of Android and Google Play Stores’
  [dynamic feature modules][] to deliver the
  deferred components packaged as Android modules.
  Deferred code does not impact other platforms,
  which continue to build as normal with all deferred
  components and assets included at initial install time.

  Also, note that this is an advanced feature.
{{site.alert.end}}

Though modules can be defer loaded,
the entire application must be completely built and
uploaded as a single Android App Bundle.
Dispatching partial updates without re-uploading
new Android App Bundles for the entire application
is not supported.

Deferred loading is only performed when the app
is compiled to [release or profile mode][].
In debug mode, all deferred components are treated
as regular imports, so they are present
at launch and load immediately. Therefore,
debug builds can still hot reload.

For a deeper dive into the technical details of
how this feature works, see [Deferred Components][]
on the [Flutter wiki][].

## How to set your project up for deferred components

The following instructions explain how to set up your
Android app for deferred loading.

### Step 1: Dependencies and initial project setup

<ol markdown="1">
<li markdown="1">Add Play Core to the Android app’s
    build.gradle dependencies.
    In `android/app/build.gradle` add the following:

```gradle
...
dependencies {
  ...
  implementation "com.google.android.play:core:1.8.0"
  ...
}
```
</li>

<li markdown="1">If using the Google Play Store as the
    distribution model for dynamic features,
    the app must support `SplitCompat` and provide an instance
    of a `PlayStoreDeferredComponentManager`.
    Both of these tasks can be accomplished by setting
    the `android:name` property on the application in
    `android/app/src/main/AndroidManifest.xml` to
    `io.flutter.app.FlutterPlayStoreSplitApplication`:

```xml
<manifest ...
  <application
     android:name="io.flutter.app.FlutterPlayStoreSplitApplication"
        ...
  </application>
</manifest>
```

`io.flutter.app.FlutterPlayStoreSplitApplication` handles
both of these tasks for you. If you use
`FlutterPlayStoreSplitApplication`,
you can skip to step 1.3.

If your Android application
is large or complex, you might want to separately support
`SplitCompat` and provide the
`PlayStoreDynamicFeatureManager` manually.

To support `SplitCompat`, there are three methods
(as detailed in the [Android docs][]), any of which are valid:

<ul markdown="1">
<li markdown="1">Make your application class extend
    `SplitCompatApplication`:
<!-- skip -->
```dart
public class MyApplication extends SplitCompatApplication {
    ...
}
```
</li>

<li markdown="1">Call `SplitCompat.install(this);`
    in the `attachBaseContext()` method:

<!-- skip -->
```dart
@Override
protected void attachBaseContext(Context base) {
    super.attachBaseContext(base);
    // Emulates installation of future on demand modules using SplitCompat.
    SplitCompat.install(this);
}
```
</li>

<li markdown="1">Declare `SplitCompatApplication` as the application
    subclass and add the Flutter compatibility code from
  `FlutterApplication` to your application class:

```js
<application
    ...
    android:name="com.google.android.play.core.splitcompat.SplitCompatApplication">
</application>
```
</li>
</ul>

The embedder relies on an injected
`DeferredComponentManager` instance to handle
install requests for deferred components.
Provide a `PlayStoreDeferredComponentManager` into
the Flutter embedder by adding the following code
to your app initialization:

<!-- skip -->
```dart
import io.flutter.embedding.engine.dynamicfeatures.PlayStoreDeferredComponentManager;
import io.flutter.FlutterInjector;
... 
PlayStoreDeferredComponentManager deferredComponentManager = new
  PlayStoreDeferredComponentManager(this, null);
FlutterInjector.setInstance(new FlutterInjector.Builder()
    .setDeferredComponentManager(deferredComponentManager).build());
```

</li>
    
<li markdown="1">Opt into deferred components by adding
    the `deferred-components` entry to the app’s `pubspec.yaml`
    under the `flutter` entry:

  ```yaml
  ...
  flutter:
    ...
    deferred-components:
    ...
  ```
  The `flutter` tool looks for the `deferred-components`
  entry in the `pubspec.yaml` to determine whether the
  app should be built as deferred or not.
  This can be left empty for now unless you already
  know the components desired and the Dart deferred libraries
  that go into each. You will fill in this section later
  in [step 3.3][] once `gen_snapshot` produces the loading units.
</li>
</ol>

### Step 2: Implementing deferred Dart libraries

Next, implement deferred loaded Dart libraries in your
app’s Dart code. The implementation does not need
to be feature complete yet. The example in the
rest of this page adds a new simple deferred widget
as a placeholder. You can also convert existing code
to be deferred by modifying the imports and
guarding usages of deferred code behind `loadLibrary()`
`Futures`.

<ol markdown="1">
<li markdown="1">Create a new Dart library.
    For example, create a new `DeferredBox` widget that
    can be downloaded at runtime.
    This widget can be of any complexity but,
    for the purposes of this guide,
    create a simple box as a stand-in.
    To create a simple blue box widget,
    create `box.dart` with the following contents:

<!-- skip -->
```dart
// box.dart

import 'package:flutter/widgets.dart';

/// A simple blue 30x30 box.
class DeferredBox extends StatelessWidget {
  DeferredBox() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
  }
}
```
</li>

<li markdown="1">Import the new Dart library
    with the `deferred` keyword in your app and
    call `loadLibrary()` (see [lazily loading a library][]).
    The following example uses `FutureBuilder`
    to wait for the `loadLibrary` `Future` (created in
    `initState`) to complete and display a
    `CircularProgressIndicator` as a placeholder.
    When the `Future` completes, it returns the `DeferredBox` widget.
    `SomeWidget` can then be used in the app as normal and
    won't ever attempt to access the deferred Dart code until
    it has successfully loaded.

<!-- skip -->
```dart
import 'box.dart' deferred as box;

// ...

class SomeWidget extends StatefulWidget {
  @override
  _SomeWidgetState createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  Future<void> _libraryFuture;

  @override
  void initState() {
    _libraryFuture = box.loadLibrary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _libraryFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return box.DeferredBox();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
// ...
```

The `loadLibrary()` function returns a `Future<void>`
that completes successfully when the code in the library
is available for use and completes with an error otherwise.
All usage of symbols from the deferred library should be
guarded behind a completed `loadLibrary()` call. All imports
of the library must be marked as `deferred` for it to be
compiled appropriately to be used in a deferred component.
If a component has already been loaded, additional calls
to `loadLibrary()` complete quickly (but not synchronously).
The `loadLibrary()` function can also be called early to
trigger a pre-load to help mask the loading time.

You can find another example of deferred import loading in
[Flutter Gallery’s lib/deferred_widget.dart][].
</li>
</ol>

### Step 3: Building the app

Use the following `flutter` command to build a deferred
components app:

```sh
$ flutter build appbundle
```

This command assists you by validating that your project
is properly set up to build deferred components apps.
By default, the build fails if the validator detects
any issues and guides you through suggested changes to fix them.

{{site.alert.note}}
  You can opt out of building deferred components
  with the `--no-deferred-components` flag.
  This flag causes all assets defined under
  deferred components to be treated as if they were
  defined under the assets section of `pubspec.yaml`.
  All Dart code is compiled into a single shared library
  and `loadLibrary()` calls complete in the next event
  loop boundary (as soon as possible while being asynchronous).
  This flag is also equivalent to omitting the `deferred-components:`
  entry in `pubspec.yaml`.
{{site.alert.end}}

<ol markdown="1">
<li markdown="1"><a name="step-3.1"></a>The
    `flutter build appbundle` command
    runs the validator and attempts to build the app with
    `gen_snapshot` instructed to produce split AOT shared libraries
    as separate `.so` files. On the first run, the validator will
    likely fail as it detects issues; the tool makes
    recommendations for how to set up the project and fix these issues.

The validator is split into two sections: prebuild
and post-gen_snapshot validation. This is because any
validation referencing loading units cannot be performed
until `gen_snapshot` completes and produces a final set
of loading units.

{{site.alert.note}}
  You can opt to have the tool attempt to build your
  app without the validator by passing the
  `--no-validate-deferred-components` flag.
  This can result in unexpected and confusing
  instructions to resolve failures.
  This flag is meant to be used in
  custom implementations that do not rely on the default
  Play-store-based implementation that the validator checks for.
{{site.alert.end}}

The validator detects any new, changed, or removed
loading units generated by `gen_snapshot`.
The current generated loading units are tracked in your
`<projectDirectory>/deferred_components_loading_units.yaml` file.
This file should be checked into source control to ensure that
changes to the loading units by other developers can be caught.

The validator also checks for the following in the
`android` directory:

<ul markdown="1">
<li markdown="1">**`<projectDir>/android/app/src/main/res/values/strings.xml`**<br>
    An entry for every deferred component mapping the key
    `${componentName}Name` to `${componentName}`.
    This string resource is used by the `AndroidManifest.xml`
    of each feature module to define the `dist:title property`.
    For example:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
  ...
  <string name="boxComponentName">boxComponent</string>
</resources>
```
</li>

<li markdown="1">**`<projectDir>/android/<componentName>`**<br>
    An Android dynamic feature module for
    each deferred component exists and contains a `build.gradle`
    and `src/main/AndroidManifest.xml` file.
    This only checks for existence and does not validate
    the contents of these files. If a file does not exist,
    it generates a default recommended one.
</li>

<li markdown="1">**`<projectDir>/android/app/src/main/res/values/AndroidManifest.xml`**<br>
    Contains a meta-data entry that encodes
    the mapping between loading units and component name the
    loading unit is associated with. This mapping is used by the
    embedder to convert Dart’s internal loading unit id
    to the name of a deferred component to install. For example:
```js
    ...
    <application
        android:label="MyApp"
        android:name="io.flutter.app.FlutterPlayStoreSplitApplication"
        android:icon="@mipmap/ic_launcher">
        ...
        <meta-data android:name="io.flutter.embedding.engine.deferredcomponents.DeferredComponentManager.loadingUnitMapping" android:value="2:boxComponent"/>
    </application>
    ...
```
</li>
</ul>

The `gen_snapshot` validator won't run until the prebuild
validator passes.
</li>

<li markdown="1">For each of these checks,
    the tool produces the modified or new files
    needed to pass the check.
    These files are placed in the
    `<projectDir>/build/android_deferred_components_setup_files` directory.
    It is recommended that the changes be applied by
    copying and overwriting the same files in the
    project’s `android` directory. Before overwriting,
    the current project state should be committed to
    source control and the recommended changes should be
    reviewed to be appropriate. The tool won't make any
    changes to your `android/` directory automatically.
</li>

<li markdown="1"><a name="step-3.3"></a>Once the available
    loading units are generated and logged in
    `<projectDirectory>/deferred_components_loading_units.yaml`,
    it is possible to fully configure the pubspec’s
    `deferred-components` section so that the loading units
    are assigned to deferred components as desired.
    To continue with the box example, the generated
    `deferred_components_loading_units.yaml` file would contain:
```yaml
loading-units:
  - id: 2
    libraries:
      - package:MyAppName/box.Dart
```

The loading unit id (‘2’ in this case) is used
internally by Dart, and can be ignored.
The base loading unit (id ‘1’) is not listed
and contains everything not explicitly contained
in another loading unit.

You can now add the following to `pubspec.yaml`:

```yaml
...
flutter:
  ...
  deferred-components:
    - name: boxComponent
      libraries:
        - package:MyAppName/box.Dart
  ...
```
To assign a loading unit to a deferred component,
add any Dart lib in the loading unit into the
libraries section of the feature module.
Keep the following guidelines in mind:

<ul markdown="1">
<li markdown="1">Loading units should not be included
    in more than one component.
</li>
<li markdown="1">Including one Dart library from a
    loading unit indicates that the entire loading
    unit is assigned to the deferred component.
</li>
<li markdown="1">All loading units not assigned to
    a deferred component are included in the base component,
    which always exists implicitly.
</li>
<li markdown="1">Loading units assigned to the same
    deferred component are downloaded, installed,
    and shipped together.
</li>
<li markdown="1">The base component is implicit and
    need not be defined in the pubspec.
</li>
</ul>
</li>

<li markdown="1">Assets can also be included by adding
    an assets section in the deferred component configuration:
```yaml
  deferred-components:
    - name: boxComponent
      libraries:
        - package:MyAppName/box.Dart
      assets:
        - assets/image.jpg
        - assets/picture.png
          # wildcard directory
        - assets/gallery/
```

An asset can be included in multiple deferred components,
but installing both components results in a replicated asset.
Assets-only components can also be defined by omitting the
libraries section. These assets-only components must be
installed with the [`DeferredComponent`][] utility class in
services rather than `loadLibrary()`.
Since Dart libs are packaged together with assets,
if a Dart library is loaded with `loadLibrary()`,
any assets in the component are loaded as well.
However, installing by component name and the services utility
won't load any dart libraries in the component.

You are free to include assets in any component,
as long as they are installed and loaded when they
are first referenced, though typically,
assets and the Dart code that uses those assets
are best packed in the same component.
</li>

<li markdown="1">Manually add all deferred components
    that you defined in `pubspec.yaml` into the
    `android/settings.gradle` file as includes.
    For example, if there are three deferred components
    defined in the pubspec named, `boxComponent`, `circleComponent`,
    and `assetComponent`, ensure that `android/settings.gradle`
    contains the following:
```gradle
include ':app', ':boxComponent', ':circleComponent', ':assetComponent'
...
```
</li>

<li markdown="1">Repeat steps [3.1][] through 3.6 (this step)
    until all validator recommendations are handled and the tool
    runs without further recommendations.

When successful, this command outputs an `app-release.aab`
file in `build/app/outputs/bundle/release`.

A successful build does not always mean the app was
built as intended. It is up to you to ensure that all loading
units and Dart libraries are included in the way you intended.
For example, a common mistake is accidentally importing a
Dart library without the `deferred` keyword,
resulting in a deferred library being compiled as part of
the base loading unit. In this case, the Dart lib would
load properly because it is always present in the base,
and the lib would not be split off. This can be checked
by examining the `deferred_components_loading_units.yaml`
file to verify that the generated loading units are described
as intended.

When adjusting the deferred components configurations,
or making Dart changes that add, modify, or remove loading units,
you should expect the validator to fail.
Follow steps [3.1][] through 3.6 (this step) to apply any
recommended changes to continue the build.
</li>
</ol>

### Running the app locally

Once your app has successfully built an `.aab` file,
use Android's [`bundletool`][] to perform
local testing with the `--local-testing` flag.

To run the `.aab` file on a test device,
download the bundletool jar executable from
[github.com/google/bundletool/releases][] and run:

```sh
$ java -jar bundletool.jar build-apks --bundle=<your_app_project_dir>/build/app/outputs/bundle/release/app-release.aab --output=<your_temp_dir>/app.apks --local-testing

$ java -jar bundletool.jar install-apks --apks=<your_temp_dir>/app.apks
```

Where `<your_app_project_dir>` is the path to your app’s
project directory and `<your_temp_dir>` is any temporary
directory used to store the outputs of bundletool.
This unpacks your `.aab` file into an `.apks` file and
installs it on the device. All available Android dynamic
features are loaded onto the device locally and
installation of deferred components is emulated.

Before running `build-apks` again,
remove the existing app .apks file:

```sh
$ rm <your_temp_dir>/app.apks
```

Changes to the Dart codebase require either incrementing
the Android build ID or uninstalling and reinstalling
the app, as Android won't update the feature modules
unless it detects a new version number.

### Releasing to the Google Play store

The built `.aab` file can be uploaded directly to
the Play store as normal. When `loadLibrary()` is called,
the needed Android module containing the Dart AOT lib and
assets is downloaded by the Flutter engine using the
Play store's delivery feature.


[3.1]: #step-3.1
[Android docs]: {{site.android-dev}}/guide/playcore/feature-delivery#declare_splitcompatapplication_in_the_manifest
[`bundletool`]: {{site.android-dev}}/studio/command-line/bundletool
[Deferred Components]: {{site.github}}/flutter/flutter/wiki/Deferred-Components
[`DeferredComponent`]: {{site.api}}/flutter/services/DeferredComponent-class.html
[dynamic feature modules]: {{site.android-dev}}/guide/playcore/feature-delivery
[Flutter Gallery’s lib/deferred_widget.dart]: {{site.github}}/flutter/gallery/blob/master/lib/deferred_widget.dart
[Flutter wiki]: {{site.github}}/flutter/flutter/wiki
[github.com/google/bundletool/releases]: {{site.github}}/google/bundletool/releases
[lazily loading a library]: {{site.dart-site}}/guides/language/language-tour#lazily-loading-a-library
[release or profile mode]: /docs/testing/build-modes
[step 3.3]: #step-3.3
