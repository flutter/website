---
title: Merged threads on macOS and Windows
description: >-
  Learn about threading changes on macOS and Windows in Flutter 3.35.
---

{% render "docs/breaking-changes.md" %}

## Summary

Flutter 3.35 merges the UI and platform threads by default on macOS and Windows.

## Context

Originally, Flutter had separate threads to produce UI frames and to
interact with the native platform.

The split-thread design prevented Flutter apps and plugins from using Dart FFI
to interoperate with native APIs that must be called on the platform thread.

## Description of change

Flutter 3.35 merges the UI and platform threads by default on macOS and Windows.

This mirrors iOS and Android, whose threads were merged by default in
Flutter 3.29.

## Migration guide

Merged threads should not affect your app.

If you suspect merged threads has regressed your app, please reach out on
[Issue 150525][].

## Timeline

Landed in version: 3.33.0-0.0.pre<br>
In stable release: 3.35

## References

Relevant issue:

* [Issue 150525][]

Relevant PRs:

* [PR 166536][]
* [PR 167472][]

[Issue 150525]: {{site.repo.flutter}}/issues/150525
[PR 166536]: {{site.repo.flutter}}/pull/166536
[PR 167472]: {{site.repo.flutter}}/pull/167472
