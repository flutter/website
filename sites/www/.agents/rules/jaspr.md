---
trigger: always_on
---

# Jaspr Project Rules

## Core Principles
- **Framework**: Use [Jaspr](https://github.com/schultek/jaspr) for all web UI components. Do not use standard Flutter widgets (Container, Column, Row, etc.). 
- **Elements**: Use HTML-like components provided by Jaspr (`div`, `section`, `h1`, `p`, `img`, `a`, `button`, `span`, etc.).

## Components
- **Stateless vs Stateful**:
  - Use `StatelessComponent` for purely presentational components that do not manage local state.
  - Use `StatefulComponent` only when internal state management (e.g., animations, form input handling) is required.
- **Client-Side Rendering**: Annotate components with `@client` if they require browser-specific APIs or interactivity that cannot be server-side rendered (SSR).

## Project Structure
- **Components**: Place reusable UI components in `lib/components/`.
- **Pages**: Place route-level components in `lib/pages/`.

## Common Patterns
- **Lists**: Prefer Dart collection-for and collection-if elements over`.map().toList()` to render lists of children.
- **Conditionals**: Prefer Dart `if` inside the children list over ternary operators for conditional rendering.

## Best Practices

When writing Jaspr components, adhere to these modern syntax rules:

### Component Signature
Always use the `Component build(BuildContext context)` signature (not `Iterable<Component>` with `yield`).

```dart
// ✅ Correct
@override
Component build(BuildContext context) {
  return div([...]);
}

// ❌ Avoid
@override
Iterable<Component> build(BuildContext context) sync* {
  yield div([...]);
}
```

### Text Components
Use the dot-shorthand `.text()` for adding text nodes, which is cleaner than wrapping strings in `text()`.

```dart
// ✅ Correct
div([
  .text('Hello World'),
])

// ❌ Avoid, Deprecated
div([
  text('Hello World'),
])
```

### Links and Navigation

Prefer standard `a` tags over `Link` components when you need full control over attributes or are migrating strict HTML.

```dart
// ✅ Correct
a(
  href: '/path',
  classes: 'my-link',
  events: {'click': (e) => ...}, // Easy to attach events
  [.text('Go')]
)
```

### Positional Arguments for Children

`div`, `span`, and other container components typically take children as a positional `List<Component>`.

```dart
// ✅ Correct
div(classes: 'wrapper', [
  child1,
  child2
])

// ❌ Avoid
div(classes: 'wrapper', children: [ ... ])
```

- Use `main_([...])` for rendering a `<main>` element.
- Use `Component.element(tag: 'xx', children: [...])` for an element that does not have a direct component.

### Using Browser APIs and handling Global/Window Events

Use `import 'package:universal_web/web.dart' as web;` for accessing standard browser APIs (e.g. `window` or `window.document`) when implementing browser-specific logic (location checking, scroll locking).

Use `web.EventStreamProviders` to listen to window-level events in `initState` and cancel stream subscriptions in `dispose`.

```dart
StreamSubscription? _resizeSubscription;

@override
void initState() {
  super.initState();
  if (kIsWeb) {
    _resizeSubscription = web.EventStreamProviders.resizeEvent
        .forTarget(web.window)
        .listen((_) => setState(() {}));
  }
}

@override
void dispose() {
  _resizeSubscription?.cancel();
  super.dispose();
}
```
