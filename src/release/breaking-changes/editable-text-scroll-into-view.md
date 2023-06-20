---
title: Updated EditableText scroll into view behavior
description: >
  Improve EditableText selection scroll into view behavior to always
  use the current selection extent.
---

## Summary

`Editable.onCaretChanged` callback is removed and with this change,
`EditableText` behavior with regard to scrolling the selection into view
changes.

## Context

To date, `EditableText` has used multiple mechanisms ensuring the selection
extent or caret is scrolled into view on updates. 

## Description of change

By removing the `Editable.onCaretChanged` callback, `EditableText` will always
use the most up to selection extent location when scrolling to show it.
Specifically this results in improved scroll into view behavior after
changing selection from collapsed to non-collapsed via
`userUpdateTextEditingValue()`.

## Timeline

Landed in version: 3.12.0-4.0.pre<br>
In stable release: 3.13.0

## References

API documentation:

* [`EditableText`]({{site.api}}/flutter/widgets/EditableText-class.html)

Relevant PRs:

* [109114: Remove Editable.onCaretChanged callback]({{site.repo.flutter}}/pull/109114)
