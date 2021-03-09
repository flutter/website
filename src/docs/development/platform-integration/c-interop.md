---
title: "Binding to native code using dart:ffi"
description: "To use C code in your Flutter program, use the dart:ffi library (currently in beta)."
---

Flutter mobile can use the [dart:ffi][] library
to call native C APIs. _FFI_ stands for
[_foreign function interface._][FFI]
Other terms for similar functionality include
_native interface_ and _language bindings._

Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading native code within a Flutter plugin or app.

This tutorial demonstrates how to bundle C/C++
sources in a Flutter plugin and bind to them using
the Dart FFI library on both Android and iOS.
In this walkthrough, you'll create a C function
that implements 32-bit addition and then
exposes it through a Dart plugin named "native_add".

{{ site.alert.version-note }}
  As of Dart 2.12.0 (included in Flutter 2.0 or later),
  FFI has been marked as stable.
{{ site.alert.end }}

### Dynamic vs static linking

A native library can be linked into an app either
dynamically or statically. A statically linked library
is embedded into the app's executable image,
and is loaded when the app starts.

Symbols from a statically linked library can be
loaded using `DynamicLibrary.executable` or
`DynamicLibrary.process`.

A dynamically linked library, by contrast, is distributed
in a separate file or folder within the app,
and loaded on-demand. On Android, a dynamically
linked library is distributed as a set of `.so` (ELF)
files, one for each architecture. On iOS,
it's distributed as a `.framework` folder.

A dynamically linked library can be loaded into
Dart via `DynamicLibrary.open`.

API documentation is available from the Dart dev channel:
[Dart API reference documentation][].

## Step 1: Create a plugin

If you already have a plugin, skip this step.

To create a plugin called "native_add",
do the following:

```terminal
$ flutter create --platforms=android,ios --template=plugin native_add
$ cd native_add
```

{{ site.alert.note }}
  You can exclude platforms from --platforms that you don't want
  to build to. However, you need to include the platform of 
  the device you are testing on.
{{ site.alert.end }}

## Step 2: Add C/C++ sources

You need to inform both the Android and iOS build
systems about the native code so the code can be compiled
and linked appropriately into the final application.

You add the sources to the `ios` folder,
because CocoaPods doesn't allow including sources
above the podspec file, but Gradle allows you to point
to the `ios` folder. It's not required to use the same
sources for both iOS and Android;
you may, of course, add Android-specific sources
to the `android` folder and modify `CMakeLists.txt`
appropriately.

The FFI library can only bind against C symbols,
so in C++ these symbols must be marked `extern C`.
You should also add attributes to indicate that the
symbols are referenced from Dart,
to prevent the linker from discarding the symbols
during link-time optimization.

For example,
to create a C++ file named `ios/Classes/native_add.cpp`,
use the following instructions. (Note that the template
has already created this file for you.) Start from the
root directory of your project:

```bash
cat > ios/Classes/native_add.cpp << EOF
#include <stdint.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}
EOF
```

On iOS, you need to tell Xcode to statically link the file:

 1. In Xcode, open `Runner.xcworkspace`.
 2. Add the C/C++/Objective-C/Swift
    source files to the Xcode project.

On Android, you need to create a `CMakeLists.txt` file
to define how the sources should be compiled and point
Gradle to it. From the root of your project directory,
use the following instructions

```bash
cat > android/CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.4.1)  # for example

add_library( native_add

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             ../ios/Classes/native_add.cpp )
EOF
```

Finally, add an `externalNativeBuild` section to
`android/build.gradle`. For example:

```nocode
android {
  // ...
  externalNativeBuild {
    // Encapsulates your CMake build configurations.
    cmake {
      // Provides a relative path to your CMake build script.
      path "CMakeLists.txt"
    }
  }
  // ...
}
```

## Step 3: Load the code using the FFI library

In this example, you can add the following code to
`lib/native_add.dart`. However the location of the
Dart binding code is not important.

First, you must create a `DynamicLibrary` handle to
the native code. This step varies between iOS and Android:

```dart
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();
```

Note that on Android the native library is named
in `CMakeLists.txt` (see above),
but on iOS it takes the plugin's name.

With a handle to the enclosing library,
you can resolve the `native_add` symbol:

<!-- skip -->
```dart
final int Function(int x, int y) nativeAdd =
  nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();
```

Finally, you can call it. To demonstrate this within
the auto-generated "example" app (`example/lib/main.dart`):

```nocode
// Inside of _MyAppState.build:
        body: Center(
          child: Text('1 + 2 == ${nativeAdd(1, 2)}'),
        ),
```

## Other use cases

### iOS and macOS

Dynamically linked libraries are automatically loaded by
the dynamic linker when the app starts. Their constituent
symbols can be resolved using [`DynamicLibrary.process`][].
You can also get a handle to the library with
[`DynamicLibrary.open`][] to restrict the scope of
symbol resolution, but it's unclear how Apple's
review process handles this.

Symbols statically linked into the application binary
can be resolved using [`DynamicLibrary.executable`][] or
[`DynamicLibrary.process`][].

#### Platform library

To link against a platform library,
use the following instructions:

1. In Xcode, open `Runner.xcworkspace`.
1. Select the target platform.
1. Click **+** in the **Linked Frameworks and Libraries**
   section.
1. Select the system library to link against.

#### First-party library

A first-party native library can be included either
as source or as a (signed) `.framework` file.
It's probably possible to include statically linked
archives as well, but it requires testing.

#### Source code

To link directly to source code,
use the following instructions:

 1. In Xcode, open `Runner.xcworkspace`.
 2. Add the C/C++/Objective-C/Swift
    source files to the Xcode project.
 3. Add the following prefix to the
    exported symbol declarations to ensure they
    are visible to Dart:

    **C/C++/Objective-C**

    ```objective-c
    extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
    ```

    **Swift**

    ```swift
    @_cdecl("myFunctionName")
    ```

#### Compiled (dynamic) library

To link to a compiled dynamic library,
use the following instructions:

1. If a properly signed `Framework` file is present,
   open `Runner.xcworkspace`.
1. Add the framework file to the **Embedded Binaries**
   section.
1. Also add it to the **Linked Frameworks & Libraries**
   section of the target in Xcode.

#### Compiled (dynamic) library (macOS)

To create add a closed source library to a [Flutter macOS Desktop][] app,
use the following instructions.

1. Follow the instructions for Flutter desktop to create a Flutter desktop app.
1. Open the `yourapp/macos/Runner.xcworkspace` in Xcode.
   1. Drag your precompiled library (`libyourlibrary.dylib`) into `Runner/Frameworks`.
   1. Click `Runner` and go to the `Build Phases` tab.
      1. Drag `libyourlibrary.dylib` into the `Copy Bundle Resources` list.
      1. Under `Bundle Framework`, check `Code Sign on Copy`.
      1. Under `Link Binary With Libraries`, set status to `Optional`. (We use dynamic linking, no need to statically link.)
   1. Click `Runner` and go to the `General` tab.
      1. Drag `libyourlibrary.dylib` into the `Frameworks, Libararies and Embedded Content` list.
      1. Select `Embed & Sign`.
1. Edit `lib/main.dart`.
   1. Use `DynamicLibrary.open('libyourlibrary.dylib')` to dynamically link to the symbols.
   1. Call your native function somewhere in a widget.
1. Run `flutter run` and check that your native function gets called.
1. Run `flutter build macos` to build a selfcontained release version of your app.

#### Open-source third-party library

To create a Flutter plugin that includes both
C/C++/Objective-C _and_ Dart code,
use the following instructions:

1. In your plugin project,
   open `ios/<myproject>.podspec`.
1. Add the native code to the `source_files`
   field.

The native code is then statically linked into
the application binary of any app that uses
this plugin.

#### Closed-source third-party library

To create a Flutter plugin that includes Dart
source code, but distribute the C/C++ library
in binary form, use the following instructions:

1. In your plugin project,
   open `ios/<myproject>.podspec`.
1. Add a `vendored_frameworks` field.
   See the [CocoaPods example][].

**Do not** upload this plugin
(or any plugin containing binary code)
to pub.dev. Instead, this plugin should be downloaded
from a trusted third-party,
as shown in the CocoaPods example.

### Android

#### Platform library

To link against a platform library,
use the following instructions:

 1. Find the desired library in the [Android NDK Native APIs][]
    list in the Android docs. This lists stable native APIs.
 1. Load the library using [`DynamicLibrary.open`][].
    For example, to load OpenGL ES (v3):
    <!-- skip -->
    ```dart
    DynamicLibrary.open('libGLES_v3.so');
    ```

You might need to update the Android manifest
file of the app or plugin if indicated by
the documentation.

#### First-party library

The process for including native code in source
code or binary form is the same for an app or
plugin.

#### Open-source third-party

Follow the [Add C and C++ code to your project][]
instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).

#### Closed-source third-party library

To create a Flutter plugin that includes Dart
source code, but distribute the C/C++ library
in binary form, use the following instructions:

1. Open the `android/build.gradle` file for your
   project.
1. Add the AAR artifact as a dependency.
   **Don't** include the artifact in your
   Flutter package. Instead, it should be
   downloaded from a repository, such as
   JCenter.


### Web

This feature is not yet supported for web plugins.

## FAQ

### Android APK size (shared object compression)

[Android guidelines][] in general recommend distributing native shared objects
uncompressed because that actually saves on device space. Shared objects can be
directly loaded from the APK instead of unpacking them on device into a
temporary location and then loading. APKs are additionally packed in transit -
that is why you should be looking at download size.

Flutter APKs by default don't follow these guidelines and compress
`libflutter.so` and `libapp.so` - this leads to smaller APK size but larger on
device size.

Shared objects from third parties can change this default setting with
`android:extractNativeLibs="true"` in their `AndroidManifest.xml` and stop the
compression of `libflutter.so`, `libapp.so`, and any user-added shared objects.
To re-enable compression, override the setting in
`your_app_name/android/app/src/main/AndroidManifest.xml` in the following way.

```diff
@@ -1,5 +1,6 @@
 <manifest xmlns:android="http://schemas.android.com/apk/res/android"
-    package="com.example.your_app_name">
+    xmlns:tools="http://schemas.android.com/tools"
+    package="com.example.your_app_name" >
     <!-- io.flutter.app.FlutterApplication is an android.app.Application that
          calls FlutterMain.startInitialization(this); in its onCreate method.
          In most cases you can leave this as-is, but you if you want to provide
          additional functionality it is fine to subclass or reimplement
          FlutterApplication and put your custom class here. -->
@@ -8,7 +9,9 @@
     <application
         android:name="io.flutter.app.FlutterApplication"
         android:label="your_app_name"
-        android:icon="@mipmap/ic_launcher">
+        android:icon="@mipmap/ic_launcher"
+        android:extractNativeLibs="true"
+        tools:replace="android:extractNativeLibs">
```

### iOS symbols stripped

When creating a release archive (IPA) the symbols are stripped by Xcode.

1. In Xcode, go to **Target Runner > Build Settings > Strip Style**.
2. Change from **All Symbols** to **Non-Global Symbols**.

[Add C and C++ code to your project]: {{site.android-dev}}/studio/projects/add-native-code
[Android NDK Native APIs]: {{site.android-dev}}/ndk/guides/stable_apis
[CocoaPods example]: {{site.github}}/CocoaPods/CocoaPods/blob/master/examples/Vendored%20Framework%20Example/Example%20Pods/VendoredFrameworkExample.podspec
[Dart API reference documentation]: {{site.dart.api}}/dev/
[dart:ffi]: {{site.dart.api}}/dev/dart-ffi/dart-ffi-library.html
[`DynamicLibrary.executable`]: {{site.dart.api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html
[`DynamicLibrary.open`]: {{site.dart.api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html
[`DynamicLibrary.process`]: {{site.dart.api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface
[ffi issue]: {{site.github}}/dart-lang/sdk/issues/34452
[Upgrading Flutter]: /docs/development/tools/sdk/upgrading
[Flutter macOS Desktop]: /desktop
[Android guidelines]: {{site.android-dev}}/topic/performance/reduce-apk-size#extract-false

