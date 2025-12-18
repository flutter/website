---
title: "Binding to native macOS code"
description: "To use C code in your Flutter program, use build hooks or the dart:ffi library."
---

<?code-excerpt path-base="platform_integration"?>

This guide demonstrates how to bind your Flutter app to native macOS code.

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
*   Can use static linking on iOS.

[build hooks]: {{site.baseurl}}/packages-and-plugins/developing-packages#build-hooks
[dart:ffi]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface

### Accessing native code (build hooks)

Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading macOS native code within a Flutter plugin or app.

When using build hooks, you can access native code using the `@Native` annotation.
The `@Native` annotation resolves native symbols automatically.

```dart
@Native<Int32 Function(Int32, Int32)>(symbol: 'native_add')
external int nativeAdd(int a, int b);
```

Currently, build hooks essentially use dynamic linking.
However, the `@Native` annotation is agnostic to the linking method.
This means that if build hooks support static linking in the future,
your Dart code won't need to change.

### Dynamic vs static linking (legacy FFI plugin)

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

## Create an FFI package (build hooks) {: #create-an-ffi-package }

If you already have a package, skip this step.

To create a package called "native_add",
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

### Platform library

To link against a platform library,
use the following instructions:

1. In Xcode, open `Runner.xcworkspace`.
1. Select the target platform.
1. Click **+** in the **Linked Frameworks and Libraries**
   section.
1. Select the system library to link against.

### First-party support

A first-party native library can be included either
as source or as a (signed) `.framework` file.
It's probably possible to include statically linked
archives as well, but it requires testing.

### Open-source third-party support

For open source, build the C/C++ sources in your build hook. Or build the
sources on GitHub actions and download the binary from github artifacts on
the build hook.

### Closed-source third-party support

For closed source, build the dynamic library somewhere, and download it in
your build hook.

## Create an FFI plugin (legacy) {: #create-an-ffi-plugin }

If you need to access the Flutter Plugin API in Swift/Objective-C,
you should use the legacy `plugin_ffi` template:

```console
$ flutter create --platforms=macos --template=plugin_ffi native_add
```

This creates a plugin with C/C++ sources in `native_add/src`,
but uses platform-specific build files (like `macos/native_add.podspec`)
to build the native code.

### First-party support

A first-party native library can be included either
as source or as a (signed) `.framework` file.
It's probably possible to include statically linked
archives as well, but it requires testing.

### Open-source third-party support

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

### Closed-source third-party support

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

## Link to source code

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

## Compiled (dynamic) library

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

## Work with symbols

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

## Stripping macOS symbols

When creating a release archive (IPA),
the symbols are stripped by Xcode.

1. In Xcode, go to **Target Runner > Build Settings > Strip Style**.
2. Change from **All Symbols** to **Non-Global Symbols**.

{% endcomment %}

{% render "docs/resource-links/ffi-video-resources.md", site: site %}
