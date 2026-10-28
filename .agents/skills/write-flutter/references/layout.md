# Flutter layout and responsiveness

Flutter layout follows one rule plus consequences.
Use the constraint rule to interpret layout errors.

## The constraint model

**Constraints go down. Sizes go up. The parent sets the position.**

- A parent passes each child minimum and maximum width and height constraints.
  The child selects a size _within them_ and reports it back.
  The parent then positions the child.
- A widget can only have a size allowed by its constraints.
  `Container(width: 100)` inside full-screen tight constraints is full-screen.
- **Tight** constraints force one size because the minimum equals the maximum.
  **Loose** constraints allow a range.
  **Unbounded** constraints have an infinite maximum.
  A scrollable gives its contents unbounded constraints
  in the scroll direction.
  A `Row` or `Column` gives its non-flex children
  unbounded constraints along the main axis.
  Supplying an unbounded constraint to a widget that must expand
  causes many layout errors.

When a layout misbehaves,
identify the constraints that the widget receives.
DevTools' widget inspector shows them directly.

## Common errors and their fixes

Choose the fix that matches the intended constraint and scrolling behavior.

### RenderFlex overflow

The `A RenderFlex overflowed by N pixels` error means
that a `Row` or `Column`'s children require more space than exists.
Choose the fix that matches the intended layout:

- Let the oversized child share space: wrap it in `Expanded` or `Flexible`.
- Let content scroll: `SingleChildScrollView` or a lazy list.
- Let items wrap to the next line: `Wrap`.
- For text specifically,
  set `maxLines` and `overflow: TextOverflow.ellipsis` on the `Text`
  inside an `Expanded`.

Don't resolve overflow by hardcoding a size
that happens to fit one device and font scale.

### Unbounded vertical viewport

The `Vertical viewport was given unbounded height` error
often indicates a `ListView` or another scrollable inside a `Column`.
The column offers infinite height,
and the list expands to fill it.
Wrap the list in `Expanded`.
Reserve `shrinkWrap: true` for short, genuinely bounded lists.
Shrink wrapping is significantly more expensive
because Flutter must recompute the scroll view's extent
as the content or scroll position changes.
For nested scrollables,
restructure the layout as one `CustomScrollView` with slivers.

### Unbounded InputDecorator width

The `An InputDecorator cannot have an unbounded width` error
often indicates a `TextField` directly in a `Row`.
Wrap it in `Expanded`.

### Ignored width or height

If a widget ignores its width or height,
it receives tight constraints.
Where you control the parent,
loosen the constraints.
Otherwise, wrap the child in `Align`
or `Center` to loosen incoming constraints,
allowing a `SizedBox` or intrinsically sized child to take effect.

## Flex mechanics

- `Expanded` fills its share of remaining space with tight constraints.
  `Flexible` can use up to its share with loose constraints.
  If the child can be smaller, use `Flexible`.
  Otherwise, use `Expanded`.
- **PREFER** the `spacing` parameter
  over interleaved `SizedBox` widgets for uniform gaps.
  Use `MainAxisAlignment` for distribution, not spacer arithmetic.
- Size flex children with the `flex` ratio rather than
  screen-fraction math, such as `width: screenWidth * 0.42`.
  Screen-fraction math can fail under split screen, padding, and text scaling.

## Expensive layout to avoid

- **AVOID** `IntrinsicHeight` and `IntrinsicWidth`, especially inside lists.
  They add a speculative extra layout pass per child.
  Usually a `CrossAxisAlignment.stretch` or a fixed extent achieves the goal.

## Responsive and adaptive design

- **DO** design against _available constraints_, not device type:
  When a widget adapts to the space its parent gives it,
  use `LayoutBuilder`.
  When it adapts to the window,
  use `MediaQuery.sizeOf(context)`.
  Prefer content-driven breakpoints
  such as "two panes when wider than 600 logical pixels"
  to device-model checks.
- **DO** make interactive and readable page content respect system insets.
  Use `SafeArea` or `SliverSafeArea` when the surrounding scaffold
  or layout doesn't already handle those insets.
  Backgrounds can still extend edge to edge intentionally.
- **DON'T** lock orientation or assume portrait phone dimensions.
  Flutter apps run on tablets, foldables, desktop, and web.
- When honoring platform conventions,
  **PREFER** `.adaptive` constructors
  such as `Switch.adaptive` and `CircularProgressIndicator.adaptive`.
  Prefer platform-conditional _behavior_ over forked widget trees.
- Leave text containers intrinsically sized
  with padding around text rather than fixed-height boxes.
  Fixed heights can fail when users raise the system font size.
