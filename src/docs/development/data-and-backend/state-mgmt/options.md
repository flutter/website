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


[Flutter Architecture Samples]: https://fluttersamples.com/
[Introduction to state management]: /docs/development/data-and-backend/state-mgmt/intro
[Pragmatic State Management in Flutter]: {{site.youtube-site}}/watch?v=d_m5csmrf7I

## Provider

A recommended approach.

* [Simple app state management][], the previous page in this section
* [Provider package][]
* [You might not need Redux: The Flutter edition][], by Ryan Edge
* [Making sense of all those Flutter Providers][]


[Making sense of all those Flutter Providers]: {{site.medium}}/flutter-community/making-sense-all-of-those-flutter-providers-e842e18f45dd?sk=7859a73fac0ca414a0e911b0322e8589
[Provider package]: {{site.pub-pkg}}/provider
[Simple app state management]: /docs/development/data-and-backend/state-mgmt/simple
[You might not need Redux: The Flutter edition]: https://proandroiddev.com/you-might-not-need-redux-the-flutter-edition-9c11eba006d7

## Riverpod

Riverpod, another good choice, is
similar to Provider and is compile-safe and testable.
Riverpod doesn't have a dependency on the Flutter SDK.

* [Riverpod][] homepage
* [Getting started with Riverpod][]


[Getting started with Riverpod]: https://riverpod.dev/docs/getting_started
[Riverpod]: https://riverpod.dev/

## setState

The low-level approach to use for widget-specific, ephemeral state.

* [Adding interactivity to your Flutter app][], a Flutter tutorial
* [Basic state management in Google Flutter][], by Agung Surya

[Adding interactivity to your Flutter app]: /docs/development/ui/interactive
[Basic state management in Google Flutter]: {{site.medium}}/@agungsurya/basic-state-management-in-google-flutter-6ee73608f96d

## InheritedWidget &amp; InheritedModel

The low-level approach used to communicate between ancestors and children
in the widget tree. This is what `provider` and many other approaches
use under the hood.

The following instructor-led video workshop covers how to
use `InheritedWidget`:

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/LFcGPS6cGrY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Other useful docs include:

* [InheritedWidget docs][]
* [Managing Flutter Application State With InheritedWidgets][],
  by Hans Muller
* [Inheriting Widgets][], by Mehmet Fidanboylu
* [Using Flutter Inherited Widgets Effectively][], by Eric Windmill
* [Widget - State - Context - InheritedWidget][], by Didier Bolelens


[InheritedWidget docs]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Inheriting Widgets]: {{site.medium}}/@mehmetf_71205/inheriting-widgets-b7ac56dbbeb1
[Managing Flutter Application State With InheritedWidgets]: {{site.flutter-medium}}/managing-flutter-application-state-with-inheritedwidgets-1140452befe1
[Using Flutter Inherited Widgets Effectively]: https://ericwindmill.com/articles/inherited_widget/
[Widget - State - Context - InheritedWidget]: https://www.didierboelens.com/2018/06/widget---state---context---inheritedwidget/

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


[Accompanying article on Medium]: {{site.flutter-medium}}/animation-management-with-flutter-and-flux-redux-94729e6585fa
[Animation Management with Redux and Flutter]: {{site.youtube-site}}/watch?v=9ZkLtr0Fbgk
[Async Redux–Redux without boilerplate. Allows for both sync and async reducers]: {{site.pub}}/packages/async_redux
[Building a (large) Flutter app with Redux]: https://hillelcoren.com/2018/06/01/building-a-large-flutter-app-with-redux/
[Building a TODO application (CRUD) in Flutter with Redux&mdash;Part 1]: {{site.youtube-site}}/watch?v=Wj216eSBBWs
[Fish-Redux–An assembled flutter application framework based on Redux]: {{site.github}}/alibaba/fish-redux/
[Flutter Redux Thunk, an example]: {{site.medium}}/flutterpub/flutter-redux-thunk-27c2f2b80a3b
[Flutter meets Redux: The Redux way of managing Flutter applications state]: {{site.medium}}/@thisisamir98/flutter-meets-redux-the-redux-way-of-managing-flutter-applications-state-f60ef693b509
[Flutter Redux package]: {{site.pub-pkg}}/flutter_redux
[Flutter + Redux&mdash;How to make a shopping list app]: https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65
[Introduction to Redux in Flutter]: https://blog.novoda.com/introduction-to-redux-in-flutter/
[Redux and epics for better-organized code in Flutter apps]: {{site.medium}}/upday-devs/reduce-duplication-achieve-flexibility-means-success-for-the-flutter-app-e5e432839e61
[Redux Saga Middleware Dart and Flutter]: {{site.pub-pkg}}/redux_saga
  
## Fish-Redux

Fish Redux is an assembled flutter application framework
based on Redux state management. 
It is suitable for building medium and large applications.

* [Fish-Redux-Library][] package, by Alibaba
* [Fish-Redux-Source][], project code
* [Flutter-Movie][], A non-trivial example demonstrating how
  to use Fish Redux, with more than 30 screens, graphql,
  payment api, and media player.


[Fish-Redux-Library]: {{site.pub-pkg}}/fish_redux
[Fish-Redux-Source]: {{site.github}}/alibaba/fish-redux
[Flutter-Movie]: {{site.github}}/o1298098/Flutter-Movie

## BLoC / Rx

A family of stream/observable based patterns. 

* [Architect your Flutter project using BLoC pattern][],
  by Sagar Suri
* [BloC Library][], by Felix Angelov
* [Reactive Programming - Streams - BLoC - Practical Use Cases][],
  by Didier Boelens


[Architect your Flutter project using BLoC pattern]: {{site.medium}}/flutterpub/architecting-your-flutter-project-bd04e144a8f1
[BloC Library]: https://felangel.github.io/bloc
[Reactive Programming - Streams - BLoC - Practical Use Cases]: https://www.didierboelens.com/2018/12/reactive-programming---streams---bloc---practical-use-cases

## GetIt

A service locator based state management approach that
doesn't need a `BuildContext`.

* [GetIt package][], the service locator.
  It can also be used together with BloCs.
* [GetIt Mixin package][], a mixin that completes
  `GetIt` to a full state management solution.
* [GetIt Hooks package][], same as the mixin in
  case you already use `flutter_hooks`.
* [Flutter state management for minimalists][], by Suragch


[Flutter state management for minimalists]: {{site.medium}}/flutter-community/flutter-state-management-for-minimalists-4c71a2f2f0c1?sk=6f9cedfb550ca9cc7f88317e2e7055a0
[GetIt package]: {{site.pub-pkg}}/get_it
[GetIt Hooks package]: {{site.pub-pkg}}/get_it_hooks
[GetIt Mixin package]: {{site.pub-pkg}}/get_it_mixin

## MobX

A popular library based on observables and reactions.

* [MobX.dart, Hassle free state-management for your Dart and Flutter apps][]
* [Getting started with MobX.dart][]
* [Flutter: State Management with Mobx][], a video by Paul Halliday

[Flutter: State Management with Mobx]: {{site.youtube-site}}/watch?v=p-MUBLOEkCs
[Getting started with MobX.dart]: https://mobx.netlify.com/getting-started
[MobX.dart, Hassle free state-management for your Dart and Flutter apps]: {{site.github}}/mobxjs/mobx.dart

## Flutter Commands

Reactive state management that uses the Command Pattern
and is based on `ValueNotifiers`. Best in combination with
[GetIt](#getit), but can be used with `Provider` or other
locators too.

* [Flutter Command package][] 
* [RxCommand package][], `Stream` based implementation.


[Flutter Command package]: {{site.pub-pkg}}/flutter_command
[RxCommand package]: {{site.pub-pkg}}/rx_command

## Binder

A state management package that uses `InheritedWidget`
at its core. Inspired in part by recoil.
This package promotes the separation of concerns.

* [Binder package][] 
* [Binder examples][]
* [Binder snippets][], vscode snippets to be even more
  productive with Binder


[Binder examples]: {{site.github}}/letsar/binder/tree/main/examples
[Binder package]: {{site.pub-pkg}}/binder
[Binder snippets]: https://marketplace.visualstudio.com/items?itemName=romain-rastel.flutter-binder-snippets

## GetX

A simplified reactive state management solution.

* [GetX package][]
* [Complete GetX State Management][], a video by Tadas Petra
* [GetX Flutter Firebase Auth Example][], by Jeff McMorris

[Complete GetX State Management]: {{site.youtube-site}}/watch?v=CNpXbeI_slw
[GetX package]: {{site.pub-pkg}}/get
[GetX Flutter Firebase Auth Example]: {{site.medium}}/@jeffmcmorris/getx-flutter-firebase-auth-example-b383c1dd1de2

## states_rebuilder

An approach that combines state management with a
dependency injection solution and an integrated router.
For more information, see the following info:

* [States Rebuilder][] project code
* [States Rebuilder documentation][]


[States Rebuilder]: {{site.github}}/GIfatahTH/states_rebuilder
[States Rebuilder documentation]: {{site.github}}/GIfatahTH/states_rebuilder/wiki

## Triple Pattern (Segmented State Pattern)

Triple is a pattern for state management that uses `Streams` or `ValueNotifier`.
This mechanism (nicknamed _triple_ because the stream always uses three
values: `Error`, `Loading`, and `State`), is based on the
[Segmented State pattern][].

For more information, refer to the following resources:

* [Triple documentation][]
* [Flutter Triple package][]
* [Triple Pattern: A new pattern for state management in Flutter][]
  (blog post written in Portuguese but can be auto-translated)
* [VIDEO: Flutter Triple Pattern by Kevlin Ossada][] (recorded in English)


[Triple documentation]: https://triple.flutterando.com.br/
[Flutter Triple package]: {{site.pub-pkg}}/flutter_triple
[Segmented State pattern]: https://triple.flutterando.com.br/docs/intro/
[Triple Pattern: A new pattern for state management in Flutter]: https://blog.flutterando.com.br/triple-pattern-um-novo-padr%C3%A3o-para-ger%C3%AAncia-de-estado-no-flutter-2e693a0f4c3e
[VIDEO: Flutter Triple Pattern by Kevlin Ossada]: {{site.youtube-site}}/watch?v=dXc3tR15AoA
