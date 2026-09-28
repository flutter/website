# Inclusive and global writing

Use this guidance to write inclusive, accessible documentation
for a global audience.

## Inclusive language

Write so that the widest possible audience feels respected and included.
Replace non-inclusive terms.
If a direct substitution doesn't make the sentence clear,
rewrite the sentence.

### Common replacements

- Replace _whitelist_ with _allowlist_.
  Replace _blacklist_ with _blocklist_ or _denylist_,
  as appropriate.
  Don't use the verbs _whitelist_ and _blacklist_.
  For example, write "To allow the address, add it to the allowlist".
- Replace _master_ and _slave_ with terms that describe the relationship,
  such as _primary_ and _replica_,
  _main_ and _secondary_, or _leader_ and _follower_.
- For a branch or copy,
  replace _master_ with _main_, _primary_, or _original_.
- Replace _dummy_ with a more precise term,
  such as _placeholder_, _sample_, or _test_.
- Replace _sanity check_ with _quick check_,
  _confidence check_, or _validation_.
- Replace _grandfathered_ with _legacy_ or _exempted_,
  depending on the intended meaning.
- When describing a feature,
  use _built-in_ instead of _native_
  unless _native_ is the precise technical term.
  Never use _native_ to describe people.
- Except for a literal signal name,
  replace _abort_ with _stop_, _cancel_, or _end_.
- When possible,
  replace _kill_ with _stop_, _end_, or _force quit_ for a process.
- Replace _crazy_, _insane_, _lame_, _cripple_, and similar terms
  with precise, non-ableist language that conveys the intended meaning,
  such as _complex_, _unexpected_, _limit_, or _slow down_.

### People-first and identity

- When appropriate,
  use people-first phrasing such as
  "a person who is blind" or "a screen reader user",
  and follow community-preferred terms.
- Avoid gendered defaults.
  Use singular _they_.
  Don't assume the reader's or a third party's gender.
- Avoid idioms tied to one culture, region, sport, or holiday.

### When a non-inclusive term appears in code or an external API

- If you must reference an existing identifier,
  such as a flag, field, or command literally named with the term,
  use it only in code font,
  in direct reference to the code, and make the reference clear.
  Don't propagate the term into your own prose.

## Writing for a global audience

Many readers use English as an additional language,
and people or software translate much developer documentation.
Write clearly so translators can preserve the meaning.

- Prefer **short, direct sentences** with clear subject-verb-object order.
- Use words consistently.
  Don't vary terminology for the same concept.
  For example, use "sign in" everywhere,
  not alternating with "log in" or "authenticate".
- Avoid idioms, slang, metaphors, colloquialisms,
  and humor that don't translate,
  such as "piece of cake", "low-hanging fruit", or "out of the box".
  Use "built-in" instead of "out of the box".
- Avoid culturally specific references
  such as holidays, sports, and regional events.
  Use a neutral fictional event in examples.
  When a specific real event matters,
  name it and provide enough context for unfamiliar readers.
- Spell out rare abbreviations and Latin terms.
  For example, replace "e.g." with "for example".
- Avoid directional and layout-dependent words
  such as "above", "below", and "to the left".
  Their meaning can change in translation or responsive layouts.
- Avoid negative constructions and double negatives.
  State things positively.
- Use the serial comma and clear punctuation to reduce ambiguity.
- Use unambiguous, internationally clear formats for dates, times,
  numbers, currency, units, and phone numbers.
  See [Formatting and structure](formatting-and-structure.md).
- Don't use "we" in ways that assume a shared cultural context.
  Keep instructions in plain second person.

## Accessibility

Write so that people using assistive technology can use the documentation
and the product it describes.

- **Link text** must describe its destination and make sense out of context.
  Never "click here" or "read more".
- **Alt text** for an informative image must convey its meaning and purpose.
  Mark decorative images and images that only repeat nearby text as
  hidden from screen readers.
  Don't put essential information only in an image.
- **Don't use directional or sensory-only instructions**
  such as "the green button on the right" or "as shown above".
  Identify elements by label and type and
  describe state without relying on color or position alone.
- Use **semantic headings and lists**,
  not bold text or manual formatting,
  so people using screen readers can navigate.
- Keep **tables** simple with proper header rows.
  Complex layout tables can be hard for people using screen readers to navigate.
- Don't convey meaning through **color alone**.
  Pair it with text or shape.
- Expand or define **abbreviations** and avoid unexplained jargon,
  which can make text harder to understand for people using screen readers
  or English as an additional language.
- For cognitive accessibility,
  prefer plain, literal language over figurative language.
- When possible,
  describe interactions without assuming a specific device,
  or cover both pointer and keyboard paths.
