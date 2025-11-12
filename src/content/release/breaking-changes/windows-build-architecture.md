---
title: Windows build path changed to add the target architecture
description: >-
  In preparation for supporting Windows on Arm64,
  the Windows build path was updated to include the target architecture.
---

{% render "docs/breaking-changes.md" %}

## Summary

Built executables for Flutter Windows apps are now located in architecture
dependent folders.

## Context

In preparation for supporting Windows on Arm64, the Windows build path was
updated to add the build's target architecture.

Previously, Flutter builds for Windows assumed an x64 target architecture.

## Migration guide

You may need to update your infrastructure to use the new Flutter Windows
build path.

Example build path before the migration:

```plaintext
build\windows\runner\Release\hello_world.exe
```

Example build path after the migration if targeting x64:

```plaintext
build\windows\x64\runner\Release\hello_world.exe
```

Example build path after the migration if targeting Arm64:

```plaintext
build\windows\arm64\runner\Release\hello_world.exe
```

If you use [`package:msix`][], update to version 3.16.7 or newer.

[`package:msix`]: {{site.pub-pkg}}/msix

## Timeline

Landed in version: 3.15.0-0.0.pre<br>
In stable release: 3.16

## References

Design document:

* [flutter.dev/go/windows-arm64][]

Relevant pull requests:

* [Introduce architecture subdirectory for Windows build][]

[flutter.dev/go/windows-arm64]: {{site.main-url}}/go/windows-arm64
[Introduce architecture subdirectory for Windows build]: {{site.repo.flutter}}/pull/131843
