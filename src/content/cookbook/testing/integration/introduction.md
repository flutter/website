---
title: Integration testing concepts
description: Learn about integration testing in Flutter.
shortTitle: Introduction
---

<?code-excerpt path-base="cookbook/testing/integration/introduction/"?>

Unit tests and widget tests validate individual classes,
functions, or widgets.
They don't validate how individual pieces work
together in whole or capture the performance
of an app running on a real device.
To perform these tasks, use *integration tests*.

Integration tests verify the behavior of the complete app.
This test can also be called end-to-end testing or GUI testing.

## Testing frameworks

Flutter supports two main approaches for integration testing:

### `integration_test` package

The Flutter SDK includes the [`integration_test`][integration_test] package.
Tests written with `integration_test` can perform the following tasks:

* Run on the target device.
  To test multiple Android or iOS devices, use Firebase Test Lab.
* Run from the host machine with `flutter test integration_test`.
* Use `flutter_test` APIs. This makes integration tests
  similar to writing [widget tests][].

However, `integration_test` can't interact with native platform UI,
such as permission dialogs, notifications, or the contents of
platform views.

### `patrol` package

[Patrol][] is an open-source testing framework that builds on top
of Flutter's testing capabilities. It extends `integration_test`
with native interaction support. Patrol lets you:

* Interact with native platform UI, such as permission dialogs,
  notifications, and WebViews.
* Access device-level features like toggling Wi-Fi
  or adjusting system settings.
* Write more concise tests using [patrol finders][].

To learn more, visit the [Patrol documentation][].

## Terminology

**host machine**
: The system on which you develop your app, like a desktop computer.

**target device**
: The mobile device, browser, or desktop application that
  runs your Flutter app.

  If you run your app in a web browser or as a desktop application,
  the host machine and the target device are the same.

## Getting started

To use `integration_test`, add it as a dependency for your
Flutter app test file.

To migrate existing projects that use `flutter_driver`,
consult the [Migrating from flutter_driver][] guide.

To use Patrol, follow the [Patrol setup guide][].

## Use cases for integration testing

The other guides in this section explain how to use integration tests to validate
[functionality][] and [performance][].

[patrol finders]: {{site.pub-pkg}}/patrol_finders
[functionality]: /testing/integration-tests/
[integration_test]: {{site.repo.flutter}}/tree/main/packages/integration_test
[Migrating from flutter_driver]: /release/breaking-changes/flutter-driver-migration
[Patrol]: {{site.pub-pkg}}/patrol
[Patrol documentation]: https://patrol.leancode.co/
[Patrol setup guide]: https://patrol.leancode.co/getting-started
[performance]: /cookbook/testing/integration/profiling/
[widget tests]: /testing/overview#widget-tests
