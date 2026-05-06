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

Two packages are commonly used to perform Flutter integration tests.
These are:

- [integration_test][integration_test] package: The official
integration test package that is part of the Flutter SDK. Tests written
with `integration_test` can perform the following tasks: run on the
target device, run from the host machine with `flutter test integration_test`,
and use `flutter_test` APIs. This makes integration tests similar to writing 
[widget tests][]. However, `integration_test` can't interact with
native platform UI.

- [patrol][] package: A popular third-party integration test package that
has many of the features supported by the `integration_test` package,
but can additionally interact with native platform UI such as
permission dialogs, notifications, or the contents of platform views.

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

To use `patrol`, follow the [Patrol setup guide][].

## Use cases for integration testing

The other guides in this section explain how to use integration tests to validate
[functionality][] and [performance][].

[functionality]: /testing/integration-tests/
[integration_test]: {{site.repo.flutter}}/tree/main/packages/integration_test
[Migrating from flutter_driver]: /release/breaking-changes/flutter-driver-migration
[patrol]: {{site.pub-pkg}}/patrol
[Patrol setup guide]: https://patrol.leancode.co/getting-started
[performance]: /cookbook/testing/integration/profiling/
[widget tests]: /testing/overview#widget-tests
