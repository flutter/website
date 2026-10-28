# Grammar and usage in documentation

When writing documentation,
use these grammar and usage rules.

## Abbreviations

- On first use,
  spell out a term followed by the abbreviation in parentheses,
  and then use the abbreviation:
  "foreign function interface (FFI)".
  For abbreviations the target audience commonly understands
  such as API, URL, HTML, CPU, and CLI,
  skip the expansion.
- If an abbreviation appears only once,
  spell out the term instead.
- Avoid Latin abbreviations in prose: write _for example_ instead of _e.g._,
  write _that is_ instead of _i.e._,
  and replace _etc._ by naming the items or rewriting the sentence.
- Write "US" without periods instead of "U.S." in prose.
  Don't add periods to most uppercase initialisms.
- To pluralize an abbreviation,
  add a lowercase _s_ with no apostrophe
  such as "APIs", "URLs", and "SDKs".
- Don't create unexplained ad hoc abbreviations
  such as "authN" and "authZ".
  Write _authentication_ and _authorization_.

## Capitalization

- Use **sentence case** for headings, titles, navigation,
  and UI text that you're authoring:
  capitalize only the first word, proper nouns, and trademarked names.
- Use standard American capitalization in running text.
- Don't use capitalization for emphasis.
  Use italics sparingly or rephrase.
- Match the exact capitalization of product names and code identifiers.
  For an existing UI label,
  match the interface unless its labels are all uppercase or inconsistent.
  In those cases, use sentence case.

## Pluralization

- Don't pluralize a product or feature name by adding _s_
  if doing so changes a trademark.
  For example, write "three Flutter SDKs" instead of "three Flutters".
- Don't inflect a code term to make it plural or possessive.
  Add a noun and inflect that noun instead,
  such as "several `Foo` objects", not "several `Foo`s".
- Avoid "(s)" to indicate optional plural ("file(s)").
  Use the plural form or rephrase.

## Possessives

- Form the possessive of a singular noun with _'s_,
  even if it ends in _s_, as in "the class's method".
- Don't make a product or company name possessive.
  For example, write
  "the Flutter SDK settings", not "Flutter SDK's settings".
- Avoid possessives with UI labels and code identifiers.
  For example, write "the value of the `name` field",
  not "the `name` field's value".

## Prepositions

- Avoid stacking prepositions and noun strings that obscure meaning.
  Break them up.
- Use _about_, not _on_, for cross-references that describe their target
  such as in "for more information about indexes".

## Pronouns

- Use singular _they_ for a person of unspecified gender.
  Don't default to _he_ or use _he/she_.
- Make sure every pronoun has a clear, nearby antecedent.
  Rewrite ambiguous references.
- When a demonstrative pronoun such as _this_ or _these_
  could have an unclear antecedent, add a noun:
  "This setting controls retries", not "This controls retries".
- Don't use _one_ as a generic pronoun in instructional prose.
  Use _you_.

## Sentence structure

- Put the **condition or context before the action**:
  "To deploy, run the command" instead of "Run the command to deploy".
  Similarly, write "If the token expires, request a new one".
- Keep the subject and verb close together.
  Don't separate them with long clauses.
- Prefer one idea per sentence.
  Break long sentences into shorter ones or a list.
- Avoid noun stacks such as "data pipeline configuration validation error".
  Rewrite them as a phrase with prepositions or verbs.

## Verb forms in reference documentation

- Describe what a method, function, or command does using third-person present:
  "Returns the user's ID",
  "Creates a new bucket",
  and "Throws an error if the input is invalid".
- Start a method or function summary with a verb,
  not "This method returns a value".
- Be consistent.
  If one entry starts "Gets the value",
  and the behavior doesn't differ,
  don't write "Returns the value" for a parallel entry.
- For parameters, describe what they are and their constraints,
  not what the reader should "pass in" narratively.
