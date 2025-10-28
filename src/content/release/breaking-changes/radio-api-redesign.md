---
title: Redesigned the Radio widget
description: >-
  Learn about changes to the radio widget in Flutter 3.35.
---

{% render "docs/breaking-changes.md" %}

## Summary

Introduced the `RadioGroup` widget to centralize `groupValue` management and the `onChanged`
callback for a set of `Radio` widgets. As a result, the individual `Radio.groupValue` and
`Radio.onChanged` properties have been deprecated.

## Context

To meet APG (ARIA Practices Guide) requirements for keyboard navigation and
semantic properties in radio button groups, Flutter needed a dedicated radio group concept.
Introducing a wrapper widget, `RadioGroup`, provides this out-of-the-box support.
This change also presented an opportunity to simplify the API for individual `Radio` widgets.

## Description of change

The following API is deprecated:

* `Radio.onChanged`
* `Radio.groupValue`
* `CupertinoRadio.onChanged`
* `CupertinoRadio.groupValue`
* `RadioListTile.groupValue`
* `RadioListTile.onChanged`.

## Migration guide

If you are using these properties, you can refactor them with `RadioGroup`.

### Case 1: trivial case

Code before migration:

```dart
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Radio<int>(
        value: 0,
        groupValue: _groupValue,
        onChanged: (int? value) {
          setState(() {
            _groupValue = value;
          });
        },
      ),
      Radio<int>(
        value: 2,
        groupValue: _groupValue,
        onChanged: (int? value) {
          setState(() {
            _groupValue = value;
          });
        },
      ),
    ],
  );
}
```

Code after migration:

```dart
Widget build(BuildContext context) {
  return RadioGroup<int>(
    groupValue: _groupValue,
    onChanged: (int? value) {
      setState(() {
        _groupValue = value;
      });
    },
    child: Column(
      children: <Widget>[
        Radio<int>(value: 0),
        Radio<int>(value: 2),
      ],
    ),
  );
}
```

### Case 2: disabled radio

Code before migration:

```dart
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Radio<int>(
        value: 0,
        groupValue: _groupValue,
        onChanged: (int? value) {
          setState(() {
            _groupValue = value;
          });
        },
      ),
      Radio<int>(
        value: 2,
        groupValue: _groupValue,
        onChanged: null, // disabled
      ),
    ],
  );
}
```

Code after migration:

```dart
Widget build(BuildContext context) {
  return RadioGroup<int>(
    groupValue: _groupValue,
    onChanged: (int? value) {
      setState(() {
        _groupValue = value;
      });
    },
    child: Column(
      children: <Widget>[
        Radio<int>(value: 0),
        Radio<int>(value: 2, enabled: false),
      ],
    ),
  );
}
```

### Case 3: mixed group or multi-selection

Code before migration:

```dart
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Radio<int>(
        value: 1,
        groupValue: _groupValue,
        onChanged: (int? value) {
          setState(() {
            _groupValue = value;
          });
        }, // disabled
      ),
      Radio<String>(
        value: 'a',
        groupValue: _stringValue,
        onChanged: (String? value) {
          setState(() {
            _stringValue = value;
          });
        },
      ),
      Radio<String>(
        value: 'b',
        groupValue: _stringValue,
        onChanged: (String? value) {
          setState(() {
            _stringValue = value;
          });
        },
      ),
      Radio<int>(
        value: 2,
        groupValue: _groupValue,
        onChanged: (int? value) {
          setState(() {
            _groupValue = value;
          });
        }, // disabled
      ),
    ],
  );
}
```

Code after migration:

```dart
Widget build(BuildContext context) {
  return RadioGroup<int>(
    groupValue: _groupValue,
    onChanged: (int? value) {
      setState(() {
        _groupValue = value;
      });
    },
    child: Column(
      children: <Widget>[
        Radio<int>(value: 1),
        RadioGroup<String>(
          child: Column(
            children: <Widget>[
              Radio<String>(value: 'a'),
              Radio<String>(value: 'b'),
            ]
          ),
        ),
        Radio<int>(value: 2),
      ],
    ),
  );
}
```

## Timeline

Landed in version: 3.34.0-0.0.pre<br>
In stable release: 3.35

## References

* [`APG`][]

API documentation:

* [`Radio`][]
* [`CupertinoRadio`][]
* [`RadioListTile`][]
* [`RadioGroup`][]

Relevant issue:

* [Issue 113562][]

Relevant PR:

* [PR 168161][]

[`APG`]: https://www.w3.org/WAI/ARIA/apg/patterns/radio
[`Radio`]: {{site.api}}/flutter/material/Radio-class.html
[`RadioListTile`]: {{site.api}}/flutter/material/RadioListTile-class.html
[`CupertinoRadio`]: {{site.api}}/flutter/cupertino/CupertinoRadio-class.html
[`RadioGroup`]: {{site.api}}/flutter/widgets/RadioGroup-class.html
[Issue 113562]: {{site.repo.flutter}}/issues/113562
[PR 168161]: {{site.repo.flutter}}/pull/168161
