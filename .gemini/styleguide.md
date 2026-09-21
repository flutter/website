# Pull request review guide

This repository contains the source and content for
the `docs.flutter.dev` and `flutter.dev` websites.
Both are static sites built with Dart and Jaspr,
with most content authored in Markdown.

Review changes for concrete problems that affect readers, contributors,
or the built websites, within the pull request's intended scope.

## Report only what matters

Report an issue only if the change introduces or worsens it,
it's of medium severity or higher,
and you can state its concrete consequence.
Read the surrounding code and content before commenting.

Prioritize:

- Incorrect instructions, commands, API names, or expected results.
- Broken or misleading examples and behavior regressions.
- Navigation, rendering, accessibility, or security defects.

Don't report:

- Preference-only rewrites, cosmetic nits, speculative optimizations,
  or refactoring and architecture changes outside the PR's scope.
- Generic best-practice reminders not tied to a specific defect in the diff.
- Issues already raised by existing review comments or automated checks,
  unless you add useful context.

Keep comments focused and intentional.
Include the problem, its consequence,
and the smallest useful fix, ideally as a suggestion block.
Skip praise, background, and tutorials.
Consolidate repeated instances of the same issue into one comment.
Never claim to have run checks or consulted sources you couldn't access.

## Respect the repository structure and each example's purpose

- `sites/docs/` and `sites/www/` are Jaspr websites, not Flutter apps.
  Don't apply Flutter widget or lifecycle rules to Jaspr components.
- `examples/` is a separate pub workspace of documentation samples.
  Samples are deliberately minimal.
  Read the surrounding explanation before flagging omitted boilerplate,
  omitted error handling, lint suppressions,
  or code explicitly labeled as incorrect or outdated,
  such as in migration guides.
- `<?code-excerpt ...?>` blocks are generated from `examples/`.
  Check the referenced source and any excerpt transformations
  before calling a snippet incomplete.
  Suggest fixing the source or directive and refreshing the excerpt,
  not editing the generated Markdown.

## Assume Dart 3.13

Unless otherwise specified,
all code in this repository is written for
Dart **3.13** and the corresponding Flutter release.
Treat every feature in that version as stable and available,
even if it's newer than what you're familiar with.
Don't request compatibility with older SDKs.

The following syntax is valid and intentional.
Never flag it as an error, typo, duplicate name, or missing type:

- Primary constructors: `class Point(final int x, final int y);`
- Concise constructor declarations:
  `new(this.x, this.y);`, `new origin() : x = 0, y = 0;`,
  and `factory parse(String source) { ... }`.
- Private named initializing formals: `Config({required this._theme});`,
  called with the public argument `Config(theme: ...)`.
- Dot shorthands: `.center`, `.new()`, and `.idle => value`
  when the context supplies the type.
- Null-aware collection elements: `[?maybeNull]`.
- Wildcards: `_` doesn't bind, so `(_, _) => 0` and `catch (_)` are valid.
- Digit separators (`1_000_000`), extension types, records, patterns,
  switch expressions, class modifiers, and private final field promotion.

For unfamiliar syntax, consult <https://dart.dev/language>
before claiming it's invalid or recommending an older form.
If you can't verify a suspected error, omit the claim.
Let the existing `dart format` and `dart analyze` checks
handle layout, trailing commas, and lint-level style.

## Dart conventions

Dart code follows Effective Dart,
except where an example deliberately deviates to teach a concept.

- Avoid `dynamic`, implicit dynamic calls, and other escapes from
  static checking, unless the surrounding explanation calls for them.
- Don't request redundant type annotations, casts, `!`,
  or `default` and `_` cases in exhaustive switches
  over enums or sealed types.
- Futures should be awaited, returned,
  or deliberately detached with `unawaited` and a comment explaining why.
- Don't request tests.
  This repository doesn't require them,
  except in examples that specifically demonstrate testing.

## Documentation and Markdown

Don't flag:

- Jaspr Content and site conventions.
  We use YAML front matter, Liquid expressions, `:::note`-style alerts,
  definition lists, custom components, raw HTML,
  and a body without an H1, which the layout supplies.
- Line wrapping.
  New prose uses semantic line breaks with lines under 80 characters,
  but deviations are ok for blog posts and low severity in general.
- Blog voice.
  First person, humor, and future-facing announcements are valid in posts.

Documentation prose, but not blog posts,
follows the Google developer documentation style guide
with some local additions and deviations,
such as introducing links with "refer to", "consult",
"check out", or "visit" rather than "see".
When existing content consistently differs from the style guide,
treat that as an intentional convention and match it.
Apply the same style to any replacement prose you propose.
