# Word choice in documentation

Use this reference for common terms and naming rules in developer documentation.

For UI verbs such as _click_, _tap_, and _select_,
consult [UI elements and interaction](code-and-ui.md#ui-elements-and-interaction).

For a strict terminology review or guidance about a term not covered here,
consult the [strict-review word list](word-list.yaml).
If the term isn't in that list,
check the [Google word list][] and then
use the first spelling in [Merriam-Webster][].
An explicit project convention takes precedence.

[Google word list]: https://developers.google.com/style/word-list
[Merriam-Webster]: https://www.merriam-webster.com/

## Prefer plain, direct wording

- Replace _allows you to_ with _lets you_,
  or write "use X to do Y".
- When _as_ means _because_, use _because_.
- Replace _comprise_ with _consist of_, _contain_, or _include_.
- Omit time-bound wording such as _currently_, _presently_,
  and _as of this writing_.
- Replace _desire_ and _desired_ with _want_ or _need_.
- Replace _e.g._ with _for example_
  and _i.e._ with _that is_.
- Instead of _etc._ or _and so on_,
  name the relevant items or rewrite the sentence.
- Replace _aka_ with _also known as_,
  or introduce the alternative with parentheses or _or_.
- Replace _and/or_ with _and_, _or_, or "A, B, or both".
- Replace _in order to_ with _to_.
- Omit _easy_, _just_, _quick_, _simple_, and _simply_.
  Don't judge how difficult a task is for the reader.
- Unless _abort_ is a literal signal name,
  replace it with _stop_, _cancel_, or _end_.
- Instead of _above_ and _below_,
  refer to the named element or use _earlier_, _preceding_,
  _later_, or _following_ as appropriate.
- Avoid using _see_ or _see the_ to introduce links or references.
  Prefer _refer to_, _consult_, or _visit_
  (for example, "To learn about X, visit Y" or
  "For details, consult the X documentation").
- Replace _via_ with _through_, _with_, or _by using_.
- Replace the verbs _leverage_ and _utilize_ with _use_.
- Use _sign in_, not _log in_, unless the UI uses _log in_.
  Write _sign in to_, not _sign into_.

## Spelling and form

- Write _backend_, _frontend_, _codebase_, _datastore_, _autoscaling_,
  _autopopulate_, and _colocate_ as one word.
- Write _data center_, _data type_, _data source_,
  and _content type_ as two words.
- Treat _data_ as a singular mass noun:
  "the data is" and "less data".
- Write _email_ and _website_, not _e-mail_ and _web site_.
- Lowercase _internet_ and _web_.
- Don't expand _CPU_, _API_, _URL_, or _HTML_ on first use.
  Use a lowercase _s_ and no apostrophe for plurals,
  such as _CPUs_ and _APIs_.
- Write _curl_ in lowercase.

## Dart and Flutter terms

- Write Dart, Flutter, Dart SDK, Flutter SDK, and Dart VM
  with the capitalization shown.
  In _Flutter framework_ and _Flutter engine_,
  capitalize only _Flutter_.
- Write DartPad and DevTools with their internal capitalization.
  Write pub.dev in lowercase.
- Use code font and lowercase for commands and subcommands,
  such as `dart`, `flutter`, `dart pub`, and `flutter pub`.
- Write _hot reload_ and _hot restart_ as lowercase, two-word terms.
- Lowercase _widget_ and other framework concepts.
  Use code font and exact capitalization for identifiers,
  such as `Widget` and `CupertinoApp`.
- Prefer _app_ to _application_ for a Dart or Flutter end-user program,
  unless an official name or established phrase uses _application_.

## Use precise terms

- Use _can_ for ability, permission, a possible outcome,
  or an optional action.
- Use _might_ for uncertainty.
  Reserve _may_ for policy or legal considerations.
- Prefer a direct instruction or present-tense statement
  when it can replace _could_, _would_, or _should_.
- Use _deprecate_ to mean recommend against use,
  not _remove_ or _shut down_.
- When describing UI state,
  prefer precise terms such as _turn on_, _turn off_,
  _active_, or _unavailable_ to _enable_ and _disable_.
  Don't use _disabled_ to mean _broken_.
- Use _display_ with an object:
  "The pane displays the results".
  Otherwise, write "The pane appears".
- Use _authentication_ for verifying an identity
  and _authorization_ for determining access.
  Don't use _authN_ or _authZ_.
- Define necessary jargon on first use.

## Product names and trademarks

- Follow the official capitalization and form of a product name.
  On first mention, use the full name when the short form could be unclear.
- Use only official abbreviations and shortened names.
- Don't pluralize a product name,
  make it possessive,
  or use it as a verb.
- Lowercase generic nouns after product names,
  as in "the DevTools console" and "the Flutter framework".
- Use _the_ only when the name or sentence requires it,
  as in "the Dart SDK" and "the `dart` CLI".
- For third-party trademarks,
  follow the owner's official form and usage guidelines.
  Use the mark as an adjective that modifies a generic noun,
  not as a noun or verb.
  Include required notices and
  don't imply a partnership or endorsement.

## Safe example data

Use reserved, fictional, and culturally varied data in examples.
Never include real credentials, API keys, tokens, or personal data.

- **Domains and URLs**:
  Use `example.com`, `example.org`, `example.net`, or their subdomains.
- **Email addresses**:
  Use `username@example.com` or a role-based address at `example.com`.
- **IP addresses**:
  Use `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24`,
  or the IPv6 range `2001:db8::/32`.
- **Phone numbers**:
  Use an officially reserved fictional range,
  such as `+1 800-555-0175`.
- **People, companies, and places**:
  Use varied fictional names and generic organizations,
  such as "Example Corporation" or "Example App".
  Don't use real people or organizations.
