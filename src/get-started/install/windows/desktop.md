---
title: Start building Flutter native desktop apps on Windows
description: Configure your system to develop Flutter desktop apps on Windows.
short-title: Windows Desktop app
target: desktop
config: WindowsDesktop
devos: Windows
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/windows/base.md
   os=page.devos
   target=page.target
   -%}

{% include docs/install/flutter-sdk.md
   os=page.devos
   target=page.target
   terminal='PowerShell'
   -%}

{% include docs/install/flutter-doctor.md
   devos=page.devos
   target=page.target platform=page.target
   config=page.config
   -%}

{% include docs/install/next-steps.md
   devos=page.devos
   target=page.target
   config=page.config
   -%}
