---
title: Linux Installation Guide
description: Comprehensive guide on how to install Flutter on Linux.
short-title: Linux
next:
  title: Set up an editor
  path: /get-started/editor
---

{% assign os = 'linux' -%}

| Main Section                             | Subsection                                                         |
|------------------------------------------|--------------------------------------------------------------------|
| 1. [Prerequisites](#prerequisites)       | [Operating Systems](#operating-systems)                            |
|                                          | [Tools](#tools)                                                    |
| 2. [Get the Flutter SDK](#get-sdk)       | [Understanding Linux Commands](#understanding-linux-commands)      |
|                                          | [Install Flutter using snapd](#install-flutter-using-snapd)        |
|                                          | [Manual Installation](#manual-installation)                        |
|                                          | [Run flutter doctor](#run-flutter-doctor)                          |
| 3. [Update your path](#update-your-path) | [Temporarily update your path](#temporarily-update-your-path)      |
|                                          | [Permanently update your path](#permanently-update-your-path)      |
|                                          | [Update the path directly](#update-the-path-directly)              |
| 4. [Android setup](#android-setup)       | [Install Android Studio](#install-android-studio)                  |
|                                          | [Set up your Android device](#setup-android-device)                |
|                                          | [Set up the Android emulator](#setup-android-emulator)             |
|                                          | [Agree to Android licenses](#agree-android-licenses)               |
|                                          | [Install Google Chrome](#install-google-chrome)                    |
| 5. [Linux setup](#linux-setup)           | [Additional Linux requirements](#additional-linux-requirements)    |
|                                          | [Understanding Linux Commands](#understanding-linux-commands)      |


## System Requirements
For installing and running Flutter, your Linux development environment needs to meet these minimum requirements:

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
- **Shared libraries**: To utilize the Flutter `test` command, your environment needs the library `libGLU.so.1`. This is typically provided by mesa packages, such as `libglu1-mesa` on Ubuntu/Debian and `mesa-libGLU` on Fedora.

{% include_relative _get-sdk-linux.md %}

{% include_relative _path-linux-chromeos.md %}

{% include_relative _android-setup.md %}

{% include_relative _linux-desktop-setup.md %}

## Next step

Set up your preferred editor.
