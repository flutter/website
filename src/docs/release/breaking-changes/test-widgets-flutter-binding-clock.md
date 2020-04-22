---
title: `TestWidgetsFlutterBinding.clock` change
description: The `Clock` implementation will now come from package:clock.
---

## Summary

The `TestWidgetsFlutterBinding.clock` now comes from `package:clock` and
not `package:quiver`.

## Context

The `flutter_test` package is removing its dependency on the heavier weight
`quiver` package in favor of a dependency on two more targeted and lighter
weight packages, `clock` and `fake_async`.

This can affect user code which grabs the clock from a
`TestWidgetsFlutterBinding` and passes that to an api that expects a `Clock`
from `package:quiver`, for example some code like this:

<!-- skip -->
```dart
testWidgets('some test', (WidgetTester tester) {
  someApiThatWantsAQuiverClock(tester.binding.clock);
});
```

## Migration guide

The error you might see after this change will look something like this:

```
Error: The argument type 'Clock/*1*/' can't be assigned to the parameter type 'Clock/*2*/'.
 - 'Clock/*1*/' is from 'package:clock/src/clock.dart' ('<pub-cache>/clock/lib/src/clock.dart').
 - 'Clock/*2*/' is from 'package:quiver/time.dart' ('<pub-cache>/quiver/lib/time.dart').
```

### Option #1: Create a packge:quiver Clock from a package:clock Clock

The easiest migration is to create a `package:quiver` clock from the
`package:clock` clock, which can be done by passing the `.now` function
tearoff to the `Clock` constructor:

Code before migration:

<!-- skip -->
```dart
testWidgets('some test', (WidgetTester tester) {
  someApiThatWantsAQuiverClock(tester.binding.clock);
});
```

Code after migration:

<!-- skip -->
```dart
testWidgets('some test', (WidgetTester tester) {
  someApiThatWantsAQuiverClock(Clock(tester.binding.clock.now));
});
```

### Option #2: Change the api to accept a package:clock Clock

If you own the api you are calling, you may want to change it to accept a Clock
from `package:clock`. This is a judgement call based on how many places are
calling this api with something other than a clock retreived from a
`TestWidgetsFlutterBinding`.

If you go this route your call sites that are passing `tester.binding.clock`
will not need to be modified, but other call sites will.

### Option #3: Change the api to accept a `DateTime function()`

If all you use the `Clock` for is the `now` function, and you control the api,
then you can also change it to accept that function directly instead of a
`Clock`. This makes it easily callable with either type of `Clock`, by passing
a tearoff of the `now` method from either type of clock:

Calling code before migration:

<!-- skip -->
```dart
testWidgets('some test', (WidgetTester tester) {
  someApiThatWantsAQuiverClock(tester.binding.clock);
});
```

Calling code after migration:

<!-- skip -->
```dart
testWidgets('some test', (WidgetTester tester) {
  modifiedApiThatTakesANowFunction(tester.binding.clock.now);
});
```

## Timeline

This change was released in version 1.18.0.

## References

{% include master-api.md %}

API documentation:
* [`TestWidgetsFlutterBinding`][]

Relevant PRs:
* [PR 54125][]

[`TestWidgetsFlutterBinding`]: {{site.api}}/flutter/flutter_test/TestWidgetsFlutterBinding-class.html
[PR 54125]: {{site.github}}/flutter/flutter/pull/54125