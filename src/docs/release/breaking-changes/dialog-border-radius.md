---
title: Dialogs' Default BorderRadius
description: The default BorderRadius of Dialog widgets is changing.
---

## Summary

Instances of `Dialog`, as well as `SimpleDialog`, `AlertDialog`, and `showTimePicker`, will now have
a default shape of a `RoundedRectangleBorder` with a `BorderRadius` of 4.0 pixels. This matches the
current specifications of Material Design. Prior to this change, the default behavior for
`Dialog.shape`'s `BorderRadius` was 2.0 pixels.

## Context

Use of `Dialog`s and their associated subclasses (`SimpleDialog`, `AlertDialog`, and
`showTimePicker`), will appear slightly different. Golden file tests will fail if they contain a
`Dialog` in the new default behavior.

This change was initially introduced with an opt-in flag
`useMaterialBorderRadius`, to allow developers time to migrate
without experiencing broken code. This temporary opt-in flag will be removed in a follow up change.

The `showDatePicker` dialog already matches this specification and is unaffected by this change.

## Migration guide

By applying the opt-in flag, `useMaterialBorder`, you can check the layout of your `Dialog` widgets
and check against exiting tests to see if they need to be updated.

Code before migration:

```dart
import 'package:flutter/material.dart';
void main() => runApp(Foo());
class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(content: Text('Alert!'));
              },
            );
          }
        ),
      ),
    );
  }
}
```

If you would like to maintain the original default behavior, you can pass the prior default shape.
Code after migrating to keep original default shape:

```dart
import 'package:flutter/material.dart';
void main() => runApp(Foo());
class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('Alert!'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
```

Code to validate migration:

```dart
import 'package:flutter/material.dart';
void main() => runApp(Foo());
class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('Alert!'),
                  useMaterialBorderRadius: true,
                );
              },
            );
          }
        ),
      ),
    );
  }
}
```

## Timeline

TBD - Add the version number that contains this change.

## References

API documentation:
* [`Dialog`][]
* [`SimpleDialog`][]
* [`AlertDialog`][]
* [`showTimePicker`][]
* [`showDatePicker`][]


Relevant PR:
* [PR 56084: Add opt-in fixing Dialog border radius to match Material Spec][]

[`Dialog`]: {{site.api}}/flutter/material/Dialog-class.html
[`SimpleDialog`]: {{site.api}}/flutter/widgets/SimpleDialog-class.html
[`AlertDialog`]: {{site.api}}/flutter/material/AlertDialog-class.html
[`showTimePicker`]: {{site.api}}/flutter/material/showTimePicker.html
[`showDatePicker`]: {{site.api}}/flutter/material/showDatePicker.html
[PR 56084: Add opt-in fixing Dialog border radius to match Material Spec]: {{site.github}}/flutter/flutter/pull/56084
