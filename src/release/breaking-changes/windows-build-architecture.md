---
title: Windows build path changed to add the target architecture
description: >
  In preparation for supporting Windows Arm64, 
  the Windows build path was updated to include the target architecture.
---

## Summary
Flutter Window's build path was updated to include the target architecture.

## Context
In preparation for supporting Windows Arm64, the Windows build path was
updated to add the build's target architecture.

Previously, Flutter Windows build assumed an x64 target architecture.

## Migration guide
You may need to update your infrastructure to use the new Flutter Windows
build path.

Example build path before the migration:
`build\windows\runner\Release\hello_world.exe`

Example build path after the migration:
`build\windows\x64\runner\Release\hello_world.exe`

If you use [`package:msix`][], update to version 3.15.0 or newer.

[`package:msix`]: https://pub.dev/packages/msix

## Timeline
Landed in version: TBD

In stable release: TBD

## References
Design document:
*  [https://flutter.dev/go/windows-arm64][]

Relevant pull requests:
* [Introduce architecture subdirectory for Windows build][]

[https://flutter.dev/go/windows-arm64]: {{site.url}}/go/windows-arm64
[Introduce architecture subdirectory for Windows build]: {{site.github}}/flutter/flutter/pull/131843
