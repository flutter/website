---
title: Add Windows devtools to Flutter from Android start
description: Configure your system to develop Flutter mobile apps also on Windows.
short-title: When you started with Android
---

To add Windows desktop as a Flutter app target for Windows:

1. Allocate a minimum of 26 GB of storage for Visual Studio.
   Consider allocating 10 GB of storage for an optimal configuration.
1. Download and install the Windows version of the following packages:

   * [Git for Windows][] {{site.appmin.git_win}} or later to manage source code.
   {% include docs/install/reqs/windows/software.md target='desktop' %}

{% include docs/install/flutter-doctor.md
   target='Windows'
   devos='Windows'
   config='WindowsDesktopAndroid' %}

[Git for Windows]: https://gitforwindows.org/
