---
title: The Route Transition Record and Transition Delegate Updates
description: Changes to the rule on how transition delegate resolve route transition.
---

## Summary

Added a new boolean getter `isWaitingForExitingDecision` to the route
transition record and renamed the getter `isEntering` to
`isWaitingForEnteringDecision`. During the resolve method in transition
delegate, developers need to use the `isWaitingForExitingDecision` to check
if a exiting route actually needs an explicit decision on how to transition
off the screen. Otherwise, it throws assertion errors if developers try to
make decisions for the exiting routes that are not waiting for exiting
decisions.


## Context

If the navigator receives a new list of pages, it tries to update its
current routes stack to match the list. It, however, requires explicit
decisions on how to transition the route in and off the screen. Developers
can customize that by providing their own implementations of transition
delegate. Previously, we made it so that all the routes that are not in the new
list must require decisions on how to transition off the screen. However,
these routes do not always require decisions. If a route that was popped
in a earlier update but is stilling waiting for the popping animation to
finish, this route will sit in the navigator routes stack until it is done.
If a page update occur during this time, this route is exiting but does
not requires any decision on how to transition off the screen. Therefore,
we add the `isWaitingForExitingDecision` to denote such case.

We also renamed the exiting getter `isEntering` to `isWaitingForEnteringDecision`
so that is is more descriptive and matches the naming scheme.

## Migration guide

If you are implementing your own transition delegate, you need to check the
exiting routes using the getter `isWaitingForExitingDecision` before you
call `markForPop`, `markForComplete`, or `markForRemove` on them. You also
need to rename all the references to `isEntering` to `isWaitingForEnteringDecision`.

Code before migration:

```dart
import 'package:flutter/widgets.dart';

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    List<RouteTransitionRecord> newPageRouteHistory,
    Map<RouteTransitionRecord, RouteTransitionRecord> locationToExitingPageRoute,
    Map<RouteTransitionRecord, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isEntering) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);

    }
    for (final RouteTransitionRecord exitingPageRoute in locationToExitingPageRoute.values) {
      exitingPageRoute.markForRemove();
      final List<RouteTransitionRecord> pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
      if (pagelessRoutes != null) {
        for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
          pagelessRoute.markForRemove();
        }
      }
      results.add(exitingPageRoute);

    }
    return results;
  }
}
```

Code after migration:

```dart
import 'package:flutter/widgets.dart';

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    List<RouteTransitionRecord> newPageRouteHistory,
    Map<RouteTransitionRecord, RouteTransitionRecord> locationToExitingPageRoute,
    Map<RouteTransitionRecord, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      // Renames isEntering to isWaitingForEnteringDecision.
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);

    }
    for (final RouteTransitionRecord exitingPageRoute in locationToExitingPageRoute.values) {
      // Checks the isWaitingForExitingDecision before calling the markFor methods.
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final List<RouteTransitionRecord> pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);

    }
    return results;
  }
}
```

## Timeline

This change landed in v1.18.0.

## References

API documentation:
* [`Navigator`][]

Relevant issue:
* [Issue 45938: Navigator 2.0][]

Relevant PR:
* [PR 55998: Fixes the navigator pages update crashes when there is still route waiting for popping animation to finish][]


[Issue 45938: Navigator 2.0]: {{site.github}}/flutter/flutter/issues/45938
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[PR 55998: Fixes the navigator pages update crashes when there is still route waiting for popping animation to finish]: {{site.github}}/flutter/flutter/pull/55998
