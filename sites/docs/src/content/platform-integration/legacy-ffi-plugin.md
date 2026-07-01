---
title: Bind to native code using the legacy FFI plugin template
description: >-
  Use the legacy plugin_ffi template and dart:ffi to bind to
  native C code in your Flutter plugin or app.
---

:::warning
This page documents the legacy `plugin_ffi` approach to C interop.

Since Flutter 3.38, we recommend using the `package_ffi` template with
[build hooks][] for C interop.

However, the legacy FFI plugin template (`plugin_ffi`) documented here is
still useful if you need to:

- Access the Flutter Plugin API.
- Use static linking (on iOS and macOS).
- Configure a Google Play services runtime on Android.
:::

Flutter mobile and desktop apps can
use the [`dart:ffi`][] library to call native C APIs.
_FFI_ stands for [_foreign function interface._][FFI]
Other terms for similar functionality include
_native interface_ and _language bindings._

[build hooks]: /platform-integration/bind-native-code
[`dart:ffi`]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface

Before your library or program can
use the FFI library to bind to native code,
you must ensure that the native code is
loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading native code within a Flutter plugin or app.

This tutorial demonstrates how to bundle C/C++ sources
in a Flutter plugin and bind to them using the Dart FFI library.
In this walkthrough, you'll create a C function that
implements 32-bit addition and then exposes it through
a Dart plugin named `native_add`.

## Dynamic versus static linking

A native library can be linked into an app either
dynamically or statically. A statically linked library
is embedded into the app's executable image,
and is loaded when the app starts.

Symbols from a statically linked library can be
loaded using [`DynamicLibrary.executable`][] or
[`DynamicLibrary.process`][].

A dynamically linked library, by contrast, is distributed
in a separate file or folder within the app,
and loaded on-demand. The distribution format depends on
the platform:

- On Android, a dynamically linked library is distributed as a
  set of `.so` (ELF) files, one for each architecture.
  Only dynamic libraries are supported,
  because the main executable is the JVM,
  which Flutter doesn't link to statically.
- On iOS and macOS, the dynamically linked library is
  distributed as a `.framework` folder.

A dynamically linked library can be loaded into
Dart using [`DynamicLibrary.open`][].

[`DynamicLibrary.executable`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html
[`DynamicLibrary.open`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.open.html
[`DynamicLibrary.process`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.process.html

## Create an FFI plugin

To create an FFI plugin called `native_add`,
use `flutter create` with the `plugin_ffi` template:

```console
$ flutter create --platforms=android,ios,macos,windows,linux --template=plugin_ffi native_add
```

:::note
You can exclude platforms from `--platforms` that you don't want to build to.
However, you need to include the platform of the device you are testing on.
:::

This creates a plugin with C/C++ sources in `native_add/src`.
These sources are built by the native build files in the
various OS build folders.

The FFI library can only bind against C symbols,
so in C++ these symbols are marked `extern "C"`.

You should also add attributes to indicate that the
symbols are referenced from Dart,
to prevent the linker from discarding the symbols
during link-time optimization:
`__attribute__((visibility("default"))) __attribute__((used))`.

The platform-specific build file links the code:

- On Android, `native_add/android/build.gradle`.
- On iOS, `native_add/ios/native_add.podspec`.
- On macOS, `native_add/macos/native_add.podspec`.
- On Linux, `native_add/linux/CMakeLists.txt`.
- On Windows, `native_add/windows/CMakeLists.txt`.

The native code is invoked from
Dart in `lib/native_add_bindings_generated.dart`.

The bindings are generated with [`package:ffigen`][].

[`package:ffigen`]: {{site.pub-pkg}}/ffigen

## Other use cases

### iOS

The dynamic linker automatically loads
dynamically linked libraries when the app starts.
Their constituent symbols can be resolved using [`DynamicLibrary.process`][].
You can also get a handle to the library with [`DynamicLibrary.open`][] to
restrict the scope of symbol resolution, but it's
unclear how Apple's review process handles this.

Symbols statically linked into the application binary can be
resolved using [`DynamicLibrary.executable`][] or [`DynamicLibrary.process`][].

#### Platform library {:#ios-platform-library}

To link against a platform library,
use the following instructions:

1.  In Xcode, open `Runner.xcworkspace`.
1.  Select the target platform.
1.  Click **+** in the **Linked Frameworks and Libraries** section.
1.  Select the system library to link against.

#### First-party library {:#ios-first-party-library}

A first-party native library can be included either
as source or as a (signed) `.framework` file.
It's probably possible to include statically linked
archives as well, but it requires testing.

#### Source code {:#ios-source-code}

To link directly to source code,
use the following instructions:

1.  In Xcode, open `Runner.xcworkspace`.
1.  Add the C/C++/Objective-C/Swift
    source files to the Xcode project.
1.  Add the following prefix to the exported symbol declarations to
    ensure they are visible to Dart:

    **C/C++/Objective-C:**

    ```objc
    extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
    ```

    **Swift:**

    ```swift
    @_cdecl("myFunctionName")
    ```

#### Compiled (dynamic) library {:#ios-compiled-dynamic-library}

To link to a compiled dynamic library,
use the following instructions:

1.  If a properly signed `Framework` file is present,
    open `Runner.xcworkspace`.
1.  Add the framework file to the
    **Frameworks, Libraries, and Embedded Content** section of
    the target in Xcode.
1.  Under the **Embed** column, select **Embed & Sign**.

#### Open-source third-party library {:#ios-open-source-third-party-library}

To create a Flutter plugin that includes both
C/C++/Objective-C _and_ Dart code,
use the following instructions:

1.  In your plugin project, open `ios/<myproject>.podspec`.
1.  Add the native code to the `source_files` field.

The native code is then statically linked into
the application binary of any app that uses this plugin.

#### Closed-source third-party library {:#ios-closed-source-third-party-library}

To create a Flutter plugin that includes Dart source code,
but distribute the C/C++ library in binary form,
use the following instructions:

1.  In your plugin project, open `ios/<myproject>.podspec`.
1.  Add a `vendored_frameworks` field.
    See the [CocoaPods example][].

:::warning
**Do not** upload this plugin
(or any plugin containing binary code) to pub.dev.
Instead, this plugin should be downloaded
from a trusted third-party,
as shown in the CocoaPods example.
:::

[CocoaPods example]: {{site.github}}/CocoaPods/CocoaPods/blob/master/examples/Vendored%20Framework%20Example/Example%20Pods/VendoredFrameworkExample.podspec

#### Stripping symbols {:#ios-stripping-symbols}

When creating a release build, Xcode strips the symbols.

1.  In Xcode, select the **Runner** target,
    then go to **Build Settings > Strip Style**.
1.  Change from **All Symbols** to **Non-Global Symbols**.

### macOS

The dynamic linker automatically loads
dynamically linked libraries when the app starts.
Their constituent symbols can be resolved using [`DynamicLibrary.process`][].
You can also get a handle to the library with [`DynamicLibrary.open`][] to
restrict the scope of symbol resolution, but it's
unclear how Apple's review process handles this.

Symbols statically linked into the application binary can be
resolved using [`DynamicLibrary.executable`][] or [`DynamicLibrary.process`][].

#### Platform library {:#macos-platform-library}

To link against a platform library,
use the following instructions:

1.  In Xcode, open `Runner.xcworkspace`.
1.  Select the target platform.
1.  Click **+** in the **Linked Frameworks and Libraries** section.
1.  Select the system library to link against.

#### First-party library {:#macos-first-party-library}

A first-party native library can be included either
as source or as a (signed) `.framework` file.
It's probably possible to include statically linked
archives as well, but it requires testing.

#### Source code {:#macos-source-code}

To link directly to source code,
use the following instructions:

1.  In Xcode, open `Runner.xcworkspace`.
1.  Add the C/C++/Objective-C/Swift
    source files to the Xcode project.
1.  Add the following prefix to the exported symbol declarations to
    ensure they are visible to Dart:

    **C/C++/Objective-C:**

    ```objc
    extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
    ```

    **Swift:**

    ```swift
    @_cdecl("myFunctionName")
    ```

#### Compiled (dynamic) library {:#macos-compiled-dynamic-library}

To link to a compiled dynamic library,
use the following instructions:

1.  If a properly signed `Framework` file is present,
    open `Runner.xcworkspace`.
1.  Add the framework file to the
    **Frameworks, Libraries, and Embedded Content** section of
    the target in Xcode.
1.  Under the **Embed** column, select **Embed & Sign**.

#### Compiled (dynamic) library, closed source {:#macos-compiled-dynamic-library-closed-source}

To add a closed source library to a
[Flutter macOS Desktop][] app,
use the following instructions:

1.  Follow the instructions for Flutter desktop to
    create a Flutter desktop app.
1.  Open the `yourapp/macos/Runner.xcworkspace` in Xcode.
    1.  Drag your precompiled library (`libyourlibrary.dylib`)
        into `Runner/Frameworks`.
    1.  Click `Runner` and go to the `Build Phases` tab.
        1.  Drag `libyourlibrary.dylib` into the `Copy Bundle Resources` list.
        1.  Under `Embed Libraries`, check `Code Sign on Copy`.
        1.  Under `Link Binary With Libraries`,
            set status to `Optional`. (We use dynamic linking,
            no need to statically link.)
    1.  Click `Runner` and go to the `General` tab.
        1.  Drag `libyourlibrary.dylib` into the
            **Frameworks, Libraries, and Embedded Content** list.
        1.  Select **Embed & Sign**.
    1.  Click **Runner** and go to the **Build Settings** tab.
        1.  In the **Search Paths** section configure the
            **Library Search Paths** to include the path
            where `libyourlibrary.dylib` is located.
1.  Edit `lib/main.dart`.
    1.  Use `DynamicLibrary.open('libyourlibrary.dylib')` to
        dynamically link to the symbols.
    1.  Call your native function somewhere in a widget.
1.  Run `flutter run` and check that your native function gets called.
1.  Run `flutter build macos` to build a
    self-contained release version of your app.

[Flutter macOS Desktop]: /platform-integration/macos/building

#### Stripping symbols {:#macos-stripping-symbols}

When creating a release build, Xcode strips the symbols.

1.  In Xcode, select the **Runner** target,
    then go to **Build Settings > Strip Style**.
1.  Change from **All Symbols** to **Non-Global Symbols**.

### Android

#### Platform library {:#android-platform-library}

To link against a platform library,
use the following instructions:

1.  Find the desired library in the [Android NDK Native APIs][]
    list in the Android docs. This lists stable native APIs.
1.  Load the library using [`DynamicLibrary.open`][].
    For example, to load OpenGL ES (v3):

    ```dart
    DynamicLibrary.open('libGLES_v3.so');
    ```

You might need to update the Android manifest file of the
app or plugin if indicated by the documentation.

[Android NDK Native APIs]: {{site.android-dev}}/ndk/guides/stable_apis

#### First-party library {:#android-first-party-library}

The process for including native code in
source code or binary form is the same for an app or plugin.

#### Open-source third-party library {:#android-open-source-third-party-library}

Follow the [Add C and C++ code to your project][]
instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).

[Add C and C++ code to your project]: {{site.android-dev}}/studio/projects/add-native-code

#### Closed-source third-party library {:#android-closed-source-third-party-library}

To create a Flutter plugin that includes Dart source code,
but distribute the C/C++ library in binary form,
use the following instructions:

1.  Open the `android/build.gradle` file for your project.
1.  Add the AAR artifact as a dependency.
    **Don't** include the artifact in your Flutter package.
    Instead, it should be downloaded from a repository, such as Maven Central.

#### Android APK size (shared object compression)

[Android guidelines][] in general recommend
distributing native shared objects uncompressed
because that actually saves on device space.
Shared objects can be directly loaded from the APK instead of
unpacking them on the device into a temporary location and then loading.
APKs are additionally packed in transit&mdash;that's
why you should be looking at download size.

By default, Flutter APKs compress `libflutter.so` and `libapp.so`,
which leads to a smaller APK size but a larger on-device size.
To control whether native libraries are stored compressed and extracted at
install time, set the Android Gradle plugin's `useLegacyPackaging` option.
For current recommendations, see the [Android guidelines][].

[Android guidelines]: {{site.android-dev}}/topic/performance/reduce-apk-size#extract-false

## Other resources

To learn more about C interoperability, check out these videos:

- [C interoperability with Dart FFI][]
- [How to Use Dart FFI to Build a Retro Audio Player][]

[C interoperability with Dart FFI]: {{site.yt.watch}}?v=2MMK7YoFgaA
[How to Use Dart FFI to Build a Retro Audio Player]: {{site.yt.watch}}?v=05Wn2oM_nWw
