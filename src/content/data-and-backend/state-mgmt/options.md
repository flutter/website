---
title: Approaches to state management
short-link: State-management approaches
breadcrumb: Approaches
description: >-
  An introduction to different approaches to
  managing state in Flutter apps.
prev:
  title: Simple app state management
  path: /data-and-backend/state-mgmt/simple
---

State management is a complex topic.
If you feel that some of your questions haven't been answered,
or that the approach described on these pages
is not viable for your use cases, you are probably right.

Learn more from the following resources,
many of which have been contributed by the Flutter community.

## General overview

Things to review before selecting an approach.

* [Introduction to state management][],
  which is the beginning of this very section
  (for those of you who arrived directly to this _Options_ page
  and missed the previous pages)
* [Pragmatic State Management in Flutter][],
  a video from Google I/O 2019
* [Flutter Architecture Samples][], by Brian Egan

[Flutter Architecture Samples]: https://fluttersamples.com/
[Introduction to state management]: /data-and-backend/state-mgmt/intro
[Pragmatic State Management in Flutter]: {{site.yt.watch}}?v=d_m5csmrf7I

## Built-in approaches

### `setState`

The low-level approach to use for widget-specific, ephemeral state.

* [Adding interactivity to your Flutter app][], a Flutter tutorial
* [Basic state management in Google Flutter][], by Agung Surya

[Adding interactivity to your Flutter app]: /ui/interactivity
[Basic state management in Google Flutter]: {{site.medium}}/@agungsurya/basic-state-management-in-google-flutter-6ee73608f96d

<a id="valuenotifier-inheritednotifier" aria-hidden="true"></a>

### `ValueNotifier` and `InheritedNotifier`

An approach using only Flutter provided APIs to
update state and notify the UI of changes.

* [State Management using ValueNotifier and InheritedNotifier][], by Tadas Petra

[State Management using ValueNotifier and InheritedNotifier]: https://www.hungrimind.com/articles/flutter-state-management

<a id="inheritedwidget-inheritedmodel" aria-hidden="true"></a>

### `InheritedWidget` and `InheritedModel`

The low-level approach used to
communicate between ancestors and children in the widget tree.
This is what `package:provider` and many other approaches use under the hood.

The following instructor-led video workshop covers how to
use `InheritedWidget`:

<YouTubeEmbed id="LFcGPS6cGrY" title="How to manage application state using inherited widgets"></YouTubeEmbed>

Other useful docs include:

* [InheritedWidget docs][]
* [Managing Flutter Application State With InheritedWidgets][],
  by Hans Muller
* [Inheriting Widgets][], by Mehmet Fidanboylu
* [Using Flutter Inherited Widgets Effectively][], by Eric Windmill
* [Widget - State - Context - InheritedWidget][], by Didier Bolelens

[InheritedWidget docs]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Inheriting Widgets]: {{site.medium}}/@mehmetf_71205/inheriting-widgets-b7ac56dbbeb1
[Managing Flutter Application State With InheritedWidgets]: {{site.flutter-blog}}/managing-flutter-application-state-with-inheritedwidgets-1140452befe1
[Using Flutter Inherited Widgets Effectively]: https://ericwindmill.com/articles/inherited_widget/
[Widget - State - Context - InheritedWidget]: https://www.didierboelens.com/2018/06/widget---state---context---inheritedwidget/

## Community-provided packages

Depending on the complexity of your app and preferences of your team,
you might find adopting a state management package useful.
State management packages often help reduce boilerplate code,
provide specialized debugging tools, and can help
enable a clearer and consistent application architecture.

The Flutter community offers a wide variety of state management packages.
The best choice for your app often depends on the app's complexity,
your team's preferences, and the specific problems you need to solve.

To begin exploring the available options,
check out the [`#state-management`][]{: target="_blank"} topic on the pub.dev site and
refine the search to find packages that match your needs.

<div class="card-grid">
  <a class="card outlined-card" href="{{site.pub}}/packages?q=topic%3Astate-management" target="_blank">
    <div class="card-header">
      <span class="card-title">
        <span>State management packages</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;" translate="no">open_in_new</span>
      </span>
    </div>
    <div class="card-content">
      <p>Explore the variety of state-management packages built by and for the Flutter community.</p>
    </div>
  </a>
</div>

:::tip
If you've developed a state management package that
you think would be useful to the Flutter community,
consider [adding the `state-management` topic][pub-topics] and
[publishing the package][pub-publish] to pub.dev.
:::

[`#state-management`]: {{site.pub}}/packages?q=topic%3Astate-management
[pub-topics]: {{site.dart-site}}/tools/pub/pubspec#topics
[pub-publish]: {{site.dart-site}}/tools/pub/publishing
