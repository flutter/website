---
title: Migrate a Windows project to set version information
description: How to update a Windows project to set version information
---

Flutter 3.3 added support for setting the Windows app's version from
the `pubspec.yaml` file or through the `--build-name` and `--build-number`
build arguments. For more information, refer to the
[Build and release a Windows app][] documentation.

Projects created before Flutter version 3.3 need to be migrated
to support versioning.

## Migration steps

Your project can be updated using these steps:

1. Verify you are on Flutter version 3.3 or newer using `flutter --version`
2. If needed, use `flutter upgrade` to update to the latest version of the
Flutter SDK
3. Backup your project, possibly using git or some other version control system
4. Delete the `windows/runner/CMakeLists.txt` and `windows/runner/Runner.rc`
files
5. Run `flutter create --platforms=windows .`
6. Review the changes to your `windows/runner/CMakeLists.txt` and
`windows/runner/Runner.rc` files

## Example

Here's an example of migrating a project: [flutter/gallery#721][].

[Build and release a Windows app]: {{site.url}}/deployment/windows#updating-the-apps-version-number
[`flutter migrate` command]: https://flutter.dev/go/flutter-migrate
[flutter/gallery#721]: {{site.github}}/flutter/gallery/pull/721/files