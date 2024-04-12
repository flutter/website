---
title: Add Windows as a target platform for Flutter from Web start
description: Configure your system to develop Flutter apps on Windows desktop.
short-title: Starting from Web
---

To add Windows desktop as a Flutter app target, follow this procedure.

## Install and configure Visual Studio

1. Allocate a minimum of 26 GB of storage for Visual Studio.
   Consider allocating 10 GB of storage for an optimal configuration.
1. Install [Visual Studio 2022][] to debug and compile native C++ Windows code.
   Make sure to install the **Desktop development with C++** workload.
   This enables building Windows app including all of its default components.
   **Visual Studio** is an IDE separate from **[Visual Studio _Code_][]**.

{% include docs/install/flutter-doctor.md target='Windows' devos='Windows' config='WindowsDesktopWeb' %}

[Visual Studio 2022]: https://learn.microsoft.com/visualstudio/install/install-visual-studio?view=vs-2022
[Visual Studio _Code_]: https://code.visualstudio.com/
