---
title: An introduction to unit testing
description: How to write unit tests.
shortTitle: Introduction
---

<?code-excerpt path-base="cookbook/testing/unit/counter_app"?>

How can you ensure that your app continues to work as you
add more features or change existing functionality?
By writing tests.

Unit tests are handy for verifying the behavior of a single function,
method, or class. The [`test`][] package provides the
core framework for writing unit tests, and the [`flutter_test`][]
package provides additional utilities for testing widgets.

This recipe demonstrates the core features provided by the `test` package
using the following steps:

  1. Add the `test` or `flutter_test` dependency.
  2. Create a test file.
  3. Create a class to test.
  4. Write a `test` for our class.
  5. Combine multiple tests in a `group`.
  6. Run the tests.

For more information about the test package,
see the [test package documentation][].

## 1. Add the test dependency

The `test` package provides the core functionality for 
writing tests in Dart. This is the best approach when
writing packages consumed by web, server, and Flutter apps.

To add the `test` package as a dev dependency,
run `flutter pub add`:

```console
$ flutter pub add dev:test
```

## 2. Create a test file

In this example, create two files: `counter.dart` and `counter_test.dart`.

The `counter.dart` file contains a class that you want to test and
resides in the `lib` folder. The `counter_test.dart` file contains
the tests themselves and lives inside the `test` folder.

In general, test files should reside inside a `test` folder
located at the root of your Flutter application or package.
Test files should always end with `_test.dart`,
this is the convention used by the test runner when searching for tests.

When you're finished, the folder structure should look like this:

```plaintext
counter_app/
  lib/
    counter.dart
  test/
    counter_test.dart
```

## 3. Create a class to test

Next, you need a "unit" to test. Remember: "unit" is another name for a
function, method, or class. For this example, create a `Counter` class
inside the `lib/counter.dart` file. It is responsible for incrementing
and decrementing a `value` starting at `0`.

<?code-excerpt "lib/counter.dart"?>
```dart
class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}
```

**Note:** For simplicity, this tutorial does not follow the "Test Driven
Development" approach. If you're more comfortable with that style of
development, you can always go that route.

## 4. Write a test for our class

Inside the `counter_test.dart` file, write the first unit test. Tests are
defined using the top-level `test` function, and you can check if the results
are correct by using the top-level `expect` function.
Both of these functions come from the `test` package.

<?code-excerpt "test/counter_test.dart"?>
```dart
// Import the test package and Counter class
import 'package:counter_app/counter.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
```

## 5. Combine multiple tests in a `group`

If you want to run a series of related tests,
use the `flutter_test` package [`group`][] function to categorize the tests.
Once put into a group, you can call `flutter test` on all tests in
that group with one command.

<?code-excerpt "test/group.dart"?>
```dart
import 'package:counter_app/counter.dart';
import 'package:test/test.dart';

void main() {
  group('Test start, increment, decrement', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
```

## 6. Run the tests

Now that you have a `Counter` class with tests in place,
you can run the tests.

### Run tests using IntelliJ or VSCode

The Flutter plugins for IntelliJ and VSCode support running tests.
This is often the best option while writing tests because it provides the
fastest feedback loop as well as the ability to set breakpoints.

- **IntelliJ**

  1. Open the `counter_test.dart` file
  1. Go to **Run** > **Run 'tests in counter_test.dart'**.
     You can also press the appropriate keyboard shortcut for your platform.

- **VSCode**

  1. Open the `counter_test.dart` file
  1. Go to **Run** > **Start Debugging**.
     You can also press the appropriate keyboard shortcut for your platform.

### Run tests in a terminal

To run the all tests from the terminal,
run the following command from the root of the project:

```console
flutter test test/counter_test.dart
```

To run all tests you put into one `group`,
run the following command from the root of the project:

```console
flutter test --plain-name "Test start, increment, decrement"
```

This example uses the `group` created in **section 5**.

To learn more about unit tests, you can execute this command:

```console
flutter test --help
```

[`group`]: {{site.api}}/flutter/flutter_test/group.html
[`flutter_test`]: {{site.api}}/flutter/flutter_test/flutter_test-library.html
[`test`]: {{site.pub-pkg}}/test
[test package documentation]: {{site.pub}}/packages/test
