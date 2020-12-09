---
title: Reversing the dependency between the scheduler and services layer
description: The services layer now depends on the scheduler layer.
---

## Summary

The services layer now depends on the scheduler layer.
Previously, the opposite was true. This may affect you
if you have defined custom bindings overriding
Flutter's `SchedulerBinding` or `ServicesBinding`.

## Context

Prior to this change, the scheduler layer was dependent
on the services layer. This change reverses the dependency
chain and allows the services layer to make use of the
scheduling primitives in the scheduler layer. For example,
services in the services layer can now schedule tasks by using
`SchedulerBinding.scheduleTask`.

## Description of change

The change only affects users who are defining their own
custom bindings based on Flutter's `SchedulerBinding`
and `ServicesBinding`.

## Migration guide

Prior to this change, the `ServiceBinding` had to be defined before the
`SchedulerBinding`. With this change, it is the other way around:

Code before migration:

<!-- skip -->
```dart
class FooBinding extends BindingBase with ServicesBinding, SchedulerBinding {
 // ...
}
```

Code after migration:

<!-- skip -->
```dart
class FooBinding extends BindingBase with SchedulerBinding, ServicesBinding {
 // ...
}
```

## Timeline

Landed in version: 1.18.0<br>
In stable release: 1.20

## References

API documentation:
* [`ServicesBinding`][]
* [`SchedulerBinding`][]

Relevant PRs:
* [Reverse dependency between services and scheduler][]
* [Revert bindings dependency workaround][]

[Reverse dependency between services and scheduler]: {{site.github}}/flutter/flutter/pull/54212
[Revert bindings dependency workaround]: {{site.github}}/flutter/flutter/pull/54286
[`SchedulerBinding`]: {{site.api}}/flutter/scheduler/SchedulerBinding-mixin.html
[`ServicesBinding`]: {{site.api}}/flutter/scheduler/ServicesBinding-mixin.html
[`SchedulerBinding`]: {{site.api}}/flutter/scheduler/SchedulerBinding-mixin.html
[`ServicesBinding`]: {{site.api}}/flutter/scheduler/ServicesBinding-mixin.html
