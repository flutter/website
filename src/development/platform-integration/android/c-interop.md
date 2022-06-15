---
title: "Binding to native Android code using dart:ffi"
description: "To use C code in your Flutter program, use the dart:ffi library."
---

<?code-excerpt path-base="development/platform_integration"?>

Flutter mobile and desktop apps can use the
[dart:ffi][] library to call native C APIs.
_FFI_ stands for [_foreign function interface._][FFI]
Other terms for similar functionality include
_native interface_ and _language bindings._

{{site.alert.note}}
  This page describes using the `dart:ffi` library
  in Android apps. For information on iOS, see
  [Binding to native iOS code using dart:ffi][ios-ffi].
  For information in macOS, see
  [Binding to native macOS code using dart:ffi][macos-ffi].
  This feature is not yet supported for web plugins.
{{site.alert.end}}


[ios-ffi]: {{site.url}}/development/platform-integration/ios/c-interop
[dart:ffi]: {{site.dart.api}}/dev/dart-ffi/dart-ffi-library.html
[macos-ffi]: {{site.url}}/development/platform-integration/macos/c-interop
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface

Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading Android native code within a Flutter plugin or app.

This tutorial demonstrates how to bundle C/C++
sources in a Flutter plugin and bind to them using
the Dart FFI library on both Android and iOS.
In this walkthrough, you'll create a C function
that implements 32-bit addition and then
exposes it through a Dart plugin named "native_add".

### Dynamic vs static linking

A native library can be linked into an app either
dynamically or statically. A statically linked library
is embedded into the app's executable image,
and is loaded when the app starts.

Symbols from a statically linked library can be
loaded using [`DynamicLibrary.executable`][] or
[`DynamicLibrary.process`][].

A dynamically linked library, by contrast, is distributed
in a separate file or folder within the app,
and loaded on-demand. On Android, a dynamically
linked library is distributed as a set of `.so` (ELF)
files, one for each architecture.

A dynamically linked library can be loaded into
Dart via [`DynamicLibrary.open`][].

API documentation is available from the Dart dev channel:
[Dart API reference documentation][].


[Dart API reference documentation]: {{site.dart.api}}/dev/
[`DynamicLibrary.executable`]: {{site.dart.api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html
[`DynamicLibrary.open`]: {{site.dart.api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html
[`DynamicLibrary.process`]: {{site.dart.api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html

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

You need to inform the Android build system about
the native code so the code can be compiled
and linked appropriately into the final application.

You can add Android-specific sources
to the `android` folder and modify `CMakeLists.txt`
appropriately.
Also, Gradle allows you to point to the `ios` folder,
if that helps, but it's not required to use the same
sources for both iOS and Android;

The FFI library can only bind against C symbols,
so in C++ these symbols must be marked `extern C`.
You should also add attributes to indicate that the
symbols are referenced from Dart,
to prevent the linker from discarding the symbols
during link-time optimization.

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
the native code. The following example shows
how to create a handle for an iOS app OR an Android app:

<?code-excerpt "lib/c_interop.dart (DynamicLibrary)"?>
```dart
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();
```

Note that on Android the native library is named
in `CMakeLists.txt` (see above),
but on iOS it takes the plugin's name.

With a handle to the enclosing library,
you can resolve the `native_add` symbol:

<?code-excerpt "lib/c_interop.dart (NativeAdd)"?>
```dart
final int Function(int x, int y) nativeAdd = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
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

### Platform library

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


[Android NDK Native APIs]: {{site.android-dev}}/ndk/guides/stable_apis

#### First-party library

The process for including native code in source
code or binary form is the same for an app or
plugin.

#### Open-source third-party

Follow the [Add C and C++ code to your project][]
instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).


[Add C and C++ code to your project]: {{site.android-dev}}/studio/projects/add-native-code

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


## Android APK size (shared object compression)

[Android guidelines][] in general recommend
distributing native shared objects uncompressed
because that actually saves on device space.
Shared objects can be directly loaded from the APK
instead of unpacking them on device into a
temporary location and then loading.
APKs are additionally packed in transit&mdash;that's
why you should be looking at download size.

Flutter APKs by default don't follow these guidelines
and compress `libflutter.so` and `libapp.so`&mdash;this
leads to smaller APK size but larger on device size.

Shared objects from third parties can change this default
setting with `android:extractNativeLibs="true"` in their
`AndroidManifest.xml` and stop the compression of `libflutter.so`,
`libapp.so`, and any user-added shared objects.
To re-enable compression, override the setting in
`your_app_name/android/app/src/main/AndroidManifest.xml`
in the following way.

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

[Android guidelines]: {{site.android-dev}}/topic/performance/reduce-apk-size#extract-false

