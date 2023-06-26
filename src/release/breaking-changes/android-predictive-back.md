---
title: Android Predictive Back
description: >
  The ability to control back navigation at the time that a back gesture is
  received has been replaced with an ahead-of-time navigation API in order to
  support Android 14's Predictive Back feature.
---

{% comment %}
  PLEASE READ THESE GENERAL INSTRUCTIONS:
  * All lines of text should be 80 chars OR LESS.
    The writers strongly prefer semantic line breaks:
    https://github.com/dart-lang/site-shared/blob/main/doc/writing-for-dart-and-flutter-websites.md#semantic-line-breaks
  * DON'T SUBMIT a PR weeks and weeks in advance.
    Doing this causes it to get stanky in the website
    repo and usually develops conflicts in the index file.
    Ideally, submit a PR once you have confirmed
    info on the version number where the breaking
    change landed.
  * One of the most important things to fill out 
    in this template is the *Timeline* section.
    I won't approve/merge the PR until the "landed in"
    release info is provided. For example:
    `Landed in version: 1.21.0-5.0.pre<br>`.
    Do NOT list the PR in this section. Also, don't
    fill in the "stable" release info unless it's
    already in a published stable release.
    After a stable release, I go through and confirm
    that updates have made it to stable and I then
    update the breaking change and the index file.
  * The text in this page should be backwards looking,
    so write about previous behavior in past tense,
    not future tense. People are reading this months
    from now when the change is likely in the stable
    release, not today. Don't say "in a month" or
    talk about your plan to do something next week.
    Assume you've done it, and that they're looking
    back to figure out how to migrate their code.
  * Use sentence case for headings and titles.
    (`## Migration guide`, NOT `Migration Guide`)
  * DON'T use the abbreviation `i.e.` or `e.g.`.
    Use "for example" or "such as", and similar.
  * For links, use the macros where possible.
    See the examples at the end of this template,
    but don't use "github.com" or "api.flutter.dev" or
    "pub.dev" in your URLs. Use the {{site.github}},
    {{site.api}}, or {{site.pub}} macros.
  * AVOID "will" when possible, in other words,
    stay in the present tense. For example:
    Bad: "When encountering an xxx value,
          the code will throw an exception."
    Good: "When encountering an xxx value,
           the code throws an exception."
    Good use of "will": "In release 2.0, the xxx API
          will be deprecated."
  * Finally, delete the comment tags and text from the
    final PR.
{% endcomment %}

## Summary

Flutter's just-in-time navigation APIs, like `WillPopScope` and
`Navigator.willPop`, are being replaced with a set of ahead-of-time APIs in
order to support Android 14's Predictive Back feature.

## Background

Android 14 introduced the
[Predictive Back feature](https://developer.android.com/guide/navigation/predictive-back-gesture),
which allows the user to peek behind the current route during a valid back
gesture and decide whether or not to continue back or to cancel the gesture.
This was incompatible with Flutter's navigation APIs that allow the developer to
cancel a back gesture after it is received.

With predictive back, the back animation begins immediately when the
user initiates the gesture and before it has been committed. There is no
opportunity for the Flutter app to decide whether or not it is allowed to happen
at that time. It must be known ahead of time.

For this reason, all APIs that allow a Flutter app developer to cancel a back
navigation at the time that a back gesture is received are now deprecated. They
have been replaced with equivalent APIs that maintain a boolean state at all
times that dictates whether or not back navigation is possible. When it is, the
predictive back animation happens as usual. Otherwise, navigation is stopped. In
both cases, the app developer is informed that a back was attempted and whether
or not it was successful.

### `WillPopScope` has been replaced with `PopScope`

{% comment %}
  High-level description of what API changed and why.
  Should be clear enough to be understandable to someone
  who has no context about this breaking change,
  such as someone who doesn't know the underlying API.
  This section should also answer the question
  "what is the problem that led to considering making
  a breaking change?"

  Include a technical description of the actual change,
  with code samples showing how the API changed.

  Include examples of the error messages that are produced
  in code that has not been migrated. This helps the search
  engine find the migration guide when people search for those
  error messages. THIS IS VERY IMPORTANT FOR DISCOVERY!
{% endcomment %}

## Migration guide

### Migrating from `WillPopScope` to `PopScope`
The direct replacement of the `WillPopScope` widget is the `PopScope` widget.
In many cases, logic that was being run at the time of the back gesture in
`onWillPop` can be done at build time and set to `canPop`.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async {
    return _myCondition;
  },
  child: ...
),
```

Code after migration:

```dart
PopScope(
  canPop: _myCondition,
  child: ...
),
```

For cases where it's necessary to be notified that a pop was attempted, the
`onPopInvoked` method can be used in a similar way to `onWillPop`. Keep in mind
that while `onWillPop` was called before the pop was handled and had the ability
to cancel it, `onPopInvoked` is called after the pop is finished being handled.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async {
    _myHandleOnPopMethod();
    return true;
  },
  child: ...
),
```

Code after migration:

```dart
PopScope(
  canPop: true,
  onPopInvoked (bool didPop) {
    _myHandleOnPopMethod();
  },
  child: ...
),
```

### Migrating from `WillPopScope` to `NavigatorPopHandler` for nested `Navigator`s
A very common use case of `WillPopScope` was to properly handle back gestures
when using nested `Navigator` widgets. It's possible to do this using `PopScope`
as well, but there is now a wrapper widget that makes this even easier:
`NavigatorPopHandler`.

Code before migration:

```dart
WillPopScope(
  onWillPop: () async => !(await _nestedNavigatorKey.currentState!.maybePop()),
  child: Navigator(
    key: _nestedNavigatorKey,
    …
  ),
)
```

Code after migration:

```dart
NavigatorPopHandler(
  onPop: () => _nestedNavigatorKey.currentState!.pop(),
  child: Navigator(
    key: _nestedNavigatorKey,
    …
  ),
)
```

### Migrating from `Form.onWillPop` to `Form.canPop` and `Form.onPopInvoked`
`Form` used to use a `WillPopScope` under the hood and expose its `onWillPop`
method. It has been replaced with a `PopScope` and has exposed its `canPop` and
`onPopInvoked` methods. Migrating is identical to migrating from `WillPopScope`
to `PopScope`, detailed above.

### Migrating from `Route.willPop` to `Route.popDisposition`
`Route`'s `willPop` method returned a `Future<RoutePopDisposition>` to
accommodate the fact that pops could be canceled.  Now that that's no longer
true, this logic has been simplified to a synchronous getter.

Code before migration:

```dart
if (await myRoute.willPop() == RoutePopDisposition.doNotPop) {
  ...
}
```

Code after migration:

```dart
if (myRoute.popDisposition == RoutePopDisposition.doNotPop) {
  ...
}
```

### Migrating from `ModalRoute.add/removeScopedWillPopCallback` to `ModalRoute.(un)registerPopInterface`
Internally, `ModalRoute` kept track of the existence of `WillPopScope`s in its
widget subtree by registering them with `addScopedWillPopCallback` and
`removeScopedWillPopCallback`. Since `WillPopScope` has been replaced by
`PopScope`, these methods have been replaced by `registerPopInterface` and
`unregisterPopInterface`, respectively.

`PopInterface` is implemented by `PopScope` in order to expose only the minimal
information necessary to `ModalRoute`. Anyone writing their own `PopScope`
should implement `PopInterface` and register and unregister their widget with
its enclosing `ModalRoute`.

Code before migration:

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (widget.onWillPop != null) {
    _route?.removeScopedWillPopCallback(widget.onWillPop!);
  }
  _route = ModalRoute.of(context);
  if (widget.onWillPop != null) {
    _route?.addScopedWillPopCallback(widget.onWillPop!);
  }
}
```

Code after migration:

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _route?.unregisterPopInterface(this);
  _route = ModalRoute.of(context);
  _route?.registerPopInterface(this);
}
```

### Migrating from `ModalRoute.hasScopedWillPopCallback` to `ModalRoute.popDisposition`
This method was previously used for a use-case very similar to Predictive Back
but in the Cupertino library, where certain back transitions allowed canceling
the navigation. The route transition was disabled when there was even the
possibility of a `WillPopScope` widget canceling the pop.

Now that the API requires this to be decided ahead of time, this no longer needs
to be speculatively based on the existence of `PopScope` widgets. The definitive
logic of whether a `ModalRoute` is having popping blocked by a `PopScope` widget
is baked into `ModalRoute.popDisposition`.

Code before migration:

```dart
if (_route.hasScopedWillPopCallback) {
  // Disable predictive route transitions.
}
```

Code after migration:

```dart
if (_route.popDisposition == RoutePopDisposition.doNotPop) {
  // Disable predictive route transitions.
}
```

{% comment %}
  Make sure you have looked for old tutorials online that
  use the old API. Contact their authors and point out how
  they should be updated. Leave a comment pointing out that
  the API has changed and linking to this guide.
{% endcomment %}

## Timeline

{% comment %}
  The version # of the SDK where this change was
  introduced.  If there is a deprecation window,
  the version # to which we guarantee to maintain
  the old API. Use the following template:

  If a breaking change has been reverted in a
  subsequent release, move that item to the
  "Reverted" section of the index.md file.
  Also add the "Reverted in version" line,
  shown as optional below. Otherwise, delete
  that line.
{% endcomment %}

Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

{% comment %}
  These links are commented out because they
  cause the GitHubActions (GHA) linkcheck to fail.
  Remove the comment tags once you fill this in with
  real links. Only use the "master-api" include if
  you link to "master-api.flutter.dev"; prefer our
  stable documentation if possible.

{% include docs/master-api.md %}

API documentation:

* [`ClassName`][]

Relevant issues:

* [Issue xxxx][]
* [Issue yyyy][]

Relevant PRs:

* [PR title #1][]
* [PR title #2][]
{% endcomment %}

{% comment %}
  Add the links to the end of the file in alphabetical order.
  The following links are commented out because they make
  the GitHubActions (GHA) link checker believe they are broken links,
  but please remove the comment tags before you commit!

  If you are sharing new API that hasn't landed in
  the stable channel yet, use the master channel link.
  To link to docs on the master channel,
  include the following note and make sure that
  the URL includes the master link (as shown below).

  Here's an example of defining a stable (site.api) link
  and a master channel (master-api) link.

<!-- Stable channel link: -->
[`ClassName`]: {{site.api}}/flutter/[link_to_relevant_page].html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`ClassName`]: {{site.master-api}}/flutter/[link_to_relevant_page].html

[Issue xxxx]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[Issue yyyy]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[PR title #1]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
[PR title #2]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
{% endcomment %}
