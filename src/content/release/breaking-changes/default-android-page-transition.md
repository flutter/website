---
title: Replace with title of breaking change
description: Brief description similar to the "context" section below. The description shouldn't have any linebreaks - let it go long and wrap. Text below should break at 80 chars or less.
---

{% comment %}
  PLEASE READ THESE GENERAL INSTRUCTIONS:
  * All lines of text should be 80 chars OR LESS.
    The writers strongly prefer semantic line breaks:
    https://github.com/dart-lang/site-shared/blob/master/doc/writing-for-dart-and-flutter-websites.md#semantic-line-breaks
  * DON'T SUBMIT a PR weeks and weeks in advance.
    Doing this causes it to get stanky in the website
    repo and usually develops conflicts in the index file.
    Ideally, submit a PR once you have confirmed
    info on the version number where the breaking
    change landed.
  * One of the most important things to fill out 
    in this template is the *Timeline* section.
    I won't approve/merge the PR until the "landed in"
    release info is provided. For example:
    `Landed in version: 1.21.0-5.0.pre<br>`.
    Do NOT list the PR in this section. Also, don't
    fill in the "stable" release info unless it's
    already in a published stable release.
    After a stable release, I go through and confirm
    that updates have made it to stable and I then
    update the breaking change and the index file.
  * The text in this page should be backwards looking,
    so write about previous behavior in past tense,
    not future tense. People are reading this months
    from now when the change is likely in the stable
    release, not today. Don't say "in a month" or
    talk about your plan to do something next week.
    Assume you've done it, and that they're looking
    back to figure out how to migrate their code.
  * Use sentence case for headings and titles.
    (`## Migration guide`, NOT `Migration Guide`)
  * DON'T use the abbreviation `i.e.` or `e.g.`.
    Use "for example" or "such as", and similar.
  * For links, use the macros where possible.
    See the examples at the end of this template,
    but don't use "github.com" or "api.flutter.dev" or
    "pub.dev" in your URLs. Use the {{site.github}},
    {{site.api}}, or {{site.pub}} macros.
  * AVOID "will" when possible, in other words,
    stay in the present tense. For example:
    Bad: "When encountering an xxx value,
          the code will throw an exception."
    Good: "When encountering an xxx value,
           the code throws an exception."
    Good use of "will": "In release 2.0, the xxx API
          will be deprecated."
  * If your included Dart code won't pass analysis
    on its own (using the analyzer from the latest
    stable release), then preface that code with an
    HTML `<!-- skip -->` tag.
  * Finally, delete the comment tags and text from the
    final PR.
{% endcomment %}

## Summary

{% comment %}
  A brief (one- to three-line) summary that gives
  context as to what changed so that someone can
  find it when browsing through an index of
  breaking changes, ideally using keywords from
  the symptoms you would see if you had not yet
  migrated (for example, the text from probable
  error messages).
{% endcomment %}

## Context

{% comment %}
  High-level description of what API changed and why.
  Should be clear enough to be understandable to someone
  who has no context about this breaking change,
  such as someone who doesn't know the underlying API.
  This section should also answer the question
  "what is the problem that led to considering making
  a breaking change?"
{% endcomment %}

## Description of change

{% comment %}
A technical description of the actual change,
with code samples showing how the API changed.

Include examples of the error messages that are produced
in code that has not been migrated. This helps the search
engine find the migration guide when people search for those
error messages.
{% endcomment %}

## Migration guide

{% comment %}
  A description of how to make the change.
  If a migration tool is available,
  discuss it here. Even if there is a tool,
  a description of how to make the change manually
  must be provided. This section needs before and
  after code examples that are relevant to the
  developer.
{% endcomment %}

Code before migration:

<!-- skip -->
```dart
// Example of code before the change.
```

Code after migration:

<!-- skip -->
```dart
// Example of code after the change.
```

## Timeline

{% comment %}
  The version # of the SDK where this change was
  introduced.  If there is a deprecation window,
  the version # to which we guarantee to maintain
  the old API. Use the following template:

  If a breaking change has been reverted in a
  subsequent release, move that item to the
  "Reverted" section of the index.md file.
  Also add the "Reverted in version" line,
  shown as optional below. Otherwise, delete
  that line.
{% endcomment %}

Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

{% comment %}
  These links are commented out because they
  cause the GitHubActions (GHA) linkcheck to fail.
  Remove the comment tags once you fill this in with
  real links. Only use the "master-api" include if
  you link to "master-api.flutter.dev".

{% include master-api.md %}

API documentation:

* [`ClassName`][]

Relevant issues:

* [Issue xxxx][]
* [Issue yyyy][]

Relevant PRs:

* [PR title #1][]
* [PR title #2][]
{% endcomment %}

{% comment %}
  Add the links to the end of the file in alphabetical order.
  The following links are commented out because they make
  the GitHubActions (GHA) link checker believe they are broken links,
  but please remove the comment tags before you commit!

  If you are sharing new API that hasn't landed in
  the stable channel yet, use the master channel link.
  To link to docs on the master channel,
  include the following note and make sure that
  the URL includes the master link (as shown below).

  Here's an example of defining a stable (site.api) link
  and a master channel (master-api) link.

<!-- Stable channel link: -->
[`ClassName`]: {{site.api}}/flutter/[link_to_relevant_page].html

<!-- Master channel link: -->
{% include master-api.md %}

[`ClassName`]: https://master-api.flutter.dev/flutter/[link_to_relevant_page].html

[Issue xxxx]: {{site.github}}/flutter/flutter/issues/[link_to_actual_issue]
[Issue yyyy]: {{site.github}}/flutter/flutter/issues/[link_to_actual_issue]
[PR title #1]: {{site.github}}/flutter/flutter/pull/[link_to_actual_pr]
[PR title #2]: {{site.github}}/flutter/flutter/pull/[link_to_actual_pr]
{% endcomment %}
