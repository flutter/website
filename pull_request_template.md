## Writing Checklist

If your PR involves adding or updating writing content,
please check the following items before submitting your PR for review:

- [ ] Use [kramdown link definition] syntax for all links.
- [ ] If needed, also use [kramdown reference link] syntax.
- [ ] Never link on the words "here", "click here", or "this document".
Instead, use a phrase that describes what the reader will see.
See the google developer [style guide page on links] for more information.
- [ ] Use the present tense, and [avoid the future tense].
- [ ] [Validate site links] prior to submitting your PR by running `./tool/shared/check-links.sh` from the project root directory).

[kramdown link definition]: https://kramdown.gettalong.org/syntax.html#link-definitions
[style guide page on links]: https://developers.google.com/style/link-text
[avoid the future tense]: https://developers.google.com/style/tense
[Validate site links]: https://github.com/flutter/website/blob/master/README.md#developing