# Flutter state and architecture

Use these rules to place and observe state
while keeping application logic testable.

## State categories

- **Ephemeral state**, also called **local state**, belongs to one subtree:
  the selected tab, a text field's contents, or an animation's progress.
  A `StatefulWidget` with `setState` is enough.
- **Shared state**, also called **app state**, has multiple readers or writers:
  the signed-in user, a cart, or cached data.
  Use a state management approach to coordinate shared state.

Putting state at the wrong level causes problems in both directions:
global stores for a checkbox, or long `setState` chains for application data.

## State placement

- **DO** keep state at the _lowest common ancestor_ of the widgets that need it:
  as low as possible, as high as necessary.
- State placed too high rebuilds large subtrees and couples unrelated features.
  State placed too low gets duplicated and drifts.
- When only one distant descendant needs a value,
  pass it through constructors first.
  When passing the value crosses several layers that don't use it,
  use inherited propagation.

## State mechanism selection

Choose the least complex mechanism that meets the sharing,
lifecycle, update-frequency, and testing requirements:

- Use `setState` for state owned by one subtree.
- Use a `ValueNotifier`, `ChangeNotifier`, or another `Listenable`
  when a small, independently testable object owns observable state.
- Use inherited propagation when descendants need a dependency or value
  without intermediate widgets forwarding it.
- Use the project's state-management package for application state.

These options aren't an upgrade sequence.
For example, an app that uses Riverpod for shared state
can still use `setState` for a local animation or disclosure.

**DO** match the project's existing approach for shared state.
Don't add a second package or architecture for shared state
without a concrete requirement.
In a new app,
choose based on actual requirements rather than example popularity.

## Separation of logic and widgets

Follow unidirectional data flow: _state flows down, events flow up._

- **Widgets** form the view, render state, and forward user events.
  Keep their callbacks as delegation, such as `onPressed: viewModel.submit`.
- **View models or controllers** hold UI state and presentation logic
  as plain Dart.
  They expose state through getters and intent through methods.
  They don't depend on `BuildContext` or widgets,
  so you can unit test them without a widget tree.
- **Repositories and services** own data access,
  such as network and storage access,
  and hide its details from view models.

**DON'T** put branching business logic in `build` methods or event handlers.
Otherwise, testing prices or business rules requires pumping a widget tree.

## Immutable state

- **PREFER** exposing state as immutable snapshots
  with `final` fields and unmodifiable or copied collections.
  Create new state objects instead of mutating existing objects in place.
- A sealed class hierarchy with `Loading`, `Data`, and `Error` states
  and an exhaustive `switch`
  prevents the impossible combinations that nullable flags allow.
  For additional guidance,
  see [Modern Dart idioms](../../write-dart/references/modern-dart.md).

## Dependency injection

- **DO** make dependencies explicit at construction or composition boundaries
  instead of reading them from globals.
  Use constructor injection for plain Dart objects and direct widget inputs.
  Use inherited propagation for dependencies shared by a subtree.
  Both approaches make fakes straightforward to supply in tests.
- **AVOID** global singletons
  and service-locator lookups throughout the code.
  If the project uses a locator,
  confine lookups to composition roots, where you construct objects,
  not inside feature logic.
