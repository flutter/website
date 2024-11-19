---
title: Communicating between layers
short-title: Dependency injection
description: >
  How to implement dependency injection.
prev: 
  title: Data layer
  path: /app-architecture/case-study/data-layer
next:
  title: Testing
  path: /app-architecture/case-study/testing
---

## Communicating between objects and layers  {#communicating-between-objects-and-layers}

Along with defining clear responsibilities for each component of architecture, it’s important to consider how the components communicate. This refers to both the rules that dictate communication, and the technical implementation of how components communicate. An app’s architecture should answer the following questions:



* Which components are allowed to communicate with which other components (including components of the same type)?
* What do these components expose as output to each other?
* How is any given layer ‘wired up’ to another layer?


![alt_text](images/image13.png "image_tooltip")


Using this diagram as a guide, the rules of engagement are as follows:



1. View
    1. A view is only aware of exactly one ViewModel, and will never be aware of any other layer or component. A ViewModel is passed into the view as an argument on creation, which exposes ViewModel data and command callbacks to the view.
2. ViewModel
    2. A ViewModel belongs to exactly one view. Its data is exposed to the view, but it never needs to know that a view exists.
    3. A ViewModel is aware of one or more repositories, which are passed into the ViewModels’s constructor.
3. Repository
    4. A repository can be aware of many services, which are passed as arguments into the repository constructor.
    5. A repository can be used by many ViewModels, but it never needs to be aware of the ViewModels.
4. Service
    6. A service can be used by many repositories, but it never needs to be aware of a repository (or any other object).

Throughout this guide there have been examples of how these different components ‘communicate’ with each other via inputs and outputs. In every case, communication between two layers is facilitated by passing a component into the constructor methods of the components that consume its data, such as a Service into a Repository.

One thing that’s been missing, however, is object creation. In what part of the application is that instance of `MyService` being created so that it can be passed into `MyRepository`? [Dependency injection](http://empty) is discussed in the next section.


### Dependency Injection {#dependency-injection}

In the Compass app, dependency injection is handled using the [provider](https://pub.dev/packages/provider) package. This is the recommended library for dependency injection by teams at Google building Flutter apps.

Services and repositories are exposed to the top level of the widget tree* *of the Flutter application as `Provider` objects.

Services are exposed only so they can immediately be injected into Repositories via the `BuildContext.read` method from `provider`, as shown above.  Repositories are then exposed so that they can be injected into ViewModels as needed.

Slightly lower in the widget tree, ViewModels that correspond to a full screen are created in the [`GoRouter`](https://pub.dev/packages/go_router) configuration, where provider is again used to inject the necessary repositories.

Within the ViewModel or repository, the injected component should be private. For example, the `HomeViewModel` class looks like this:

Private methods prevent the view, which has access to the ViewModel, from calling methods on the repository directly.

This concludes the code walkthrough of the Compass app. This page only walked through the architecture-related code, but it doesn’t tell the whole story. Most utility code, widget code, and UI styling was ignored. Browse the code in the [Compass app repository](https://github.com/flutter/samples/) for a complete example of a robust Flutter application built using these principles.
