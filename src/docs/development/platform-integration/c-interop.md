---
title: "Binding to native code using dart:ffi"
description: "To use C code in your Flutter program, use the dart:ffi library (currently in preview)."
---

Flutter mobile can use the dart:ffi library
to call native C APIs. The _ffi_ acronym stands for
[_foreign function interface._][FFI]
Other terms for similar functionality include
_native interface_ and _language bindings._

{{ site.alert.note }}
  The dart:ffi library is [in active development][ffi issue]
  and isn't complete yet. Note that the API is likely to have
  breaking changes between now and its completion.

  Using the feature requires a Flutter 1.10.x
  dev channel build. To switch to the dev channel and
  upload the latest dev version, do the following:

  ```terminal
  $ flutter channel dev
  $ flutter upgrade
  ```
  For more information on Flutter's channels,
  see [Upgrading Flutter][].
{{ site.alert.end }}

API documentation is available from the Dart dev channel:
[Dart API reference documentation][].

## iOS and macOS

Dynamically linked libraries are automatically loaded by
the dynamic linker when the app starts. Their constituent
symbols can be resolved via [`DynamicLibrary.process`][].
You can also get a handle to the library with
[`DynamicLibrary.open`][] to restrict the scope of
symbol resolution, but it's unclear how Apple's
review process handles this.

Symbols statically linked into the application binary
can be resolved via [`DynamicLibrary.executable`][] or
[`DynamicLibrary.process`][].

### Platform library

To link against a platform library,
open `Runner.xcodeproj` in Xcode, select the target,
click **+** in the **Linked Frameworks and Libraries**
section, and select the platform library to link against.

### First-party library

A first-party native library can be included either as
source or as a (signed) `.framework`.
It's probably possible to include statically linked
archives as well, but this should be tested.

#### Source

Add the C/C++/Objective-C/Swift sources to the Xcode
project, and add the following prefix to the exported
symbol declarations to ensure they are visible to Dart:

**C/C++/Objective-C**

```
extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute((used))
```

**Swift**

```
@_cdecl("myFunctionName")
```

#### Compiled (dynamic library)

If a (properly signed) `Framework` file is present,
add it to the **Embedded Binaries** and
**Linked Frameworks & Libraries** section of the
target in Xcode.

### Open-source third-party library

Simply add the native code to the `source_files`
field of the `.podspec` in the Flutter plugin.
The native code will be statically linked into
the application binary of any downstream app.

### Closed-source third-party library

Add a `vendored_frameworks` field to the `.podspec`
of the Flutter plugin. See the [CocoaPods Example][].

Note that binary code should not be uploaded to
Pub directly but rather downloaded from a trusted
third-party as in the example.

## Android

### Platform library

See [Android NDK Native APIs][] in the
Android docs for a list of stable native APIs.

[`DynamicLibrary.open`][] can be used to load
a library from the list.
For example, to load OpenGL ES (v3):

```
DynamicLibrary.open("libGLES_v3.so");
```

You might need to update the Android manifest
file of the app or plugin if indicated by
the documentation.

### First-party library

The process for including native code in source
or binary form is the same for an app or plugin.

### Open-source third-party library

Follow the [Add C and C++ code to your project][]
instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).

### Closed-source third-party library

Add the AAR artifact as a dependency in your `build.gradle`.
It should be downloaded from a repository such as JCenter,
not included in your Flutter package.


[Add C and C++ code to your project]: {{site.android-dev}}/studio/projects/add-native-code
[Android NDK Native APIs]: {{site.android-dev}}/ndk/guides/stable_apis
[CocoaPods Example]: {{site.github}}/CocoaPods/CocoaPods/blob/master/examples/Vendored%20Framework%20Example/Example%20Pods/VendoredFrameworkExample.podspec
[Dart API reference documentation]: {{site.dart-api}}/dev/
[`DynamicLibrary.executable`]: {{site.dart-api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html
[`DynamicLibrary.open`]: {{site.dart-api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html
[`DynamicLibrary.process`]: {{site.dart-api}}/dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface
[ffi issue]: {{site.github}}/dart-lang/sdk/issues/34452
[Upgrading Flutter]: /docs/development/tools/sdk/upgrading

