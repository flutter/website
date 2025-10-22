---
title: Architecture case study
shortTitle: Architecture case study
description: >-
  A walk-through of a Flutter app that implements the MVVM architectural pattern.
prev:
  title: Guide to app architecture
  path: /app-architecture/guide
next:
  title: UI Layer
  path: /app-architecture/case-study/ui-layer
---

The code examples in this guide are from the [Compass sample application][],
an app that helps users build and book itineraries for trips.
It's a robust sample application with many features, routes, and screens.
The app communicates with an HTTP server,
has development and production environments,
includes brand-specific styling, and contains high test coverage.
In these ways and more, it simulates a real-world,
feature-rich Flutter application.

<div class="wrapping-row" style="margin-block-end: 2rem">
  <DashImage figure image="app-architecture/case-study/splash_screen.png" alt="A screenshot of the splash screen of the compass app." img-style="max-height: 400px;" />
  <DashImage figure image="app-architecture/case-study/home_screen.png" alt="A screenshot of the home screen of the compass app." img-style="max-height: 400px;" />
  <DashImage figure image="app-architecture/case-study/search_form_screen.png" alt="A screenshot of the search form screen of the compass app." img-style="max-height: 400px;" />
  <DashImage figure image="app-architecture/case-study/booking_screen.png" alt="A screenshot of the booking screen of the compass app." img-style="max-height: 400px;" />
</div>

The Compass app's architecture most resembles the [MVVM architectural pattern][]
as described in Flutter's [app architecture guidelines][].
This architecture case study demonstrates how to
implement those guidelines by walking through
the "Home" feature of the compass app.
If you aren't familiar with MVVM, you should read those guidelines first.

The Home screen of the Compass app displays user account information and
a list of the user's saved trips.
From this screen you can log out, open detailed trip pages,
delete saved trips, and navigate to the first page of the core app flow,
which allows the user to build a new itinerary.

In this case study, you'll learn the following:

* How to implement Flutter's [app architecture guidelines][]
  using repositories and services in the [data layer][] and
  the MVVM architectural pattern in the [UI layer][]
* How to use the [Command pattern][] to safely render UI as data changes
* How to use [`ChangeNotifier`][] and [`Listenable`][] objects to manage state
* How to implement [Dependency Injection][] using `package:provider`
* How to [set up tests][] when following the recommended architecture
* Effective [package structure][] for large Flutter apps

This case-study was written to be read in order.
Any given page might reference the previous pages.

The code examples in this case-study include all the details needed to
understand the architecture, but they're not complete, runnable snippets.
If you prefer to follow along with the full app,
you can find it on [GitHub][].

## Package structure

Well-organized code is easier for multiple engineers to work on with
minimal code conflicts and is easier for new engineers to
navigate and understand.
Code organization both benefits and benefits from well-defined architecture.

There are two popular means of organizing code:

1. By feature - The classes needed for each feature are grouped together. For
   example, you might have an `auth` directory, which would contain files
   like `auth_viewmodel.dart`, `login_usecase.dart`, `logout_usecase.dart`,
   `login_screen.dart`, `logout_button.dart`, etc.
2. By type - Each "type" of architecture is grouped together.
   For example, you might have directories such as
   `repositories`, `models`, `services`, and `viewmodels`.

The architecture recommended in this guide lends itself to
a combination of the two.
Data layer objects (repositories and services) aren't tied to a single feature,
while UI layer objects (views and view models) are.
The following is how the code is organized within the Compass application.

```plaintext
lib
├─┬─ ui
│ ├─┬─ core
│ │ ├─┬─ ui
│ │ │ └─── <shared widgets>
│ │ └─── themes
│ └─┬─ <FEATURE NAME>
│   ├─┬─ view_model
│   │ └─── <view_model class>.dart
│   └─┬─ widgets
│     ├── <feature name>_screen.dart
│     └── <other widgets>
├─┬─ domain
│ └─┬─ models
│   └─── <model name>.dart
├─┬─ data
│ ├─┬─ repositories
│ │ └─── <repository class>.dart
│ ├─┬─ services
│ │ └─── <service class>.dart
│ └─┬─ model
│   └─── <api model class>.dart
├─── config
├─── utils
├─── routing
├─── main_staging.dart
├─── main_development.dart
└─── main.dart

// The test folder contains unit and widget tests
test
├─── data
├─── domain
├─── ui
└─── utils

// The testing folder contains mocks other classes need to execute tests
testing
├─── fakes
└─── models
```

Most of the application code lives in the
`data`, `domain`, and `ui` folders.
The data folder organizes code by type,
because repositories and services can be used across
different features and by multiple view models.
The ui folder organizes the code by feature,
because each feature has exactly one view and exactly one view model.

Other notable features of this folder structure:

* The UI folder also contains a subdirectory named "core".
  Core contains widgets and theme logic that is shared by multiple views,
  such as buttons with your brand styling.
* The domain folder contains the application data types, because they're
  used by the data and ui layers.
* The app contains three "main" files, which act as different entry points to
  the application for development, staging, and production.
* There are two test-related directories at the same level as `lib`: `test/` has
  the test code, and its own structure matches `lib/`. `testing/` is a
  subpackage that contains mocks and other testing utilities which can be used
  in other packages' test code. The `testing/` folder could be described as a
  version of your app that you don't ship. It's the content that is tested.

There's additional code in the compass app that doesn't pertain to architecture.
For the full package structure, [view it on GitHub][].

## Other architecture options

The example in this case-study demonstrates how one application abides by our
recommended architectural rules, but there are many other example apps that
could've been written. The UI of this app leans heavily on view models
and `ChangeNotifier`, but it could've easily been written
with streams, or with other libraries like provided by the [`riverpod`][],
[`flutter_bloc`][], and [`signals`][] packages.
The communication between layers of this app handled
everything with method calls, including polling for new data.
It could've instead used streams to expose data from a repository to
a view model and still abide by the rules covered in this guide.

Even if you do follow this guide exactly,
and choose not to introduce additional libraries, you have decisions to make:
Will you have a domain layer?
If so, how will you manage data access?
The answer depends so much on an individual team's needs that
there isn't a single right answer.
Regardless of how you answer these questions,
the principles in this guide will help you write scalable Flutter apps.

And if you squint, aren't all architectures MVVM anyway?

[Compass sample application]: https://github.com/flutter/samples/tree/main/compass_app
[MVVM architectural pattern]: https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel
[app architecture guidelines]: /app-architecture/guide
[data layer]: /app-architecture/case-study/data-layer
[UI layer]: /app-architecture/case-study/ui-layer
[Command pattern]: /app-architecture/case-study/ui-layer#command-objects
[`ChangeNotifier`]: {{site.api}}/flutter/foundation/ChangeNotifier-class.html
[`Listenable`]: {{site.api}}/flutter/foundation/Listenable-class.html
[Dependency Injection]: /app-architecture/case-study/dependency-injection
[set up tests]: /app-architecture/case-study/testing
[view it on GitHub]: https://github.com/flutter/samples/tree/main/compass_app
[GitHub]: https://github.com/flutter/samples/tree/main/compass_app
[`riverpod`]: {{site.pub-pkg}}/riverpod
[`flutter_bloc`]: {{site.pub-pkg}}/flutter_bloc
[`signals`]: {{site.pub-pkg}}/signals
[package structure]: /app-architecture/case-study#package-structure

## Feedback

As this section of the website is evolving,
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_4T0XuR9Ts29acw6?page="case-study/index"
