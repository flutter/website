---
title: Using HTML slots to render platform views in the web
description: iframes in Flutter web used to reload, because of the way some DOM operations were made. A change in the way Flutter web apps render Platform Views makes them much more stable (preventing iframe reloads, and other problems with video tags or forms potentially losing their state).
---

## Summary

Flutter now renders Platform Views using [slot elements][] inside of a single,
app-wide [Shadow Root][]. Slot elements can be added/removed/moved around the
Shadow DOM without affecting the underlying slotted content (which is rendered
in a constant location)

## Context

The Flutter framework frequently tweaks its Render Tree to optimize the paint
operations that are ultimately made per frame. In the web, these Render Tree
changes often result in DOM operations.

Flutter web used to render its Platform Views (`HtmlElementView` widgets)
directly into its corresponding position of the DOM.

Using certain DOM elements as the "target" of some DOM operations causes those
elements to lose their internal state. In practice this means that `iframe` tags
are going to reload, `video` players might restart, or a form being edited might
lose the edits made to it.

This change was made to:

* make Platform Views behave in a stable way in Flutter web.
* unify the way Platform Views were rendered in the web for both rendering
backends (`html` and `canvaskit`).

## Description of change

A Flutter web app is now rendered inside a common Shadow Root in which slot
elements are used to represent platform views. The actual content of each
platform view is rendered *outside* of the Shadow Root, as a child of the Shadow
Root host.

### Before

<!-- skip -->
```html
...

<flt-glass-pane>
  ...
  <div id="platform-view">Contents</div> <!-- canvaskit -->
  <!-- OR -->
  <flt-platform-view>
    #shadow-root
    | <div id="platform-view">Contents</div> <!-- html -->
  </flt-platform-view>
  ...
</flt-glass-pane>

...
```

### After

<!-- skip -->
```html
...

<flt-glass-pane>
  #shadow-root
  | ...
  | <flt-platform-view-slot>
  |   <slot name="platform-view-1" />
  | </flt-platform-view-slot>
  | ...
  <flt-platform-view slot="platform-view-1">
    <div id="platform-view">Contents</div>
  </flt-platform-view>
  ...
</flt-glass-pane>

...
```

Now, when the framework needs to move DOM nodes around, it'll operate over
`flt-platform-view-slot`s, which only contain the `slot` tag that "projects" the
content defined in the `flt-platform-view` tags outside of the Shadow Root
(which never move), thus preventing the reloads.

From an app's perspective, this change is transparent. **However**, this is
considered a _breaking change_ because some tests make assumptions
about how the DOM of a Flutter web app might break.

## Migration guide

### Code

Previously, the content returned by [`PlatformViewFactory`][] was resized and
positioned by the framework. Instead, Flutter now sizes and positions
`<flt-platform-view>`, which is the parent of the content.
To ensure the `html.Element` that you return takes the whole space
allocated to it, set its `style.width` and `style.height` properties to `'100%'`:

[`PlatformViewFactory`]: {{site.api}}/javadoc/index.html?io/flutter/plugin/platform/PlatformView.html

<!-- skip -->
```dart
ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
  final html.Element htmlElement = html.DivElement()
    // ..other props
    ..style.width = '100%'
    ..style.height = '100%';
  // ...
  return htmlElement;
});
```

Otherwise, the engine prints a warning message to the console similar to:

<!-- skip -->
```bash
Height of Platform View type: [$viewType] may not be set. Defaulting to `height: 100%`.
Set `style.height` to any appropriate value to stop this message.
```

or:

<!-- skip -->
```bash
Width of Platform View type: [$viewType] may not be set. Defaulting to `width: 100%`.
Set `style.width` to any appropriate value to stop this message.
```

### Tests

By design, there are no selectors that let one _pierce_ through the shadow
DOM boundary to locate elements underneath it, so code that once peeked inside
of the `flt-glass-pane` needs to be made shadow DOM aware. Using the html
markup from above:

<!-- skip -->
```dart
// Find #some-element inside the app:
final element = document.querySelector('#some-element');
```

Code after migration:

<!-- skip -->
```dart
final shadowRoot = document.querySelector('flt-glass-pane')?.shadowRoot!;
final element = shadowRoot.querySelector('#some-element');
```

It's probably a good practice to not assume `document` is always going to be the
root element of searches, so a helper like this might be convenient:

<!-- skip -->
```dart
/// Locate elements in the correct root of the application, whether it is
/// `document` or the new `shadowRoot` of `flt-class-pane`.
List<Node> findElements(String selector) {
  final ShadowRoot? shadowRoot = document.querySelector('flt-glass-pane')?.shadowRoot;
  return (shadowRoot != null) ?
    shadowRoot.querySelectorAll(selector):
    document.querySelectorAll(selector);
}
```

(See Relevant PRs below for multiple examples of the "migrations" described
above).

## Timeline

Landed in version: 2.3.0-16.0.pre<br>
In stable release: not yet

## References

Design doc:

* [Using slot to embed web Platform Views][design doc]

Relevant issues:

* [Issue #80524][issue-80524]

Relevant PRs:

* [flutter/engine#25747][pull-25747]: Introduces the feature.
* [flutter/flutter#82926][pull-82926]: Tweaks `flutter` tests.
* [flutter/plugins#3964][pull-3964]: Tweaks to `plugins` code.
* [flutter/packages#364][pull-364]: Tweaks to `packages` code.

[design doc]: https://flutter.dev/go/web-slot-content
[issue-80524]: {{site.github}}/flutter/flutter/issues/80524
[pull-25747]: {{site.github}}/flutter/engine/pull/25747
[pull-364]: {{site.github}}/flutter/packages/pull/364
[pull-3964]: {{site.github}}/flutter/plugins/pull/3964
[pull-82926]: {{site.github}}/flutter/flutter/pull/82926
[Shadow Root]: https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot
[slot elements]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/slot
