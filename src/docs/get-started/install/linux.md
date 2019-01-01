---
title: Linux install
short-title: Linux
# js: [{defer: true, url: /assets/archive.js}]
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'linux' -%}

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

- **Operating Systems**: Linux (64-bit)
- **Disk Space**: 600 MB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these command-line tools being available in your environment.
  - `bash`, `mkdir`, `rm`, `git`, `curl`, `unzip`, `which`, `xz-utils`
- **Shared libraries**: Flutter `test` command depends on this library being available in your environment.
  - `libGLU.so.1` - provided by mesa packages e.g. `libglu1-mesa` on Ubuntu/Debian

{% include_relative _get-sdk.md %}

{% include_relative _path-mac-linux.md %}

{% include_relative _android-setup.md %}

## Next step

[Next step: Configure Editor](/docs/get-started/editor)
