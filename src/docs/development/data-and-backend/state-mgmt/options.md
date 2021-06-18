---
title: List of state management approaches
description: A list of different approaches to managing state.
prev:
  title: Simple app state management
  path: /docs/development/data-and-backend/state-mgmt/simple
---

State management is a complex topic.
If you feel that some of your questions haven't been answered,
or that the approach described on these pages
is not viable for your use cases, you are probably right.

Learn more at the following links,
many of which have been contributed by the Flutter community:

## General overview

Things to review before selecting an approach. 

* [Introduction to state management][],
  which is the beginning of this very section
  (for those of you who arrived directly to this _Options_ page 
  and missed the previous pages)
* [Pragmatic State Management in Flutter][],
  a video from Google I/O 2019
* [Flutter Architecture Samples][], by Brian Egan

## Provider

A recommended approach.

* [Simple app state management][], the previous page in this section
* [Provider package][]
* [You might not need Redux: The Flutter edition][], by Ryan Edge
* [Making sense of all those Flutter Providers][]

## setState

The low-level approach to use for widget-specific, ephemeral state.

* [Adding interactivity to your Flutter app][], a Flutter tutorial
* [Basic state management in Google Flutter][], by Agung Surya

## InheritedWidget &amp; InheritedModel

The low-level approach used to communicate between ancestors and children
in the widget tree. This is what `provider` and many other approaches
use under the hood.

The following instructor-led video workshop covers how to
use `InheritedWidget`:

<iframe width="560" height="315" src="https://www.youtube.com/embed/LFcGPS6cGrY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Other useful docs include:

* [InheritedWidget docs][]
* [Managing Flutter Application State With InheritedWidgets][],
  by Hans Muller
* [Inheriting Widgets][], by Mehmet Fidanboylu
* [Using Flutter Inherited Widgets Effectively][], by Eric Windmill
* [Widget - State - Context - InheritedWidget][], by Didier Bolelens

## Redux

A state container approach familiar to many web developers.

* [Animation Management with Redux and Flutter][],
  a video from DartConf 2018 [Accompanying article on Medium][]
* [Flutter Redux package][]
* [Redux Saga Middleware Dart and Flutter][], by Bilal Uslu
* [Introduction to Redux in Flutter][], by Xavi Rigau
* [Flutter + Redux&mdash;How to make a shopping list app][],
  by Paulina Szklarska on Hackernoon
* [Building a TODO application (CRUD) in Flutter with Redux&mdash;Part 1][],
  a video by Tensor Programming
* [Flutter Redux Thunk, an example][], by Jack Wong
* [Building a (large) Flutter app with Redux][], by Hillel Coren
* [Fish-Redux–An assembled flutter application framework based on Redux][],
  by Alibaba
* [Async Redux–Redux without boilerplate. Allows for both sync and async reducers][],
  by Marcelo Glasberg
* [Flutter meets Redux: The Redux way of managing Flutter applications state][],
  by Amir Ghezelbash
* [Redux and epics for better-organized code in Flutter apps][], by Nihad Delic
  
## Fish-Redux

Fish Redux is an assembled flutter application framework based on Redux state management. 
It is suitable for building medium and large applications.

* [Fish-Redux-Library][] package, by Alibaba
* [Fish-Redux-Source][], project code
* [Flutter-Movie][] - Non-trivial example demonstrating how to use Fish Redux,
with more than 30 screens, graphql, payment api and media player.

## BLoC / Rx

A family of stream/observable based patterns. 

* [Architect your Flutter project using BLoC pattern][],
  by Sagar Suri
* [BloC Library][], by Felix Angelov
* [Reactive Programming - Streams - BLoC - Practical Use Cases][],
  by Didier Boelens

## GetIt

A service locator based state management approach that doesn't need a `BuildContext`.

* [GetIt package][], the service locator. It can also be used together with BloCs.
* [GetIt Mixin package][], a mixin that completes `GetIt` to a full state management solution.
* [GetIt Hooks package][], same as the mixin in case you already use `flutter_hooks`.
* [Flutter state management for minimalists][], by Suragch

## MobX

A popular library based on observables and reactions.

* [MobX.dart, Hassle free state-management for your Dart and Flutter apps][]
* [Getting started with MobX.dart][]
* [Flutter: State Management with Mobx][], a video by Paul Halliday

## Flutter Commands

Reactive state management that uses the Command Pattern and is based on `ValueNotifiers`. Best in combination with [GetIt](#getit), but can be used with `Provider` or other locators too.

* [Flutter Command package][] 
* [RxCommand package][], `Stream` based implementation.

## Binder

A state management package that uses `InheritedWidget` at its core. Inspired in part by recoil. This package promotes the separation of concerns.

* [Binder package][] 
* [Binder examples][]
* [Binder snippets][], vscode snippets to be even more productive with Binder

## GetX

A simplified reactive state management solution.

* [GetX package][]
* [Complete GetX State Management][], a video by Tadas Petra
* [GetX Flutter Firebase Auth Example][], by Jeff McMorris

## Riverpod

An approach similar to Provider that is compile-safe and testable. It doesn't have a dependency on the Flutter SDK.

* [Riverpod][] homepage
* [Getting started with Riverpod][]

[Getting started with Riverpod]: https://riverpod.dev/docs/getting_started
[Riverpod]: https://riverpod.dev/
[Flutter-Movie]: {{site.github}}/o1298098/Flutter-Movie
[Fish-Redux-Source]: {{site.github}}/alibaba/fish-redux
[Fish-Redux-Library]: {{site.pub-pkg}}/fish_redux
[Adding interactivity to your Flutter app]: /docs/development/ui/interactive
[accompanying article]: {{site.flutter-medium}}/build-reactive-mobile-apps-in-flutter-companion-article-13950959e381
[Accompanying article on Medium]: {{site.flutter-medium}}/animation-management-with-flutter-and-flux-redux-94729e6585fa
[Animation Management with Redux and Flutter]: https://www.youtube.com/watch?v=9ZkLtr0Fbgk
[Architect your Flutter project using BLoC pattern]: {{site.medium}}/flutterpub/architecting-your-flutter-project-bd04e144a8f1
[Async Redux–Redux without boilerplate. Allows for both sync and async reducers]: {{site.pub}}/packages/async_redux
[Basic state management in Google Flutter]: {{site.medium}}/@agungsurya/basic-state-management-in-google-flutter-6ee73608f96d
[Flutter meets Redux: The Redux way of managing Flutter applications state]: https://medium.com/@thisisamir98/flutter-meets-redux-the-redux-way-of-managing-flutter-applications-state-f60ef693b509
[BloC Library]: https://felangel.github.io/bloc
[Building a (large) Flutter app with Redux]: https://hillelcoren.com/2018/06/01/building-a-large-flutter-app-with-redux/
[Building a TODO application (CRUD) in Flutter with Redux&mdash;Part 1]: https://www.youtube.com/watch?v=Wj216eSBBWs
[Complete GetX State Management]: https://www.youtube.com/watch?v=CNpXbeI_slw
[Fish-Redux–An assembled flutter application framework based on Redux]: {{site.github}}/alibaba/fish-redux/
[Flutter Architecture Samples]: https://fluttersamples.com/
[Flutter: State Management with Mobx]: https://www.youtube.com/watch?v=p-MUBLOEkCs
[Flutter Redux package]: {{site.pub-pkg}}/flutter_redux
[Redux Saga Middleware Dart and Flutter]: {{site.pub-pkg}}/redux_saga
[Flutter Redux Thunk, an example]: {{site.medium}}/flutterpub/flutter-redux-thunk-27c2f2b80a3b
[Flutter + Redux&mdash;How to make a shopping list app]: https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65
[Getting started with MobX.dart]: https://mobx.netlify.com/getting-started
[GetX Flutter Firebase Auth Example]: {{site.medium}}/@jeffmcmorris/getx-flutter-firebase-auth-example-b383c1dd1de2
[InheritedWidget docs]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Inheriting Widgets]: {{site.medium}}/@mehmetf_71205/inheriting-widgets-b7ac56dbbeb1
[Introduction to Redux in Flutter]: https://blog.novoda.com/introduction-to-redux-in-flutter/
[Introduction to state management]: /docs/development/data-and-backend/state-mgmt/intro
[Making sense of all those Flutter Providers]: {{site.medium}}/flutter-community/making-sense-all-of-those-flutter-providers-e842e18f45dd
[Managing Flutter Application State With InheritedWidgets]: {{site.flutter-medium}}/managing-flutter-application-state-with-inheritedwidgets-1140452befe1
[MobX.dart, Hassle free state-management for your Dart and Flutter apps]: {{site.github}}/mobxjs/mobx.dart
[Pragmatic State Management in Flutter]: https://www.youtube.com/watch?v=d_m5csmrf7I
[Provider package]: {{site.pub-pkg}}/provider
[GetX package]: {{site.pub-pkg}}/get
[Reactive Programming - Streams - BLoC - Practical Use Cases]: https://www.didierboelens.com/2018/12/reactive-programming---streams---bloc---practical-use-cases
[Simple app state management]: /docs/development/data-and-backend/state-mgmt/simple
[Using Flutter Inherited Widgets Effectively]: https://ericwindmill.com/articles/inherited_widget/
[Widget - State - Context - InheritedWidget]: https://www.didierboelens.com/2018/06/widget---state---context---inheritedwidget/
[You might not need Redux: The Flutter edition]: https://proandroiddev.com/you-might-not-need-redux-the-flutter-edition-9c11eba006d7
[Redux and epics for better-organized code in Flutter apps]: {{site.medium}}/upday-devs/reduce-duplication-achieve-flexibility-means-success-for-the-flutter-app-e5e432839e61
[GetIt package]: https://pub.dev/packages/get_it
[GetIt Hooks package]: https://pub.dev/packages/get_it_hooks
[GetIt Mixin package]: https://pub.dev/packages/get_it_mixin
[Flutter state management for minimalists]: {{site.medium}}/flutter-community/flutter-state-management-for-minimalists-4c71a2f2f0c1?sk=6f9cedfb550ca9cc7f88317e2e7055a0
[Flutter Command package]: https://pub.dev/packages/flutter_command
[RxCommand package]: https://pub.dev/packages/rx_command
[Binder package]: https://pub.dev/packages/binder
[Binder examples]: https://github.com/letsar/binder/tree/main/examples
[Binder snippets]: https://marketplace.visualstudio.com/items?itemName=romain-rastel.flutter-binder-snippets
