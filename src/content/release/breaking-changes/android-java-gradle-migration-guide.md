---
title: Android Java Gradle migration guide
description: >
  How to migrate your Android app if you experience
  a run or build error from Gradle.
---

## Summary

If you've recently upgraded Android Studio and have either run or built an existing Android app, you might have run into an error similar to the following:

![Error dialog in Android Studio: MultipleCompilationErrorsException](/assets/images/docs/releaseguide/android-studio-error.png)

The terminal output for this error is similar to the following:

```sh
PS C:\Users\karth\Desktop\flutter_chat_ui\example> flutter run
Launching lib\main.dart on sdk gphone64 x86 64 in debug mode...

FAILURE: Build failed with an exception.

* What went wrong:
Could not open cp_settings generic class cache for settings file 'C:\Users\karth\Desktop\flutter_chat_ui\example\android\settings.gradle' (C:\Users\karth\.gradle\caches\7.6.3\scripts\89h1b0pgkuoa5c28iqf1kcknq).
> BUG! exception in phase 'semantic analysis' in source unit '_BuildScript_' Unsupported class file major version 65

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 888ms
Running Gradle task 'assembleDebug'...                           1,641ms

┌─ Flutter Fix ─────────────────────────────────────────────────────────────────────────────────────────────┐   
│ [!] Your project's Gradle version is incompatible with the Java version that Flutter is using for Gradle. │   
│                                                                                                           │   
│ If you recently upgraded Android Studio, consult the migration guide at                                   │   
│ https://flutter.dev/to/to/java-gradle-incompatibility.                                                    │   
│                                                                                                           │   
│ Otherwise, to fix this issue, first, check the Java version used by Flutter by running `flutter doctor    │   
│ --verbose`.                                                                                               │   
│                                                                                                           │   
│ Then, update the Gradle version specified in                                                              │   
│ C:\Users\karth\Desktop\flutter_chat_ui\example\android\gradle\wrapper\gradle-wrapper.properties to be     │   
│ compatible with that Java version. See the link below for more information on compatible Java/Gradle      │   
│ versions:                                                                                                 │   
│ https://docs.gradle.org/current/userguide/compatibility.html#java                                         │   
│                                                                                                           │   
└───────────────────────────────────────────────────────────────────────────────────────────────────────────┘   
Error: Gradle task assembleDebug failed with exit code 1
```

This error occurs because Android Studio updates its bundled Java SDK to a newer version. Flutter uses the version of Java bundled with Android Studio to build Android apps. Gradle versions prior to 8.5 can't run when using Java 21.

1. **Check the JDK Version**:
   - Before upgrading your Gradle version, ensure that your JDK version is up to date. You can check your current JDK version using the following commands:
     ```sh
     flutter upgrade
     flutter doctor --verbose
     ```

2. **Update the Gradle Version**:
   - The latest Gradle version compatible with Java 21 is Gradle 8.5. As an example, it is recommended to use Gradle 8.5 to ensure compatibility with Java 21.

## Solution #1: Guided fix using Android Studio

Upgrade the Gradle version in Android Studio as follows:

1. In Android Studio, open the `android` folder.
   This should bring up the following dialog: 

   ![Dialog prompting you to upgrade Gradle](/assets/images/docs/releaseguide/android-studio-upgrade-alert.png){:width="50%"}

   Update to Gradle release 8.5.

1. Follow the guided workflow to update Gradle.

   ![Workflow to upgrade Gradle](/assets/images/docs/releaseguide/android-studio-gradle-upgrade.png){:width="85%"}

## Solution #2: Manual fix at the command line

Do the following from the top of your Flutter project.

1. Go to the Android directory for your project.

   ```console
   $ cd android
   ```

1. Update Gradle to the preferred version 8.5.

   ```console
   $ ./gradlew wrapper --gradle-version=8.5
   ```

## Notes

A few notes to be aware of:

* Repeat this step for each affected Android app.
* This issue can be experienced by those who
  _don't_ download Java and the Android SDK through
  Android studio.
  If you've manually upgraded your Java SDK to
  version 21 but haven't upgraded Gradle, you can
  also encounter this issue. The fix is the same:
  upgrade Gradle to release 8.5.
* Your development machine _might_ contain more
  than one copy of the Java SDK:
  * The Android Studio app includes a version of Java,
    which Flutter uses by default.
  * If you don't have Android Studio installed,
    Flutter relies on the version defined by your
    shell script's `JAVA_HOME` environment variable.
  * If `JAVA_HOME` isn't defined, Flutter looks
    for any `java` executable in your path.
    Once [issue 122609][] lands, the `flutter doctor`
    command reports which version of Java is used.
* If you upgrade Gradle to a release _newer_ than 8.5,
  you might (though it's unlikely) encounter issues
  that result from changes to Gradle, such as
  [deprecated Gradle classes][], or changes to the
  Android file structure, such as
  [splitting out ApplicationId from PackageName][].
  If this occurs, downgrade to Gradle 8.5.
* Upgrading to Flutter 3.10 won't fix this issue.

[deprecated Gradle classes]: https://docs.gradle.org/8.5/javadoc/deprecated-list.html
[issue 122609]: {{site.repo.flutter}}/issues/122609
[splitting out ApplicationId from PackageName]: http://tools.android.com/tech-docs/new-build-system/applicationid-vs-packagename
