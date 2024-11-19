---
title: UI layer case study
short-title: UI layer
description: >
  A walk-through of the UI layer of an app that implements the Flutter architecture.
prev: 
  title: Case study overview
  path: /app-architecture/case-study
next:
  title: Data Layer
  path: /app-architecture/case-study/data-layer
---

The [UI layer][] of each feature in your Flutter application should be
made up of two components: a **[View][]** and
a **[ViewModel][].**

<img src='/assets/images/docs/app-architecture/case-study/mvvm-case-study-ui-layer-highlighted.png'
alt="A screenshot of the booking screen of the compass app.">

In the most general sense, ViewModels manage UI state, and views display UI
state. Views and ViewModels have a one-to-one relationship. For each view, there
is exactly one corresponding ViewModel that manages that View’s state. Each pair
of View and ViewModel make up the UI for a single feature. For example, an app
might have classes called `LogOutView` and a `LogOutViewModel`.

[UI layer]: app-architecture/guide#UI-layer
[View]: app-architecture/guide#Views
[ViewModel]: app-architecture/guide#ViewModels

## Define a ViewModel

A ViewModel is a Dart class responsible for handling UI logic. ViewModels take
domain models as inputs and expose it as UI state to their
corresponding views. They encapsulate logic that the View can attach to event
handlers, like button presses, and manage sending these events to the data layer
of the app, where data changes happen.

The following code snippet is a class declaration for aViewModel class called
the `HomeViewModel`. Its inputs are the [repositories](prevpage) that provide
its data. In this case, the ViewModel is dependent on the `BookingRepository`
and `UserRepository` as arguments.

```dart 
// app/lib/ui/home/view_models/home_viewmodel.dart

class HomeViewModel {
  HomeViewModel({
    required BookingRepository bookingRepository, 
    required UserRepository userRepository,
  }) : 
// Repositories are manually assigned because they're private members
    _bookingRepository = bookingRepository, 
    _userRepository = userRepository;

  final BookingRepository _bookingRepository;
  final UserRepository _userRepository;
  // ... 
}
```

ViewModels are always dependent on data repositories, which are provided as
arguments to the ViewModel’s constructor. ViewModels and repositories have a
many-to-many relationship, and most ViewModels will have multiple repositories
provided as input.

It’s important that repositories are private members on the ViewModel, because
views should never have direct access to the data layer of the application.

[repositories]: app-architecture/guide#repositories

### UI state

The output of a ViewModel is data that a view needs to render, generally referred to as **UI State, **or just state. UI state is an immutable snapshot of data that is required to fully render a view.


[//]: # (![alt_text]&#40;images/image6.png "image_tooltip"&#41;)


State is exposed as public members of the ViewModel class. On this ViewModel, the exposed data is a `User` object and the user’s saved itineraries, which are exposed as an object of type `List<TripSummary>`.

As mentioned, the UI state should be immutable. This is a crucial part of bug-free software.

The compass app uses the [freezed](https://pub.dev/packages/freezed) package to enforce immutability on data classes. For example, the following code shows the `User` class definition. `freezed` provides deep immutability, and generates the code for useful methods like `[copyWith](freezed.copywoith)` and `[toJson](jsonseralizable.toJson)`.

In our current example, two objects are needed to render the view. As the UI state for any given model grows in complexity, a ViewModel may have many more pieces of data from many more repositories exposed to the view. In some cases, you may want to create objects that specifically represent the UI state. For example, I could create a class called `HomeUiState`.


#### Updating UI state

In addition to storing state, ViewModels need to tell Flutter to re-render views when the data layer provides a new state. In the Compass app, ViewModels extend [`ChangeNotifier`](https://api.flutter.dev/CHANGENOTIFIER) to achieve this.

`HomeViewModel.user` is a public member that the view depends on. When new data flows from the data layer and new state needs to be emitted, [`notifyListeners`](https://github.com) is called.


[//]: # (![alt_text]&#40;images/image7.png "image_tooltip"&#41;)
*[caption] This figure shows from a high-level how new data in the repository propagates up to the UI layer and triggers a re-build of your Flutter widgets.*

1. *New state is provided to the ViewModel from a Repository*
2. *The ViewModel updates its UI state to reflect the new data*
3. *ViewModel.notifyListers is called, alerting the View of new UI State*
4. *The View (widget) re-renders.*

For example, when the user navigates to the Home screen and the ViewModel is created, the `_load` method is called. Until this method completes, the UI state is empty, the view displays a loading indicator. When the `_load` method completes, if it is successful, there is new data in the ViewModel, and it must notify the view that new data is available.

:::note

`ChangeNotifier` and `ListenableBuilder` (discussed later on this page) are part of the Flutter SDK, and provide a good solution for updating the UI when state changes. You can also use a robust third-party state management solution, such as [Riverpod](http://riverpod), [flutter_bloc](http://bloc), or [signals](https://pub.dev/packages/signals). These libraries offer different tools for handling UI updates. Read more about using [`ChangeNotifier`](http://fwepage) or [other popular solutions](http://statemanagementoptions).

:::


### Define a View {#define-a-view}

A [view](prevpage) is a widget within your app. Often, a view represents one screen in your app that has its own route and includes a [`Scaffold`](scaffold) at the top of the widget subtree, such as the `HomeScreen`.

But this isn’t always the case. Sometimes a view is a single UI element that encapsulates functionality that needs to be re-used throughout the app. For example, the Compass app has a view called `LogoutButton`, which can be dropped anywhere in the tree that a user might expect to find a logout button. The `LogoutButton` view has its own ViewModel called `LogoutViewModel`. On larger screens, there might be multiple views on screen that would take up the full screen on mobile.

:::note

“View” is an abstract term, and one View does not equal one widget. Widgets are composable, and several can be combined to create one view. Therefore, ViewModels don’t have a 1-to-1 relationship with widgets, but rather a 1-to-1 relation with a *collection* of widgets.

:::

The widgets within any given view have three responsibilities:



* Display the data properties from the ViewModel
* Listen for updates from the ViewModel and re-render when new data is available
* Attach callbacks from the ViewModel to event handlers, if applicable.


[//]: # (![alt_text]&#40;images/image8.png "image_tooltip"&#41;)


Continuing the Home feature example, the following code shows the definition of the ‘HomeScreen’ view.

In every view, the only inputs to the a view should be the `key`, which all Flutter widgets have as an optional argument, and the view’s corresponding ViewModel.


#### Display UI data in a View {#display-ui-data-in-a-view}

A view depends on a ViewModel for its state.  In the Compass app, the ViewModel is passed in as an argument in the view’s constructor. The following example code is from the `HomeScreen` widget.

Within the widget, you can access the bookings from the `viewModel` that was passed in. In the following code, the `booking` property is being provided to a sub-widget.


#### Update the UI {#update-the-ui}

The `HomeScreen` widget listens for updates from the ViewModel with the [`ListenableBuilder`](https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html) widget. Everything in the widget subtree under the `ListenableBuilder` widget re-renders when the provided [`Listenable`](https://api.flutter.dev/flutter/foundation/Listenable-class.html) changes. In this case, the provided `Listenable` is the ViewModel. Recall that the ViewModel is of type `ChangeNotifier` which is a subtype of the `Listenable` type.


### Handling user events {#handling-user-events}

Finally, a view needs to listen for *events* from users, so the ViewModel can handle those events. This is achieved by exposing a callback method on the ViewModel class, which encapsulates all the logic.


[//]: # (![alt_text]&#40;images/image9.png "image_tooltip"&#41;)


On the `HomeScreen`, users can delete previously booked events by swiping a `[Dismissable](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)` widget.


[//]: # (![alt_text]&#40;images/image10.gif "image_tooltip"&#41;)


Recall the code for the previous snippet.

On the `HomeScreen`, a user’s saved trip is represented by the `_Booking` widget.  When a `_Booking` is dismissed, the `viewModel.deleteBooking` method is executed.

A saved booking is application state that persists beyond a session or the lifetime of a view, and only repositories should modify the application state. So, the `HomeViewModel.deleteBooking` method turns around and calls a method exposed by a repository in the data layer.

In the Compass app, these methods that handle user events are called *[commands](http://commandpattern)*. Commands are responsible for the interaction that starts in the UI layer and flows back to the data layer. In this app specifically, a `Command` is also a type that helps update the UI safely regardless of the response time or contents.


#### Command objects {#command-objects}

The `Command` class wraps a method and helps handle the different states of that method, such as `running`, `complete`, and `error`. These states make it easy to display different UI, like loading indicators when `Command.running` is true.

The following is code from the `Command` class. Some code has been omitted for demo purposes.

The `Command` class itself extends `ChangeNotifier`, and within the method `Command.execute`, `notifyListeners` is called multiple times. This allows the view to handle different states with very little logic, which you’ll see an example of later on this page.

You may have also noticed that `Command` is an abstract class. It’s implemented by concrete classes such as `Command1`, which is used when the underlying method has one argument.

:::note

You can also use the [flutter_command](https://pub.dev/packages/flutter_command) package, which is a robust library that implements classes like these.

:::


#### Ensuring views can render before data exists {#ensuring-views-can-render-before-data-exists}

In ViewModel classes, commands are created in the constructor.

The `Command.execute` method is asynchronous, so it can’t guarantee that the data will be available when the view wants to render. This gets at *why* the Compass app uses `Commands`. In the view’s `Widget.build` method, the command is used to conditionally render different widgets.

Because the `load` command is a property that exists on the ViewModel rather than something ephemeral, it doesn’t matter when the `load` method is called or when it resolves. For example, if the load command resolves before the `HomeScreen	 widget was even created, it isn’t a problem because the `Command` object still exists, and exposes the correct state.

This pattern standardizes how common UI problems are solved in the app, making your codebase less error prone and more scalable, but it’s not a pattern that every app will want to implement. Whether you want to use it is highly dependent on other architectural choices you make. Many libraries that help you manage state have their own tools to solve these problems. For example, if you were to use [`Streams`](https://api.flutter.dev/flutter/dart-async/Stream-class.html) and  [`StreamBuilders`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) in your app, the [‘AsyncSnapshot’](https://api.flutter.dev/flutter/widgets/AsyncSnapshot-class.html) classes provided by Flutter have this functionality built in.

{%comment%}
TODO  – include explanation of [this real life bug](https://github.com/flutter/samples/pull/2449#pullrequestreview-2328333146) that Command’s solved 
{%endcomment%}

