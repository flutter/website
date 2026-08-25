---
name: write-dart
description: >-
  Write, review, or refactor correct, idiomatic Dart code.
  Use for Dart source, packages, snippets, tests, public APIs,
  documentation examples, and modern language features.
  Pair with the write-flutter skill for Flutter-specific concerns.
---

# Write Dart

Produce clear, correct, idiomatic Dart.
Reference the  `write-technical-docs` skill when authoring
explanatory prose and documentation comments.
Two principles guide the code rules:

- **Be consistent.** Make different-looking code mean something different.
- **Be brief.** Prefer concise Dart idioms, but don't make code dense.

In the references, **DO** and **DON'T** are near-absolute,
**PREFER** and **AVOID** are strong defaults,
and **CONSIDER** requires judgment.

## Match the project

- Follow the project's `analysis_options.yaml` and surrounding conventions.
- Before using a recent language feature,
  check the lower SDK constraint in `pubspec.yaml`.
  The installed SDK might support syntax that the package doesn't.

## Core defaults

Apply these high-frequency rules while writing.

### Naming

- Use `UpperCamelCase` for types and extensions,
  `lowerCamelCase` for members, variables, and constants,
  and `lowercase_with_underscores` for files, packages, and import prefixes.
  For example, write `defaultTimeout`, never `DEFAULT_TIMEOUT`.
- Name booleans as positive, non-imperative verb phrases
  such as `isEmpty` and `canClose`.
- Name value-returning members as noun phrases such as `pageCount`.
- Name side-effecting functions as imperative verbs such as `removeLast()`.
  Never prefix an accessor with `get`.

### Types

- Annotate return and parameter types on function and method declarations.
  Signatures are API documentation.
- Don't annotate types that inference can determine:
  initialized locals, lambda parameters, initializing formals,
  and inferable type arguments.
- Use `Object?` to mean "any value".
  Reserve `dynamic` for deliberately disabling static checking.

### Null safety and immutability

- When possible,
  make fields and top-level variables `final`.
- When a constructor supports it,
  make the constructor `const`.
- Use `late` when initialization genuinely happens after construction
  or lazily on first access.
  If code needs to ask whether initialization happened,
  use a nullable type and check for `null` instead.
- When absence has no meaning distinct from "empty",
  return an empty collection or stream instead of `null`.
  Use a nullable return type only when absence is a real state
  that callers must distinguish.

### Control flow and errors

- Switch over enums and sealed types without a `default` or `_` case,
  so adding a new case becomes a compile-time error everywhere it's handled.
- Catch specific types with `on`.
  Never discard errors without handling them.
  Use `rethrow`, not `throw e`.
  Throw `Error` subtypes only for programming bugs and
  don't catch them for recovery.

### Functions and async

- Prefer named parameters for booleans
  and for arguments that are unclear at the call site.
  For example, write `resize(width: 320, keepAspect: true)`.
- Use `async` and `await` over raw `.then()` chains,
  and account for every returned `Future`.
  Await or return the future.
  If an operation is intentionally detached,
  wrap it in `unawaited(operation())`
  and make its error behavior deliberate.

## Write maintainable code

- Keep functions small and single-purpose.
  Prefer a clear name to an explanatory comment.
- Use the type system to prevent invalid states with
  sealed class hierarchies, extension types, and non-nullable types
  instead of runtime conventions and documentation.
- Avoid unnecessary complexity:
  don't add parameters, options,
  or abstractions without a concrete requirement.

## Use modern Dart

Use modern features when they improve type safety or remove boilerplate
without obscuring the example.
Check the package's SDK constraint,
then read [Modern Dart idioms](references/modern-dart.md)
for version requirements and examples.

## Validate

When an SDK and project are available,
format changed files, run `dart analyze`, and run the relevant tests.
Use `flutter test` instead of `dart test` for Flutter code.
For standalone snippets, check the relevant reference and
compile them when practical.

## References

Read only the references relevant to the code you're writing or reviewing:

- **[Style](references/style.md)**:
  Naming identifiers, organizing imports and exports,
  and layout decisions the formatter doesn't handle.
- **[Documentation](references/documentation.md)**:
  Read before writing doc comments or reviewing comment quality.
- **[Usage](references/usage.md)**:
  Imports, null handling, strings, collections, members,
  constructors, errors, and async.
- **[Public API design](references/design.md)**:
  Public API design, including names, classes, signatures,
  annotations, parameters, and equality.
- **[Modern Dart idioms](references/modern-dart.md)**:
  Recent language features, version constraints, and examples.
