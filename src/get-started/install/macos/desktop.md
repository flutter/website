---
title: Start building Flutter native desktop apps on macOS
description: Configure your system to develop Flutter desktop apps on macOS.
short-title: macOS desktop development
target: desktop
config: macOSDesktop
devos: macOS
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/macos/base.md
   os=page.devos
   target=page.target
   -%}

{% include docs/install/flutter-sdk.md
   os=page.devos
   target=page.target
   terminal='Terminal'
   -%}

{% include docs/install/compiler/xcode.md
   os=page.devos
   target=page.target
   attempt='first'
   -%}

{% include docs/install/flutter-doctor.md
   devos=page.devos
   target=page.target
   config=page.config
   -%}

{% include docs/install/next-steps.md
   devos=page.devos
   target=page.target
   config=page.config
   -%}
