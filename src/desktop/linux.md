---
title: Building Linux apps with Flutter
description: Platform-specific considerations for building for Linux with Flutter.
toc: true
short-title: Linux development
---

This page discusses considerations unique to building Linux apps with Flutter,
including shell integration and preparation of apps for distribution.

## Integrating with Linux

The Linux programming interface, comprising library functions and system calls,
is designed around the C language and ABI.
Fortunately, Dart provides `dart:ffi`,
which is designed to enable Dart programs to efficiently call into C libraries.
FFI provides Flutter apps with the ability to allocate native memory
with `malloc` or `calloc`, support for pointers, structs and callbacks,
and ABI types like `long` and `size_t`.

For more information about calling C libraries from Flutter,
see [C interop using `dart:ffi`].

Many apps will benefit from using a package that wraps the underlying library
calls in a more convenient, idiomatic Dart API.
[Canonical has built a series of packages][Canonical]
with a focus on enabling Dart and Flutter on Linux,
including support for desktop notifications, dbus, network management,
and Bluetooth.

More generally, many other [packages support Linux], including common packages
such as [`url_launcher`], [`shared_preferences`], [`file_selector`], and
[`path_provider`].

[C interop using `dart:ffi`]: {{site.dart-site}}/guides/libraries/c-interop
[Canonical]: {{site.pub}}/publishers/canonical.com/packages
[packages support Linux]: {{site.pub}}/packages?q=platform%3Alinux
[`url_launcher`]: {{site.pub-pkg}}/url_launcher
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`file_selector`]: {{site.pub-pkg}}/file_selector
[`path_provider`]: {{site.pub-pkg}}/path_provider

## Preparing Linux apps for distribution

The executable binary can be found in your project under
`build/linux/<build mode>/bundle/`. Alongside your
executable binary in the `bundle` directory there are
two directories:

* `lib` contains the required `.so` library files
* `data` contains the application's data assets,
    such as fonts or images

In addition to these files, your application also
relies on various operating system libraries that
it's been compiled against.
You can see the full list by running `ldd`
against your application. For example,
assuming you have a Flutter desktop application
called `linux_desktop_test` you could inspect
the system libraries it depends upon as follows:

```terminal
$ flutter build linux --release
$ ldd build/linux/release/bundle/linux_desktop_test
```

To wrap up this application for distribution
you need to include everything in the `bundle` directory,
and make sure the Linux system you are installing
it upon has all of the system libraries required.
This may be as simple as:

```terminal
$ sudo apt-get install libgtk-3-0 libblkid1 liblzma5
```

For information on publishing a Linux application
to the [Snap Store], see
[Build and release a Linux application to the Snap Store].

[Snap Store]: https://snapcraft.io/store
[Build and release a Linux application to the Snap Store]: {{site.url}}/deployment/linux
