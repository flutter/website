---
title: macOS install
description: How to install on macOS.
short-title: macOS
next:
  title: Set up an editor
  path: /get-started/editor
---

{% assign os = 'macos' -%}

## System requirements

To install and run Flutter,
your development environment must meet these minimum requirements:

- **Operating Systems**: macOS
- **Disk Space**: 2.8 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter uses `git` for installation and upgrade. We recommend
  installing [Xcode][], which includes `git`, but you can also 
  [install `git` separately][]. 

{% include_relative _get-sdk-mac.md %}

{% include_relative _path-mac.md %}

## Platform setup

macOS supports developing Flutter apps for iOS, Android, macOS itself 
and the web. Complete at least one of the platform setup steps now,
to be able to build and run your first Flutter app.

{% include_relative _ios-setup.md %}

{% include_relative _android-setup.md %}

{% include_relative _macos-desktop-setup.md %}

{% include_relative _web-setup.md %}

## Next step

Set up your preferred editor.

[Apple Silicon Mac]: https://support.apple.com/en-us/HT211814
[these supplementary notes]: {{site.repo.flutter}}/wiki/Developing-with-Flutter-on-Apple-Silicon
[Xcode]: {{site.apple-dev}}/xcode/
[install `git` separately]: https://git-scm.com/download/mac
