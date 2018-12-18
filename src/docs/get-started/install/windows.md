---
title: Windows install
short-title: Windows
# js: [{defer: true, url: /assets/archive.js}]
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'windows' -%}

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

- **Operating Systems**: Windows 7 SP1 or later (64-bit)
- **Disk Space**: 400 MB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these tools being available in your environment.
  - [Windows PowerShell 5.0][] or newer (this is pre-installed with Windows 10)
  - [Git for Windows][], with the **Use Git from the Windows Command Prompt** option.

     If Git for Windows is already installed, make sure you can run `git` commands from the
     command prompt or PowerShell.

{% include_relative _get-sdk-win.md %}

{% include_relative _android-setup.md %}

## Next step

[Next step: Configure Editor](/docs/get-started/editor)

[Git for Windows]: https://git-scm.com/download/win
[Windows PowerShell 5.0]: https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell
