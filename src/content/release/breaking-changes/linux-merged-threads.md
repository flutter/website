---
title: Merged threads on Linux
description: >-
  Learn about threading changes on Linux in Flutter FIXME:RELEASE_VERSION
---

## Summary

Flutter FIXME:RELEASE_VERSION merges the UI and platform threads by default on Linux.

## Context

Originally, Flutter had separate threads to produce UI frames and to
interact with the native platform.

The split-thread design prevented Flutter apps and plugins from using Dart FFI
to interoperate with native APIs that must be called on the platform thread.

## Description of change

Flutter FIXME:Next version merges the UI and platform threads by default on Linux.

This mirrors all the other platforms, whose threads were merged by default in
Flutter 3.29 (iOS and Android) and 3.35 (macOS and Windows).

## Migration guide

Merged threads should not affect your app.

If you suspect merged threads has regressed your app, please reach out on
[Issue 150525][].

## Timeline

Landed in version: FIXME:LANDED_VERSION<br>
In stable release: FIXME:RELEASE_VERSION

## References

Relevant issue:

* [Issue 150525][]

Relevant PRs:

* [PR 176759][]

[Issue 150525]: {{site.repo.flutter}}/issues/150525
[PR 176759]: {{site.repo.flutter}}/pull/176759

