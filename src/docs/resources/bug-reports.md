---
title: Creating Useful Bug Reports
---

The instructions in this document detail the current steps required to provide the most
actionable bug reports for crashes and other bad behavior. Each step is optional but
will greatly improve how quickly issues are diagnosed and addressed. We appreciate your
effort in sending us as much feedback as possible.

## Create an Issue on GitHub

* A new issue may be created in the [Flutter
  repo]({{site.github}}/flutter/flutter/issues/new) on GitHub.

## Provide some Flutter Diagnostics

* Run `flutter doctor` in your project directory and paste the results into the GitHub Issue:

```
[✓] Flutter (on Mac OS, channel master)
    • Flutter at /Users/me/projects/flutter
    • Framework revision 8cbeb2e (4 hours ago), engine revision 5c28578

[✓] Android toolchain - develop for Android devices (Android SDK 23.0.2)
    • Android SDK at /usr/local/Cellar/android-sdk/24.4.1_1
    • Platform android-23, build-tools 23.0.2
    • Java(TM) SE Runtime Environment (build 1.8.0_73-b02)

[✓] iOS toolchain - develop for iOS devices (Xcode 7.3)
    • XCode at /Applications/Xcode.app/Contents/Developer
    • Xcode 7.3, Build version 7D175

[✓] IntelliJ IDEA Ultimate Edition (version 2016.2.5)
    • Dart plugin installed
    • Flutter plugin installed
```

## Run the Command in Verbose Mode

Follow these steps only if your issue is related to the `flutter` tool.

* All Flutter commands accept the `--verbose` flag. If attached to the issue, the output from this command may aid in diagnosing the issue.
* Attach the results of the command to the GitHub issue.
![flutter verbose](/images/verbose_flag.png)

## Provide the Most Recent Logs

* Logs for the currently connected device may be accessed via `flutter logs`
* If the crash is reproducible, clear the logs (⌘ + k on Mac), reproduce the crash and copy the newly generated logs into a file attached to the bug report.
* If you are getting exceptions thrown by the framework, include all the output between and including the dashed lines of the first such exception.
![flutter logs](/images/logs.png)

## Provide the Crash Report

* In case the iOS simulator crashes, a crash report is generated in `~/Library/Logs/DiagnosticReports/`.
* In case the iOS device crashes, a crash report is generated in `~/Library/Logs/CrashReporter/MobileDevice`.
* Find the report corresponding to the crash (usually the latest) and attach it to the GitHub issue.
![crash report](/images/crash_reports.png)
