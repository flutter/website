---
title: Adding a Flutter View to an Android app
short-title: Integrate via FlutterView
description: Learn how to perform advanced integrations via Flutter Views
---

{{site.alert.warning}}
  Integrating via a [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
  is advanced usage and requires manually creating custom, application specific
  bindings.
{{site.alert.end}}

Integrating via a [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
requires a bit more work than via FlutterActivity and FlutterFragment previously
described.

Fundamentally, the Flutter framework on the Dart side requires access to various
activity-level events and lifecycles to function. Since the FlutterView (which
is an [android.view.View](https://developer.android.com/reference/android/view/View.html))
can be added to any activity which is owned by the developer's application
and since the FlutterView doesn't have access to activity level events, the
developer must bridge those connections manually to the [FlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html).

How you choose to feed your application's activities' events to the FlutterView
will be specific to your application.

## A sample

{% asset
development/add-to-app/android/add-flutter-view/add-view-sample.gif
class="mw-100" alt="Add Flutter View sample video" %}

Unlike the guides for FlutterActivity and FlutterFragment, the FlutterView
integration could be better demonstrated with a sample project.

A sample project is at [{{site.github}}/flutter/samples/tree/master/add_to_app/android_view]({{site.github}}/flutter/samples/tree/master/add_to_app/android_view)
to document a simple FlutterView integration where FlutterViews are used
for some of the cells in a RecycleView list of cards as seen in the gif above.

## General approach

The general gist of the FlutterView-level integration is that you must recreate
the various interactions between the your Activity, the [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
and the [FlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
present in the [FlutterActivityAndFragmentDelegate](https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/android/FlutterActivityAndFragmentDelegate.java)
in your own application's code. The connections made in the [FlutterActivityAndFragmentDelegate](https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/android/FlutterActivityAndFragmentDelegate.java)
are done automatically when using a [FlutterActivity]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html)
or a [FlutterFragment]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterFragment.html),
but since the [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
in this case is being added to an Activity or Fragment in your application,
you must recreate the connections manually. Otherwise, the [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
will not render anything or have other missing functionalities.

A sample [FlutterViewEngine]({{site.github}}/flutter/samples/blob/master/add_to_app/android_view/app/src/main/java/dev/flutter/example/androidView/FlutterViewEngine.kt)
class shows one such possible implementation of an application-specific
connection between an Activity, a [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
and a [FlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html).

### APIs to implement

The absolute minimum implementation needed for Flutter to draw anything at all
is to:

- Call [attachToFlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html#attachToFlutterEngine-io.flutter.embedding.engine.FlutterEngine-) when the
  [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
  is added to a resumed Activity's view hierarchy and is visible; and
- Call [appIsResumed]({{site.api}}/javadoc/io/flutter/embedding/engine/systemchannels/LifecycleChannel.html#appIsResumed--) on the [FlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)'s
  `lifecycleChannel` field when the Activity hosting the [FlutterView]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html)
  is visible.

The reverse [detachFromFlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterView.html#detachFromFlutterEngine--) and other lifecycle methods on the [LifecycleChannel]({{site.api}}/javadoc/io/flutter/embedding/engine/systemchannels/LifecycleChannel.html)
class must also be called to not leak resources when the FlutterView or Activity
is no longer visible.

In addition, see the remaining implementation in the [FlutterViewEngine]({{site.github}}/flutter/samples/blob/master/add_to_app/android_view/app/src/main/java/dev/flutter/example/androidView/FlutterViewEngine.kt)
demo class or in the [FlutterActivityAndFragmentDelegate](https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/android/FlutterActivityAndFragmentDelegate.java)
to ensure a correct functioning of other features such as clipboards, system
UI overlay, plugins etc.
