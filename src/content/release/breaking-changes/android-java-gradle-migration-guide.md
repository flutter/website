---
title: Android Java Gradle migration guide
description: >
  How to migrate your Android app if you experience
  a run or build error from Gradle.
---

{% render "docs/breaking-changes.md" %}

## Summary

If you've recently upgraded Android Studio to the Flamingo
release and have either run or built an existing Android app,
you might have run into an error similar to the following:

```sh
Caused by: org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
```

The terminal output for this error is
similar to the following:


```sh
FAILURE: Build failed with an exception.

* Where:
Build file '…/example/android/build.gradle'
* What went wrong:
Could not compile build file '…/example/android/build.gradle'.
> startup failed:
  General error during conversion: Unsupported class file major version 61

  java.lang.IllegalArgumentException: Unsupported class file major version 61
  	at groovyjarjarasm.asm.ClassReader.<init>(ClassReader.java:189)
  	at groovyjarjarasm.asm.ClassReader.<init>(ClassReader.java:170)
  	[…
  	 …
  	 … 209 more lines of Groovy and Gradle stack trace …
  	 …
  	 …]
  	at java.base/java.lang.Thread.run(Thread.java:833)
```

This error occurs because Android Studio Flamingo
updates its bundled Java SDK from 11 to 17.
Flutter uses the version of Java bundled with
Android Studio to build Android apps.
Gradle versions [prior to 7.3][] can't run
when using Java 17.

**You can fix this error by upgrading your Gradle project
to a compatible version (7.3 through 7.6.1, inclusive)
using one of the following approaches.**

[prior to 7.3]: https://docs.gradle.org/current/userguide/compatibility.html#java

## Solution #1: Guided fix using Android Studio

Upgrade the Gradle version in Android Studio Flamingo
as follows:

1. In Android Studio, open the `android` folder.
   This should bring up the following dialog:

   ![Dialog prompting you to upgrade Gradle](/assets/images/docs/releaseguide/android-studio-flamingo-upgrade-alert.png){:width="50%"}

   Update to a Gradle release between 7.3 through 7.6.1, inclusive.

1. Follow the guided workflow to update Gradle.

   ![Workflow to upgrade Gradle](/assets/images/docs/releaseguide/android-studio-flamingo-gradle-upgrade.png){:width="85%"}

## Solution #2: Manual fix at the command line

Do the following from the top of your Flutter project.

1. Go to the Android directory for your project.

   ```console
   $ cd android
   ```

1. Update Gradle to the preferred version. Choose between 7.3 through 7.6.1, inclusive.

   ```console
   $ ./gradlew wrapper --gradle-version=7.6.1
   ```

## You didn't update Android Studio and still have a Java error
The error appears similar to `Unsupported class file major version 65`.
This is an indication that your Java version is newer than the version of
gradle you are running can handle. There is a non obvious set of dependencies
surrounding AGP, Java, and Gradle.

### Solution 1: Android Studio
The easiest way to resolve this issue is to use Android Studio AGP upgrade assistant.
To use select your top-level `build.gradle` file in Android Studio then select
Tools -> AGP Upgrade Assistant.

### Solution 2: Command line
Run `flutter analyze --suggestions` to see if your AGP, Java, and Gradle versions are compatible.
If Gradle needs to be updated you can update it with `./gradlew wrapper --gradle-version=SOMEGRADLEVERSION`
where SOMEGRADLEVERSION is the version (you can use a newer version)
suggested by `flutter analyze`.

To find the Java version being used run `flutter doctor`.
On a mac, you can find the Java versions that the OS knows about with `/usr/libexec/java_home -V`.
To set the version of Java that all flutter projects use run `flutter config --jdk-dir=SOMEJAVAPATH`
where SOMEJAVAPATH is a path to a Java version like `/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home`

## Notes

A few notes to be aware of:

* Repeat this step for each affected Android app.
* This issue can be experienced by those who
  _don't_ download Java and the Android SDK through
  Android studio.
  If you've manually upgraded your Java SDK to
  version 17 but haven't upgraded Gradle, you can
  also encounter this issue. The fix is the same:
  upgrade Gradle to a release between 7.3 and 7.6.1.
* Your development machine _might_ contain more
  than one copy of the Java SDK:
  * The Android Studio app includes a version of Java,
    which Flutter uses by default.
  * If you don't have Android Studio installed,
    Flutter relies on the version defined by your
    shell script's `JAVA_HOME` environment variable.
  * If `JAVA_HOME` isn't defined, Flutter looks
    for any `java` executable in your path.
    The `flutter doctor -v` command reports which version
    of Java is used.
* If you upgrade Gradle to a release _newer_ than 7.6.1,
  you might (though it's unlikely) encounter issues
  that result from changes to Gradle, such as
  [deprecated Gradle classes][], or changes to the
  Android file structure, such as
  [splitting out ApplicationId from PackageName][].
  If this occurs, downgrade to a release of Gradle
  between 7.3 and 7.6.1, inclusive.
* Upgrading to Flutter 3.10 won't fix this issue.

[deprecated Gradle classes]: https://docs.gradle.org/7.6/javadoc/deprecated-list.html
[issue 122609]: {{site.repo.flutter}}/issues/122609
[splitting out ApplicationId from PackageName]: http://tools.android.com/tech-docs/new-build-system/applicationid-vs-packagename
