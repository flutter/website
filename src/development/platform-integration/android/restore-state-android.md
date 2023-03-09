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
state of the app before it was sent to the background,
you've lost the state and the app starts from
scratch. The user has lost the continuity they expect
and are generally annoyed. (Imagine filling out a
lengthy form and being interrupted by a phone call
_before_ clicking **Submit**...)

So, how can you restore the state of the app so that
it looks like it did before it was sent to the
background?

{% comment %}
xxx: Instance state vs long-lived state (2:22:28)
xxx: Instance state:
xxx:   UI state: active tab, current form field values
xxx:   Limited to <1MB on Android; if you go over
xxx:    your app will crash with TransactionToolLargeException
xxx:    thrown in the native code.
xxx: Long-lived state:
xxx:   User's login token
xxx:   Apps local data
xxx:   use state_persistence package
{% endcomment %}

Flutter has a solution for that scenario with the
[`RestorationManager`][] (and related classes)
in the [services][] library.
With the `RestorationManager`, the Flutter Framework
provides the state data to the engine _as the state
changes_, so that the app is ready when the OS signals
that it's about to kill the app, giving the app only
moments to prepare.

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
this object _unless_ you have two (or more) buckets with
the same `restorationId`. If that occurs, you
can create a new `RestorationScope` to ensure
that each ID is unique to its scope.
Each scope is assigned a unique [`restorationScopeId`][].

You must decide what state you want to save and restore,
but you can only save specific types to a `RestorationBucket`,
namely: null, bool, int, double, String, Uint8List
(and other typed data), List, Map, and child `RestorationBucket`s.

[`restorationId`]: {{site.api}}/flutter/widgets/RestorationScope/restorationId.html
[`restorationScopeId`]: {{site.api}}/flutter/widgets/RestorationScope/restorationScopeId.html
[`RestorationScope`]: {{site.api}}/flutter/widgets/RestorationScope-class.html

## Step 1: Enabling state restoration

Most every Flutter app contains a `main` method that calls the
[`runApp`][] function. You can use `runApp`
to set up the framework and the bindings that bind
the Dart code to the native Flutter engine.
In this case, set up the `RestorationManager` in the
`runApp` function.  For example:

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

QUESTION: I thought that Flutter automatically created
  the Scope for every route. But this app manually
  creats a Scope for the page... (xxx)

[`runApp`]: {{site.api}}/flutter/widgets/runApp.html

## Step 2: Add RestorableMixin to the State class

The easiest way to implement restorable state is to
add the [`RestorableMixin`][] to the app's `State` class.

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
[`restoreState`]: {{site.api}}/flutter/widgets/RestorationMixin/restoreState.html

## Step 3: Define a restorationScopeId for each scope

Each Scope in the app should have a `restorationScopeId`,
meaning that, at a minimum, you will have one scope per
route. If you create additional scopes
(to avoid `restorationId` duplication, for example),
then those are also assigned a unique ID.

```dart
restorationScopeId: 'app',
```

Also, if you want your app to return to the page that the
user was most recently viewing, then you need to implement
restoration state for the navigation, as well.
This page won't cover navigation, but the
accompanying example, VeggieSeasons, implements this
feature using the [go_router][] package.

[go_router]: {{site.pub}}/packages/go_router

## Step 4:

Most of the state restoration work occurs in the
`build` method on the `State` class that implements
`RestorationMixin`. Your primary task here is to
define a `restorationId` for each piece of state
you want to save.


```dart
class _VeggieAppState extends State<VeggieApp> with RestorationMixin {
  final _RestorableAppState _appState = _RestorableAppState();

  @override
  String get restorationId => 'wrapper';
    
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_appState, 'state');
  }
    
  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _appState.value,
        ),
        ChangeNotifierProvider(
          create: (_) => Preferences()..load(),
        ),
      ],
      child: CupertinoApp.router(
        theme: Styles.veggieThemeData,
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        routerConfig: GoRouter(
          navigatorKey: _rootNavigatorKey,
          restorationScopeId: 'router',
          initialLocation: '/list',
          redirect: (context, state) {
            if (state.path == '/') {
              return '/list';
            }
            return null;
          },
          debugLogDiagnostics: true,
          routes: [
            ShellRoute(
              navigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state, child) {
                return CupertinoPage(
                  restorationId: 'router.shell',
                  child: HomeScreen(
                    restorationId: 'home',
                    child: child,
                    onTap: (index) {
                      if (index == 0) {
                        context.go('/list');
                      } else if (index == 1) {
                        context.go('/favorites');
                      } else if (index == 2) {
                        context.go('/search');
                      } else {
                        context.go('/settings');
                      }
                    },
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: '/list',
                  pageBuilder: (context, state) {
                    return FadeTransitionPage(
                      key: state.pageKey,
                      restorationId: 'route.list',
                      child: const ListScreen(restorationId: 'list'),
                    );
                  },
                  routes: [
                    _buildDetailsRoute(),
                  ],
                ),
                GoRoute(
                  path: '/favorites',
                  pageBuilder: (context, state) {
                    return FadeTransitionPage(
                      key: state.pageKey,
                      restorationId: 'route.favorites',
                      child: const FavoritesScreen(restorationId: 'favorites'),
                    );
                  },
                  routes: [
                    _buildDetailsRoute(),
                  ],
                ),
                GoRoute(
                  path: '/search',
                  pageBuilder: (context, state) {
                    return FadeTransitionPage(
                      key: state.pageKey,
                      restorationId: 'route.search',
                      child: const SearchScreen(restorationId: 'search'),
                    );
                  },
                  routes: [
                    _buildDetailsRoute(),
                  ],
                ),
                GoRoute(
                  path: '/settings',
                  pageBuilder: (context, state) {
                    return FadeTransitionPage(
                      key: state.pageKey,
                      restorationId: 'route.settings',
                      child: const SettingsScreen(restorationId: 'settings'),
                    );
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'categories',
                      pageBuilder: (context, state) {
                        return VeggieCategorySettingsScreen.pageBuilder(
                            context);
                      },
                    ),
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'calories',
                      pageBuilder: (context, state) {
                        return CalorieSettingsScreen.pageBuilder(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // GoRouter does not support relative routes,
  // see https://github.com/flutter/flutter/issues/108177
  GoRoute _buildDetailsRoute() {
    return GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: 'details/:id',
      pageBuilder: (context, state) {
        final veggieId = int.parse(state.params['id']!);
        return CupertinoPage(
          restorationId: 'route.details',
          fullscreenDialog: true,
          child: DetailsScreen(
            id: veggieId,
            restorationId: 'details',
          ),
        );
      },
    );
  }
}

```
## Testing state restoration

To test state restoration, set up your mobile device so that
it doesn't save state once an app is backgrounded.
To learn how to do this for iOS and Android, check out
[Testing state restoration][] on the
[`RestorationManager`][] page. Don't forget to reenable
storing state once you are finished with testing!

[Testing state restoration]: {{site.api}}/flutter/services/RestorationManager-class.html#testing-state-restoration

[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html
[`RestorationBucket`]: {{site.api}}/flutter/services/RestorationBucket-class.html
[`RestorationManager`]: {{site.api}}/flutter/services/RestorationManager-class.html
[services]: {{site.api}}/flutter/services/services-library.html

## Other resources

The code in this page was taken from the [VeggieSeasons][] app.
VeggieSeasons is a sample app written for iOS that uses Cupertino
widgets. An iOS app requires [a bit of extra setup][] in Xcode, but
the restoration classes otherwise work the same on both iOS and Android.

You might also want to check out packages on pub.dev that
perform state restoration, such as [`statePersistence`][].

[`statePersistence`]: {{site.pub-pkg}}/state_persistence
[VeggieSeasons]: {{site.github}}/flutter/samples/tree/master/veggieseasons

