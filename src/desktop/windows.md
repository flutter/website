---
title: Building Windows apps with Flutter
description: Platform-specific considerations for building for Windows with Flutter.
toc: true
short-title: Windows development
---

This page discusses considerations unique to building Windows apps with Flutter,
including shell integration and distribution of Windows apps through the
Microsoft Store on Windows.

## Integrating with Windows

The Windows programming interface combines traditional Win32 APIs, COM
interfaces and more modern Windows Runtime libraries. As all these provide a
C-based ABI, it is possible to call into the services provided by the operating
system using Dart's Foreign Function Interface library (`dart:ffi`). FFI is
designed to enable Dart programs to efficiently call into C libraries. It
provides Flutter apps with the ability to allocate native memory with `malloc`
or `calloc`, support for pointers, structs and callbacks, and ABI types like
`long` and `size_t`.

For more information about calling C libraries from Flutter,
see [C interop using `dart:ffi`].

In practice, while it is relatively straightforward to call basic Win32 APIs
from Dart in this way, it is easier to use a wrapper library that abstracts the
intricacies of the COM programming model. The [win32 package] provides a library
for accessing thousands of common Windows APIs, using metadata provided by
Microsoft for consistency and correctness. The package also includes examples of
a variety of common use cases, such as WMI, disk management, shell integration,
and system dialogs.

A number of other packages build on this foundation, providing idiomatic Dart
access for the [Windows registry], [gamepad support], [biometric storage],
[taskbar integration], and [serial port access], to name a few.

More generally, many other [packages support Windows], including common packages
such as [`url_launcher`], [`shared_preferences`], [`file_selector`], and
[`path_provider`].

[C interop using `dart:ffi`]: {{site.dart-site}}/guides/libraries/c-interop
[win32 package]: {{site.pub}}/packages/win32
[Windows registry]: {{site.pub}}/packages/win32_registry
[gamepad support]: {{site.pub}}/packages/win32_gamepad
[biometric storage]: {{site.pub}}/packages/biometric_storage
[taskbar integration]: {{site.pub}}//packages/windows_taskbar
[serial port access]: {{site.pub}}/packages/serial_port_win32
[packages support Windows]: {{site.pub}}/packages?q=platform%3Awindows
[`url_launcher`]: {{site.pub-pkg}}/url_launcher
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`file_selector`]: {{site.pub-pkg}}/file_selector
[`path_provider`]: {{site.pub-pkg}}/path_provider

## Supporting Windows UI guidelines

While you can use any visual style or theme you choose, including Material, some
app authors may wish to build an app that matches the conventions of Microsoft's
[Fluent design system][]. The [fluent_ui][] package, a [Flutter Favorite][],
provides support for visuals and common controls that are commonly found in
modern Windows apps, including navigation views, content dialogs, flyouts, date
pickers, and tree view widgets.

In addition, Microsoft offers [fluentui_system_icons][], a package which
provides easy access to thousands of Fluent icons for use in your Flutter app.

Lastly, the [bitsdojo_window][] package provides support for "owner draw" title
bars, allowing you to replace the standard Windows title bar with a custom one
that matches the rest of your app.

[Fluent design system]: https://docs.microsoft.com/en-us/windows/apps/design/
[fluent_ui]: {{site.pub}}/packages/fluent_ui
[Flutter Favorite]: {{site.url}}/development/packages-and-plugins/favorites
[fluentui_system_icons]: {{site.pub}}/packages/fluentui_system_icons
[bitsdojo_window]: {{site.pub}}/packages/bitsdojo_window

## Changing the name of the executable

To change the name of the generated Windows app, edit the
`BINARY_NAME` variable in `windows/CMakeLists.txt` in
your Flutter project.

```cmake
cmake_minimum_required(VERSION 3.14)
project(windows_desktop_app LANGUAGES CXX)

# The name of the executable created for the application. Change this to change
# the on-disk name of your application.
set(BINARY_NAME "YourNewApp")

cmake_policy(SET CMP0063 NEW)
```

## Distributing Windows apps

There are various approaches you can use for
distributing your Windows application.
Here are some options:

* Use tooling to construct an MSIX installer
  (described in the next section)
  for your application and distribute it through
  the Microsoft Windows App Store.
  You don't need to manually create a signing
  certificate for this option as it is
  handled for you.
* Construct an MSIX installer and distribute
  it through your own website. For this
  option, you need to to give your application a
  digital signature in the form of a
  `.pfx` certificate.
* Collect all of the necessary pieces
  and build your own zip file.

### MSIX packaging

[MSIX][], the new Windows application package format,
provides a modern packaging format and installer.
This format can either be used to ship applications
to the Microsoft Store on Windows, or you can
distribute app installers directly.

The easiest way to create an MSIX distribution
for a Flutter project is to use the
[`msix` pub package][msix package].
For an example of using the `msix` package
from a Flutter desktop app,
see the [Desktop Photo Search][] sample.

[MSIX]: https://docs.microsoft.com/en-us/windows/msix/overview
[msix package]: {{site.pub}}/packages/msix
[Desktop Photo Search]: {{site.github}}/flutter/samples/tree/main/desktop_photo_search

#### Create a self-signed .pfx certificate for local testing

For private deployment and testing with the help
of the MSIX installer, you need to give your application a
digital signature in the form of a `.pfx` certificate.

For deployment through the Windows Store,
generating a `.pfx` certificate is not required.
The Windows Store handles creation and management
of certificates for applications
distributed through its store.

Distributing your application by self hosting it on a
website requires a certificate signed by a
Certificate Authority known to Windows.

Use the following instructions to generate a
self-signed `.pfx` certificate.

1. If you haven't already, download the [OpenSSL][]
   toolkit to generate your certificates.
1. Go to where you installed OpenSSL, for example,
   `C:\Program Files\OpenSSL-Win64\bin`.
1. Set an environment variable so that you can access
   `OpenSSL` from anywhere:<br>
   `"C:\Program Files\OpenSSL-Win64\bin"`
1. Generate a private key as follows:<br>
   `openssl genrsa -out mykeyname.key 2048`
1. Generate a certificate signing request (CSR)
   file using the private key:<br>
   `openssl req -new -key mykeyname.key -out mycsrname.csr`
1. Generate the signed certificate (CRT) file using
   the private key and CSR file:<br>
   `openssl x509 -in mycsrname.csr -out mycrtname.crt -req -signkey mykeyname.key -days 10000`
1. Generate the `.pfx` file using the private key and
   CRT file:<br>
   `openssl pkcs12 -export -out CERTIFICATE.pfx -inkey mykeyname.key -in mycrtname.crt`
1. Install the `.pfx` certificate first on the local machine
   in `Certificate store` as
   `Trusted Root Certification Authorities`
   before installing the app.

[OpenSSL]: https://slproweb.com/products/Win32OpenSSL.html

### Building your own zip file for Windows

The Flutter executable, `.exe`, can be found in your
project under `build\windows\runner\<build mode>\`.
In addition to that executable, you need the following:

* From the same directory:
  * all the `.dll` files
  * the `data` directory
* The Visual C++ redistributables.
  You can use any of the methods shown in the
  [deployment example walkthroughs][] on the Microsoft site
  to ensure that end users have the C++ redistributables.
  If you use the `application-local` option, you need to copy:
  * `msvcp140.dll`
  * `vcruntime140.dll`
  * `vcruntime140_1.dll`
  
    Place the DLL files in the directory next to the executable
  and the other DLLs, and bundle them together in a zip file.
  The resulting structure looks something like this:
  
  ```text
  Release
  │   flutter_windows.dll
  │   msvcp140.dll
  │   my_app.exe
  │   vcruntime140.dll
  │   vcruntime140_1.dll
  │
  └───data
  │   │   app.so
  │   │   icudtl.dat

  ...
  ```

At this point if desired it would be relatively simple to
add this folder to a Windows installer such as Inno Setup, WiX, etc.

[deployment example walkthroughs]: https://docs.microsoft.com/en-us/cpp/windows/deployment-examples
