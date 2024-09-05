---
title: Integration testing concepts
description: Learn about integration testing in Flutter.
short-title: Introduction
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

The Flutter SDK includes the [integration_test][] package.

## Terminology

**host machine**
: The system on which you develop your app, like a desktop computer.

**target device**
: The mobile device, browser, or desktop application that runs
your Flutter app.

  If you run your app in a web browser or as a desktop application,
  the host machine and the target device are the same.

## Dependent package

To run integration tests, add the `integration_test` package
as a dependency for your Flutter app test file.

To migrate existing projects that use `flutter_driver`,
consult the [Migrating from flutter_driver][] guide.

Tests written with the `integration_test` package 
can perform the following tasks.

* Run on the target device.
  To test multiple Android or iOS devices, use Firebase Test Lab.
* Run from the host machine with `flutter test integration_test`.
* Use `flutter_test` APIs. This makes integration tests
  similar to writing [widget tests][].

## Use cases for integration testing

The other guides in this section explain how to use integration tests to validate
[functionality][] and [performance][].

[functionality]: /testing/integration-tests/
[performance]: /cookbook/testing/integration/profiling/
[integration_test]: {{site.repo.flutter}}/tree/main/packages/integration_test
[Migrating from flutter_driver]:
    /release/breaking-changes/flutter-driver-migration
[widget tests]: /testing/overview#widget-tests
