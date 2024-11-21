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


The data layer of an application, known as the *model* in MVVM terminology, 
is the source of truth for all application data. As the source of truth, 
it is the only place that application data should be updated.

It's responsible for consuming data from various external APIs, 
exposing that data to the UI, 
handling events from the UI that require data to be updated, 
and sending update requests to those external APIs as needed.

The data layer in this guide has two main components, 
[repositories][] and [services][].

<img src='/assets/images/docs/app-architecture/guide/feature-architecture-simplified-Data-highlighted.png'
alt="A diagram that highlights the data layer components of an application.">

* **Repositories** are the source of the truth for application data, and contain
  logic that relates to that data, like updating the data in response to new
  user events or polling for data from services. Repositories are responsible
  for synchronizing the data when offline capabilities are supported, managing
  retry logic, and caching data.
* **Services** are stateless Dart classes that interact with APIs, like HTTP
  servers and platform plugins. Any data that your application needs that isn't
  created inside the application code itself should be fetched from within
  service classes.

## Define a Service

A service class is the least ambiguous of all the architecture components. 
It's stateless, and its functions don't have side effects. 
Its only job is to wrap an external API. 
There is generally one service class per data source, 
such as a client HTTP server or a platform plugin.

<img src='/assets/images/docs/app-architecture/case-study/mvvm-case-study-services-architecture.png'
alt="A diagram that shows the inputs and outputs of service objects.">

In the Compass app, for example, there is an [`APIClient`][] service that 
handles the CRUD calls to the client-facing server.

```dart
// app/lib/data/services/api/api_client.dart

class ApiClient {
  // ... some code omitted for demo purposes

  Future<Result<List<ContinentApiModel>>> getContinents() async {...}

  Future<Result<List<DestinationApiModel>>> getDestinations() async {...}

  Future<Result<List<ActivityApiModel>>> getActivityByDestination(String ref) async {...}

  Future<Result<List<BookingApiModel>>> getBookings() async {...}

  Future<Result<BookingApiModel>> getBooking(int id) async {...}

  Future<Result<BookingApiModel>> postBooking(BookingApiModel booking) async {...}

  Future<Result<void>> deleteBooking(int id) async {...}

  Future<Result<UserApiModel>> getUser() async {...}
}
```

The service itself is a class, 
nd each method wraps a different API endpoint and 
exposes asynchronous response objects. 
Continuing the earlier example of deleting a saved booking, 
the `deleteBooking` method returns a `Future<Result<void>>`.

:::note
Some methods return data classes that are 
specifically for raw data from the API, 
such as the `BookingApiModel` class. 
As you'll soon see, repositories extract data and 
expose it to ViewModels in a different format.
:::

### Result objects

In this app, methods on service classes return `Result` objects.
`Result` is a utility class that adds type safety to API calls, 
making it easier to handle errors. 
Encoding asynchronous responses in this way makes it easy to
write helper functions for a number of different cases, 
such as API retry logic, 
without having to write custom logic for every instance of the case.

In the Compass app, 
`Result` is a [sealed][] class with two subclasses, 
called `Ok` and `Error`. 
The following example shows the `Result class`.

```dart
// app/lib/data/utils/result.dart

sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Ok(value);

  /// Create an instance of Result containing an error
  factory Result.error(Exception error) => Error(error);

  /// Convenience method to cast to Ok
  Ok<T> get asOk => this as Ok<T>;

  /// Convenience method to cast to Error
  Error get asError => this as Error<T>;
}
```

The `Ok` and `Error` subclasses add additional properties to 
handle different response types. 
The `Error` subclass has the property `Exception error`, 
and the `Ok` subclass has the generic property `T value`.

```dart
// app/lib/data/utils/result.dart

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  /// Returned value in result
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error(this.error);

  /// Returned error in result
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
```

To use the `Result` class, 
wrap the responses from API calls in a result, 
like in the following example which shows how 
`ApiClient.deleteBooking` is implemented:

```dart
// app/lib/data/services/api/api_client.dart

class ApiClient {
 // ...

 Future<Result<void>> deleteBooking(int id) async {
    final client = _clientFactory();
    try {
      final request = await client.delete(_host, _port, '/booking/$id');
      await _authHeader(request.headers);
      final response = await request.close();
      // Response 204 "No Content", delete was successful
      if (response.statusCode == 204) {
        [!return Result.ok(null);!]
      } else {
        [!return Result.error(const HttpException("Invalid response"));!]
      }
    } on Exception catch (error) {
      [!return Result.error(error);!]
    } finally {
      client.close();
    }
  }
}

```
 
This pattern is a recommendation, but not a requirement. 
The architecture recommended in this guide can be implemented without it. 
The value of using a pattern like this will be explained in
the next section about repositories, which consume the results of API calls.

## Define a repository

A repository's sole responsibility is to manage application data. 
A repository is the source of truth for a single type of application data, 
and it should be the only place that data type is mutated. 
It's responsible for polling new data from external sources, 
handling retry logic, managing cached data, 
and transforming raw data into domain models.

<img src='/assets/images/docs/app-architecture/guide/feature-architecture-simplified-Repository-highlighted.png'
alt="A diagram that highlights the repository component of an application.">

You should have a separate repository for each different type of 
data in your application. For example, 
the Compass app has repositories called `UserRepository`, 
`BookingRepository`, `AuthRepository`, `DestinationRepository`, and more.

The following example is the `BookingRepository` from the Compass app, 
and shows the basic structure of a repository.

```dart
// app/lib/data/repositories/booking/booking_repository_remote.dart

class BookingRepositoryRemote implements BookingRepository {
  BookingRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;
  List<Destination>? _cachedDestinations;

  Future<Result<void>> createBooking(Booking booking) async {...}
  Future<Result<Booking>> getBooking(int id) async {...}
  Future<Result<List<BookingSummary>>> getBookingsList() async {...}
  Future<Result<void>> delete(int id) async {...}
}

```

:::note Development vs staging environments
The class in the example above is `BookingRepositoryRemote`, 
which extends an abstract class called `BookingRepository`. 
This base class is used to create repositories for different environments. 
For example, the compass app also has a class called `BookingRepositoryLocal`, 
which is used for local development.

You can see the differences between the [`BookingRepository` classes on Github][].
:::


The `BookingRepository` takes the `ApiClient` service as an input, 
which it uses to get and update the raw data from the server. 
It's important that the service is a private member, 
so that the UI layer cannot bypass the repository and call a service directly.

Via the `ApiClient` service, 
the repository can poll for updates to a user's saved bookings that 
might happen on the server, and make POST requests to delete saved bookings.

The raw data that a repository transforms into application models can come from
multiple sources via multiple services, 
and therefore repositories and services have a many-to-many relationship. 
A service can be used by any number of repositories, 
and a repository can use more than one service.

<img src='/assets/images/docs/app-architecture/guide/feature-architecture-simplified-Data-highlighted.png'
alt="A diagram that highlights the data layer components of an application.">

### Domain models

The `BookingRepository` outputs `Booking` and `BookingSummary` objects, 
which are *domain models*. All repositories output corresponding domain models. 
These data models differ from API models in that they only contain the data 
needed by the rest of the app. 
API models contain raw data that often needs to be filtered or 
combined or removed to be useful to the app's ViewModels. 
When the raw data has been refined, its output as domain models.

In the example app, domain models are exposed via 
return values on methods like `BookingRepository.getBooking`. 
The `getBooking` method is responsible for getting the raw data from 
the `ApiClient` service, and transforming it into a `Booking` object. 
It does this by combining data from multiple service endpoints.

```dart
// app/lib/data/repositories/booking/booking_repository_remote.dart

// method edited for brevity
 Future<Result<Booking>> getBooking(int id) async {
    try {
      // Get booking by ID from server
      final resultBooking = await _apiClient.getBooking(id);
      if (resultBooking is Error<BookingApiModel>) {
        return Result.error(resultBooking.error);
      }
      final booking = resultBooking.asOk.value;

      final destination = _apiClient.getDestination(booking.destinationRef);
      final activities = _apiClient.getActivitiesForBooking(booking.activitiesRef);

      [!return Result.ok(!]
      [!  Booking(!]
      [!    startDate: booking.startDate,!]
      [!    endDate: booking.endDate,!]
      [!    destination: destination,!]
      [!    activity: activities,!]
      [!  ),!]
      [!);!]
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
```

### Complete the event cycle

Throughout this page, you've seen how a user can delete a saved booking,
starting with an event--a user swiping on a `Dismissable` widget. 
That event is handled in the ViewModel, 
which delegates the actual data mutation to the `BookingRepository`. 
The following snippet shows the `BookingRepository.deleteBooking` method.

```dart
// app/lib/data/repositories/booking/booking_repository_remote.dart

  Future<Result<void>> delete(int id) async {
    try {
      return _apiClient.deleteBooking(id);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
```

The repository sends a POST request to the API client via
the `_apiClient.deleteBooking` method, 
and returns a `Result`. This `Result`and the data it contains is consumed by
the `HomeViewModel`, which will ultimately call `notifyListeners`, 
completing the cycle.

[repositories]: /app-architecture/guide#repositories 
[services]:  /app-architecture/guide#services
[`APIClient`]: https://github.com/flutter/samples/blob/main/compass_app/app/lib/data/services/api/api_client.dart
[sealed]: https://dart.dev/language/class-modifiers#sealed
[`BookingRepository` classes on Github]: https://github.com/flutter/samples/tree/main/compass_app/app/lib/data/repositories/booking
