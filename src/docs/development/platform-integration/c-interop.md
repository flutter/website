---
title: "Binding to native code using dart:ffi"
description: "To use C code in your Flutter program, use the dart:ffi library (currently in preview)."
---

Flutter mobile can use the [dart:ffi][] library
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
symbols can be resolved using [`DynamicLibrary.process`][].
You can also get a handle to the library with
[`DynamicLibrary.open`][] to restrict the scope of
symbol resolution, but it's unclear how Apple's
review process handles this.
(**Question: I find this, and the next paragraph, to be
 confusing. Why does the developer care about this?
 Can we find a better/more compelling way to word it?**)

Symbols statically linked into the application binary
can be resolved using [`DynamicLibrary.executable`][] or
[`DynamicLibrary.process`][].

### Link to a system library shipped with a target device

To link against a platform's system library,
use the following instructions:

1. In Xcode, open `Runner.xcodeproj`.
1. Select the target platform.
1. Click **+** in the **Linked Frameworks and Libraries**
   section.
1. Select the system library to link against.

### Link directly to source code

To link directly to source code,
use the following instructions:

<ol markdown="1">
<li markdown="1">In Xcode, open `Runner.xcodeprof`.
</li>
<li markdown="1">Add the C/C++/Objective-C/Swift
    source files to the Xcode project.
    (**Question: Is this added to Runner.xcodeproj?
     I'm assuming so. Also, do we have an example?**)
</li>
<li markdown="1">Add the following prefix to the
    exported symbol declarations to ensure they
    are visible to Dart:
    (**Question: Is "exported symbol declarations" in the same file?**)

**C/C++/Objective-C**

```objective-c
extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute((used))
```

**Swift**

```swift
@_cdecl("myFunctionName")
```
</li>
</ol>

### Link to a compiled library

To link to a compiled dynamic library,
use the following instructions:

1. If a properly signed `Framework` file is present,
   open `Runner.xcodeproj` and add it to
   it to the **Embedded Binaries** section.
1. Also add it to the **Linked Frameworks & Libraries**
   section of the target in Xcode.

(**Question: If no Framework file is present, or if it IS
 present, but not properly signed, what then?**)

### Create a plugin containing Dart and native code

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

### Create a plugin distributed in binary form

To create a Flutter plugin that includes Dart
source code, but distribute the C/C++ library
in binary form, use the following instructions:

1. In your plugin project,
   open `ios/<myproject>.podspec`.
1. Add a `vendored_frameworks` field.
   See the [CocoaPods example][].

**Do not** upload this plugin
(or any plugin containing binary code)
to Pub. Instead, this plugin should be downloaded
from a trusted third-party,
as shown in the CocoaPods example.

## Android

### Link to a system library shipped with a target device

To link against a platform's system library,
use the following instructions:

1. Find the desired library in the
   [Android NDK Native APIs][]
   list in the Android docs.
   This lists stable native APIs.
   (**Question: What if it's not in the list?
   Are you then unable to make it work?**)
1. Load the library using
   [`DynamicLibrary.open`][].
   For example, to load OpenGL ES (v3):

   ```dart
   DynamicLibrary.open('libGLES_v3.so');
   ```

You might need to update the Android manifest
file of the app or plugin if indicated by
the documentation.

### Create a plugin containing Dart and native code

Follow the [Add C and C++ code to your project][]
instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).
(**Comment: Wow, the instructions on that page are
 long and complex. It's rather intimidating.**)

### Create a plugin distributed in binary form

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

## Web

Plugins are not yet supported for web apps.


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

