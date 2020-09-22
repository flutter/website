---
title: FlutterMain.setIsRunningInRobolectricTest on Android removed
description: The test-only FlutterMain.setIsRunningInRobolectricTest API on the Android engine is consolidated into the FlutterInjector.
---

## Summary

If you write Java JUnit tests (such as Robolectric tests) against the Flutter
engine's Java embedding and used the
`FlutterMain.setIsRunningInRobolectricTest(true)` API, replace it with

```java
FlutterJNI mockFlutterJNI = mock(FlutterJNI.class);
FlutterInjector.setInstance(
        new FlutterInjector.Builder()
            .setFlutterLoader(new FlutterLoader(mockFlutterJNI))
            .build());
```

This should be very uncommon.

## Context

The `FlutterMain` class itself is being deprecated and replaced with the
`FlutterInjector` class. The `FlutterMain` class uses a number of
static variables and functions than make it difficult to test.
`FlutterMain.setIsRunningInRobolectricTest()` is one ad-hoc static
mechanism to allow tests to run on the host machine on JVM without
loading the libflutter.so native library (which can't be done on the host
machine).

Rather than one-off solutions, all dependency injections needed for tests
in Flutter's Android/Java engine embedding are now moved to the
[`FlutterInjector`](https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/FlutterInjector.java)
class.

Within the `FlutterInjector` class, the `setFlutterLoader()` Builder
function allows for control of how the [`FlutterLoader`](https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/engine/loader/FlutterLoader.java)
class locates and loads the libflutter.so library.

## Description of change

https://github.com/flutter/engine/commit/15f5696c4139a21e1fc54014ce17d01f6ad1737c#diff-599e1d64442183ead768757cca6805c3L154
removes the `FlutterMain.setIsRunningInRobolectricTest()` testing function.

https://github.com/flutter/engine/commit/15f5696c4139a21e1fc54014ce17d01f6ad1737c#diff-f928557f2d60773a8435366400fa42ed
adds a `FlutterInjector` class to assist testing.

https://github.com/flutter/engine/pull/20473 further refactors FlutterLoader and FlutterJNI
to allow for additional mocking/testing.

## Migration guide

Code before migration:

```java
FlutterMain.setIsRunningInRobolectricTest(true);
```

Code after migration:

```java
FlutterJNI mockFlutterJNI = mock(FlutterJNI.class);
FlutterInjector.setInstance(
        new FlutterInjector.Builder()
            .setFlutterLoader(new FlutterLoader(mockFlutterJNI))
            .build());
```

## Timeline

Landed in version: 1.22.0-2.0.pre.133<br>
In stable release: not yet
