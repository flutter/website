---
title: Migrate a Windows project to the idiomatic run loop
description: How to update a Windows project to use the idiomatic run loop
---

Flutter 2.5 replaced Windows apps' run loop with an idiomatic
Windows message pump to reduce CPU usage.

Projects created before Flutter version 2.5 need to be
migrated to get this improvement. You should follow the
migration steps below if the `windows/runner/run_loop.h`
file exists in your project.

## Migration steps

{{site.alert.note}}
 As part of this migration, you must recreate your Windows project,
  which clobbers any custom changes to the
  files in the `windows/runner` folder.  The following steps
  include instructions for this scenario.
{{site.alert.end}}

Your project can be updated using these steps:

1. Verify you are on Flutter version 2.5 or newer using `flutter --version`
2. If needed, use `flutter upgrade` to update to the latest version of the
Flutter SDK
3. Backup your project with git (or your preferred version control system),
   since you need to reapply any local changes you've made (if any) to your
   project in a later step
4. Delete all files under the `windows/runner` folder
5. Run `flutter create --platforms=windows .` to recreate the Windows project
6. Review the changes to files in the `windows/runner` folder
7. Reapply any custom changes made to the files in the
`windows/runner` folder prior to this migration
8. Verify that your app builds using `flutter build windows`
