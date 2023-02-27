---
title: ChromeOS install
description: How to install on ChromeOS.
short-title: ChromeOS
next:
  title: Set up an editor
  path: /get-started/editor
---

{% assign os = 'linux' -%}

## System requirements

To install and run Flutter on a Chromebook, your machine
must have [Linux][] enabled from the **Developers** tab of Settings.

The amount of disk space required varies
depending on which target platforms you enable.
We recommend that you increase the disk size for the
Linux environment from the default of 10GB to 32GB or larger,
to accommodate Android Studio and other tooling.

{% include_relative _get-sdk-chromeos.md %}

{% include_relative _chrome-setup-chromeos.md %}

{% include_relative _android-setup-chromeos.md %}

## Next step

Set up your preferred editor.

[Linux]: https://support.google.com/chromebook/answer/9145439
