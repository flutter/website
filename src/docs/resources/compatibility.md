---
title: Flutter compatibility policy
description: How Flutter approaches the question of breaking changes.
---

The Flutter team tries to balance the need for API stability with the
need to keep evolving APIs to fix bugs, improve API ergonomics, and
provide new features in a coherent manner.

To this end, we have created a test registry where you can provide
unit tests for your own applications or libraries that we should run
on every change to help us track down when changes would break
existing applications. Our commitment is that we will not make any
changes that break these tests without working with the developers of
those tests to (a) determine if the change is sufficiently valuable
and (b) provide fixes for the code so that the tests continue to pass.

If you would like to provide tests as part of this program, please
submit a PR to the [flutter/tests
repository][https://github.com/flutter/tests]. The README.md file on
that repository describes the process in detail.


## Announcements and migration guides

If we do make a breaking change (defined as a change that caused one
or more of these submitted tests to require changes), we will announce
the change on our
[flutter-announce][https://groups.google.com/forum/#!forum/flutter-announce]
mailing list as well as in our release notes.

We provide a list of [guides for migrating
code][https://flutter.dev/docs/release/breaking-changes/] affected by
breaking changes.


## Deprecation policy

We will, on occasion, deprecate certain APIs rather than outright
break them overnight. Deprecations are not considered breaking
changes, though the eventual removal of the deprecated feature could
be (if it breaks any of the submitted tests).


## Dart and other libraries used by Flutter

The Dart language itself has a separate breaking-change policy,
[documented on the Dart
wiki][https://github.com/dart-lang/sdk/blob/master/docs/process/breaking-changes.md].

In general, the Flutter team does not currently have any commitment
regarding breaking changes for other dependencies. For example, it is
possible that a new version of Flutter using a new version of Skia
(the graphics engine used by Flutter) or Harfbuzz (the font shaping
engine used by Flutter) would have changes that affect contributed
tests. Such changes would not necessarily be accompanied by a
migration guide.
