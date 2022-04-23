---
title: Desktop support for Flutter
description: Announcing the platform releases of Flutter for desktop.
toc: true
---

Desktop support allows you to compile Flutter source code
to a native Windows, macOS, or Linux desktop app.
Flutter's desktop support also extends to plugins&mdash;you
can install existing plugins that support the Windows,
macOS, or Linux platforms, or you can create your own.

{{site.alert.note}}
  Windows is fully supported as a development target. For more information, see
  [Announcing Flutter for Windows][]. 

  macOS and Linux desktop app support is still beta-quality. Snapshots of their
  support are available on the stable channel, but we recommend that you use the
  beta channel for access to the latest features and bug fixes on those
  platforms.
{{site.alert.end}}

[Announcing Flutter for Windows]: {{site.flutter-medium}}/announcing-flutter-for-windows-6979d0d01fed

## Requirements

To compile a desktop application, you must build it **on** the targeted
platform: build a Windows application on Windows, a macOS application on macOS,
and a Linux application on Linux.

To create a Flutter application with desktop support,
you need the following software:

* Flutter SDK. See the
  [Flutter SDK][] installation instructions.
* Optional: An IDE that supports Flutter.
  You can install [Android Studio][], [IntelliJ IDEA][],
  or [Visual Studio Code][] and
  [install the Flutter and Dart plugins][]
  to enable language support and tools for refactoring,
  running, debugging, and reloading your desktop app
  within an editor. See [setting up an editor][]
  for more details.

[Android Studio]: {{site.android-dev}}/studio/install
[Flutter SDK]: {{site.url}}/get-started/install
[install the Flutter and Dart plugins]: {{site.url}}/get-started/editor
[IntelliJ IDEA]: https://www.jetbrains.com/idea/download/
[setting up an editor]: {{site.url}}/get-started/editor
[Visual Studio Code]: {{site.url}}/development/tools/vs-code

### Additional Windows requirements

For Windows desktop development,
you need the following in addition to the Flutter SDK:

* [Visual Studio 2022][] When installing Visual Studio select the "Desktop
  development with C++" workload, including all of its default components, to
  install the necessary C++ toolchain and Windows SDK header files.

{{site.alert.note}}
  **Visual Studio** is different than Visual Studio _Code_.
{{site.alert.end}}

[Visual Studio 2022]: https://visualstudio.microsoft.com/downloads/

### Additional macOS requirements

For macOS desktop development,
you need the following in addition to the Flutter SDK:

* [Xcode][]
* [CocoaPods][] if you use plugins

[CocoaPods]: https://cocoapods.org/
[Xcode]: {{site.apple-dev}}/xcode/

### Additional Linux requirements

For Linux desktop development,
you need the following in addition to the Flutter SDK:

* [Clang][]
* [CMake][]
* [GTK development headers][]
* [Ninja build][]
* [pkg-config][]
* [liblzma-dev][] This dependency may be required

One easy way to install the Flutter SDK along with the necessary
dependencies is by using [snapd][].
For more information, see [Installing snapd][].

Once you have `snapd`, you can install Flutter
using the [Snap Store][], or at the command line:

```terminal
$ sudo snap install flutter --classic
```

Alternatively, if you prefer not to use `snapd`,
you can use the following command:

```terminal
$ sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

[Clang]: https://clang.llvm.org/
[CMake]: https://cmake.org/
[GTK development headers]: https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[Ninja build]: https://ninja-build.org/
[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/
[liblzma-dev]: https://packages.debian.org/sid/liblzma-dev
[Snap Store]: https://snapcraft.io/store
[snapd]: https://snapcraft.io/flutter

## Create a new project

You can use the following steps
to create a new project with desktop support.

### Set up

On Windows, desktop support is enabled on Flutter 2.10 or higher. 

On macOS and Linux, desktop support is disabled by default in the stable
channel. You can manually enable it with one of these commands, depending on
which platform you are running:

```terminal
$ flutter config --enable-macos-desktop
$ flutter config --enable-linux-desktop
```

{{site.alert.note}}
  You only need to execute
  `flutter config --enable-<platform>-desktop`
  once. You can check the status of your configuration at any time by using
  the command `flutter config` with no arguments.
{{site.alert.end}}

To test that desktop support is configured, use the `flutter devices` command to
list the available targets. In addition to any mobile or web devices, you should
see a row for the operating system you're running on, for example (on Windows):

``` terminal
C:\> flutter devices
1 connected device:

Windows (desktop) • windows • windows-x64 • Microsoft Windows [Version 10.0.22557.1]
```

You might also run `flutter doctor` to see if there are any unresolved issues.
You should see a checkmark for each successfully configured area. It should look
something like the following on Windows, with an entry for "develop for Windows":

```terminal
C:\> flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 2.10.1, on Microsoft Windows [Version 10.0.22557.1], locale en-US)
[✓] Chrome - develop for the web
[✓] Visual Studio - develop for Windows (Visual Studio Community 2022 17.0.5)
[✓] VS Code (version 1.64.2)
[✓] Connected device (3 available)
[✓] HTTP Host Availability

• No issues found!
```

On macOS, look for a line like this:

```terminal
[✓] Xcode - develop for iOS and macOS
```

On Linux, look for a line like this:

```terminal
[✓] Linux toolchain - develop for Linux desktop
```

If `flutter doctor` finds problems or missing components for a platform that you
don't want to develop for, you can ignore those warnings. Or you can disable the
platform altogether using the `flutter config` command, for example:

```terminal
$ flutter config --no-enable-ios
```

After enabling desktop support, restart your IDE so that it can detect the new
device.

### Create and run

Creating a new project with desktop support is no different
than [creating a new Flutter project][] for other platforms.

Once you've configured your environment for desktop
support, you can create and run a desktop application
either in the IDE or from the command line.

[creating a new Flutter project]: {{site.url}}/get-started/test-drive

#### Using an IDE

After you've configured your environment to support
desktop, make sure you restart the IDE if it was
already running.

Create a new application in your IDE and it automatically
creates iOS, Android, web, and desktop versions of your app.
From the device pulldown, select **windows (desktop)**,
**macOS (desktop)**, or **linux (desktop)**
and run your application to see it launch on the desktop.

[web support]: {{site.url}}/get-started/web

#### From the command line

To create a new application that includes desktop support
(in addition to mobile and web support), run the following commands,
substituting `my_app` with the name of your project:

```terminal
$ flutter create my_app
$ cd my_app
```
To launch your application from the command line,
enter one of the following commands from the top
of the package:

```terminal
C:\> flutter run -d windows
$ flutter run -d macos
$ flutter run -d linux
```

{{site.alert.note}}
  If you do not supply the `-d` flag, `flutter run` lists
  the available targets to choose from.
{{site.alert.end}}

## Build a release app

To generate a release build,
run one of the following commands:

```terminal
PS C:\> flutter build windows
$ flutter build macos
$ flutter build linux
```

## Distribution

### Windows

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

#### Changing the name of the generated binary

To change the name of the generated Windows application, edit the 
`BINARY_NAME` variable set on line 4 of `windows/CMakeLists.txt` in
your Flutter project.

```cmake
cmake_minimum_required(VERSION 3.15)
project(windows_desktop_app LANGUAGES CXX)

set(BINARY_NAME "YourNewApp")  # Change this line

cmake_policy(SET CMP0063 NEW)
```

#### MSIX packaging

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
[Desktop Photo Search]: {{site.github}}/flutter/samples/tree/master/desktop_photo_search

##### Create a self-signed .pfx certificate for local testing

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

#### Building your own zip file for Windows

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
  
  ```
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

### macOS

To distribute your macOS application, you can either
[distribute it through the macOS App Store][], 
or you can distribute the `.app` itself,
perhaps from your own website.
As of macOS 10.14.5, you need to notarize
your macOS application before distributing 
it outside of the macOS App Store. 

The first step in both of the above processes
involves working with your application inside of Xcode.
To be able to compile your application from inside of
Xcode you first need to build the application for release
using the `flutter build` command, then open the
Flutter macOS Runner application.

```bash
$ flutter build macos
$ open macos/Runner.xcworkspace
```

Once inside of Xcode, follow either Apple's
[documentation on notarizing macOS Applications][],
or [on distributing an application through the App Store][].
You should also read through the
[macOS-specific support](#macos-specific-support)
section below to understand how entitlements,
the App Sandbox, and the Hardened Runtime
impact your distributable application.

[Build and release a macOS app][] provides a more detailed
step-by-step walkthrough.

[distribute it through the macOS App Store]: {{site.apple-dev}}/macos/submit/
[documentation on notarizing macOS Applications]:{{site.apple-dev}}/documentation/xcode/notarizing_macos_software_before_distribution
[on distributing an application through the App Store]: https://help.apple.com/xcode/mac/current/#/dev067853c94
[Build and release a macOS app]: {{site.url}}/deployment/macos

### Linux

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

```
$ flutter build linux --release
$ ldd build/linux/release/bundle/linux_desktop_test
```

To wrap up this application for distribution
you need to include everything in the `bundle` directory,
and make sure the Linux system you are installing
it upon has all of the system libraries required.
This may be as simple as:

```
$ sudo apt-get install libgtk-3-0 libblkid1 liblzma5
```

For information on publishing a Linux application
to the [Snap Store][], see
[Build and release a Linux application to the Snap Store][].

As the tooling solidifies, stay tuned for updates
on other ways to distribute a Linux desktop app.

[Build and release a Linux application to the Snap Store]: {{site.url}}/deployment/linux

## Add desktop support to an existing Flutter app

To add desktop support to an existing Flutter project,
run the following command in a terminal from the
root project directory:

```terminal
$ flutter create --platforms=windows,macos,linux .
```

This adds the necessary desktop files and directories
to your existing Flutter project.
To add only specific desktop platforms,
change the `platforms` list to include only
the platform(s) you want to add.

## macOS-specific support

The following information applies only to
macOS development.

### Entitlements and the App Sandbox

macOS builds are configured by default to be signed,
and sandboxed with App Sandbox.
This means that if you want to confer specific
capabilities or services on your macOS app,
such as the following:

* Accessing the internet
* Capturing movies and images from the built-in camera 
* Accessing files

Then you must set up specific _entitlements_ in Xcode.
The following section tells you how to do this.

#### Setting up entitlements

Managing sandbox settings is done in the
`macos/Runner/*.entitlements` files. When editing
these files, you shouldn't remove the original
`Runner-DebugProfile.entitlements` exceptions
(that support incoming network connections and JIT),
as they're necessary for the `debug` and `profile`
modes to function correctly.

If you're used to managing entitlement files through
the **Xcode capabilities UI**, be aware that the capabilities
editor updates only one of the two files or,
in some cases, it creates a whole new entitlements
file and switches the project to use it for all configurations.
Either scenario causes issues. We recommend that you
edit the files directly. Unless you have a very specific
reason, you should always make identical changes to both files.

If you keep the App Sandbox enabled (which is required if you
plan to distribute your application in the [App Store][]),
you need to manage entitlements for your application
when you add certain plugins or other native functionality.
For instance, using the [`file_chooser`][] plugin
requires adding either the
`com.apple.security.files.user-selected.read-only` or
`com.apple.security.files.user-selected.read-write` entitlement.
Another common entitlement is
`com.apple.security.network.client`,
which you must add if you make any network requests.

Without the `com.apple.security.network.client` entitlement,
for example, network requests fail with a message such as:

```terminal
flutter: SocketException: Connection failed
(OS Error: Operation not permitted, errno = 1),
address = example.com, port = 443
```

{{site.alert.secondary}}
  **Important:** The `com.apple.security.network.server`
  entitlement, which allows incoming network connections,
  is enabled by default only for `debug` and `profile`
  builds to enable communications between Flutter tools
  and a running app. If you need to allow incoming
  network requests in your application,
  you must add the `com.apple.security.network.server`
  entitlement to `Runner-Release.entitlements` as well,
  otherwise your application will work correctly for debug or
  profile testing, but will fail with release builds.
{{site.alert.end}}

For more information on these topics,
see [App Sandbox][] and [Entitlements][]
on the Apple Developer site.

[App Sandbox]: {{site.apple-dev}}/documentation/security/app_sandbox
[App Store]: {{site.apple-dev}}/app-store/submissions/
[Entitlements]: {{site.apple-dev}}/documentation/bundleresources/entitlements
[`file_chooser`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/file_chooser

### Hardened Runtime

If you choose to distribute your application outside
of the App Store, you need to notarize your application
for compatibility with macOS 10.15+.
This requires enabling the Hardened Runtime option.
Once you have enabled it, you need a valid signing
certificate in order to build.

By default, the entitlements file allows JIT for
debug builds but, as with App Sandbox, you may
need to manage other entitlements.
If you have both App Sandbox and Hardened
Runtime enabled, you may need to add multiple
entitlements for the same resource.
For instance, microphone access would require both
`com.apple.security.device.audio-input` (for Hardened Runtime)
and `com.apple.security.device.microphone` (for App Sandbox).

For more information on this topic,
see [Hardened Runtime][] on the Apple Developer site.

[Hardened Runtime]: {{site.apple-dev}}/documentation/security/hardened_runtime

## Plugin support

Flutter on the desktop supports using and creating plugins.

### Using a plugin

To use a plugin that supports desktop,
follow the steps for plugins in [using packages][].
Flutter automatically adds the necessary native code
to your project, as with iOS or Android.

We recommend the following plugins,
which have been updated to work for desktop apps:

* [`url_launcher`][]
* [`shared_preferences`][]
* [`path_provider`][]

Use the following links to find all packages on pub.dev
that support desktop apps. These links lists _all_ packages,
not just plugin packages.
(Remember that _plugin packages_, or _plugins_,
provide an interface to platform-specific services.)

* [Windows packages][]
* [macOS packages][]
* [Linux packages][]

[Linux packages]: {{site.pub}}/flutter/packages?platform=linux
[macOS packages]: {{site.pub}}/flutter/packages?platform=macos
[`path_provider`]: {{site.pub}}/packages/path_provider
[`shared_preferences`]: {{site.pub}}/packages/shared_preferences
[`url_launcher`]: {{site.pub}}/packages/url_launcher
[using packages]: {{site.url}}/development/packages-and-plugins/using-packages
[windows packages]: {{site.pub}}/flutter/packages?platform=windows

### Writing a plugin

When you start building your own plugins,
you’ll want to keep federation in mind.
Federation is the ability to define several
different packages, each targeted at a
different set of platforms, brought together
into a single plugin for ease of use by developers.
For example, the Windows implementation of the
`url_launcher` is really `url_launcher_windows`,
but a Flutter developer can simply add the
`url_launcher` package to their `pubspec.yaml`
as a dependency and the build process pulls in
the correct implementation based on the target platform.
Federation is handy because different teams with
different expertise can build plugin implementations
for different platforms.
You can add a new platform implementation to any
endorsed federated plugin on pub.dev,
so long as you coordinate this effort with the
original plugin author.

For more information, including information
about endorsed plugins, see the following resources:

* [Developing packages and plugins][], particularly the
  [Federated plugins][] section.
* [How to write a Flutter web plugin, part 2][],
  covers the structure of federated plugins and
  contains information applicable to desktop
  plugins.
* [Modern Flutter Plugin Development][] covers
  recent enhancements to Flutter's plugin support.
* [Federated Plugin proposal][]

[Developing packages and plugins]: {{site.url}}/development/packages-and-plugins/developing-packages
[Federated Plugin proposal]: {{site.url}}/go/federated-plugins
[Federated plugins]: {{site.url}}/development/packages-and-plugins/developing-packages#federated-plugins
[How to write a Flutter web plugin, part 2]: {{site.flutter-medium}}/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6
[Modern Flutter Plugin Development]: {{site.flutter-medium}}/modern-flutter-plugin-development-4c3ee015cf5a

## Samples and codelabs

[Write a Flutter desktop application][]
: A codelab that walks you through building
a desktop application that integrates the GitHub
GraphQL API with your Flutter app.

You can run the following samples as desktop apps,
as well as download and inspect the source code to
learn more about Flutter desktop support.

Flutter Gallery [running web app][], [repo][flutter-gallery-repo]
: A samples project hosted on GitHub to help developers
  evaluate and use Flutter. The Gallery consists of a
  collection of Material design widgets, behaviors,
  and vignettes implemented with Flutter.
  You can clone the project and run Gallery as a desktop app
  by following the instructions provided in the [README][].
  
Flokk [announcement blogpost][gskinner-flokk-blogpost], [repo][gskinner-flokk-repo]
: A Google contacts manager that integrates with GitHub and Twitter. 
  It syncs with your Google account, imports your contacts,
  and allows you to manage them.

[Photo Search app][]
: A sample application built as a desktop application that
  uses the following desktop-supported plugins:
  * [`file_chooser`][]
  * [`menubar`][]
  * [`url_launcher`][]

[`menubar`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/menubar
[Photo Search app]: {{site.repo.organization}}/samples/tree/master/desktop_photo_search
[running web app]: {{site.gallery}}
[flutter-gallery-repo]: {{site.repo.gallery}}
[README]: {{site.repo.gallery}}#flutter-gallery
[gskinner-flokk-repo]: {{site.github}}/gskinnerTeam/flokk
[gskinner-flokk-blogpost]: https://blog.gskinner.com/archives/2020/09/flokk-how-we-built-a-desktop-app-using-flutter.html
[Write a Flutter desktop application]: {{site.codelabs}}/codelabs/flutter-github-client
