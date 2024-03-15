---
title: Add macOS devtools to Flutter from web start
description: Configure your system to develop Flutter mobile apps on macOS.
short-title: When you started with web
---

To add macOS desktop as a Flutter app target, follow this procedure.

This procedure presumes you installed [Xcode][] {{site.appnow.xcode}}
when your Flutter getting started path began with iOS.

{% include docs/install/compiler/xcode.md
   target='macOS'
   devos='macOS'
   attempt="first" -%}

{% include docs/install/flutter-doctor.md
   target='macOS'
   devos='macOS'
   config='macOSDesktopiOS' %}

[Xcode]: {{site.apple-dev}}/xcode/
