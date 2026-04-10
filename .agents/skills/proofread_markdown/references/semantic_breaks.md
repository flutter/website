# Semantic Line Breaks

Semantic line breaks make Markdown files easier to read,
maintain, and review in diffs.
Instead of wrapping text at a strict character limit,
lines are broken at natural pauses.

- **Max length**: Try to keep lines under 80 characters.
- **Punctuation first**: Break lines after periods, commas, colons, and
  semicolons.
- **Natural pauses**: If a line is still too long after punctuation,
  break at natural pauses (for example, ends of phrases).
- **No mid-word breaks**: Never break a line in the middle of a word.
- **Safety**: Do not break URLs, file paths, or code strings.

## Examples

### Bad: Strict 80-character wrapping

This approach makes diffs hard to read
because changing one word reflows the entire paragraph.

```markdown
This is a very long sentence that is wrapped at exactly eighty characters
without considering the meaning of the words or the structure of the sentence.
```

### Good: Semantic line breaks

This approach keeps lines readable
and ensures that changes to one sentence only affect that line in the diff.

```markdown
This is a very long sentence,
that is wrapped at natural pauses
to make it easier to read and maintain.
```

Another example with list items:

```markdown
- This is a list item,
  broken at the comma.
- Here is another item
  that is broken at a natural pause.
```
