---
title: Linux Installation Guide
description: Comprehensive guide on how to install Flutter on Linux.
short-title: Linux
next:
  title: Set up an editor
  path: /get-started/editor
---

{% assign os = 'linux' -%}

## System Requirements

To install and run Flutter,
your Linux development environment needs to meet these minimum requirements:

- **Operating System**: Linux (64-bit)
- **Disk Space**: At least 600 MB (excluding disk space for IDE/tools).
- **Tools**: Flutter relies on these command-line tools:
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
- **Shared libraries**: To utilize the Flutter `test` command,
  your environment needs the library `libGLU.so.1`.
  The `mesa` packages provide this library:
  `libglu1-mesa` on Ubuntu/Debian and `mesa-libGLU` on Fedora.

{% include_relative _get-sdk-linux.md %}

{% include_relative _path-linux-chromeos.md %}

{% include_relative _android-setup.md %}

{% include_relative _linux-desktop-setup.md %}

## Next step

Set up your preferred editor.
