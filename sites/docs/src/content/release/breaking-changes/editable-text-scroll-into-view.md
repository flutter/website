---
title: Updated EditableText scroll into view behavior
description: >
  Improve EditableText selection scroll into view behavior to always
  use the current selection extent.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `Editable.onCaretChanged` callback is removed. With this change,
`EditableText` behavior for scrolling the selection into view
changes.

## Context

Previously, upon scrolling into view to show user updates, `EditableText`
used multiple mechanisms to determine the extent of the selection or the
caret location.

## Description of change

By removing the `Editable.onCaretChanged` callback, `EditableText` will always
use the most up-to-date selection extent location when scrolling to show it.
Specifically, this improves scroll into view behavior after
changing selection from collapsed to non-collapsed using
`userUpdateTextEditingValue()`.

## Timeline

Landed in version: 3.12.0-4.0.pre<br>
In stable release: 3.13.0

## References

API documentation:

* [`EditableText`]({{site.api}}/flutter/widgets/EditableText-class.html)

Relevant PRs:

* [109114: Remove Editable.onCaretChanged callback]({{site.repo.flutter}}/pull/109114)
