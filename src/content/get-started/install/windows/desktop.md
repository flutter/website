---
title: Start building Flutter native desktop apps on Windows
description: Configure your system to develop Flutter desktop apps on Windows.
short-title: Make Windows desktop apps
target: desktop
config: WindowsDesktop
devos: Windows
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% render docs/install/reqs/windows/base.md, os:devos, target:target -%}

{% render docs/install/flutter-sdk.md, os:devos, target:target, terminal:'PowerShell' -%}

{% render docs/install/flutter-doctor.md, devos:devos, target:target, platform:target, config:config -%}

{% render docs/install/next-steps.md, devos:devos, target:target, config:config -%}
