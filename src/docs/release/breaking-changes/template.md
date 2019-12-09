---
title: [Title of breaking change]
description: [Brief description similar to the "context" section below.]
---

# [Title of breaking change, which should give context as to what changed so that someone can find it when browsing through an index of breaking changes, ideally using keywords from the symptoms you would see if you had not yet migrated (i.e. when you get broken)]


## Context

[High-level description of what API changed and why.
Should be clear enough to be understandable to someone
who has no context about this breaking change,
such as someone who doesn't know the underlying API.
This section should also answer the question
"what is the problem that led to considering making
a breaking change?"]


## Description of change

[A dry technical description of the actual change,
with code samples.]


## Migration guide

[A description of how to make the change.
If a migration tool is available,
discuss it here. Even if there is a tool,
a description of how to make the change manually must be provided.]

### Before

```dart
[Example of code before the change.]
```

### After

```dart
[Example of code after the change.]
```


## Timeline

[Details regarding when the change was made.
If there is a deprecation window,
the date to which we guarantee to maintain the old API.]


## References

API documentation:
* https://api.flutter.dev/flutter/[link_to_relevant_page].html

Relevant issues:
* https://github.com/flutter/flutter/issues/[link_to_actual_issue]
* https://github.com/flutter/flutter/issues/[link_to_actual_issue]

Relevant PRs:
* https://github.com/flutter/flutter/pull/[link_to_actual_pr]
* https://github.com/flutter/flutter/pull/[link_to_actual_pr]
