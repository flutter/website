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
- **Tools**: Flutter uses `git` for installation and upgrade. We recommend
  installing [Xcode][], which includes `git`, but you can also 
  [install `git` separately][]. 

{{site.alert.important}}
  If you're installing on a Mac with the latest [Apple M1 processor][],
  you may find [these supplementary notes][] useful reading as we complete support
  for the new Apple Silicon architecture.
{{site.alert.end}}

{% include_relative _get-sdk.md %}

{% include_relative _path-mac.md %}

## Platform setup

macOS supports developing Flutter apps in iOS, Android,
and the web (technical preview release).
Complete at least one of the platform setup steps now,
to be able to build and run your first Flutter app.

{% include_relative _ios-setup.md %}

{% include_relative _android-setup.md %}

{% include_relative _macos-desktop-setup.md %}

{% include_relative _web-setup.md %}

## Next step

Set up your preferred editor.

[Apple M1 processor]: https://www.apple.com/mac/m1
[these supplementary notes]: https://github.com/flutter/flutter/wiki/Developing-with-Flutter-on-Apple-Silicon
[Xcode]: https://developer.apple.com/xcode/
[install `git` separately]: https://git-scm.com/download/mac
