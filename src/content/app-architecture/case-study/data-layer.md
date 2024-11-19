---
title: Data layer case study
short-title: Data layer
description: >
  A walk-through of the data layer of an app that implements the Flutter architecture.
prev: 
  title: UI layer
  path: /app-architecture/case-study/ui-layer
next:
  title: Dependency Injection
  path: /app-architecture/case-study/dependency-injection
---

## The data layer {#the-data-layer}

The data layer of an application, known as the *model *in MVVM terminology, is the source of truth for all application data. As the source of truth, it is the only place that application data should be updated.

It’s responsible for consuming data from various external APIs, exposing that data to the UI, handling events from the UI that require data to be updated, and sending update requests to those external APIs as needed.

The data layer in this guide has two main components, [repositories](prevpage) and [services](prevpage).


![alt_text](images/image11.png "image_tooltip")




* **Repositories** are the source of the truth for application data, and contain logic that relates to that data, like updating the data in response to new user events or polling for data from services. Repositories are responsible for synchronizing the data when offline capabilities are supported, managing retry logic, and caching data.
* **Services **are stateless Dart classes that interact with APIs, like HTTP servers and platform plugins. Any data that your application needs that isn’t created inside the application code itself should be fetched from within service classes.


### Define a Service {#define-a-service}

A service class is the least ambiguous of all the architecture components. It’s stateless, and its functions don’t have side effects. Its only job is to wrap an external API. There is generally one service class per data source, such as a client HTTP server or a platform plugin.


![alt_text](images/image12.png "image_tooltip")


In the Compass app, for example, there is an [`APIClient`](github) service that handles most calls to the client-facing server.

The service itself is a class, and each method wraps a different API endpoint and exposes asynchronous response objects. Continuing the earlier example of deleting a saved booking, the `deleteBooking` method returns a `Future&lt;Result&lt;void>>`.

:::note

Some methods return data classes that are specifically for raw data from the API, such as the `BookingApiModel` class. As you’ll soon see, repositories extract data and expose it to ViewModels in a different format.

:::


### Result objects {#result-objects}

In this app, methods on service classes return `Result` objects. `Result` is a utility class that adds type safety to API calls, making it easier to handle errors. Encoding asynchronous responses in this way makes it easy to write helper functions for a number of different cases, such as API retry logic, without having to write custom logic for every instance of the case.

In the Compass app, `Result` is a [sealed](https://dart.dev/language/class-modifiers#sealed) class with two subclasses, called `Ok` and `Error`. The following example shows the `Result class`.

The `Ok` and `Error` subclasses add additional properties to handle different response types. The `Error` subclass has the property `Exception error`, and the `Ok` subclass has the generic property `T value`.

To use the `Result` class, wrap the responses from API calls in a result, like in the following example which shows how `ApiClient.deleteBooking` is implemented :

The value of using a pattern like this will be explained in the next section about repositories, which consume the results of API calls. This pattern is a recommendation, but not a requirement. The architecture recommended in this guide can be implemented without it.


### Define a repository {#define-a-repository}

A repository’s sole responsibility is to manage application data. A repository is the source of truth for a single type of application data, and it should be the only place that data type is mutated. It’s responsible for polling new data from external sources, handling retry logic, managing cached data, and transforming raw data into domain models.

You should have a separate repository for each different type of data in your application. For example, the Compass app has repositories called `UserRepository`, `BookingRepository`, `AuthRepository`, `DestinationRepository`, and more.

The following example is the `BookingRepository` from the Compass app, and shows the basic structure of a repository.

:::note

The class in the example above is `BookingRepositoryRemote`, which extends an abstract class called `BookingRepository`. This base class is used to create repositories for different environments. For example, the compass app also has a class called `BookingRepositoryLocal`, which is used for local development.

{%comment%} This pattern is explained in depth in the design pattern cookbook. {%endcomment%}

:::

The `BookingRepository` takes the `ApiClient` service as an input, which it uses to get and update the raw data from the server. It’s important that the service is a private member, so that the UI layer cannot bypass the repository and call a service directly.

Via the `ApiClient` service, it can poll for updates to a user’s saved bookings that might happen on the server, and make POST requests to delete saved bookings.

The raw data that a repository transforms into application models can come from multiple sources via multiple services, and therefore repositories and services have a many-to-many relationship. A service can be used by any number of repositories, and a repository can use more than one service.

[figure]


### Domain models {#domain-models}

The `BookingRepository` outputs `Booking` and `BookingSummary` objects. There are *domain models*. All repositories output corresponding domain models. These data models differ from API models in that they only contain the data needed by the rest of the app. API models contain raw data that often needs to be filtered or combined or removed to be useful to the app’s ViewModels. When the raw data has been refined, its output as domain models.

In the example app, domain models are exposed via return values on methods like `BookingRepository.getBooking`. The `getBooking` method is responsible for getting the raw data from `ApiClient` service, and transforming it into a `Booking` object. It does this by combining data from multiple service endpoints.


### Complete the event cycle {#complete-the-event-cycle}

Throughout this page, you’ve seen how a user can delete a saved booking, starting with an event–a user swiping on a `Dismissable` widget. That event is handled in the ViewModel, which delegates the actual data mutation to the `BookingRepository`. The following snippet shows the `BookingRepository.deleteBooking` method.

The repository sends a POST request to the API client via the `_apiClient.deleteBooking` method, and returns a `Result`. This `Result`, and the data it contains, is consumed by the `HomeViewModel`, which will ultimately call `notifyListeners`, completing the cycle.
