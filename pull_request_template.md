## Writing Checklist

If your PR involves adding or updating writing content,
please check the following items before submitting your PR for review:

- [ ] Avoid [inline links]. Instead, use [reference links] with a list of [link reference definitions] at the bottom of your page.

### Example:

Not recommended:

```md
For more information, consult [reference links](https://github.github.com/gfm#reference-links) for [GitHub Flavored Markdown](https://github.github.com/gfm).

```

Recommended:

```md
For more information, consult [reference links] for [GitHub Flavored Markdown].

(Include this list of link reference definitions at the bottom of the markdown file)

[reference links]: https://github.github.com/gfm/#reference-link
[GitHub Flavored Markdown]: https://github.github.com/gfm/
```

- [ ] Avoid duplicating a referenced link definition by using
    [link labels] after [reference links].

### Example:

Not recommended:
```md
[Foo] and [bar] link to the same URL.

[Foo]: https://google.com
[bar]: https://google.com
```

Recommended:
```md
[Foo][google] and [bar][google] link to the same URL.

[google]: https://google.com
```

- [ ] Never link on the words "here", "click here", or "this document".
    Instead, use a phrase that describes what the reader will see.
    For more information, see the Google Developer Style Guide pages on
    [link text] and [cross references].

- [ ] Use the present tense, and [avoid future tense].
    One way to check for future tense in your docs
    is to search for "will" and remove it wherever possible.

- [ ] Where possible, use [active voice].

#### Example

Not recommended (passive):

```md
"There is no equivalent in Flutter."
```

Recommended (active):

```md
"Flutter has no equivalent."
```

One way to help identify passive voice
is to search for "there is" or "there are" or other versions of "to be".
- [ ] Avoid writing in first person.
    If needed, use [second person].
    Better yet, rewrite to avoid either.

#### Example

Not recommended (first person):

```md
"In this section, we'll..."
```

Better (second person):

```md`
"In this section, you'll..."
```

Even better (imperative with implied subject):

```md
"In this section, learn how to..."
```
When translated to other languages, even second person can be problematic.

- [ ] [Validate site links] prior to submitting your PR
    by running`./tool/shared/check-links.sh` from the project root directory.

[second person]: https://developers.google.com/style/person
[active voice]: https://developers.google.com/style/voice
[link text]: https://developers.google.com/style/link-text
[cross references]: https://developers.google.com/style/cross-references
[link labels]: https://github.github.com/gfm#link-label
[inline links]: https://github.github.com/gfm/#inline-link
[link reference definitions]: https://github.github.com/gfm/#link-reference-definition
[reference links]: https://github.github.com/gfm/#reference-link
[kramdown link definition]: https://kramdown.gettalong.org/syntax.html#link-definitions
[style guide page on links]: https://developers.google.com/style/link-text
[avoid future tense]: https://developers.google.com/style/tense
[Validate site links]: https://github.com/flutter/website/blob/master/README.md#developing