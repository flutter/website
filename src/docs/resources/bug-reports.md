---
title: Creating useful bug reports
description: Where to file bug reports and enhancement requests for flutter and the website.
---

The instructions in this document detail the current steps
required to provide the most actionable bug reports for
crashes and other bad behavior. Each step is optional but
will greatly improve how quickly issues are diagnosed and addressed.
We appreciate your effort in sending us as much feedback as possible.

## Create an issue on GitHub

* To report a Flutter crash or bug,
  [create an issue in the flutter/flutter project][Flutter issue].
* To report a problem with the website,
  [create an issue in the flutter/website project][Website issue].

## Provide some Flutter diagnostics

* Run `flutter doctor -v` in your project directory and paste
  the results into the GitHub issue:

```none
[✓] Flutter (Channel stable, 1.22.3, on Mac OS X 10.15.7 19H2, locale en-US)
    • Flutter version 1.22.3 at /Users/me/projects/flutter
    • Framework revision 8874f21e79 (5 days ago), 2020-10-29 14:14:35 -0700
    • Engine revision a1440ca392
    • Dart version 2.10.3

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.2)
    • Android SDK at /Users/me/Library/Android/sdk
    • Platform android-30, build-tools 29.0.2
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6222593)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 12.2)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 12.2, Build version 12B5035g
    • CocoaPods version 1.9.3

[✓] Android Studio (version 4.0)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 50.0.1
    • Dart plugin version 193.7547
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6222593)

[✓] VS Code (version 1.50.1)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.13.2

[✓] Connected device (1 available)
    • iPhone (mobile) • 00000000-0000000000000000 • ios • iOS 14.0
```

## Run the command in verbose mode

Follow these steps only if your issue is related to the
`flutter` tool.

* All Flutter commands accept the `--verbose` flag.
  If attached to the issue, the output from this command
  might aid in diagnosing the problem.
* Attach the results of the command to the GitHub issue.
![flutter verbose](/images/verbose_flag.png){:width="100%"}

## Provide the most recent logs

* Logs for the currently connected device are accessed
  using `flutter logs`.
* If the crash is reproducible, clear the logs
  (⌘ + k on Mac), reproduce the crash and copy the
  newly generated logs into a file attached to the bug report.
* If you are getting exceptions thrown by the framework,
  include all the output between and including the dashed
  lines of the first such exception.
![flutter logs](/images/logs.png){:width="100%"}

## Provide the crash report

* When the iOS simulator crashes,
  a crash report is generated in `~/Library/Logs/DiagnosticReports/`.
* When an iOS device crashes,
  a crash report is generated in `~/Library/Logs/CrashReporter/MobileDevice`.
* Find the report corresponding to the crash (usually the latest)
  and attach it to the GitHub issue.
![crash report](/images/crash_reports.png){:width="100%"}


[Flutter issue]: {{site.github}}/flutter/flutter/issues/new/choose
[Website issue]: {{site.github}}/flutter/website/issues/new/choose
