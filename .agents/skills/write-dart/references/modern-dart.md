# Modern Dart idioms

When modern Dart features move errors from runtime to compile time
or reduce boilerplate without hurting clarity, prefer them.
This reference covers features available in recent stable versions of Dart.
Before using a feature,
confirm that the project's SDK constraint supports it.

## Primary and concise constructors

For a library with a language version of at least 3.13,
consider a primary constructor when a type mainly declares fields
and initializes them from parameters:

```dart
class Point(final int x, final int y);
```

The `final` or `var` modifier declares and initializes a field.
An unmodified parameter is available to initializers
but doesn't declare a field.
Keep a traditional class body when it makes nontrivial initialization,
validation, or API documentation easier to understand.

For constructors declared inside the class body,
prefer the concise declaration syntax in Dart 3.13 and later:

```dart
class Point {
  final int x;
  final int y;

  new(this.x, this.y);
  new origin() : x = 0, y = 0;
}
```

Use `new` for generative constructor declarations
and `factory` for factory constructor declarations.
At call sites, continue to write `Point(1, 2)` and `Point.origin()`.
Don't write `new Point(1, 2)`.

## Records

Use records for multiple return values and lightweight local grouping,
instead of out-parameters, `List<Object>` values, or one-off result classes:

```dart
(double min, double max) bounds(List<double> sortedValues) =>
    (sortedValues.first, sortedValues.last);

void main() {
  final samples = [1.2, 3.4, 2.1]..sort();
  final (min, max) = bounds(samples);
  print('$min-$max');
}
```

Named fields, as in `({int width, int height})`,
make roles clearer than positional fields after two values.
For a public API result that needs a name and doc comments,
a class is often more appropriate.
Use records for private and local data flow.

## Patterns and switch expressions

- When each case maps to a value,
  use a `switch` _expression_:

  ```dart
  final color = switch (level) {
    Level.debug => 'gray',
    Level.warning => 'orange',
    Level.error => 'red',
  };
  ```

- **Keep switches over enums and sealed types exhaustive
  without a `default` or `_` case.**
  A wildcard handles later cases without a diagnostic.
  An exhaustive switch reports a compile-time error at every site
  that must handle a new case.

- Use `if`-case to match and destructure in one step:

  ```dart
  if (json case {'name': String name, 'age': int age}) {
    return Person(name, age);
  }
  ```

  Add `when` guards to cases that need a condition.

- Destructure in declarations, such as in
  `final (a, b) = pair;` or `final [first, ...rest] = items;`.

- Prefer patterns over chains of `is` checks with manual casts.
  Promotion and destructuring do the casting safely.

## Sealed hierarchies and class modifiers

Model closed unions with `sealed` and let the compiler verify handling:

```dart
import 'dart:math' show pi;

sealed class Shape {}

class Circle extends Shape {
  Circle(this.radius);
  final double radius;
}

class Square extends Shape {
  Square(this.side);
  final double side;
}

double area(Shape shape) => switch (shape) {
  Circle(:final radius) => pi * radius * radius,
  Square(:final side) => side * side,
};
```

This model replaces enum-plus-nullable-payload structs and untyped `is` chains,
and makes missed cases compile-time errors.

For a public class whose subtyping boundary matters,
choose `final`, `interface`, or `base` deliberately.
For additional guidance, see [Public API design](design.md).

## Extension types

Use an extension type to distinguish values with the same representation
without allocating a wrapper object at runtime:

```dart
extension type UserId(int value) {
  bool get isValid => value > 0;
}

extension type ProductId(int value) {}
```

Static checking prevents accidental swaps between `UserId` and `ProductId`.
Use extension types for typed IDs, units,
restricted static interfaces, and interop wrappers.
The wrapper is erased at runtime,
so `is` and `as` operate on the representation type.
In this example, the representation type is `int`,
so extension types enforce discipline statically, not at runtime.
Don't assume that an extension type provides runtime identity or validation.

## Dot shorthands

When the context type makes the type name unambiguous,
omit the name:

```dart
enum Status { idle, running, stopped }

Status current = .running;
final StringBuffer buffer = .new();

String label(Status status) => switch (status) {
  .idle => 'Idle',
  .running => 'Running',
  .stopped => 'Stopped',
};
```

Use dot shorthands for enum values in switches, assignments, and arguments,
and for `.new()` in explicitly typed declarations.
If the context type isn't close and clear,
write the type name.
Prioritize clarity over brevity.
`x == .value` works, but `.value == x` doesn't:
the shorthand must be on the right side of `==` and `!=`.

## Additional features

- **Private-named constructor parameters:**
  Requires Dart 3.12 or later.
  Use syntax like `Config({required this._theme});`
  to initialize private `_theme` from the public named argument `theme:`.
  This applies only to named initializing formals.
- **Private final field promotion:**
  If `_cache` is private and `final`,
  and no conflicting declaration prevents promotion,
  `if (_cache != null)` promotes it without a local copy or `!`.
- **Digit separators:**
  Requires Dart 3.6 or later.
  For example, `const budget = 1_000_000;`.
- **Wildcard variables:**
  Requires Dart 3.7 or later.
  `_` doesn't bind,
  so `(_, _) => 0` can use multiple wildcards,
  and `catch (_)` can ignore an exception parameter.
- **Null-aware elements:**
  Requires Dart 3.8 or later.
  `[?maybeNull]` includes the element only when non-null.
  This replaces `if (x != null) x` in collection literals.
