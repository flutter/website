---
title: Route transition record and transition delegate updates
description: Changes to the rule on how transition delegate resolve route transition.
---

## Summary

A new boolean getter `isWaitingForExitingDecision` was added
to the route transition record and the `isEntering` getter
was renamed to `isWaitingForEnteringDecision`.
In the `resolve()` method for the transition delegate,
use the `isWaitingForExitingDecision` to check if an exiting
route actually needs an explicit decision on how to transition
off the screen. If you try to make a decision for an existing route
that _isn't_ waiting for a decision, Flutter throws an assertion error.

## Context

When the navigator receives a new list of pages, it tries to update its
current routes stack to match the list. However, it requires explicit
decisions on how to transition the route on and off the screen.
Previously, routes that were not in the new list required decisions
on how to transition off the screen. However, we later found out
this is not always true. If a route is popped,
but is still waiting for the popping animation to finish,
this route would sit in the navigator routes stack until
the animation was done. If a page update occurred during this time,
this route exits but doesn't requires a decision
on how to transition off the screen. Therefore, 
`isWaitingForExitingDecision` was added to cover that case.

The `isEntering` getter is also renamed to
`isWaitingForEnteringDecision` to be more descriptive,
and also to make the naming more consistent.

## Migration guide

If you implement your own transition delegate, you need to check the
exiting routes using the getter `isWaitingForExitingDecision` before you
call `markForPop`, `markForComplete`, or `markForRemove` on them.
You also need to rename all the references from `isEntering` to
`isWaitingForEnteringDecision`.

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

Landed in version: 1.18.0<br>
In stable release: 1.20

## References

API documentation:
* [`Navigator`][]
* [`TransitionDelegate`][]
* [`RouteTransitionRecord`][]

Relevant issue:
* [Issue 45938: Navigator 2.0][]

Relevant PR:
* [PR 55998][]: Fixes the navigator pages update crash
  when there is still a route waiting


[Issue 45938: Navigator 2.0]: {{site.github}}/flutter/flutter/issues/45938
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[PR 55998]: {{site.github}}/flutter/flutter/pull/55998
[`TransitionDelegate`]: {{site.api}}/flutter/widgets/TransitionDelegate-class.html
[`RouteTransitionRecord`]: {{site.api}}/flutter/widgets/RouteTransitionRecord-class.html
