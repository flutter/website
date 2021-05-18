---
title: unnecessary imports
description: The Dart analyzer reports unnecessary imports which can safely be removed.
---

## Summary

The Dart analyzer reports unnecessary imports which can safely be removed.

## Context

Imports which provide a subset of the elements provided by another import are
considered unnecessary and can safely be removed. The Dart analyzer reports
such "unnecessary imports."

Unnecessary imports can represent code bloat and cause confusion with regards
to why one Dart library imports another.

## Description of change

The Dart analyzer reports unnecessary imports which can safely be removed.

Take this example Dart library:

```dart
import 'package:characters/characters.dart';
import 'package:flutter/widgets.dart';

void f(Characters characters, Actions actions) {}
```

This code uses two elements from `widgets.dart` (Characters and Actions), and
one element from `characters.dart` (Characters). `widgets.dart` exports
`characters.dart`. The import for `characters.dart` is therefore unnecessary;
it provides a strict subset of the used elements which the `widgets.dart`
import provides.

The Dart analyzer will report the following:

> The import of 'package:characters/characters.dart' is unnecessary as all of
> the used elements are also provided by the import of
> 'package:flutter/widgets.dart'

## Migration guide

If an import is reported as "unnecessary" by the Dart analyzer, it can safely
be removed.

Code before migration:

<!-- skip -->
```dart
import 'package:characters/characters.dart';
import 'package:flutter/widgets.dart';

void f(Characters characters, Actions actions) {}
```

Code after migration:

<!-- skip -->
```dart
import 'package:flutter/widgets.dart';

void f(Characters characters, Actions actions) {}
```

## Timeline

Landed in version: xxx<br>
In stable release: not yet

## References

Relevant issues:

* [Issue 44569][]

[Issue 44569]: {{site.github}}/dart-lang/sdk/issues/44569
