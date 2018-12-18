---
title: MacOS install
short-title: MacOS
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'macos' -%}

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

- **Operating Systems**: macOS (64-bit)
- **Disk Space**: 700 MB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these command-line tools being available in your environment.
  - `bash`, `mkdir`, `rm`, `git`, `curl`, `unzip`, `which`

{% include_relative _get-sdk.md %}

{% include_relative _path-mac-linux.md %}

## Platform setup

MacOS supports developing Flutter apps for both iOS and Android. Complete at
least one of the two platform setup steps now, to be able to build and run your
first Flutter app.

{% include_relative _ios-setup.md %}

{% include_relative _android-setup.md %}

## Next step

[Next step: Configure Editor](/docs/get-started/editor)
