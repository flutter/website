---
title: Added missed `dispose()` for some disposable objects in Flutter
description: >
  'dispose()' may fail because of double disposal.
---

## Summary

Missed 'dispose()' are added for some disposable objects. If some other code
also invoked 'dispose()' for these objects, and the class is protected from double
disposal, the second 'dispose()' will fail with error message:

`Once you have called dispose() on a <class name>, it can no longer be used.` 

## Background

There is a rule that owner of an object should dispose it.

This rule was broken in number of places: some owners did not dispose disposable objects.
The issue was fixed by adding `dispose()`. The added `dispose()` can cause failures in debug mode,
if there is another `dispose()`, and the class is protected from double disposal.

## Migration guide

If you got error like `Once you have called dispose() on a <class name>, it can no longer be used.`,
and the error is raised for your code, 
update the code to call `dispose()' only in cases when your code created the object.

Code before migration:

```dart
x.dispose();
```

Code after migration:

```dart
if (xIsCreatedByMe) {
  x.dispose();
}
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
