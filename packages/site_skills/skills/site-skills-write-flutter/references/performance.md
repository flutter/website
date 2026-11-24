# Flutter performance

Each frame has a limited budget for build, layout, and paint.
Measure first, then optimize the stage that causes missed frames.

## Measure performance first

- **DO** profile in `profile` mode on a real device
  by running `flutter run --profile` with DevTools' performance view.
  Debug-mode performance isn't sufficient evidence
  because debug builds include assertions, diagnostics,
  and runtime behavior that profile and release builds omit.
- Use the inspector's rebuild counts and the timeline
  to identify the widgets that rebuild
  and the frames that exceed the budget before changing code.
  Optimizing unmeasured code can add unnecessary complexity.

## Controlling rebuilds

Individual rebuilds have a low cost,
but many rebuilds can consume significant time.
Shrink their scope:

- **DO** use `const` widgets where possible.
  Reusing the same widget instance lets Flutter
  stop update traversal at that widget.
- **DO** keep each `setState` call in the lowest widget that owns the change.
  Extracting that state into its own widget can limit the rebuild scope.
  Extracting a stateless helper alone doesn't
  prevent its parent from updating it.
- **DO** pass the static subtree as the `child` parameter
  of `ListenableBuilder`, `AnimatedBuilder`, or `ValueListenableBuilder`.
  The builder reruns for each notification,
  the `child` is built once:

  ```dart
  AnimatedBuilder(
    animation: _rotation,
    child: const _ExpensiveLogo(), // Built once.
    builder: (context, child) =>
        Transform.rotate(angle: _rotation.value, child: child),
  );
  ```

- **DO** use granular `MediaQuery` accessors,
  such as `sizeOf`, `paddingOf`, and `viewInsetsOf`.
  `MediaQuery.of(context)` re-runs the build when _any_ metric changes,
  including every keyboard animation frame.
- **AVOID** doing work in every `build` call
  that you can do once in state,
  such as parsing, sorting, or formatting large data.

## Lists and scrolling

- **DO** use lazy constructors,
  such as `ListView.builder`, `.separated`, and `GridView.builder`,
  for anything long or unbounded.
  Flutter then builds only visible items.
- **CONSIDER** `itemExtent` or `prototypeItem` for uniform rows.
  Known extents let the list scroll and jump without measuring children.
- **AVOID** `shrinkWrap: true` on long lists.
  Shrink wrapping requires the scroll view to recompute its extent
  as the content or scroll position changes.
  Nest scrolling regions as slivers in one `CustomScrollView` instead.
- **DO** key reorderable or mutating list items
  so moves reuse elements rather than rebuilding them.
  For key guidance, see [Widgets](widgets.md).

## Expensive painting

- **AVOID** the `Opacity` widget for animation.
  Prefer `FadeTransition`.
  When fading a solid color,
  animate the color's alpha
  with `color.withValues(alpha: t)` instead of wrapping in `Opacity`.
  Whole-subtree opacity can force a costly offscreen `saveLayer` pass.
- **AVOID** unnecessary clipping.
  Clipping adds work,
  and some modes create an offscreen layer.
  When only a background or border needs rounded corners,
  prefer `borderRadius` on a `BoxDecoration` or `Card` shape
  to wrapping in `ClipRRect`.
  When child content must be clipped,
  use a clipping widget.
- **CONSIDER** using a `RepaintBoundary`
  to separate a complex static subtree
  from a neighboring subtree that repaints every frame,
  so Flutter can reuse the static subtree's layer.
  Verify with DevTools' repaint rainbow.
  A boundary that never prevents a repaint uses memory without a benefit.

## Expensive computation

- **DO** keep the UI isolate free of CPU-intensive work.
  Decode large JSON, process images,
  and run cryptography in `Isolate.run(...)` or `compute` on native platforms.
  `async` alone doesn't move work off the isolate.
  On the web, `compute` runs on the current event loop,
  so use web workers or platform-appropriate APIs
  when work must leave the UI thread.

## Images

- **DO** size large images to their display size
  with `cacheWidth` and `cacheHeight`,
  or use pre-sized assets and variants.
  Decoding a 4,000-pixel photo into an 80-pixel avatar
  wastes memory and decoding time.
  Choose decoded pixel dimensions that account for
  the widget's logical size and the device pixel ratio.
  The cache values specify decoded pixel dimensions,
  and `Image.network` ignores them on the web.
