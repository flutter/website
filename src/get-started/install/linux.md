---
title: Linux install
description: How to install on Linux.
short-title: Linux
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'linux' -%}

## System requirements

To install and run Flutter,
your development environment must meet these minimum requirements:

- **Operating Systems**: Linux (64-bit)
- **Disk Space**: 600 MB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these command-line tools being available
  in your environment.
  - `bash`
  - `curl`
  - `file`
  - `git` 2.x
  - `mkdir`
  - `rm`
  - `unzip`
  - `which`
  - `xz-utils`
  - `zip`

- **Shared libraries**: Flutter `test` command depends on this library
  being available in your environment.
  - `libGLU.so.1` - provided by mesa packages such as `libglu1-mesa` on
     Ubuntu/Debian and `mesa-libGLU` on Fedora.

{% include_relative _get-sdk-linux.md %}

{% include_relative _path-linux-chromeos.md %}

{% include_relative _android-setup.md %}

{% include_relative _linux-desktop-setup.md %}

{% include_relative _web-setup.md %}

## Next step

Set up your preferred editor.
