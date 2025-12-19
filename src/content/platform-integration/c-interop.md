---
title: Bind to native code using FFI
description: To use native code in your Flutter program, use the dart:ffi library with the package_ffi template.
---

Flutter apps can use the [dart:ffi][] library to call native APIs.
_FFI_ stands for [_foreign function interface_][FFI].
Other terms for similar functionality include
_native interface_ and _language bindings._

Since Flutter 3.38, the recommended way to bind to native code is to use
the `flutter create --template=package_ffi` command. This template uses
[build hooks](https://dart.dev/tools/hooks) to configure the native build
in a `build.dart` script, and no longer requires OS-specific build files.
This approach works for both Flutter and Dart standalone projects.

The legacy FFI plugins (`flutter create --template=plugin_ffi`) are still
useful for some situations. For these cases, refer to the legacy FFI plug-in documentation:
- [Android](/platform-integration/android/c-interop)
- [iOS](/platform-integration/ios/c-interop)
- [macOS](/platform-integration/macos/c-interop)

[dart:ffi]: {{site.dart.api}}/dart-ffi/dart-ffi-library.html
[FFI]: https://en.wikipedia.org/wiki/Foreign_function_interface

## Create an FFI package

To create an FFI package, run the following command:

```console
$ flutter create --template=package_ffi native_add
$ cd native_add
```

This creates a package with the following specialized content:

- **`lib/native_add.dart`**: The Dart code that defines the API of the package.
- **`lib/src/native_add_bindings_generated.dart`**: The generated Dart bindings for the native code.
- **`src/native_add.c`**: The native C source code.
- **`src/native_add.h`**: The C header file for the native code.
- **`hook/build.dart`**: A script that is run by the Flutter SDK to compile the native code.
- **`ffigen.yaml`**: The configuration file for [`package:ffigen`][] to generate the Dart bindings.
- **`pubspec.yaml`**: The package definition, which enables the `build.dart` hook.

[`package:ffigen`]: {{site.pub-pkg}}/ffigen

## The native code

The native code is located in `src/native_add.c` and `src/native_add.h`. The C function `sum` is defined in the `.c` file and its signature is in the header file. The function is marked to be exported so that it can be called from Dart.

## The build hook

The native code is compiled and bundled with your app automatically. This is done by the `hook/build.dart` script, which is a [build hook](https://dart.dev/tools/hooks).

This means you no longer need to write OS-specific build files (like `CMakeLists.txt` for Linux/Windows, `.podspec` for iOS/macOS, or `build.gradle` for Android) to compile your native code.

The build hook uses `package:native_toolchain_c` to compile the C code into a dynamic library. You can customize this file to build other native languages or to download pre-compiled binaries.

## The Dart code

The Dart code defines the public API of the package.

### Generating the bindings

To bind to the native code, the template uses [`package:ffigen`][] to generate bindings from the header file (`src/native_add.h`). The generation is configured in `ffigen.yaml`.

This generates `lib/src/native_add_bindings_generated.dart`.

### Calling the native function

The generated bindings in `lib/src/native_add_bindings_generated.dart` contain `@Native() external` functions. These functions are automatically resolved at runtime against the code asset outputted by the build hook (which runs at build time). This means there is no OS-specific logic required for `dlopen`-ing the dynamic libraries, making the Dart code truly cross-platform.

The main library file `lib/native_add.dart` exposes these functions. Your app can then call these functions by importing `package:native_add/native_add.dart`.

## Testing

The generated package includes a unit test in `test/native_add_test.dart` that shows how to test the native function.
