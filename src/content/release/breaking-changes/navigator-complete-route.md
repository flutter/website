---
title: When a route is removed from the stack, associated futures must complete
description: >
  Before this breaking change, routes created by Navigator and awaited for
  results could never complete if the route was removed instead of popped.
---

## Summary

When routes are pushed, developers can await them to be notified when they are
popped. However, this didn't work when they were removed because the associated
future was never completed.

## Context

All Navigator methods that call `remove` had this issue. By using `complete`,
the issue is properly resolved, allowing developers to pass a result.

## Description of change

All Navigator methods have been updated to no longer call `remove` but instead
use `complete`. Context menus are now built from the `contextMenuBuilder`
parameter.

All methods that directly use `complete` now accept an optional `result`
parameter to return it to the associated future. Other methods that indirectly
use `remove` currently return `null`. In the future, we may extend these
methods with an optional callback function to allow developers to handle pop
logic in indirect scenarios (e.g., `removeUntil`).

## Migration guide

For developers who implemented `RouteTransitionRecord` and used `markForRemove`,
they need to use `markForComplete` instead. `markForRemove` is now deprecated.

For other developers, no changes are required. The navigator continues to work
as expected with new capabilities.

## Timeline

Landed in version: 3.27.0-1.0.pre.39922  
In stable release: X.X.X

## References

### API documentation:

* [`RouteTransitionRecord`]({{site.api}}/flutter/widgets/RouteTransitionRecord-class.html)
* [`Navigator`]({{site.api}}/flutter/widgets/Navigator-class.html)

### Relevant issues:

* [removeRoute unresolved future]({{site.repo.flutter}}/issues/157505)

### Relevant PRs:

* [feat: removeRoute now calls didComplete]({{site.repo.flutter}}/pull/157725)
