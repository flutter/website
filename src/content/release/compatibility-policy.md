---
title: Flutter compatibility policy
description: How Flutter approaches the question of breaking changes.
---

The Flutter team tries to balance the need for API stability with the
need to keep evolving APIs to fix bugs, improve API ergonomics,
and provide new features in a coherent manner.

To this end, we have created a test registry where you can provide
unit tests for your own applications or libraries that we run
on every change to help us track changes that would break
existing applications. Our commitment is that we won't make any
changes that break these tests without working with the developers of
those tests to (a) determine if the change is sufficiently valuable,
and (b) provide fixes for the code so that the tests continue to pass.

If you would like to provide tests as part of this program, please
submit a PR to the [flutter/tests repository][]. 
The [README][flutter-tests-readme] on that repository describes 
the process in detail.

[flutter/tests repository]: {{site.github}}/flutter/tests
[flutter-tests-readme]: {{site.github}}/flutter/tests#adding-more-tests

## Announcements and migration guides

If we do make a breaking change (defined as a change that caused one
or more of these submitted tests to require changes), we will announce
the change on our [flutter-announce][]
mailing list as well as in our release notes.

We provide a list of [guides for migrating code][] affected by
breaking changes.

[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[guides for migrating code]: /release/breaking-changes

## Deprecation policy

We will, on occasion, deprecate certain APIs rather than outright
break them overnight. This is independent of our compatibility policy
which is exclusively based on whether submitted tests fail, as
described above.

The Flutter team doesn't remove deprecated APIs on a scheduled basis.
If the team removes a deprecated API,
it follows the same procedures as those for breaking changes.


## Dart and other libraries used by Flutter

The Dart language itself has a [separate breaking-change policy][],
with announcements on [Dart announce][].

In general, the Flutter team doesn't currently have any commitment
regarding breaking changes for other dependencies.
For example, it's possible that a new version of
Flutter using a new version of Skia
(the graphics engine used by some platforms on Flutter)
or Harfbuzz (the font shaping engine used by Flutter)
would have changes that affect contributed tests.
Such changes wouldn't necessarily be accompanied by a
migration guide.

[separate breaking-change policy]: {{site.github}}/dart-lang/sdk/blob/main/docs/process/breaking-changes.md
[Dart announce]: {{site.groups}}/a/dartlang.org/g/announce
