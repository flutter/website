# Flutter visual design and accessibility

Centralize visual decisions in the theme or token system,
treat text as resizable,
and build in semantics from the start.
Follow the project's design system.
The theming examples in this reference use Material;
for Cupertino or a custom system,
use its corresponding theme and token APIs.

## Theming

- **DO** make `ThemeData` the central source for visual values.
  Derive color from a `ColorScheme`, such as with `ColorScheme.fromSeed`,
  and read it at use sites with `Theme.of(context)`:

  ```dart
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Row(
      children: [
        Text('Total', style: text.titleMedium),
        Icon(Icons.check, color: colors.primary),
      ],
    );
  }
  ```

- **AVOID** duplicating shared colors or typography
  as `Color(0xFF6750A4)` or `TextStyle(fontSize: 16)` literals at use sites.
  Those values can't follow theme changes or a rebrand.
  A truly local, fixed visual value is acceptable
  when the design system doesn't need to reuse or vary it.
- **PREFER** styling components once through component themes
  such as `elevatedButtonTheme`, `cardTheme`, and `inputDecorationTheme`
  instead of repeating `style:` arguments for each instance.
- Use a `ThemeExtension` when project-specific tokens
  need to vary with the active theme.
  Implement `copyWith` and `lerp` so they interpolate with the theme.
- Derive variants from scheme roles such as `colors.primaryContainer`
  and `colors.onSurfaceVariant` instead of alpha-fading hardcoded colors.
  When alpha is genuinely needed, use `color.withValues(alpha: 0.5)`,
  not the deprecated `withOpacity`.

## Brightness modes

- Support the brightness modes that the product promises.
  In a Material app that follows the system brightness,
  supply `theme` and `darkTheme` with `themeMode: ThemeMode.system`,
  and exercise the UI in both modes.
  Widgets styled from the theme can then adapt automatically.
- **DON'T** assume surface colors.
  Don't use images that assume a white surface
  or `Colors.black` text literals.

## Text and typography

- **DO** use `textTheme` roles,
  such as `headlineSmall`, `bodyMedium`, `labelLarge`,
  instead of standalone `TextStyle` objects.
  When adjustments are necessary,
  use `copyWith`.
- **DO** treat all text as resizable.
  Users raise the system font scale.
  Flutter applies it through `TextScaler`.
  Don't override the scale with fixed-height text containers.
  Let padding size the box.
- **DO** decide overflow behavior for text that can exceed its space.
  Use `maxLines` with `TextOverflow.ellipsis` or `.fade`
  only when truncation is acceptable.
  Otherwise, let the layout grow, wrap, or scroll.
- Test important layouts at larger text scales supported by the target,
  including 2.0× where practical.

## Spacing and design tokens

- **PREFER** a consistent spacing scale, such as multiples of 4 or 8,
  exposed as named constants or a `ThemeExtension`
  instead of unnamed numbers at each call site.
- Reuse the project's existing scale.
  Don't introduce a second one.

## Accessibility

- **DO** prefer built-in interactive widgets,
  such as buttons, `Checkbox`, and `ListTile`.
  They include semantics, focus handling, and minimum tap targets.
  A custom `GestureDetector` doesn't provide these behaviors automatically.
  Give it a `Semantics` ancestor that declares its role
  and exposes an accessible name,
  such as `Semantics(button: true, child: customControl)`.
  Reuse a meaningful visible label when one exists;
  otherwise, supply a concise `label`.
  Also provide the focus, keyboard interaction,
  visual feedback, and target size that the supported platforms require.
- **DO** meet the target platform's minimum interactive size:
  48 by 48 logical pixels for Material and Android,
  and 44 by 44 for iOS.
  Pad small icons rather than shrinking the target.
- **DO** label meaningful images
  with `Image.asset('logo.png', semanticLabel: 'Company logo')`
  or `Icon(Icons.info, semanticLabel: 'Information')`,
  and exclude purely decorative ones
  with `excludeFromSemantics: true`.
- **DON'T** convey state by color alone.
  Pair it with an icon, label, or shape change,
  and keep contrast at least 4.5:1 for normal text
  and 3:1 for large text and meaningful non-text components.
- **CONSIDER** `MergeSemantics` when a compound widget,
  such as an icon, label, and value, represents one announcement.
  Don't merge descendants that need separate semantic actions.
  Give list items meaningful, concise semantics.
- Widget tests can enforce tap target size, contrast,
  and labeled interactive targets
  with accessibility guideline matchers.
  See [Testing](testing.md).
