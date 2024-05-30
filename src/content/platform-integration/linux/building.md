---
title: Build Linux apps with Flutter
description: Platform-specific considerations when building for Linux with Flutter.
toc: true
short-title: Linux development
---

This page discusses considerations unique to building
Linux apps with Flutter, including shell integration
and preparation of apps for distribution.

## Integrate with Linux

The Linux programming interface,
comprising library functions and system calls,
is designed around the C language and ABI.
Fortunately, Dart provides the `dart:ffi` package,
which enables Dart programs to call into C libraries.

Foreign Function Interfaces (FFI) allow Flutter apps to perform the
following with native libraries:

* allocate native memory with `malloc` or `calloc`
* support pointers, structs, and callbacks
* support Application Binary Interface (ABI) types like `long` and `size_t`

To learn more about calling C libraries from Flutter,
consult [C interop using `dart:ffi`][].

Many apps benefit from using a package that wraps the underlying library
calls in a more convenient, idiomatic Dart API.
[Canonical has built a series of packages][Canonical]
with a focus on enabling Dart and Flutter on Linux,
including support for desktop notifications,
dbus, network management, and Bluetooth.

In general, many other [packages support creating Linux apps][support-linux],
including common packages such as [`url_launcher`],
[`shared_preferences`], [`file_selector`], and [`path_provider`].

[C interop using `dart:ffi`]: {{site.dart-site}}/guides/libraries/c-interop
[Canonical]: {{site.pub}}/publishers/canonical.com/packages
[support-linux]: {{site.pub}}/packages?q=platform%3Alinux
[`url_launcher`]: {{site.pub-pkg}}/url_launcher
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`file_selector`]: {{site.pub-pkg}}/file_selector
[`path_provider`]: {{site.pub-pkg}}/path_provider

## Prepare Linux apps for distribution

The executable binary can be found in your project under
`build/linux/x64/<build mode>/bundle/`.
Alongside your executable binary in the `bundle` directory,
you can find two directories:

* `lib` contains the required `.so` library files
* `data` contains the application's data assets, such as fonts or images

In addition to these files, your application also relies on various
operating system libraries against which it's been compiled.
To see the full list of libraries,
use the `ldd` command on your application's directory.

For example, assume you have a Flutter desktop application
called `linux_desktop_test`.
To inspect the its system library dependencies, use the following commands:

```console
$ flutter build linux --release
$ ldd build/linux/x64/release/bundle/linux_desktop_test
```

To wrap up this application for distribution,
include everything in the `bundle` directory
and verify the target Linux system has all required system libraries.

This might only require using the following command.

```console
$ sudo apt-get install libgtk-3-0 libblkid1 liblzma5
```

To learn how to publish a Linux application to the [Snap Store],
consult [Build and release a Linux application to the Snap Store][].

## Additional resources

To learn how to create Linux Debian (`.deb`) and RPM (`.rpm`)
builds of your Flutter desktop app,
consult the step-by-step [Linux packaging guide][linux_packaging_guide].

[Snap Store]: https://snapcraft.io/store
[Build and release a Linux application to the Snap Store]: /deployment/linux
[linux_packaging_guide]: https://medium.com/@fluttergems/packaging-and-distributing-flutter-desktop-apps-the-missing-guide-part-3-linux-24ef8d30a5b4
