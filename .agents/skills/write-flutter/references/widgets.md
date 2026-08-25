# Flutter widget composition and lifecycle

How to structure widgets so they stay correct across rebuilds.

## Composition

- **PREFER** many small, single-purpose widget classes over fewer large ones.
  Flutter's model relies on composing small widgets.
- **PREFER** a named widget class over a private
  `Widget _buildHeader()` helper method
  when the subtree has its own identity or rebuild boundary.
  A class can be `const`, can limit rebuild scope,
  appears by name in DevTools and error traces,
  and supports isolated tests.
  A short, one-use helper can remain a method
  when extracting it wouldn't add a meaningful boundary.
- **CONSIDER** extracting whenever a subtree is
  deep enough to name, reused, or independently rebuilt.
  If `build` needs structural comments, decompose it.

## Widget constructors

- **DO** make every field `final` and the constructor `const` when possible.
  A widget is immutable _configuration_, not mutable view state.
- **DO** accept and forward a key:
  `const ProfileCard({required this.profile, super.key});`.
- **PREFER** named parameters beyond a single positional parameter
  whose meaning is clear at the call site,
  matching the framework's style.
  When no sensible default exists, use `required`.

## Stateless versus stateful

- **PREFER** `StatelessWidget`.
  Use `State` only for values that change over time
  _and_ belong to this subtree:
  a text field's contents, an animation, a toggled disclosure.
- **DON'T** use `StatefulWidget`
  as a place for logic or dependencies that never change.
  Pass them through the constructor.
- Keep each `State` small.
  If a `State` class manages several unrelated pieces of state,
  split the widget.

## Pure build methods

`build` can run on every frame,
including during animations, keyboard appearance, or parent rebuilds.
The `build` method must be a pure function
of the widget, its state, and inherited data:

- **DON'T** perform side effects:
  no network calls, writes to storage, state mutations, or `Navigator` calls.
- **DON'T** create objects with identity in `build`,
  such as controllers, focus nodes, futures, streams, or view models.
  Create them in a field or the appropriate lifecycle method
  so they survive rebuilds and refresh when their inputs change.
- **AVOID** CPU-intensive computation in `build`.
  When profiling shows meaningful work,
  compute or cache it outside `build` and update it when its inputs change.
  Don't store inexpensive derived values merely to avoid recalculating them.

## Widget state lifecycle

- **`initState`**:
  One-time setup.
  Create controllers, subscribe, start requests.
  Don't establish inherited dependencies,
  such as with `Theme.of` or `MediaQuery.sizeOf` in `initState`.
  Establish them in `didChangeDependencies`.
- **`didUpdateWidget`**:
  The parent rebuilt with new configuration.
  Compare against `oldWidget` and update anything derived from widget fields.
  For example, re-target a controller or resubscribe to a new stream.
- **`dispose`**:
  Release resources that the state owns.
  Cancel subscriptions that it created,
  and dispose every controller, node, and notifier that it created.
  Don't dispose an object received from a parent
  unless the API explicitly transfers ownership.
- **DO** use `setState` only for an actual state change,
  keep the callback's body to synchronous mutation,
  and never call it after `dispose`.
  Guard async paths with `mounted`.

## Async safety

The user can navigate away while a widget awaits asynchronous work:

- **DO** check `mounted` in a `State`
  or check `context.mounted` for a `BuildContext`
  after an asynchronous gap
  before calling `setState`, using the context, navigating,
  or doing other work that requires the widget to remain mounted.
  The `use_build_context_synchronously` lint enforces the context half.
- **DO** hold the future or stream
  that a `FutureBuilder` or `StreamBuilder` consumes
  in a `State` field rather than creating it during `build`:

  ```dart
  late Future<Profile> _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.repository.fetchProfile(widget.userId);
  }

  @override
  void didUpdateWidget(covariant ProfileView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId ||
        oldWidget.repository != widget.repository) {
      _profile = widget.repository.fetchProfile(widget.userId);
    }
  }
  ```

  Passing `repository.fetchProfile(userId)`
  directly to a `FutureBuilder`
  can restart the request on every rebuild.
  `didChangeDependencies` is another appropriate place
  when the asynchronous work depends on inherited data.
- **DO** cancel `StreamSubscription`s in `dispose`.
- **PREFER** `StreamBuilder` when the UI is the only consumer,
  as it manages its own subscription.

## Keys

- Most widgets need **no key**.
  When Flutter would otherwise match state to the wrong element, add a key.
- **DO** use `ValueKey` or `ObjectKey` on the children of a list that can be
  reordered, inserted into, or removed from.
  The key makes state, including animations,
  travel with the item instead of its index.
- **AVOID** `GlobalKey` except when you need its specific capabilities,
  such as reparenting a subtree or imperative access to descendant state.
  A `Form` can use a `GlobalKey<FormState>`,
  but `Form.of(context)` often avoids the key.
  A `GlobalKey` is comparatively expensive.
  Using it for state sharing usually indicates misplaced state.
  Move the state to a common ancestor instead.

## Interaction widgets

- When their interaction model fits,
  **PREFER** built-in buttons or `ListTile`.
  These widgets provide feedback, focus,
  minimum tap-target sizing, and semantics.
- **PREFER** `InkWell` over `GestureDetector`
  for a custom Material surface that responds to taps.
  Ensure that the `InkWell` has a `Material` ancestor
  so it can paint its interaction effects.
  Give the surface a sufficient tap-target size and clear semantics.
  Use `GestureDetector` only for custom gestures.
  When you use it,
  apply the accessibility guidance in [Design](design.md).
