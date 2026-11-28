# Dart comments and doc comments

Use these rules to write clear comments and `dart doc` comments
that follow core library conventions.

## Regular comments

- **DO** format comments like sentences:
  capitalize the first word and end with a period.
- Use `//` for implementation comments that explain _why_, not _what_.
  If you need a "what" comment,
  improve the code's name or structure instead.

## Doc comment mechanics

- **DO** use `///` for doc comments on members and types.
  Never use `/** ... */` blocks or Javadoc-style tags.
- **PREFER** doc comments on public APIs.
  **CONSIDER** them for private APIs and for library-level comments on unnamed
  `library;` directives.
- **DO** place doc comments _before_ metadata annotations:

  ```dart
  /// Whether the connection retries after a timeout.
  @override
  bool get retries => _retries;
  ```

## Structure and phrasing

- **DO** start with a concise, single-sentence summary.
  Separate it from the rest with a blank line.
  Tools use the first paragraph as the short description.
- **AVOID** redundancy with the surrounding context.
  Readers can see the class name and signature.
  Don't restate them.
  For example, `/// The [Foo] class ...` says nothing.
- Match the phrase form to the declaration and its primary purpose:

  | Declaration or primary purpose | Start with | Example |
  | --- | --- | --- |
  | Function or method whose main purpose is a side effect | Third-person verb | `/// Starts the stopwatch if it isn't already running.` |
  | Non-boolean variable or property | Noun phrase | `/// The current day of the week.` |
  | Boolean variable or property | "Whether" + noun or gerund phrase | `/// Whether this list is empty.` |
  | Non-boolean function or method whose primary purpose is returning a value | Noun phrase or non-imperative verb phrase | `/// The [index]th element of this iterable in iteration order.` |
  | Boolean function or method whose primary purpose is returning a value | "Whether" + noun or gerund phrase | `/// Whether this iterable contains an element equal to [element].` |
  | Library or type | Noun phrase | `/// A chunked reader for byte streams.` |

- **DON'T** document both the getter and setter of a property.
  `dart doc` treats the pair as one field and retains only one comment.
  Document the getter.
- When referring to the member's own instance,
  **PREFER** "this" over "the":
  `/// Deletes this file.`

## Referencing and explaining

- **DO** use square brackets to reference in-scope identifiers.
  The `dart doc` command then links them:
  `/// Similar to [anotherMethod], but validates the result.`
- Add a `@docImport` to the library doc comment
  when documentation needs to reference an external declaration
  that the implementation doesn't import.
  Don't add a runtime import only to create documentation links.
- **DO** explain parameters, return values, and exceptions in prose.
  Weave them into sentences instead of using tag-style lists:

  ```dart
  abstract interface class Flag {}

  abstract interface class FlagRegistry {
    /// Defines a flag with the given [name] and [abbreviation].
    ///
    /// Throws an [ArgumentError] if an option already uses [name].
    Flag addFlag(String name, String abbreviation);
  }
  ```

- **CONSIDER** a short code sample when
  behavior is easier to show than describe.
- **PREFER** brevity.
- **AVOID** abbreviations unless the audience is familiar with them.

## Markdown in doc comments

- **AVOID** extensive Markdown formatting.
  Headings, deep nesting, and horizontal rules rarely improve API documentation.
- **AVOID** HTML for ordinary formatting.
  Use only HTML or dartdoc directives that the target renderer supports
  when Markdown can't express the necessary semantics.
- **PREFER** fenced code blocks with a language tag
  so tools can highlight and analyze them:

  ````dart
  /// ```dart
  /// final auth = Authorization.basic('user', 'pass');
  /// ```
  ````
