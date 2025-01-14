---
title: "Binding to native macOS code using dart:ffi"
description: "To use C code in your Flutter program, use the dart:ffi library."
---

<?code-excerpt path-base="platform_integration"?>

Flutter mobile and desktop apps can use the
[dart:ffi][] library to call native C APIs.
_FFI_ stands for [_foreign function interface._][FFI]
Other terms for similar functionality include
_native interface_ and _language bindings._

:::note
This page describes using the `dart:ffi` library
in macOS desktop apps.
For information on Android, see
[Binding to native Android code using dart:ffi][android-ffi].
For information on iOS, see
[Binding to native iOS code using dart:ffi][ios-ffi].
This feature is not yet supported for web plugins.
:::


[android-ffi]: /platform-integration/android/c-interop
[ios-ffi]: /platform-integration/ios/c-interop
[dart:ffi]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface

Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading macOS native code within a Flutter plugin or app.

This tutorial demonstrates how to bundle C/C++
sources in a Flutter plugin and bind to them using
the Dart FFI library on macOS.
In this walkthrough, you'll create a C function
that implements 32-bit addition and then
exposes it through a Dart plugin named "native_add".

## Dynamic vs static linking

A native library can be linked into an app either
dynamically or statically. A statically linked library
is embedded into the app's executable image,
and is loaded when the app starts.

Symbols from a statically linked library can be
loaded using `DynamicLibrary.executable` or
`DynamicLibrary.process`.

A dynamically linked library, by contrast, is distributed
in a separate file or folder within the app,
and loaded on-demand. On macOS, the dynamically linked
library is distributed as a `.framework` folder.

A dynamically linked library can be loaded into
Dart using `DynamicLibrary.open`.

API documentation is available from the
[Dart API reference documentation][].


[Dart API reference documentation]: {{site.dart.api}}

## Create an FFI plugin

If you already have a plugin, skip this step.

To create a plugin called "native_add",
do the following:

```console
$ flutter create --platforms=macos --template=plugin_ffi native_add
$ cd native_add
```

:::note
You can exclude platforms from `--platforms` that you don't want
to build to. However, you need to include the platform of 
the device you are testing on.
:::

This will create a plugin with C/C++ sources in `native_add/src`.
These sources are built by the native build files in the various
os build folders.

The FFI library can only bind against C symbols,
so in C++ these symbols are marked `extern "C"`.

You should also add attributes to indicate that the
symbols are referenced from Dart,
to prevent the linker from discarding the symbols
during link-time optimization.
`__attribute__((visibility("default"))) __attribute__((used))`.

On iOS, the `native_add/macos/native_add.podspec` links the code.

The native code is invoked from dart in `lib/native_add_bindings_generated.dart`.

The bindings are generated with [package:ffigen]({{site.pub-pkg}}/ffigen).

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


[`DynamicLibrary.executable`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html
[`DynamicLibrary.open`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.open.html
[`DynamicLibrary.process`]: {{site.dart.api}}/dart-ffi/DynamicLibrary/DynamicLibrary.process.html

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

    ```objc
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

To add a closed source library to a
[Flutter macOS Desktop][] app,
use the following instructions:

1. Follow the instructions for Flutter desktop to create
   a Flutter desktop app.
1. Open the `yourapp/macos/Runner.xcworkspace` in Xcode.
   1. Drag your precompiled library (`libyourlibrary.dylib`)
      into `Runner/Frameworks`.
   1. Click `Runner` and go to the `Build Phases` tab.
      1. Drag `libyourlibrary.dylib` into the
         `Copy Bundle Resources` list.
      1. Under `Embed Libraries`, check `Code Sign on Copy`.
      1. Under `Link Binary With Libraries`,
         set status to `Optional`. (We use dynamic linking,
         no need to statically link.)
   1. Click `Runner` and go to the `General` tab.
      1. Drag `libyourlibrary.dylib` into the **Frameworks,
         Libraries and Embedded Content** list.
      1. Select **Embed & Sign**.
   1. Click **Runner** and go to the **Build Settings** tab.
      1. In the **Search Paths** section configure the
         **Library Search Paths** to include the path
         where `libyourlibrary.dylib` is located.
1. Edit `lib/main.dart`.
   1. Use `DynamicLibrary.open('libyourlibrary.dylib')`
      to dynamically link to the symbols.
   1. Call your native function somewhere in a widget.
1. Run `flutter run` and check that your native function gets called.
1. Run `flutter build macos` to build a self-contained release
   version of your app.

[Flutter macOS Desktop]: /platform-integration/macos/building

{% comment %}

#### Open-source third-party library

To create a Flutter plugin that includes both
C/C++/Objective-C _and_ Dart code,
use the following instructions:

1. In your plugin project,
   open `macos/<myproject>.podspec`.
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
   open `macos/<myproject>.podspec`.
1. Add a `vendored_frameworks` field.
   See the [CocoaPods example][].

:::warning
**Do not** upload this plugin
(or any plugin containing binary code) to pub.dev.
Instead, this plugin should be downloaded
from a trusted third-party,
as shown in the CocoaPods example.
:::

[CocoaPods example]: {{site.github}}/CocoaPods/CocoaPods/blob/master/examples/Vendored%20Framework%20Example/Example%20Pods/VendoredFrameworkExample.podspec

## Stripping macOS symbols

When creating a release archive (IPA),
the symbols are stripped by Xcode.

1. In Xcode, go to **Target Runner > Build Settings > Strip Style**.
2. Change from **All Symbols** to **Non-Global Symbols**.

{% endcomment %}

{% include docs/resource-links/ffi-video-resources.md %}
