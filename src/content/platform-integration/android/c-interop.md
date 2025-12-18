---
title: "Binding to native Android code"
description: "To use C code in your Flutter program, use build hooks or the dart:ffi library."
---

<?code-excerpt path-base="platform_integration"?>

This guide demonstrates how to bind your Flutter app to native Android code.

## Overview

Flutter mobile and desktop apps can use [build hooks][] or the the [dart:ffi][]
library to call native C APIs. FFI stands for
[_foreign function interface._][FFI]. Other terms for similar functionality
include _native interface_ and _language bindings_.

:::note
This feature is not yet supported for web plugins.
:::

Prefer using an FFI package with [build hooks][] and code assets.

**Packages with code assets**:
*   Don't require OS-specific build scripts.
*   Run on all OSes and on Dart standalone.
*   Access native code in a uniform way no matter what link mode is used.

**Legacy FFI plugins**:
*   Can access the Flutter plugin API.
*   Can use Google Play services on Android.

[build hooks]: {{site.baseurl}}/packages-and-plugins/developing-packages#build-hooks
[dart:ffi]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface

### Accessing native code (build hooks)

When using build hooks, you can access native code using the
`@Native` annotation. The `@Native` annotation resolves native symbols
automatically.

```dart
@Native<Int32 Function(Int32, Int32)>(symbol: 'native_add')
external int nativeAdd(int a, int b);
```

Currently, build hooks essentially use dynamic linking.
However, the `@Native` annotation is agnostic to the linking method.
This means that if build hooks support static linking in the future,
your Dart code won't need to change.

### Dynamic vs static linking (legacy FFI plugin) {: #static-linking }

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

API documentation is available from the
[Dart API reference documentation][].

On Android, only dynamic libraries are supported
(because the main executable is the JVM,
which we don't link to statically).

[Dart API reference documentation]: {{site.dart.api}}
[`DynamicLibrary.executable`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html
[`DynamicLibrary.open`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.open.html
[`DynamicLibrary.process`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.process.html

## Create an FFI package (build hooks) {: #create-an-ffi-package }

To create an FFI package called "native_add",
do the following:

```console
$ flutter create --template=package_ffi native_add
$ cd native_add
```

This creates a package with C/C++ sources in `native_add/src`.
These sources are built by the `hook/build.dart` file.

The FFI library can only bind against C symbols,
so in C++ these symbols are marked `extern "C"`.

:::note
If you are using the legacy `plugin_ffi`,
You should also add attributes to indicate that the
symbols are referenced from Dart,
to prevent the linker from discarding the symbols
during link-time optimization.
`__attribute__((visibility("default"))) __attribute__((used))`.
:::

The native code is invoked from dart in `lib/native_add_bindings_generated.dart`.

The bindings are generated with [package:ffigen]({{site.pub-pkg}}/ffigen).

### Platform library (build hooks) {: #platform-library }

To link against a platform library, use the `DynamicLoadingSystem` in your
`hook/build.dart`.

For example, to load OpenGL ES (v3):

```dart
      output.assets.code.add(
        CodeAsset(
          package: 'my_package',
          name: 'libGLES_v3',
          linkMode: DynamicLoadingSystem(Uri.file('libGLES_v3.so')),
        ),
      );
```

You might need to update the Android manifest
file of the app or plugin if indicated by
the documentation.

### First-party support

The process for including native code in source
code or binary form is the same for an app or
plugin.

### Open-source third-party support

For open source, build the C/C++ sources in your build hook. Or build the
sources on GitHub actions and download the binary from github artifacts on
the build hook.

### Closed-source third-party support

For closed source, build the dynamic library somewhere, and download it in
your build hook.

## Create an FFI plugin (legacy) {: #create-an-ffi-plugin }

Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading Android native code within a Flutter plugin or app.

If you need to access the Flutter Plugin API in Swift/Kotlin,
or if you need to configure a Google Play services runtime on Android,
you should use the legacy `plugin_ffi` template:

```console
$ flutter create --platforms=android --template=plugin_ffi native_add
```

This creates a plugin with C/C++ sources in `native_add/src`,
but uses platform-specific build files (like `android/build.gradle`)
to build the native code.

### Platform library (legacy FFI plugin)

To link against a platform library,
use the following instructions:

 1. Find the desired library in the [Android NDK Native APIs][]
    list in the Android docs. This lists stable native APIs.
 1. Load the library using [`DynamicLibrary.open`][].
    For example, to load OpenGL ES (v3):

    ```dart
    DynamicLibrary.open('libGLES_v3.so');
    ```

You might need to update the Android manifest
file of the app or plugin if indicated by
the documentation.

[Android NDK Native APIs]: {{site.android-dev}}/ndk/guides/stable_apis

### Open-source third-party support (legacy)

Follow the [Add C and C++ code to your project][]
instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).

[Add C and C++ code to your project]: {{site.android-dev}}/studio/projects/add-native-code

### Closed-source third-party library support (legacy)

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

```xml diff
  <manifest xmlns:android="http://schemas.android.com/apk/res/android"
-     package="com.example.your_app_name">
+     xmlns:tools="http://schemas.android.com/tools"
+     package="com.example.your_app_name" >
      <!-- io.flutter.app.FlutterApplication is an android.app.Application that
           calls FlutterMain.startInitialization(this); in its onCreate method.
           In most cases you can leave this as-is, but you if you want to provide
           additional functionality it is fine to subclass or reimplement
           FlutterApplication and put your custom class here. -->

      <application
          android:name="io.flutter.app.FlutterApplication"
          android:label="your_app_name"
-         android:icon="@mipmap/ic_launcher">
+         android:icon="@mipmap/ic_launcher"
+         android:extractNativeLibs="true"
+         tools:replace="android:extractNativeLibs">
```

[Android guidelines]: {{site.android-dev}}/topic/performance/reduce-apk-size#extract-false

{% render "docs/resource-links/ffi-video-resources.md", site: site %}
