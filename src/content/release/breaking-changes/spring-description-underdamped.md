---
title: Underdamped spring formula changed
description: >-
  The formula for `SpringDescription` changed to correct an earlier error,
  affecting underdamped springs (damping ratio less than 1).
---

{% render "docs/breaking-changes.md" %}

## Summary

The formula for `SpringDescription` changed to correct an earlier error,
affecting underdamped springs (damping ratio less than 1)
with mass values other than 1.
Springs created prior to this change may exhibit
different bouncing behaviors after upgrading.

## Background

The [`SpringDescription`][] class describes the behavior of damped springs,
enabling Flutter widgets to animate realistically based on provided parameters.
The physics of damped springs are widely studied and documented. For an overview
of damping, see [Wikipedia: Damping][].

Previously, Flutter's formula for calculating underdamped spring behavior was
incorrect, as reported in [Issue 163858][]. This error affected all springs with
a damping ratio less than 1 and a mass other than 1. Consequently, animations
did not match expected real-world physics, and behavior around the critical
damping point (damping ratio of exactly 1) exhibited discontinuities.
Specifically, when using `SpringDescription.withDampingRatio`, small
differences, such as damping ratios of 1.0001 versus 0.9999, resulted in
significantly different animations.

The issue was corrected in PR [Fix SpringSimulation formula for underdamping][],
which updated the underlying calculation. As a result, previously affected
animations now behave differently, though no explicit errors are reported by the
framework.

## Migration guide

Migration is necessary only for springs with damping ratios less than 1 and
masses other than 1.

To restore previous animation behavior, update your spring parameters
accordingly. You can calculate the required parameter adjustments using the
provided [JSFiddle for migration][]. Detailed formulas and explanations follow
in the next sections.

### Default constructor

If the `SpringDescription` was built with the default constructor with
mass `m`, stiffness `k`, and damping `c`,
then it should be changed with the following formula:

```plaintext
new_m = 1
new_c = c * m
new_k = (4 * (k / m) - (c / m)^2 + (c * m)^2) / 4
```

Code before migration:

```dart
const spring = SpringDescription(
  mass: 20.0,
  stiffness: 10,
  damping: 1,
);
```

Code after migration:

```dart
const spring = SpringDescription(
  mass: 1.0,
  stiffness: 100.499375,
  damping: 20,
);
```

### `.withDampingRatio` constructor

If the `SpringDescription` was built with the `.withDampingRatio` constructor
with mass `m`, stiffness `k`, and ratio `z`, then first calculate damping:

```plaintext
c = z * 2 * sqrt(m * k)
```

Then apply the formula above.
Optionally, you might convert the result back to damping ratio with:

```plaintext
new_z = new_c / 2 / sqrt(new_m * new_k)
```

Code before migration:

```dart
const spring = SpringDescription.withDampingRatio(
  mass: 5.0,
  stiffness: 6.0,
  damping: 0.03,
);
```

Code after migration:

```dart
const spring = SpringDescription.withDampingRatio(
  mass: 1,
  stiffness: 1.87392,
  ratio: 0.60017287468545,
);
```

## Timeline

Landed in version: 3.31.0-0.1.pre<br>
In stable release: 3.32

## References

API documentation:

* [`SpringDescription`][]

Relevant issues:

* [Issue 163858][], where the bug was discovered and more context can be found.

Relevant PRs:

* [Fix SpringSimulation formula for underdamping][]

Tool:
* [JSFiddle for migration][]

[Fix SpringSimulation formula for underdamping]: {{site.repo.flutter}}/pull/165017
[Issue 163858]: {{site.repo.flutter}}/issues/163858
[JSFiddle for migration]: https://jsfiddle.net/6jgvbzps/30/
[`SpringDescription`]: {{site.api}}/flutter/physics/SpringDescription-class.html
[Wikipedia: Damping]: https://en.wikipedia.org/wiki/Damping
