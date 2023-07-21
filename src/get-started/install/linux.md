---
title: Linux Installation Guide
description: Comprehensive guide on how to install Flutter on Linux.
short-title: Linux
next:
  title: Set up an editor
  path: /get-started/editor
---

{% assign os = 'linux' -%}

## Table of Contents
- System Requirements
- Understanding Linux Commands
- Installing Snap on Ubuntu
- Flutter Installation
- Android Studio Setup
- Chrome Setup
- Additional Linux Configuration
- Next Steps
- Glossary

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

## Understanding Linux Commands
Your journey with Flutter on Linux involves the use of certain common Linux commands. We provide an overview of these commands and their definitions in the Glossary section.

## Installing Snap on Ubuntu
Snap, a universal Linux package system, is preinstalled in most modern Ubuntu versions. However, if you find it missing, you can easily install it with the instructions provided in this section.

## Flutter Installation
Detailed instructions on how to install Flutter on your Linux system.

## Android Studio Setup
Setting up Android Studio correctly is crucial for Flutter development. This section guides you through this process.

## Chrome Setup
Installing Chrome is necessary for Flutter web development. We walk you through this process in this section.

## Additional Linux Configuration
Further configuration options to optimize your Flutter development experience on Linux.

## Next Steps
After successfully installing Flutter and setting up the necessary tools, learn how to set up your preferred editor.

## Glossary
An overview of common Linux commands used in Flutter installation and their definitions.

{% include_relative _get-sdk-linux.md %}

{% include_relative _path-linux-chromeos.md %}

{% include_relative _android-setup.md %}

{% include_relative _linux-desktop-setup.md %}

## Next step

Set up your preferred editor.
