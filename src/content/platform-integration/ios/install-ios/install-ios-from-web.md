---
title: Add iOS as a target platform from web start
description: Configure your system to develop Flutter mobile apps on iOS.
short-title: Starting from web
---

To add iOS as a Flutter app target for macOS, follow this procedure.

## Install Xcode

1. Allocate a minimum of 26 GB of storage for Xcode.
   Consider allocating 42 GB of storage for an optimal configuration.
1. Install [Xcode][] {{site.appnow.xcode}} to debug and compile native
   Swift or ObjectiveC code.

{% include docs/install/compiler/xcode.md target='iOS' devos='macOS' attempt="first" -%}

{% include docs/install/flutter-doctor.md target='iOS' devos='macOS' config='macOSiOSWeb' %}

[Xcode]: {{site.apple-dev}}/xcode/
