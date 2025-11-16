---
title: Merged threads on Linux
description: >-
  Learn about the threading changes on Linux in Flutter 3.39.
---

## Summary

Flutter 3.39 merges the UI and platform threads by default on Linux.

## Context

Originally, Flutter had separate threads to produce UI frames and
to interact with the native platform.

The split-thread design prevented Flutter apps and plugins from using Dart FFI
to interoperate with native APIs that must be called on the platform thread.

## Description of change

Flutter version 3.39 merges the UI and platform threads by default on Linux.

This mirrors all the other platforms, whose threads were merged by default in
Flutter 3.29 (iOS and Android) and 3.35 (macOS and Windows).

## Migration guide

Merged threads shouldn't affect your app.

If you suspect merged threads have caused regressions to your app,
please reach out on [Issue 150525][].

## Timeline

Landed in version: 3.39.0-0.1.pre<br>
In stable release: Not yet

## References

Relevant issue:

* [Issue 150525][]

Relevant PRs:

* [PR 176759][]

[Issue 150525]: {{site.repo.flutter}}/issues/150525
[PR 176759]: {{site.repo.flutter}}/pull/176759
