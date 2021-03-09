---
title: Android ActivityControlSurface attachToActivity signature change
description: attachToActivity activity parameter changed to ExclusiveAppComponent instead of Activity
---

## Summary

{{site.alert.note}}
  If you use standard Android embedding Java classes like
  [`FlutterActivity`][] or [`FlutterFragment`][],
  and don't manually embed a [`FlutterView`][]
  inside your own custom `Activity` (this should be uncommon),
  you can stop reading.
{{site.alert.end}}

A new [`ActivityControlSurface`][] method:

```java
void attachToActivity(
    @NonNull ExclusiveAppComponent<Activity> exclusiveActivity,
    @NonNull Lifecycle lifecycle);
```

is replacing the now deprecated method:

```java
void attachToActivity(@NonNull Activity activity, @NonNull Lifecycle lifecycle);
```

The existing deprecated method with the `Activity`
parameter was removed in Flutter 2.

## Context

In order for custom Activities to also supply the `Activity`
lifecycle events Flutter plugins expect using the
[`ActivityAware`][] interface, the [`FlutterEngine`][]
exposed a [`getActivityControlSurface()`][] API.

This allows custom Activities to signal to the engine
(with which it has a `(0|1):1` relationship) that
it was being attached or detached from the engine.

{{site.alert.note}}
  This lifecycle signaling is done automatically when you
  use the engine's bundled [`FlutterActivity`][]
  or [`FlutterFragment`][], which should be the most
  common case.
{{site.alert.end}}

However, the previous API had the flaw that it didn't
enforce exclusion between activities connecting to
the engine, thus enabling `n:1` relationships between
the activity and the engine,
causing lifecycle cross-talk issues.

## Description of change

After [Issue #21272][], instead of attaching your activity
to the [`FlutterEngine`][] by using the:

```java
void attachToActivity(@NonNull Activity activity, @NonNull Lifecycle lifecycle);
```

API, which is now deprecated, instead use:

```java
void attachToActivity(
    @NonNull ExclusiveAppComponent<Activity> exclusiveActivity,
    @NonNull Lifecycle lifecycle);
```

An `ExclusiveAppComponent<Activity>` interface
is now expected instead of an `Activity`.
The `ExclusiveAppComponent<Activity>` provides a callback
in case your exclusive activity is being replaced by
another activity attaching itself to the `FlutterEngine`.

The

```java
void detachFromActivity();
```

API remains unchanged and you're still expected
to call it when your custom
activity is being destroyed naturally.

## Migration guide

If you have your own activity holding a
[`FlutterView`][], replace calls to:

```java
void attachToActivity(@NonNull Activity activity, @NonNull Lifecycle lifecycle);
```

with calls to:

```java
void attachToActivity(
    @NonNull ExclusiveAppComponent<Activity> exclusiveActivity,
    @NonNull Lifecycle lifecycle);
```

on the [`ActivityControlSurface`][] that you obtained by calling
[`getActivityControlSurface()`][] on the [`FlutterEngine`][].

Wrap your activity with an `ExclusiveAppComponent<Activity>`
and implement the callback method:

```java
void detachFromFlutterEngine();
```

to handle your activity being replaced by another
activity being attached to the [`FlutterEngine`][].
Generally, you want to perform the same detaching operations
as performed when the activity is being naturally destroyed.

## Timeline

Landed in version: 1.23.0-7.0.pre<br>
In stable release: 2.0.0

## References

Motivating bug: [Issue #66192][]—Non exclusive
UI components attached to the FlutterEngine causes
event crosstalk


[`ActivityAware`]: {{site.api}}/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityAware.html
[`ActivityControlSurface`]: {{site.api}}/javadoc/io/flutter/embedding/engine/plugins/activity/ActivityControlSurface.html
[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[`FlutterEngine`]: {{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html
[`FlutterFragment`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterFragment.html
[`FlutterView`]: {{site.api}}/javadoc/io/flutter/view/FlutterView.html
[`getActivityControlSurface()`]: {{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html#getActivityControlSurface--
[Issue #66192]: {{site.github}}/flutter/flutter/issues/66192.
[Issue #21272]: {{site.github}}/flutter/engine/pull/21272
