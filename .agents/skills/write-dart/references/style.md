# Dart code style

Use these rules for names, directives,
and layout decisions that `dart format` doesn't make for you.

## Identifiers

| Convention | Applies to | Examples |
| --- | --- | --- |
| `UpperCamelCase` | Classes, enums, typedefs, extensions, extension types, type parameters | `HttpRequest`, `Predicate<T>` |
| `lowerCamelCase` | Variables, parameters, members, constants, enum values, named parameters | `itemCount`, `defaultTimeout`, `Status.running` |
| `lowercase_with_underscores` | Packages, directories, source files, import prefixes | `angular_components`, `file_system.dart`, `as math` |

- **PREFER** `lowerCamelCase` for constants,
  including enum values and `const` declarations:
  `const defaultTimeout = Duration(seconds: 5);`.
  `SCREAMING_CAPS` isn't idiomatic Dart.
- **DO** capitalize acronyms and abbreviations longer than
  two letters like words:
  `HttpRequest`, `JsonDecoder`, not `HTTPRequest`.
  Keep two-letter _acronyms_ fully capitalized, as in `IOStream`,
  but treat two-letter _abbreviations_ like words.
  For example, `Id` and `userId`.
- **PREFER** the wildcard `_` for unused callback parameters:
  `stream.listen((_) => count++);`.
  Because `_` is non-binding, multiple parameters can all be `_`.
- Except for the wildcard `_`,
  **DON'T** use a leading underscore
  for identifiers that aren't private declarations.
  A leading `_` means library-private in Dart.
  On locals and parameters it is misleading.
- **DON'T** use prefix letters or Hungarian-style notation:
  don't use `kMaxCount`, `mValue`, or `s_instance`.
  Types and context convey the same information.
- **DON'T** explicitly name libraries.
  If you need a `library` directive to attach doc comments or annotations,
  leave it unnamed: `library;`.

## Naming files

Name a file after its primary declaration,
converted to `lowercase_with_underscores`:
for example, use `http_request.dart` for `HttpRequest`.
Multiple closely related declarations can share a file.
Dart has no one-type-per-file rule.

## Ordering directives

Keep the top of each file in this order,
each section separated by a blank line and sorted alphabetically within itself:

```dart
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';

import 'sibling.dart';
import 'src/utility.dart';

export 'src/public_api.dart';
```

1.  `dart:` imports first.
1.  `package:` imports next.
1.  Relative imports after.
1.  All `export` directives in a separate, final section.

The `directives_ordering` lint enforces this.

## Formatting

- **DO** format all code with `dart format`.
  Treat the formatter's output as canonical.
- **PREFER** lines of 80 characters or fewer.
  The formatter uses this by default.
  A project can change it with `page_width` in
  the `formatter` section of `analysis_options.yaml`.
- **CONSIDER** revising code instead of accepting awkward formatter output:
  shorten a local name, move a subexpression into a named local,
  or split a long function chain.
- **DO** use curly braces for all flow control statements:

  ```dart
  if (isOverflowing) {
    flush();
  }
  ```

  _Exception:_ If an `if` has no `else`
  and the whole statement fits on one line,
  it can omit braces:

  ```dart
  if (arg == null) return defaultValue;
  ```
