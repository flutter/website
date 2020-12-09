---
title: The forgetChild() method must call super
description: Any element subclasses that override forgetChild are required to call super.
---

## Summary

A recent global key duplication detection refactor now requires
`Element` subclasses that override the `forgetChild()` to call `super()`.

## Context

When encountering a global key duplication that will be
cleaned up by an element rebuild later,
we must not report global key duplication.
Our previous implementation threw an error as soon as
duplication was detected, and didn't wait for the rebuild if the
element with the duplicated global key would have rebuilt.

The new implementation keeps track of all global
key duplications during a build cycle, and only verifies global
key duplication at the end of the that cycle instead of
throwing an error immediately. As part of the refactoring,
we implemented a mechanism to remove previous global key
duplication in `forgetChild` if the rebuild had happened.
This, however, requires all `Element` subclasses that
override `forgetChild` to call the `super` method.

## Description of change

The `forgetChild` of abstract class `Element` has a base
implementation to remove global key reservation,
and it is enforced by the `@mustCallSuper` meta tag.
All subclasses that override the method have to call `super`;
otherwise, the analyzer shows a linting error and
global key duplication detection might throw an unexpected error.

## Migration guide

In the following example, an app's `Element`
subclass overrides the `forgetChild` method.

Code before migration:

<!-- skip -->
```dart
class CustomElement extends Element {

    @override
    void forgetChild(Element child) {
        ...
    }
}
```

Code after migration:

<!-- skip -->
```dart
class CustomElement extends Element {

    @override
    void forgetChild(Element child) {
        ...
        super.forgetChild(child);
    }
}
```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

API documentation:
* [`Element`][]
* [`forgetChild()`][]

Relevant issues:
* [Issue 43780][]

Relevant PRs:
* [PR 43790: Fix global key error][]


[`Element`]: {{site.api}}/flutter/widgets/Element-class.html
[`forgetChild()`]: {{site.api}}/flutter/widgets/Element/forgetChild.html
[Issue 43780]: {{site.github}}/flutter/flutter/issues/43780
[PR 43790: Fix global key error]: {{site.github}}/flutter/flutter/pull/46183
