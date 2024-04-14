---
title: Add iOS as a target platform from macOS start
description: Configure your system to develop Flutter mobile apps on iOS.
short-title: Starting from macOS
---

To add iOS as a Flutter app target for macOS, follow this procedure.

This procedure presumes you installed [Xcode][] {{site.appnow.xcode}}
when your Flutter getting started path began with macOS.

{% render docs/install/compiler/xcode.md, target:'iOS', devos:'macOS', attempt:"next" -%}

{% render docs/install/flutter-doctor.md, target:'iOS', devos:'macOS', config:'macOSDesktopiOS' %}

[Xcode]: {{site.apple-dev}}/xcode/
