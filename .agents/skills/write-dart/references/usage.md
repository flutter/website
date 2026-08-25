# Dart language usage guidelines

Use these language features effectively inside implementations.

## Libraries and imports

- **PREFER** relative import paths
  between files inside your own package's `lib/` directory:
  `import 'src/utility.dart';`.
- **DON'T** use an import path that enters or leaves `lib/`.
  Code in `test/` or `bin/`
  imports the package's own libraries with `package:` URIs,
  never `../lib/...`.
- **DON'T** import libraries inside another package's `src/` directory.
  They're private implementation details with no stability guarantee.
- **DO** use string URIs in `part of` directives, not library names.

## Null

- **DON'T** explicitly initialize variables to `null`,
  and **DON'T** write `= null` as a default parameter value.
  Nullable declarations already default to `null`.
- **DON'T** compare booleans with `== true` or `== false`.
  For a nullable `bool`, convert explicitly: `if (optional ?? false)`.
- **AVOID** `late` when you would need to _check_ whether it's initialized.
  Dart provides no initialization check,
  and access before initialization throws an error.
  Use a nullable type and check for `null`.
- **CONSIDER** type promotion and null-check patterns before using `!`:

  ```dart
  // Promotion through control flow:
  if (response == null) return;
  use(response); // Promoted to non-nullable.

  // Null-check pattern binds a promoted local:
  if (json case {'name': String name}) return name;
  ```

  Fields and getters don't promote, except _private final fields_,
  so copy other fields to a local variable first or use an if-case statement.

## Strings

- **DO** use adjacent string literals to split long literals across lines.
  You don't need `+`.
- **PREFER** interpolation over concatenation: `'Hello, $name!'`.
- **AVOID** curly braces in interpolation when not needed: `'$name'`,
  but `'${user.name}'` for anything more than a simple identifier.

## Collections

- **DO** use collection literals, including spread, `if`, and `for` elements,
  instead of constructors and imperative building:

  ```dart
  List<String> buildArguments(
    List<String> options,
    String command,
    List<String> filePaths, {
    required bool verbose,
  }) => [
    ...options,
    command,
    if (verbose) '--verbose',
    for (final filePath in filePaths) '--include=$filePath',
  ];
  ```

- **DON'T** use `.length` to test emptiness.
  Use `isEmpty` and `isNotEmpty`,
  which state the intent directly.
- **AVOID** `Iterable.forEach()` with a function literal.
  Use a `for`-in loop.
  Passing an existing function as a tear-off is fine.
- **DON'T** use `List.from()` unless you intend to _change_ the element type.
  Use `.toList()` to copy while preserving it.
- **DO** use `whereType<T>()` to filter by type,
  not `where((e) => e is T)` followed by a cast.
- **AVOID** `cast()`.
  The `cast()` method wraps the collection in a lazily checking view.
  Prefer creating the collection with the right type up front,
  or transform with `List<T>.from()` or `.map()` at a single point.

## Functions

- **DO** use a function declaration to bind a function to a name,
  not `final loudify = (String message) => message.toUpperCase();`.
- **DON'T** write a lambda that only forwards to another function.
  Pass the tear-off:
  `names.forEach(print);`.

## Variables

- **DO** follow one rule for `var` versus `final` locals.
  The `prefer_final_locals` lint means `final` wherever it applies.
  Otherwise, match surrounding code.
- **AVOID** storing what you can calculate.
  Caching can introduce invalidation bugs.
  Compute derived values in a getter until profiling shows a need to cache them.

## Members

- **DON'T** wrap a field in a getter and setter that do nothing else.
  Expose the field.
  You can replace a field with a getter and setter later
  without breaking callers.
- **PREFER** a `final` field over a getter-only wrapper for read-only state.
- **CONSIDER** `=>` for single-expression members
  that fit on one or two lines, especially getters.
  If the body doesn't fit comfortably, use a block.
- **DON'T** use `this.`
  except to redirect to a named constructor or to escape shadowing.
- **DO** initialize fields in their declaration
  if the value doesn't depend on constructor parameters.

## Constructors

- **DO** use initializing formals when a parameter directly initializes a field.
  Don't repeat assignments such as `this.x = x` in the constructor body.
- **DON'T** use `late` when an initializer list can compute the value:

  ```dart
  Point.polar(double theta, double radius)
    : x = cos(theta) * radius,
      y = sin(theta) * radius;
  ```

- **DO** end empty constructor bodies with `;`, not `{}`.
- **DON'T** write `new` at an invocation site.
  For example, call the constructor as `Point()`, not `new Point()`.
- **DON'T** repeat `const` when the context already implies it,
  such as inside a `const` collection or constructor invocation.

## Error handling

- **AVOID** `catch` without an `on` clause: it catches _everything_,
  including bugs such as `TypeError`.
  Catch the specific exception types the code can meaningfully handle.
- **DON'T** silently discard errors from a bare `catch`.
  If one is truly necessary, log, assert, or rethrow.
- **DO** throw `Error` subtypes,
  such as `ArgumentError`, `StateError`, `RangeError`, and `UnsupportedError`,
  only for _programmatic_ misuse:
  bugs that require caller changes,
  not conditions to handle at runtime.
  Use `Exception` implementations for recoverable runtime failures.
- **DON'T** catch `Error` or its subtypes for recovery.
  Let programming bugs surface.
  A top-level reporting boundary can record an error before rethrowing it.
- **DO** use `rethrow` to propagate a caught exception.
  `throw e` resets the stack trace.

## Asynchrony

- **PREFER** `async` and `await` over raw `.then()` chains.
  They make asynchronous control flow resemble synchronous control flow.
- **DON'T** mark a function `async` when it has no useful effect.
  An `async` function that only returns another future adds noise
  and can change error timing.
- **DON'T** ignore a returned `Future`.
  Await it, return it,
  or wrap it in `unawaited(operation())` from `dart:async`
  to record that ignoring it is deliberate.
  The `unawaited` function doesn't handle asynchronous errors,
  so the detached operation must handle them
  or intentionally report them through the current zone.
- **CONSIDER** stream transformers, such as `map`, `where`, and `expand`,
  over manual `listen` and `StreamController` setup.
- **AVOID** `Completer` directly.
  The `Future` constructors and `async` functions cover almost every case.
- **DO** test `is Future<T>` instead of `is T` when
  disambiguating a `FutureOr<T>` whose type argument could be `Object`.
  The value could be both.
