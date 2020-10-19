---
title: macOS install
description: How to install on macOS.
short-title: macOS
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'macos' -%}

## System requirements

To install and run Flutter,
your development environment must meet these minimum requirements:

- **Operating Systems**: macOS (64-bit)
- **Disk Space**: 2.8 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these command-line tools being available
  in your environment.
  - `bash`
  - `curl`
  - `git` 2.x
  - `mkdir`
  - `rm`
  - `unzip`
  - `which`

{% include_relative _get-sdk.md %}

{% include_relative _path-mac.md %}

## Platform setup

macOS supports developing Flutter apps in iOS, Android,
and the web (technical preview release).
Complete at least one of the platform setup steps now,
to be able to build and run your first Flutter app.

{% include_relative _ios-setup.md %}

{% include_relative _android-setup.md %}

{% include_relative _web-setup.md %}

## Next step

Set up your preferred editor.
