---
name: write-flutter
description: >-
  Write, review, or refactor idiomatic Flutter code.
  Use for widgets, state and architecture, lifecycle, layout, theming,
  accessibility, performance, and tests.
  Apply alongside the write-dart skill for Dart guidance.
---

# Write Flutter

Produce Flutter code that is composable,
correct across rebuilds, efficient, and accessible.

This skill builds on the `write-dart` skill:
apply that skill's Dart guidance,
then add the Flutter-specific guidance here.
In the references, **DO** and **DON'T** are near-absolute,
**PREFER** and **AVOID** are strong defaults,
and **CONSIDER** requires judgment.

## Match the project

- **Lints.**
  Follow the configuration in `analysis_options.yaml`.
- **State management.**
  Identify what the project already uses
  such as `setState`, `ChangeNotifier`, provider, or Riverpod,
  and match its approach for shared state.
  Local `setState` can coexist with an app-level state solution.
  Don't add a second package or competing architecture for shared state
  without a concrete requirement.
- **Design system.**
  Reuse the existing theme, tokens, and spacing conventions,
  whether the app is Material, Cupertino, or custom.

## Core defaults

Apply these high-frequency Flutter rules alongside `write-dart`.

### Composition

- Prefer small, single-purpose widget _classes_.
  When a subtree has its own identity,
  extract a named widget instead of a `_buildHeader()` helper.
  Widget classes can be `const`, appear by name in DevTools and error messages,
  limit rebuild scope, and support independent tests.
- Give widgets `const` constructors,
  and use `const` at creation sites wherever possible.
  Reusing the same widget instance lets Flutter
  stop the update traversal at that widget.
- Keep `build` free of side effects and unnecessary work.
  The `build` method can run every frame.
  Don't perform side effects, start requests,
  or create futures, controllers, and other objects with identity.

### State

- Default to `StatelessWidget`.
  When something genuinely changes over time, add state.
- Keep state as low in the tree as possible,
  moving it only to the lowest common ancestor of the widgets that need it.
- Keep significant or reusable business logic out of widgets.
  Widgets render state and forward events.
  Plain Dart classes hold the logic.

### Lifecycle and async

- Dispose controllers, focus nodes, and notifiers that the `State` owns,
  and cancel subscriptions that it creates.
  Don't dispose objects supplied by a parent unless ownership was transferred.
- After an asynchronous gap,
  check `mounted` in a `State` or `context.mounted` for a `BuildContext`
  before calling `setState`, using the context,
  or doing other work that requires the `State` to remain in the tree.
  The `use_build_context_synchronously` lint flags violations.
- For `FutureBuilder` and `StreamBuilder`,
  obtain futures and streams before `build`,
  such as in `initState`, `didUpdateWidget`, or `didChangeDependencies`.
  Refresh them when the inputs change.
  Creating them inline in `build` can restart work on every rebuild.

### Layout

- Use Flutter's constraint model:
  _constraints go down, sizes go up,
  the parent sets the position._
  Use the model to diagnose layout errors.
- Give scrollables inside a `Column` or `Row` bounded space,
  usually with `Expanded`.
  Use `spacing` for uniform main-axis gaps.

### Design and accessibility

- Read shared colors and text styles from the project's theme or token system,
  such as `Theme.of(context)` for Material
  or `CupertinoTheme.of(context)` for Cupertino.
  Avoid duplicating visual constants at use sites.
- Respect system text scaling.
  For intentionally constrained text,
  choose `maxLines` and `overflow` behavior deliberately.
- Meet the target platform's minimum interactive size:
  48 by 48 logical pixels for Material and Android,
  and 44 by 44 for iOS.
  Give meaningful custom interactive or visual elements semantics.

### Performance

- Use `.builder` constructors for long or unbounded lists.
- Rebuild the smallest affected subtree:
  use `const`, extracted widgets,
  and the `child` parameter of `ListenableBuilder` and `AnimatedBuilder`
  for static subtrees.

## Validate

Extend the `write-dart` validation loop with Flutter tools.
When the environment allows it,
run the app and exercise the changed UI.
Check the console for overflow errors, exceptions,
and `setState() called after dispose()` warnings that analysis can't catch.

## References

Read only the references relevant to the code you're writing or reviewing:

- **[Widgets](references/widgets.md)**:
  Composition, constructors, keys, lifecycle, and async safety.
- **[State and architecture](references/state-and-architecture.md)**:
  State placement, mechanism selection, separation of logic,
  and dependency injection.
- **[Layout](references/layout.md)**:
  Layouts, constraint errors, overflow, unbounded height,
  ignored dimensions, and responsive design.
- **[Design](references/design.md)**:
  Theming, text, and accessibility.
- **[Performance](references/performance.md)**:
  Animations, long lists, and frame performance.
- **[Testing](references/testing.md)**:
  Test levels, widget-test mechanics, accessibility checks, and goldens.
