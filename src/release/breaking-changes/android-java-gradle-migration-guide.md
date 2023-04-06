---
title: Android Java Gradle migration guide
description: How to migrate your Android app if you experience a run or build error from Gradle.
---

## Summary

If you've recently upgraded Android Studio to the Flamingo
release and have either run or built an existing Android app,
you might have run into an error similar to the following:

![Error dialog in Android Studio Flamingo]({{site.url}}/assets/images/docs/releaseguide/android-studio-flamingo-error.png){:width="80%"}

The terminal output looks similar to the following:


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
updates the Java SDK from 11 to 17, which
isn't compatible with the version of the Java SDK
used to build the app's Gradle file when the project
was originally created with `flutter create`.

**You can fix this error by upgrading your Gradle project
to a compatible version (7.3 or later) using one of
the following approaches.**

## Solution #1: Guided fix using Android Studio

Upgrade the Gradle version in Android Studio Flamingo
as follows:

**Step 1**: In Android Studio Flamingo, open the `android` folder,
  which should bring up the following dialog: 

![Dialog prompting you to upgrade Gradle]({{site.url}}/assets/images/docs/releaseguide/android-studio-flamingo-upgrade-alert.png){:width="50%"}

**Step 2**: Follow the guided workflow to update Gradle:

![Workflow to upgrade Gradle]({{site.url}}/assets/images/docs/releaseguide/android-studio-flamingo-gradle-upgrade.png){:width="85%"}

## Solution #2: Manual fix at the command line

Do the following from the top of your Flutter project.

**Step 1**: Go to the gradle directory for your project:

```sh
cd android/gradle/wrapper
```

**Step 2**: Edit the `gradle-wrapper.properties` file to
  change the `distributionUrl` field to the new Gradle version:

```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.0.2-all.zip 
```

## Notes

A few notes to be aware of:

* Repeat this step for each affected Android app.
* This issue can also be experienced by those who
  don't use Android Studio.
  If you've manually upgraded the Java SDK to
  version 17 but haven't upgraded Gradle, you can
  also encounter this issue. The fix is the same:
  upgrade Gradle.
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
* If you upgrade Gradle to a release _newer_ than 7.6,
  you might (though it's unlikely) encounter issues
  that result from changes to Gradle, such as
  [deprecated Gradle classes][], or changes to the
  Android file structure, such as
  [splitting out ApplicationId from PackageName][].
  If this occurs, downgrade to the 7.6 release of
  Gradle.
* If, as part of this fix, you upgraded to Flutter 3.10
  (which isn't required), be aware that
  the 3.10 release (which includes Dart 3) requires
  [**sound** null safety][]
  that might cause other migration issues.
  

[deprecated Gradle classes]: https://docs.gradle.org/7.6/javadoc/deprecated-list.html
[issue 122609]: {{site.github}}/flutter/flutter/issues/122609
[**sound** null safety]: {{site.dart-site}}/null-safety
[splitting out ApplicationId from PackageName]: http://tools.android.com/tech-docs/new-build-system/applicationid-vs-packagename
