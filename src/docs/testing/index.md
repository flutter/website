---
title: Testing Flutter apps
description: Learn more about the different types of testing and how to write them.
---

The more features your app has, the harder it is to test manually.
Automated tests help ensure that your app performs correctly before
you publish it, while retaining your feature and bug fix velocity.

{{site.alert.note}}
  For hands-on practice of testing Flutter apps, see the
  [How to test a Flutter app][] codelab.
{{site.alert.end}}

Automated testing falls into a few categories:

* A [_unit test_](#unit-tests) tests a single function, method, or class.
* A [_widget test_](#widget-tests) (in other UI frameworks referred to
  as _component test_) tests a single widget.
* An [_integration test_](#integration-tests)
  tests a complete app or a large part of an app.

Generally speaking, a well-tested app has many unit and widget tests,
tracked by [code coverage][], plus enough integration tests
to cover all the important use cases. This advice is based on
the fact that there are trade-offs between different kinds of testing,
seen below.

|                      | Unit   | Widget | Integration |
|----------------------|--------|--------|-------------|
| **Confidence**       | Low    | Higher | Highest     |
| **Maintenance cost** | Low    | Higher | Highest     |
| **Dependencies**     | Few    | More   | Most        |
| **Execution speed**  | Quick  | Quick  | Slow        |
{:.table.table-striped}


## Unit tests

A _unit test_ tests a single function, method, or class.
The goal of a unit test is to verify the correctness of a
unit of logic under a variety of conditions.
External dependencies of the unit under test are generally
[mocked out](/cookbook/testing/mocking).
Unit tests generally don't read from or write
to disk, render to screen, or receive user actions from
outside the process running the test.
For more information regarding unit tests, 
you can view the following recipes 
or run `flutter test --help` in your terminal.

### Recipes

{% include testing_toc.md type='unit' %}

## Widget tests

A _widget test_ (in other UI frameworks referred to as _component test_)
tests a single widget. The goal of a widget test is to verify that the
widget's UI looks and interacts as expected. Testing a widget involves
multiple classes and requires a test environment that provides the
appropriate widget lifecycle context.

For example, the Widget being tested should be able to receive and
respond to user actions and events, perform layout, and instantiate child
widgets. A widget test is therefore more comprehensive than a unit test.
However, like a unit test, a widget test's environment is replaced with
an implementation much simpler than a full-blown UI system.

### Recipes

{% include testing_toc.md type='widget' %}

## Integration tests

An _integration test_ tests a complete app or a large part of an app.
The goal of an integration test is to verify that all the widgets
and services being tested work together as expected.
Furthermore, you can use integration
tests to verify your app's performance.

Generally, an _integration test_ runs on a real device or an OS emulator,
such as iOS Simulator or Android Emulator.
The app under test is typically isolated
from the test driver code to avoid skewing the results.

For more information on how to write integration tests, see the [integration
testing page][].

### Recipes

{% include testing_toc.md type='integration' %}

## Continuous integration services

Continuous integration (CI) services allow you to run your
tests automatically when pushing new code changes.
This provides timely feedback on whether the code
changes work as expected and do not introduce bugs.

For information on running tests on various continuous
integration services, see the following:

* [Continuous delivery using fastlane with Flutter][]
* [Test Flutter apps on Appcircle][]
* [Test Flutter apps on Travis][]
* [Test Flutter apps on Cirrus][]
* [Codemagic CI/CD for Flutter][]
* [Flutter CI/CD with Bitrise][]


[code coverage]: https://en.wikipedia.org/wiki/Code_coverage
[Codemagic CI/CD for Flutter]: https://blog.codemagic.io/getting-started-with-codemagic/
[Continuous delivery using fastlane with Flutter]: /docs/deployment/cd#fastlane
[Flutter CI/CD with Bitrise]: https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/
[How to test a Flutter app]: {{site.codelabs}}/codelabs/flutter-app-testing
[mocked out]: /cookbook/testing/mocking
[Test Flutter apps on Appcircle]: https://appcircle.io/blog/guide-to-automated-mobile-ci-cd-for-flutter-projects-with-appcircle/#testing-the-flutter-app
[Test Flutter apps on Cirrus]: https://cirrus-ci.org/examples/#flutter
[Test Flutter apps on Travis]: {{site.flutter-medium}}/test-flutter-apps-on-travis-3fd5142ecd8c
[integration testing page]: /docs/testing/integration-tests
