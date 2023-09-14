---
title: Added missed `dispose()` for some disposable objects in Flutter
description: >
  'dispose()' may fail because of usage after disposal.
---

## Summary

{% comment %}
  Missed 'dispose()' are added for some disposable objects. If some other code
  also invoked 'dispose()' for these objects, and the class is protected from double
  disposal, the second 'dispose()' will fail with error message:

  Once you have called dispose() on a <class name>, it can no longer be used.  
{% endcomment %}

## Background

{% comment %}
  High-level description of what API changed and why.
  Should be clear enough to be understandable to someone
  who has no context about this breaking change,
  such as someone who doesn't know the underlying API.
  This section should also answer the question
  "what is the problem that led to considering making
  a breaking change?"

  Include a technical description of the actual change,
  with code samples showing how the API changed.

  Include examples of the error messages that are produced
  in code that has not been migrated. This helps the search
  engine find the migration guide when people search for those
  error messages. THIS IS VERY IMPORTANT FOR DISCOVERY!
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

```dart
// Example of code before the change.
```

Code after migration:

```dart
// Example of code after the change.
```

{% comment %}
  Make sure you have looked for old tutorials online that
  use the old API. Contact their authors and point out how
  they should be updated. Leave a comment pointing out that
  the API has changed and linking to this guide.
{% endcomment %}

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
  you link to "master-api.flutter.dev"; prefer our
  stable documentation if possible.

{% include docs/master-api.md %}

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
{% include docs/master-api.md %}

[`ClassName`]: {{site.master-api}}/flutter/[link_to_relevant_page].html

[Issue xxxx]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[Issue yyyy]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[PR title #1]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
[PR title #2]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
{% endcomment %}
