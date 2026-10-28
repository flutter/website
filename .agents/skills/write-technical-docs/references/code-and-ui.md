# Code and UI documentation conventions

Use these rules for code, command lines, placeholders, and UI interactions.

## Code in text

Use **code font** for code-related text in running prose.
Code font is monospace and is delimited by backticks in Markdown.
Apply it to:

- Keywords, language constructs, and reserved words
- Function, method, class, and variable names
- Filenames, file paths, and directory names
- Commands, subcommands, flags, and options
- Literal values the reader types or sees,
  such as `true`, `null`, `200`, and `UTF-8`
- HTTP methods, status codes, and header names
- Environment variable names

Don't use code font for:

- Ordinary words that merely relate to code conceptually.
- Product, feature, or company names, which use plain text.
- UI labels, which use bold.
- Non-code placeholders that don't represent sample code or commands.
  Use the variable convention in
  [Placeholder formatting](#placeholder-formatting).

Match the exact capitalization and spelling of the code item.
Don't inflect a code term to make it plural or possessive.
Add a noun and inflect that noun instead.
For example, write "several `Foo` objects" instead of "several `Foo`s".

## Code samples

- Make samples correct, complete enough to run or adapt, and minimal:
  show the point without unrelated boilerplate.
- Introduce a sample with a sentence explaining what it does before showing it.
- Use realistic but safe example values
  according to [Word choice](word-choice.md).
  Never include real credentials, keys, or personal data.
- Follow the language's idioms and formatting conventions.
  Keep indentation consistent.
- Show expected output separately from the command or code that produces it.
- Don't require readers to infer placeholder values.
  Call them out and explain what to substitute.
- Keep comments in samples brief and useful.
  Don't narrate the obvious.

## Command-line syntax

- Show commands in code font.
  Unless you're distinguishing input from output,
  don't include shell prompts such as `$`, `#`, or `>`
  in copyable command blocks.
- Format optional arguments in square brackets,
  required placeholders according to the placeholder convention,
  and repeated arguments with an ellipsis.
  Use a documented syntax convention consistently.
- Put each long command on its own line.
  Use line continuations that the target shell understands.
- Separate the command from its output.
  Label or visually distinguish output.
- Explain non-obvious flags rather than assuming the reader knows them.

## Placeholder formatting

- Follow the target language or project's placeholder convention.
- For commands, configuration, and other contexts with no convention,
  use descriptive uppercase words separated by underscores.
  For example, `PROJECT_ID` and `BUCKET_NAME`.
- In source code,
  use a valid identifier that follows the language's style,
  such as `projectId` in Dart.
- For an inline placeholder in a command,
  combine code font with variable styling when the platform supports it,
  such as _`PROJECT_ID`_ in Markdown.
- For a placeholder that isn't part of code or a command,
  use the platform's variable style without code font,
  such as _PROJECT_ID_ in Markdown.
- In a fenced code block,
  use the placeholder as plain code.
  Inline emphasis doesn't render inside the fence.
- Explain every placeholder: what it represents, its format,
  and how to find or choose the value.
- Keep placeholder names descriptive and consistent across the document.
- Don't include possessive adjectives such as `MY_` or `YOUR_`
  in placeholder names.
- When using uppercase placeholder tokens,
  don't use angle-bracket syntax such as `<project-id>`.
  Apply one convention consistently within the document.

## UI elements and interaction

These conventions apply to development tools and to apps
that the documentation describes or helps readers create.
Match the interaction verb to the target platform and input method,
and preserve exact API identifiers such as `onTap`.

- Use **bold** for the names of UI elements:
  **Save**, the **Settings** menu, and the **Name** field.
  Match the label's capitalization
  unless the interface uses all-uppercase or inconsistent labels.
  In those cases, use sentence case.
- If a UI element is also a code value,
  apply both code and bold formatting.
- Use the right interaction verb:
  - **click** for mouse targets such as buttons, links, and list items.
    Don't write _click on_.
    Hyphenate _right-click_ and _double-click_.
  - **tap** for touch interfaces and on-screen or capacitive buttons.
  - **select** for choosing from a menu or list, and for marking a checkbox.
    Don't use _check_ to mean marking a checkbox.
  - **clear** to turn a checkbox off.
    Don't write _uncheck_ or _deselect_.
  - **press** for keyboard keys, key combinations, and mechanical buttons.
  - **enter** or **type** for text the reader inputs.
    Prefer _enter_ and tell them what to enter, not to "copy and paste".
- Don't refer to a link as a _button_.
  They are different controls.
- Describe elements by their label and type,
  not by screen position,
  as in "the **Delete** button", not "the button on the right".
- For navigation paths, name each element:
  "Click **Menu** > **Settings** > **Privacy**".
- Omit a trailing ellipsis from a UI label
  unless its absence could cause confusion.
- For keyboard shortcuts,
  use `<kbd>` in HTML or code font in other markup,
  and join spelled-out key names with a plus and no spaces
  as in `Control+S` or `Command+S` on macOS.
  Use uppercase for individual letter keys in most cases.
  When the audience spans platforms, mention both.

## API reference code comments

- Follow the target language's best practices for documentation comments.
  For example, for Dart doc comments, reference our guidelines at
  [Dart doc comments](../../write-dart/references/documentation.md).
- Describe parameters, return values, exceptions, errors,
  fields, and constants precisely.
  Include meaning, constraints, units, and defaults that aren't clear
  from the signature or schema.
  Include the type when the surrounding reference doesn't already show it.
- State whether a parameter is optional or required
  and what happens at boundaries such as `null`, empty, or out of range.
- Document deprecations clearly:
  state that the item is deprecated and what to use instead.
  If an official removal timeline exists, include it.
- Keep comments consistent in form across parallel items.

## Filenames and file types

- Use code font for actual filenames, paths, and extensions
  such as `config.yaml`, `/etc/hosts`, and `.json`.
- When referring generically to a file type in prose,
  use the extension without a dot and with its established capitalization.
  For example, "a YAML file" or "a PNG image".
- Follow the target language or project's filename convention.
  For example, Dart filenames use `lowercase_with_underscores`.
  For an invented prose-only filename with no applicable convention,
  use lowercase ASCII and separate words with hyphens.
- When referring to a specific file,
  include the noun _file_ after its code-formatted name,
  such as "the `pubspec.yaml` file".
- Use forward slashes in platform-neutral invented paths.
  Match the actual platform when documenting a literal path.
- Use _directory_ in a command-line context
  and _folder_ in a graphical interface context.
  If the context is unclear,
  use _directory_.
