---
title: An introduction to unit testing
short-title: Introduction
---

How can we ensure that our apps continue to work as we add more features or
change existing functionality? By writing tests!

Unit tests are handy for verifying the behavior of a single function, method, or
class. The [`test`]({{site.pub-pkg}}/test) package provides the
core framework for writing unit tests, and the
[`flutter_test`]({{site.api}}/flutter/flutter_test/flutter_test-library.html)
package provides additional utilities for testing Widgets.

This recipe demonstrates the core features provided by the `test` package. For
more information about the test package, please see the
[test package documentation](https://github.com/dart-lang/test/blob/master/README.md).

## Directions

  1. Add the `test` or `flutter_test` dependency
  2. Create a test file
  3. Create a class to test
  4. Write a `test` for our class
  5. Combine multiple tests in a `group`
  6. Run the tests

## 1. Add the test dependency

If we're working on a Dart package that does not depend on Flutter, we
can import the `test` package. The test package provides the core functionality
for writing tests in Dart. This is the best approach when writing packages that
will be consumed by web, server, and Flutter apps.

```yaml
dev_dependencies:
  test: <latest_version>
```

If we're working on a package that will only be used for Flutter apps, or if
we need to write Widget tests, we can depend on the `flutter_test` package
instead. It will also include everything from the `test` package, as well as
additional utilities for testing Widgets.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```


## 2. Create a test file

In this example, we'll create two files: `counter.dart` and `counter_test.dart`.

The `counter.dart` file will contain a class we want to test and will reside in
the `lib` folder. The `counter_test.dart` file will contain the tests
themselves and will live inside the `test` folder!

In general, test files should reside inside a `test` folder located at the root
of your Flutter application or package.

When we're finished, our folder structure should look like this:

```
counter_app/
  lib/
    counter.dart
  test/
    counter_test.dart
```

## 3. Create a class to test

Next, we'll need a "unit" to test. Remember: "unit" is a fancy name for a
function, method or class. In this example, we'll create a `Counter` class
inside the `lib/counter.dart` file. It will be responsible for incrementing and
decrementing a `value` starting at `0`.

<!-- skip -->
```dart
class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}
```

**Note:** For simplicity, this tutorial does not follow the "Test Driven
Development" approach. If you're more comfortable with that style of
development, you can always go that route!

## 4. Write a test for our class

Inside the `counter_test.dart` file, we can write our first unit test! Tests are
defined using the top-level `test` function, and we can check if the results are
correct by using the top-level `expect` function. Both of these functions come
from the `test` package.

<!-- skip -->
```dart
// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:counter_app/counter.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
```

## 5. Combine multiple tests in a `group`

If we have several tests which are related to one another, it can be handy
to combine them using the `group` function provided by the `test` package.

<!-- skip -->
```dart
import 'package:test/test.dart';
import 'package:counter_app/counter.dart';

void main() {
  group('Counter', () {
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

### 6. Run the tests

Now that we have a `Counter` class with tests in place, we can run the tests!

#### Run tests using IntelliJ or VSCode

The Flutter plugins for IntelliJ and VSCode support running tests. This is often
the best option while writing tests because it provides the fastest feedback
loop as well as the ability to set breakpoints.

  * **IntelliJ**
    1. Open the `counter_test.dart` file
    2. Select the `Run` menu
    3. Click the `Run 'tests in counter_test.dart'` option
    4. *Alternatively, use the appropriate keyboard shortcut for your platform!*
  * **VSCode**
    1. Open the `counter_test.dart` file
    2. Select the `Debug` menu
    3. Click the `Start Debugging` option
    4. *Alternatively, use the appropriate keyboard shortcut for your platform!*

#### Run tests in a terminal

We can also use a terminal to run our tests by executing the following
command from the root of the project:

```
flutter test test/counter_test.dart
```
