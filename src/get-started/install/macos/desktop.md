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

{% include docs/install/reqs/macos/base.md target=page.target os=page.devos -%}

{% include docs/install/flutter-sdk.md target=page.target os=page.devos terminal='Terminal' -%}

{% include docs/install/compiler/xcode.md target=page.target os=page.devos time='first' -%}

{% include docs/install/flutter-doctor.md target=page.target devos=page.devos target=page.target compiler='Xcode' config=page.config -%}

{% include docs/install/next-steps.md devos=page.devos target=page.target config=page.config -%}
