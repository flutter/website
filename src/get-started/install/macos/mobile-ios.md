---
title: Start building Flutter iOS apps on macOS
description: Configure your system to develop Flutter mobile apps on macOS and iOS.
short-title: macOS iOS development
target: iOS
config: macOSiOS
devos: macOS
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/macos/base.md target=page.target os=page.devos -%}

{% include docs/install/flutter-sdk.md target=page.target os=page.devos terminal='Terminal' -%}

{% include docs/install/compiler/xcode.md target=page.target os=page.devos time='first' -%}

{% include docs/install/flutter-doctor.md target=page.target devos=page.devos compiler='Xcode' config=page.config -%}

{% include docs/install/next-steps.md devos=page.devos target=page.target config=page.config -%}