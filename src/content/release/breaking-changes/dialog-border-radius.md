---
title: Dialogs' Default BorderRadius
description: The default BorderRadius of Dialog widgets is changing.
---

{% render docs/breaking-changes.md %}

## Summary

Instances of `Dialog`, as well as
`SimpleDialog`, `AlertDialog`, and `showTimePicker`,
now have a default shape of a `RoundedRectangleBorder`
with a `BorderRadius` of 4.0 pixels.
This matches the current specifications of Material Design.
Prior to this change, the default behavior for
`Dialog.shape`'s `BorderRadius` was 2.0 pixels.

## Context

`Dialog`s and their associated subclasses
(`SimpleDialog`, `AlertDialog`, and `showTimePicker`), appears
slightly different as the border radius is larger.
If you have master golden file images that have the
prior rendering of the `Dialog` with a 2.0 pixel border radius,
your widget tests will fail.
These golden file images can be updated to reflect the new rendering,
or you can update your code to maintain the original behavior.

The `showDatePicker` dialog already matched
this specification and is unaffected by this change.

## Migration guide

If you prefer to maintain the old shape, you can use
the shape property of your `Dialog` to specify the original 2 pixel radius.

Setting the Dialog shape to the original radius:

```dart
import 'package:flutter/material.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Alert!'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
              );
            },
          );
        }),
      ),
    );
  }
}
```

If you prefer the new behavior and have failing golden file tests,
you can update your master golden files using this command:

```console
flutter test --update-goldens
```

## Timeline

Landed in version: 1.20.0-0.0.pre<br>
In stable release: 1.20

## References

API documentation:

* [`Dialog`][]
* [`SimpleDialog`][]
* [`AlertDialog`][]
* [`showTimePicker`][]
* [`showDatePicker`][]

Relevant PR:

* [PR 58829: Matching Material Spec for Dialog shape][]

[`Dialog`]: {{site.api}}/flutter/material/Dialog-class.html
[`SimpleDialog`]: {{site.api}}/flutter/material/SimpleDialog-class.html
[`AlertDialog`]: {{site.api}}/flutter/material/AlertDialog-class.html
[`showTimePicker`]: {{site.api}}/flutter/material/showTimePicker.html
[`showDatePicker`]: {{site.api}}/flutter/material/showDatePicker.html
[PR 58829: Matching Material Spec for Dialog shape]: {{site.repo.flutter}}/pull/58829
