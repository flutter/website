--- 
title: "State restoration for Android apps"
description: "How to restore the state of your Android app after it's been killed by the OS."
---

When a user runs a mobile app and then selects another
app to run, the first app is moved to the background,
or _backgrounded_. The operating system (both iOS and Android)
often kill the backgrounded app to release memory or
improve performance for the app running in the foreground.

When the user selects the app again, bringing it
back to the foreground, the OS relaunches it.
But, unless you've set up a way to save the
state of the app before it was killed,
you've lost the state and the app starts from
scratch. The user has lost the continuity they expect,
which is clearly not ideal.
(Imagine filling out a lengthy form and being interrupted
by a phone call _before_ clicking **Submit**.)

So, how can you restore the state of the app so that
it looks like it did before it was sent to the
background?

Flutter has a solution for that scenario with the
[`RestorationManager`][] (and related classes)
in the [services][] library.
With the `RestorationManager`, the Flutter Framework
provides the state data to the engine _as the state
changes_, so that the app is ready when the OS signals
that it's about to kill the app, giving the app only
moments to prepare.

{{site.alert.secondary}}
  <strong>Instance state vs long-lived state</strong>
  When should you use the `RestorationManager` and
  when should you save state to long term storage?
  _Instance state_ or
  (also called _short-term_ or _ephemeral_ state),
  includes unsubmitted form field values, the currently
  selected tab, and so on. On Android, this is
  limited to 1 MB and, if the app exceeds this,
  it crashes with a `TransactionTooLargeException`
  error in the native code.
  To learn more about short term and long term state,
  check out [Differentiate between ephemeral state
  and app state][state].
{{site.alert.end}}

[state]: {{site.url}}/development/data-and-backend/state-mgmt/ephemeral-vs-app

The `RestorationManager` manages the restoration
data, which is serialized to a tree of [`RestorationBucket`][],
that are synchronized with the Flutter engine.
A `RestorationBucket` contains a key/value pair
of state information that you want to save. The key is a
[`restorationId`][] that is unique to that `RestorationScope`.

Flutter automatically creates a
[`RestorationScope`][] for each route in your
app to track the `RestorationBucket`s in that scope.
In general, you shouldn't need to worry about
this object _unless_ the scope has two (or more) buckets with
the same `restorationId`. If that occurs,
create a new `RestorationScope` to ensure
that each ID is unique to its scope.
Each scope is assigned a unique [`restorationScopeId`][].

You must decide what state you want to save and restore,
but you can only save specific types to a `RestorationBucket`,
namely: `null`, `bool`, `int`, `double`, `String`, `Uint8List`
(and other typed data), `List`, `Map`, and child `RestorationBucket`s.

{{site.alert.note}}
  The code in this page was taken from [VeggieSeasons][].
  VeggieSeasons is a sample app written for iOS that uses Cupertino
  widgets. An iOS app requires [a bit of extra setup][] in Xcode, but
  the restoration classes otherwise work the same on both iOS and Android.
{{site.alert.end}}


[a bit of extra setup]: {{site.api}}/flutter/services/RestorationManager-class.html#state-restoration-on-ios
[`restorationId`]: {{site.api}}/flutter/widgets/RestorationScope/restorationId.html
[`restorationScopeId`]: {{site.api}}/flutter/widgets/RestorationScope/restorationScopeId.html
[`RestorationScope`]: {{site.api}}/flutter/widgets/RestorationScope-class.html
[VeggieSeasons]: {{site.github}}/flutter/samples/tree/master/veggieseasons

## Step 1: Enabling state restoration

Most every Flutter app contains a `main` method that calls the
[`runApp`][] function. You can use `runApp`
to set up the framework and the bindings that bind
the Dart code to the native Flutter engine.
Set up the `RestorationManager` in the `runApp` function.
For example:

```dart
void main() {
  /...

  runApp(
    const RootRestorationScope(
      restorationId: 'root',
      child: VeggieApp(),
    ),
  );
}
```

QUESTION for Michael: I thought that Flutter automatically created
  the Scope for every route. But this app manually
  creats a Scope for the page. ?? (xxx)

[`runApp`]: {{site.api}}/flutter/widgets/runApp.html

## Step 2: Add RestorationMixin to the State class

To implement restorable state,
add the [`RestorationMixin`][] to the app's `State` class.

```dart
class _VeggieAppState extends State<VeggieApp> with RestorationMixin
```

Once you've added the restore state mixin,
your IDE asks you to implement an abstract method
called [`restoreState`][]. The `restoreState` method calls
[`registerForRestoration`][] to register that you
intend to save state. For example:

```dart
@override
void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  registerForRestoration(_appState, 'state');
} 
```

[`registerForRestoration`]: {{site.api}}/flutter/widgets/RestorationMixin/registerForRestoration.html
[`RestorationMixin`]: {{site.api}}/flutter/widgets/RestorationMixin-mixin.html
[`restoreState`]: {{site.api}}/flutter/widgets/RestorationMixin/restoreState.html

## Step 3: Define a restorationScopeId for each scope

Each Scope in the app should have a `restorationScopeId`,
meaning that, at a minimum, you will have one scope per
route. If you create additional scopes
(to avoid `restorationId` duplication, for example),
then also assign those with a unique ID.

```dart
restorationScopeId: 'app',
```

## Step 4: Restoring navigation state

If you want your app to return to the route (such
as a specific tab) that the user was most recently viewing,
then you need to implement
restoration state for the navigation, as well.
This page won't cover navigation, but the
accompanying example, VeggieSeasons, implements this
feature using the [go_router][] package.

For more information on navigation and the
`go_router` package, check out [Navigation and routing][].

[go_router]: {{site.pub}}/packages/go_router
[Navigation and routing]: {{site.url}}/development/ui/navigation

## Step 4: Save the state you want to restore

Most of the state restoration work occurs in the
`build` method on the `State` class that implements
`RestorationMixin`. Your primary task here is to
define a `restorationId` for each piece of state
you want to save.

In the VeggieSeasons example, most of this work
is implemented in the `lib/screens` classes.

QUESTION for Michael: This part of VeggieSeasons is fairly dense.
I'm not sure what is a good code excerpt to include here. (xxx)

## Testing state restoration

To test state restoration, set up your mobile device so that
it doesn't save state once an app is backgrounded.
To learn how to do this for both iOS and Android,
check out [Testing state restoration][] on the
[`RestorationManager`][] page.

{{site.alert.note}}
  Don't forget to reenable
  storing state on your device once you are
  finished with testing!
{{site.alert.end}}

[Testing state restoration]: {{site.api}}/flutter/services/RestorationManager-class.html#testing-state-restoration

[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html
[`RestorationBucket`]: {{site.api}}/flutter/services/RestorationBucket-class.html
[`RestorationManager`]: {{site.api}}/flutter/services/RestorationManager-class.html
[services]: {{site.api}}/flutter/services/services-library.html

## Other resources

You might want to check out packages on pub.dev that
perform state restoration, such as [`statePersistence`][].

[`statePersistence`]: {{site.pub-pkg}}/state_persistence

