---
title: Android Java Gradle migration guide
description: How to migrate your Android app if you experience a run or build error from Gradle.
---

## Summary

If you've recently upgraded Android Studio to the Flamingo
release and have either run or built an existing Android app,
you have likely run into an error similar to the following:

![Error dialog in Android Studio Flamingo]({{site.url}}/assets/images/docs/releaseguide/android-studio-flamingo-error.png)

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

{{site.alert.important}}
  You can fix this by upgrading your Gradle project
  to a compatible version of 7.3 or later.
  Repeat this fix for every affected Android app.
{{site.alert.end}}

## Guided fix using Android Studio

Upgrade the Gradle version in Android Studio Flamingo
as follows:

Step 1: In Android Studio Flamingo, open the `android` subfolder,
  which should display the following dialog: 

![Dialog prompting you to upgrade Gradle]({{site.url}}/assets/images/docs/releaseguide/android-studio-flamingo-upgrade-alert.png)

Step 2: Following the guided workflow to update Gradle:

![Workflow to upgrade Gradle]({{site.url}}/assets/images/docs/releaseguide/releaseguide/android-studio-flamingo-gradle-upgrade.png)

## Manual fix using command line

xxx


## Notes

A few notes to be aware of:

* If you upgrade Gradle to a release _newer_ than 8.0.3,
  you might (though it's probably unlikely) encounter issues
  that result from changes to Gradle, such as
  deprecated Gradle classes, or changes to the Android
  file structure. 


