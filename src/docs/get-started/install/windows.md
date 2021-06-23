---
title: Windows install
description: How to install on Windows.
short-title: Windows
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'windows' -%}

## System requirements

To install and run Flutter,
your development environment must meet these minimum requirements:

- **Operating Systems**: Windows 7 SP1 or later (64-bit), x86-64 based.
- **Disk Space**: 1.64 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these tools being available in your environment.
  - [Windows PowerShell 5.0][] or newer (this is pre-installed with Windows 10)
  - [Git for Windows][] 2.x, with the
    **Use Git from the Windows Command Prompt** option.

     If Git for Windows is already installed,
     make sure you can run `git` commands from the
     command prompt or PowerShell.

{% include_relative _get-sdk-win.md %}

{% include_relative _android-setup.md %}

{% include_relative _windows-desktop-setup.md %}

{% include_relative _web-setup.md %}

## Next step

Set up your preferred editor.

[Git for Windows]: https://git-scm.com/download/win
[Windows PowerShell 5.0]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-windows-powershell
