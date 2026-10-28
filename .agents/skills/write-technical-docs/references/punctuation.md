# Punctuation in documentation

Use these rules to punctuate documentation consistently.

## Colons

- When the lead-in is a complete sentence,
  use a colon to introduce a list or an explanation:
  "You need three things: a key, a token, and a scope".
- Don't put a colon after a verb or preposition
  that directly governs the list:
  write "You need a key, a token, and a scope",
  not "You need: a key".
- Lowercase the first word after a colon
  unless it's a proper noun, heading, quotation,
  or text after a label such as "Note" or "Caution".

## Commas

- Use the **serial comma**, also called the **Oxford comma**,
  before the final conjunction in a list of three or more:
  "buttons, links, and menus".
- Use a comma after an introductory clause or phrase:
  "After the build completes, deploy the app".
- Use commas to set off nonrestrictive, or nonessential, clauses.
  Don't use them around restrictive clauses that change meaning.
- Use a comma between independent clauses
  joined by a coordinating conjunction:
  "The build runs, and the tests pass".
- Use a comma between coordinate adjectives
  that independently modify the noun,
  as in "a fast, reliable service".
- Don't use a comma between cumulative adjectives
  as in "three new servers".

## Ellipses

- In general, don't use ellipses in documentation.
- To show omitted material in the middle of quoted text,
  use three contiguous periods, `...`, instead of the ellipsis character, `…`.
  Put a space before and after the three periods
  unless another punctuation mark immediately follows them.
- When a UI label ends in an ellipsis,
  omit the ellipsis unless leaving it out could cause confusion.
- Don't use ellipses for dramatic pauses or trailing off.
- In command syntax, three periods can indicate that an argument can repeat.
  Follow the command-line syntax convention for the project.

## Hyphens and dashes

### Hyphens

Use the `-` character to join compound modifiers and some prefixes.

- Hyphenate compound modifiers before a noun such as in
  "high-quality documentation", "command-line tool", or "256-bit key".
  Unless it's a permanent compound,
  don't hyphenate the same phrase after the noun,
  such as in "the documentation is high quality".
- Don't hyphenate adverbs ending in _-ly_ plus an adjective:
  "a fully managed service", not "fully-managed".
- Follow [Word choice](word-choice.md) and its linked sources
  for closed, open, and hyphenated compounds
  such as the closed "backend" and the open "data center".
  Check those sources for specific prefixed terms.
  Many take no hyphen, including "colocate", "hardcoded", and "prebuilt".
- Hyphenate "right-click", "double-click", and similar interaction verbs.
- Use a hyphen with no spaces for a numeric range,
  such as "8-20 files".
  If the hyphen could be ambiguous,
  write the range with _to_ or _through_ instead.
- For a range with units,
  use _to_ and repeat the unit, as in "5 MB to 10 MB".

### En dashes

Don't use the `–` character.

### Em dashes

The `—` character sets off a strong break or parenthetical aside.
Use it sparingly, with no spaces around it.
Where a comma, colon, or separate sentence is clearer,
don't use an em dash.

## Parentheses

- Use parentheses for brief, genuinely optional asides.
  If the information matters, put it in the main sentence.
- Keep parenthetical content short.
  Don't nest parentheses.
- Punctuate around parentheses correctly.
  When the parenthetical ends a sentence,
  put the period outside.
  When the whole sentence is parenthetical,
  put the period inside.
- Don't overuse parentheses as a substitute for clear sentence structure.

## Periods and end punctuation

- End complete sentences with a period,
  including most list items that are full sentences.
- Don't end headings, titles, or short UI labels with a period.
- For list items that are sentence fragments, be consistent within the list:
  either all get periods or none do.
  Default: use periods if any item is a full sentence, otherwise omit them.
- Use one space after a period, not two.
- If a period would change a literal value,
  don't put it inside code font.
  Keep sentence punctuation outside inline code when ambiguity could result.
- Avoid exclamation points except in rare, genuinely warranted cases.

## Quotation marks

- When italics aren't available,
  quotation marks can occasionally identify a word used as a word.
- Use code font, not quotation marks, for literal code, filenames, and values.
- For quoted keywords, literal strings, and other exact text,
  use logical punctuation.
  Place punctuation inside the closing quotation mark
  only when it's part of the quoted content.
  For example, in `The status is "ready".`,
  the period ends the surrounding sentence.
- For ordinary prose quotations,
  place commas and periods inside the closing quotation mark.
  In `The guide says, "Run the command."`,
  the period is part of the quoted sentence.
- Don't use quotation marks for emphasis or scare quotes.
- Use straight quotation marks and apostrophes in prose and code.

## Semicolons

- Use semicolons rarely.
  Prefer two sentences or a restructured list.

## Slashes

- Avoid slashes that signal an ambiguous "and/or" relationship.
  Write out the meaning:
  "import or export", not "import/export".
  If space is constrained, such as in a table heading,
  a slash can be acceptable.
- Don't use "and/or".
  Rephrase with "or", "and", or "A, B, or both".
- Don't use slashes in dates or fractions.
  Use an unambiguous date format and decimals or words instead.
- For rates, use _per_ when space permits.
  A slash is acceptable in an established unit abbreviation
  or a space-constrained table.
