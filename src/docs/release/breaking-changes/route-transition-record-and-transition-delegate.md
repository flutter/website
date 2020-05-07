---
title: The Route Transition Record and Transition Delegate Updates
description: Changes to the rule on how transition delegate resolve route transition.
---

## Summary

We added a new boolean getter `isWaitingForExitingDecision` to the route
transition record and renamed the getter `isEntering` to
`isWaitingForEnteringDecision`. During the `resolve` method in transition
delegate, you need to use the `isWaitingForExitingDecision` to check
if an exiting route actually needs an explicit decision on how to transition
off the screen. Otherwise, it throws assertion errors if you try to
make decisions for exiting routes that aren't waiting for exiting
decisions.


## Context

If the navigator receives a new list of pages, it tries to update its
current routes stack to match the list. However, it requires explicit
decisions on how to transition the route on and off the screen. Previously,
routes that were not in the new list required decisions on how to transition
off the screen. However, we later found out this is not always true. If a
route that was popped but is still waiting for the popping animation to finish,
this route will sit in the navigator routes stack until it is done. If a page
update occurs during this time, this route exits but doesn't requires a decision
on how to transition off the screen. Therefore, we added the
`isWaitingForExitingDecision` to denote such case.

The `isEntering` getter is also renamed to `isWaitingForEnteringDecision` so
that is is more descriptive and matches the naming scheme.

## Migration guide

If you are implementing your own transition delegate, you need to check the
exiting routes using the getter `isWaitingForExitingDecision` before you
call `markForPop`, `markForComplete`, or `markForRemove` on them. You also
need to rename all the references to `isEntering` to `isWaitingForEnteringDecision`.

Code before migration:

<!-- skip -->
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

<!-- skip -->
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
* [`TransitionDelegate`][]
* [`RouteTransitionRecord`][]

Relevant issue:
* [Issue 45938: Navigator 2.0][]

Relevant PR:
* [PR 55998][]


[Issue 45938: Navigator 2.0]: {{site.github}}/flutter/flutter/issues/45938
[`Navigator`]: https://master-api.flutter.dev/flutter/widgets/Navigator-class.html
[`TransitionDelegate`]: https://master-api.flutter.dev/flutter/widgets/TransitionDelegate-class.html
[`RouteTransitionRecord`]: https://master-api.flutter.dev/flutter/widgets/RouteTransitionRecord-class.html
[PR 55998]: {{site.github}}/flutter/flutter/pull/55998
