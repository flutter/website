--- 
title: "Restore state on Android"
description: "How to restore the state of your Android app after it's been killed by the OS."
---

When a user runs a mobile app and then selects another
app to run, the first app is moved to the background,
or _backgrounded_. The operating system (both iOS and Android)
might kill the backgrounded app to release memory and
improve performance for the app running in the foreground.

When the user selects the app again, bringing it
back to the foreground, the OS relaunches it.
But, unless you've set up a way to save the
state of the app before it was killed,
you've lost the state and the app starts from scratch.
The user has lost the continuity they expect,
which is clearly not ideal.
(Imagine filling out a lengthy form and being interrupted
by a phone call _before_ clicking **Submit**.)

So, how can you restore the state of the app so that
it looks like it did before it was sent to the
background?

Flutter has a solution for this with the
[`RestorationManager`][] (and related classes)
in the [services][] library.
With the `RestorationManager`, the Flutter framework
provides the state data to the engine _as the state
changes_, so that the app is ready when the OS signals
that it's about to kill the app, giving the app only
moments to prepare.

:::secondary Instance state vs long-lived state
  When should you use the `RestorationManager` and
  when should you save state to long term storage?
  _Instance state_
  (also called _short-term_ or _ephemeral_ state),
  includes unsubmitted form field values, the currently
  selected tab, and so on. On Android, this is
  limited to 1 MB and, if the app exceeds this,
  it crashes with a `TransactionTooLargeException`
  error in the native code.
:::

[state]: /data-and-backend/state-mgmt/ephemeral-vs-app

## Overview

You can enable state restoration with just a few tasks:

1. Define a `restorationId` or a `restorationScopeId`
   for all widgets that support it,
   such as [`TextField`][] and [`ScrollView`][].
   This automatically enables built-in state restoration
   for those widgets.

2. For custom widgets,
   you must decide what state you want to restore
   and hold that state in a [`RestorableProperty`][].
   (The Flutter API provides various subclasses for
   different data types.)
   Define those `RestorableProperty` widgets 
   in a `State` class that uses the [`RestorationMixin`][].
   Register those widgets with the mixin in a
   `restoreState` method.

3. If you use any Navigator API (like `push`, `pushNamed`, and so on)
   migrate to the API that has "restorable" in the name
   (`restorablePush`, `restorablePushNamed`, and so on)
   to restore the navigation stack.

Other considerations:

* Providing a `restorationId` to
  `MaterialApp`, `CupertinoApp`, or `WidgetsApp`
  automatically enables state restoration by
  injecting a `RootRestorationScope`.
  If you need to restore state _above_ the app class,
  inject a `RootRestorationScope` manually.

* **The difference between a `restorationId` and
  a `restorationScopeId`:** Widgets that take a
  `restorationScopeID` create a new `restorationScope`
  (a new `RestorationBucket`) into which all children
  store their state. A `restorationId` means the widget
  (and its children) store the data in the surrounding bucket.

[a bit of extra setup]: {{site.api}}/flutter/services/RestorationManager-class.html#state-restoration-on-ios
[`restorationId`]: {{site.api}}/flutter/widgets/RestorationScope/restorationId.html
[`restorationScopeId`]: {{site.api}}/flutter/widgets/RestorationScope/restorationScopeId.html
[`RestorationMixin`]: {{site.api}}/flutter/widgets/RestorationMixin-mixin.html
[`RestorationScope`]: {{site.api}}/flutter/widgets/RestorationScope-class.html
[`restoreState`]: {{site.api}}/flutter/widgets/RestorationMixin/restoreState.html
[VeggieSeasons]: {{site.repo.samples}}/tree/main/veggieseasons

## Restoring navigation state

If you want your app to return to a particular route
that the user was most recently viewing
(the shopping cart, for example), then you must implement
restoration state for navigation, as well.

If you use the Navigator API directly,
migrate the standard methods to restorable
methods (that have "restorable" in the name).
For example, replace `push` with [`restorablePush`][].

The VeggieSeasons example (listed under "Other resources" below)
implements navigation with the [`go_router`][] package.
Setting the `restorationId`
values occur in the `lib/screens` classes.

## Testing state restoration

To test state restoration, set up your mobile device so that
it doesn't save state once an app is backgrounded.
To learn how to do this for both iOS and Android,
check out [Testing state restoration][] on the
[`RestorationManager`][] page.

:::warning
Don't forget to reenable
storing state on your device once you are
finished with testing!
:::

[Testing state restoration]: {{site.api}}/flutter/services/RestorationManager-class.html#testing-state-restoration
[`RestorationBucket`]: {{site.api}}/flutter/services/RestorationBucket-class.html
[`RestorationManager`]: {{site.api}}/flutter/services/RestorationManager-class.html
[services]: {{site.api}}/flutter/services/services-library.html

## Other resources

For further information on state restoration,
check out the following resources:

* For an example that implements state restoration, 
  check out [VeggieSeasons][], a sample app written
  for iOS that uses Cupertino widgets. An iOS app requires
  [a bit of extra setup][] in Xcode, but the restoration
  classes otherwise work the same on both iOS and Android.<br>
  The following list links to relevant parts of the VeggieSeasons
  example:
    * [Defining a `RestorablePropery` as an instance property]({{site.repo.samples}}/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L33-L37)
    * [Registering the properties]({{site.repo.samples}}/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L49-L54)
    * [Updating the property values]({{site.repo.samples}}/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L108-L109)
    * [Using property values in build]({{site.repo.samples}}/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L205-L210)<br>

* To learn more about short term and long term state,
  check out [Differentiate between ephemeral state
  and app state][state].

* You might want to check out packages on pub.dev that
  perform state restoration, such as [`statePersistence`][].

* For more information on navigation and the
  `go_router` package, check out [Navigation and routing][].

[`RestorableProperty`]: {{site.api}}/flutter/widgets/RestorableProperty-class.html
[`restorablePush`]: {{site.api}}/flutter/widgets/Navigator/restorablePush.html
[`ScrollView`]: {{site.api}}/flutter/widgets/ScrollView/restorationId.html
[`statePersistence`]: {{site.pub-pkg}}/state_persistence
[`TextField`]: {{site.api}}/flutter/material/TextField/restorationId.html
[`restorablePush`]: {{site.api}}/flutter/widgets/Navigator/restorablePush.html
[`go_router`]: {{site.pub}}/packages/go_router
[Navigation and routing]: /ui/navigation
