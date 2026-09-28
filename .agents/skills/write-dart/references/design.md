# Design Dart APIs

Use these rules to design public APIs
that are difficult to misuse and practical to maintain.

## Names

- **DO** use terms consistently across an API: one concept, one word.
  Don't mix `fetch`, `load`, and `get` for the same operation.
- **AVOID** abbreviations unless they're
  more common than the full word.
  For example, `id` and `max` are fine.
  `cnt` and `idx` are not.
- **PREFER** putting the most descriptive noun last:
  `pageCount` rather than `numPages`,
  and `ConversionSink` rather than `SinkForConversion`.
- **CONSIDER** naming APIs so call sites resemble sentences
  such as `if (errors.isEmpty)` and `subscription.cancel()`.

## Libraries and privacy

- **PREFER** making declarations private, such as `_name`.
  Every public declaration is a commitment:
  you must document it, keep it backward-compatible,
  and consider it in every change.
- **CONSIDER** declaring multiple closely related classes in the same library.
  Dart has no one-type-per-file rule.
  Prioritize cohesion over file count.

## Classes and mixins

- **AVOID** defining a one-member abstract class when
  a function type is sufficient, such as
  `typedef Predicate<E> = bool Function(E element);`.
- **AVOID** extending a class unless its API documents subclassing as supported
  or declares the class `base` to require inheritance-based reuse.
  A class with no modifier is syntactically extensible,
  but that alone doesn't guarantee a stable subclassing contract.
  An override can break when maintainers change a class
  that doesn't support subclassing.
- **DO** state the intended external subtyping boundary
  for public classes where that boundary matters:
  `sealed` for a closed family of direct subtypes,
  `final` to prohibit external subtyping,
  `interface` to allow external implementation but not extension,
  and `base` to allow external extension but not implementation.
  Omit these modifiers when allowing both extension and implementation
  is an intentional part of the API.
- **DO** use `mixin` to declare a mixin.
  Don't rely on mixing in a plain class.
- **PREFER** composition over inheritance for code reuse.
  Reserve subtyping for genuine is-a relationships.

## Constructors

- **CONSIDER** a primary constructor
  when it makes a straightforward type clearer and more concise.
- **CONSIDER** making constructors `const` when the class supports it.
  Callers can then use the constructor in `const` contexts.
- **PREFER** named constructors over static factory methods:
  `Point.polar(...)`, not `Point.createPolar(...)`.
  Static constants such as `Duration.zero` are fine.
- **DO** use `factory` constructors when construction can
  return a cached instance or a subtype.

## Members

- **PREFER** making fields and top-level variables `final`.
  Use mutable state intentionally.
- **DO** use getters for operations that conceptually access a property
  and are inexpensive, idempotent, and without visible side effects,
  and setters for operations that conceptually set a property.
  Anything else is a method.
- **DON'T** define a setter without a corresponding getter.
- **AVOID** returning `this` from methods to create fluent chains.
  Dart has cascades: `buffer..write('a')..write('b');`.
- **AVOID** returning nullable `Future`, `Stream`, and collection types.
  For an asynchronously computed optional value,
  return `Future<T?>` instead of `Future<T>?`.
  When appropriate,
  return an empty stream or collection.
  Otherwise, model absence explicitly in the return type.

## Parameters

- **AVOID** positional boolean parameters.
  `Task(true)` is unreadable.
  Require a name: `Task(isUrgent: true)`.
  When the flag selects behavior,
  use an enum or two named constructors.
- **AVOID** a positional parameter that call sites commonly omit.
  Make it named so callers pass only what they mean.
- **DO** use inclusive start and exclusive end for ranges,
  matching `String.substring` and `List.sublist`.

## Types in APIs

- **DO** annotate types on every public declaration:
  fields, top-level variables, and full function signatures.
  Inference changes when implementation changes.
  Annotations keep the API stable and self-documenting.
- **AVOID** the bare `Function` type for callbacks.
  Write the full signature, such as:
  `void Function(int index) onTap`.
- **DON'T** specify a return type for a setter.
  It's always `void`.
- **AVOID** `FutureOr<T>` as a return type.
  Make the function consistently synchronous with a `T` return type
  or asynchronous with a `Future<T>` return type
  so call sites have a consistent return type.
  Accepting `FutureOr<T>` as a parameter is fine.
- **AVOID** `dynamic` anywhere in a public signature.
  Use `Object?` for "any value" so callers must check before use.

## Equality

- **DO** override `hashCode` whenever you override `==`,
  and keep them consistent:
  equal objects must have equal hash codes.
- **DO** make `==` an equivalence relation:
  reflexive, symmetric, and transitive.
  Comparing across subtypes usually breaks symmetry.
- **AVOID** custom equality on mutable classes.
  A mutated object silently corrupts any hash-based collection that contains it.
- **DON'T** check for `null` in `==`.
  The parameter is non-nullable `Object`.
