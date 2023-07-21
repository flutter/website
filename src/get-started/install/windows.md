---
title: Windows install
description: How to install on Windows.
short-title: Windows
next:
  title: Set up an editor
  path: /get-started/editor
---

{% assign os = 'wsl' -%}

## Table of Contents
1. [System requirements](#system-requirements)
2. [Installation methods](#installation-methods)
    1. [Method 1: Native Windows installation](#method-1-native-windows-installation)
    2. [Method 2: Installation in WSL2 with Ubuntu](#method-2-installation-in-wsl2-with-ubuntu)
3. [Next step](#next-step)

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

- **Operating Systems**: Windows 10 or later (64-bit), x86-64 based.
- **Disk Space**: 1.64 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these tools being available in your environment.
  - [Windows PowerShell 5.0][] or newer (this is pre-installed with Windows 10)
  - [Git for Windows][] 2.x, with the
    **Use Git from the Windows Command Prompt** option.

     If Git for Windows is already installed,
     make sure you can run `git` commands from the
     command prompt or PowerShell.

<a name="installation-methods"></a>
## Installation methods

<a name="method-1-native-windows-installation"></a>
### Method 1: Native Windows installation

{% assign os = 'windows' -%}
{% include_relative _get-sdk-win.md %}
{% include_relative _android-setup.md %}
{% include_relative _windows-desktop-setup.md %}

<a name="method-2-installation-in-wsl2-with-ubuntu"></a>
### Method 2: Installation in WSL2 with Ubuntu


{% include_relative _get-sdk-wsl.md %}

<a name="next-step"></a>
## Next step

Set up your preferred editor.

[Git for Windows]: https://git-scm.com/download/win
[Windows PowerShell 5.0]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-windows-powershell
