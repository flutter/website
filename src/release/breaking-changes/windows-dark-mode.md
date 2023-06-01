---
title: Migrate a Windows project to support dark title bars
description: How to update a Windows project to support dark title bars
---

Projects created before Flutter 3.7 have light title bars even
when the Windows theme is dark mode. Projects created before
Flutter 3.7 need to be migrated to support dark title bars.

## Migration steps

Your project can be updated using these steps:

1. Verify you are on Flutter version 3.7 or newer using `flutter --version`
2. If needed, use `flutter upgrade` to update to the latest version of the
Flutter SDK
3. Backup your project, possibly using git or some other version control system
4. Delete the following files:
    1. `windows/runner/CMakeLists.txt`
    2. `windows/runner/win32_window.cpp`
    3. `windows/runner/win32_window.h`
5. Run `flutter create --platforms=windows .`
6. Review the changes to the following files:
    1. `windows/runner/CMakeLists.txt`
    2. `windows/runner/win32_window.cpp`
    3. `windows/runner/win32_window.h`
7. Verify your app builds using `flutter build windows`

{{site.alert.note}}
  Follow the [run loop migration guide][] if the build fails
  with the following error message:

  ```
  flutter_window.obj : error LNK2019: unresolved external symbol "public: void __cdecl RunLoop::RegisterFlutterInstance(class flutter::FlutterEngine *)" (?RegisterFlutterInstance@RunLoop@@QEAAXPEAVFlutterEngine@flutter@@@Z) referenced in function "protected: virtual bool __cdecl FlutterWindow::OnCreate(void)" (?OnCreate@FlutterWindow@@MEAA_NXZ)
  ```
{{site.alert.end}}

## Example

[PR 862][] shows the migration work for the
[Flutter Gallery][] app.

[run loop migration guide]: {{site.url}}/release/breaking-changes/windows-run-loop
[PR 862]: {{site.github}}/flutter/gallery/pull/862/files
[Flutter Gallery]: https://gallery.flutter.dev/