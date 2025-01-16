---
title: Error handling with Result objects
description: "Improve error handling across classes with Result objects."
contentTags:
  - error handling
  - services
iconPath: /assets/images/docs/app-architecture/design-patterns/result-icon.svg
order: 5
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="app-architecture/result"?>

Dart provides a built-in error handling mechanism 
with the ability to throw and catch exceptions.

As mentioned in the [Error handling documentation][], 
Dart's exceptions are unhandled exceptions.
This means that methods that throw exceptions don’t need to declare them, 
and calling methods aren't required to catch them either.

This can lead to situations where exceptions are not handled properly. 
In large projects, 
developers might forget to catch exceptions, 
and the different application layers and components 
could throw exceptions that aren’t documented. 
This can lead to errors and crashes.

In this guide, 
you will learn about this limitation 
and how to mitigate it using the _result_ pattern.

## Error flow in Flutter applications

Applications following the [Flutter architecture guidelines][]
are usually composed of view models, 
repositories, and services, among other parts. 
When a function in one of these components fails, 
it should communicate the error to the calling component.

Typically, that's done with exceptions. 
For example, 
an API client service failing to communicate with the remote server
might throw an HTTP Error Exception. 
The calling component, 
for example a Repository, 
would have to either capture this exception 
or ignore it and let the calling view model handle it.

This can be observed in the following example. Consider these classes:

- A service, `ApiClientService`, performs API calls to a remote service.
- A repository, `UserProfileRepository`,
  provides the `UserProfile` provided by the `ApiClientService`.
- A view model, `UserProfileViewModel`, uses the `UserProfileRepository`.

The `ApiClientService` contains a method, `getUserProfile`,
that throws exceptions in certain situations:

- The method throws an `HttpException` if the response code isn’t 200.
- The JSON parsing method throws an exception 
  if the response isn't formatted correctly.
- The HTTP client might throw an exception due to networking issues.

The following code tests for a variety of possible exceptions:

<?code-excerpt "lib/no_result.dart (ApiClientService)"?>
```dart
class ApiClientService {
  // ···

  Future<UserProfile> getUserProfile() async {
    try {
      final request = await client.get(_host, _port, '/user');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return UserProfile.fromJson(jsonDecode(stringData));
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }
}
```

The `UserProfileRepository` doesn’t need to handle 
the exceptions from the `ApiClientService`. 
In this example, it just returns the value from the API Client.

<?code-excerpt "lib/no_result.dart (UserProfileRepository)"?>
```dart
class UserProfileRepository {
  // ···

  Future<UserProfile> getUserProfile() async {
    return await _apiClientService.getUserProfile();
  }
}
```

Finally, the `UserProfileViewModel` 
should capture all exceptions and handle the errors.

This can be done by wrapping 
the call to the `UserProfileRepository` with a try-catch:

<?code-excerpt "lib/no_result.dart (UserProfileViewModel)"?>
```dart
class UserProfileViewModel extends ChangeNotifier {
  // ···

  Future<void> load() async {
    try {
      _userProfile = await userProfileRepository.getUserProfile();
      notifyListeners();
    } on Exception catch (exception) {
      // handle exception
    }
  }
}
```

In reality, a developer might forget to properly capture exceptions and
end up with the following code.
It compiles and runs, but crashes if
one of the exceptions mentioned previously occurs:

<?code-excerpt "lib/no_result.dart (UserProfileViewModelNoTryCatch)" replace="/NoTryCatch//g"?>
```dart
class UserProfileViewModel extends ChangeNotifier {
  // ···

  Future<void> load() async {
    _userProfile = await userProfileRepository.getUserProfile();
    notifyListeners();
  }
}
```

You can attempt to solve this by documenting the `ApiClientService`, 
warning about the possible exceptions it might throw. 
However, since the view model doesn’t use the service directly, 
other developers working in the codebase might miss this information.

## Using the result pattern

An alternative to throwing exceptions 
is to wrap the function output in a `Result` object.

When the function runs successfully, 
the `Result` contains the returned value. 
However, if the function does not complete successfully,
the `Result` object contains the error.

A `Result` is a [`sealed`][] class 
that can either subclass `Ok` or the `Error` class.
Return the successful value with the subclass `Ok`,
and the captured error with the subclass `Error`.

The following code shows a sample `Result` class that
has been simplified for demo purposes.
A full implementation is at the end of this page.

<?code-excerpt "lib/simple_result.dart"?>
```dart
/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Ok(value);

  /// Create an instance of Result containing an error
  factory Result.error(Exception error) => Error(error);
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error(this.error);

  /// Returned error in result
  final Exception error;
}
```

In this example,
the `Result` class uses a generic type `T` to represent any return value, 
which can be a primitive Dart type like `String` or an `int` or a custom class like `UserProfile`.

### Creating a `Result` object

For functions using the `Result` class to return values, 
instead of a value, 
the function returns a `Result` object containing the value.

For example, in the `ApiClientService`, 
`getUserProfile` is changed to return a `Result`:

<?code-excerpt "lib/main.dart (ApiClientService1)"?>
```dart
class ApiClientService {
  // ···

  Future<Result<UserProfile>> getUserProfile() async {
    // ···
  }
}
```

Instead of returning the `UserProfile` directly, 
it returns a `Result` object containing a `UserProfile`.

To facilitate using the `Result` class, 
it contains two named constructors, `Result.ok` and `Result.error`. 
Use them to construct the `Result` depending on desired output. 
As well, capture any exceptions thrown by the code 
and wrap them into the `Result` object.

For example, here the `getUserProfile()` method 
has been changed to use the `Result` class:

<?code-excerpt "lib/main.dart (ApiClientService2)"?>
```dart
class ApiClientService {
  // ···

  Future<Result<UserProfile>> getUserProfile() async {
    try {
      final request = await client.get(_host, _port, '/user');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return Result.ok(UserProfile.fromJson(jsonDecode(stringData)));
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (exception) {
      return Result.error(exception);
    } finally {
      client.close();
    }
  }
}
```

The original return statement was replaced 
with a statement that returns the value using `Result.ok`. 
The `throw HttpException()` 
was replaced with a statement that returns `Result.error(HttpException())`,
wrapping the error into a `Result`. 
As well, the method is wrapped with a `try-catch` block
to capture any exceptions thrown by the Http client 
or the JSON parser into a `Result.error`.

The repository class also needs to be modified, 
and instead of returning a `UserProfile` directly, 
now it returns a `Result<UserProfile>`.

<?code-excerpt "lib/main.dart (getUserProfile1)" replace="/1//g"?>
```dart
Future<Result<UserProfile>> getUserProfile() async {
  return await _apiClientService.getUserProfile();
}
```

### Unwrapping the Result object

Now the view model doesn't receive the `UserProfile` directly, 
but instead it receives a `Result` containing a `UserProfile`.

This forces the developer implementing the view model 
to unwrap the `Result` to obtain the `UserProfile`, 
and avoids having uncaught exceptions.

<?code-excerpt "lib/main.dart (UserProfileViewModel)"?>
```dart
class UserProfileViewModel extends ChangeNotifier {
  // ···

  UserProfile? userProfile;

  Exception? error;

  Future<void> load() async {
    final result = await userProfileRepository.getUserProfile();
    switch (result) {
      case Ok<UserProfile>():
        userProfile = result.value;
      case Error<UserProfile>():
        error = result.error;
    }
    notifyListeners();
  }
}
```

The `Result` class is implemented using a `sealed` class, 
meaning it can only be of type `Ok` or `Error`. 
This allows the code to evaluate the result with a  
[switch result or expression][]. 

In the `Ok<UserProfile>` case, 
obtain the value using the `value` property. 

In the `Error<UserProfile>` case,
obtain the error object using the `error` property.

## Improving control flow

Wrapping code in a `try-catch` block ensures that
thrown exceptions are caught and not propagated to other parts of the code.

Consider the following code.

<?code-excerpt "lib/no_result.dart (UserProfileRepository2)" replace="/2//g"?>
```dart
class UserProfileRepository {
  // ···

  Future<UserProfile> getUserProfile() async {
    try {
      return await _apiClientService.getUserProfile();
    } catch (e) {
      try {
        return await _databaseService.createTemporaryUser();
      } catch (e) {
        throw Exception('Failed to get user profile');
      }
    }
  }
}
```

In this method, the `UserProfileRepository` 
attempts to obtain the `UserProfile` 
using the `ApiClientService`.
If it fails, it tries to create a temporary user in a `DatabaseService`.

Because either service method can fail, 
the code must catch the exceptions in both cases.

This can be improved using the `Result` pattern:


<?code-excerpt "lib/main.dart (getUserProfile)"?>
```dart
Future<Result<UserProfile>> getUserProfile() async {
  final apiResult = await _apiClientService.getUserProfile();
  if (apiResult is Ok) {
    return apiResult;
  }

  final databaseResult = await _databaseService.createTemporaryUser();
  if (databaseResult is Ok) {
    return databaseResult;
  }

  return Result.error(Exception('Failed to get user profile'));
}
```

In this code, if the `Result` object is an `Ok` instance, 
then the function returns that object; 
otherwise, it returns `Result.Error`.

## Putting it all together

In this guide, you have learned 
how to use a `Result` class to return result values.

The key takeaways are:

- `Result` classes force the calling method to check for errors, 
  reducing the amount of bugs caused by uncaught exceptions.
- `Result` classes help improve control flow compared to try-catch blocks.
- `Result` classes are `sealed` and can only return `Ok` or `Error` instances, 
  allowing the code to unwrap them with a switch statement.

Below you can find the full `Result` class 
as implemented in the [Compass App example][] 
for the [Flutter architecture guidelines][].

:::note
Check [pub.dev][] for different ready-to-use 
implementations of the `Result` class,
such as the [`result_dart`][], [`result_type`][], and [`multiple_result`][] packages.
:::

<?code-excerpt "lib/result.dart (Result)"?>
```dart
/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;
}

/// A successful [Result] with a returned [value].
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// The returned value of this result.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// An error [Result] with a resulting [error].
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// The resulting error of this result.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
```

[Error handling documentation]: {{site.dart-site}}/language/error-handling
[Flutter architecture guidelines]: /app-architecture
[Compass App example]: {{site.repo.samples}}/tree/main/compass_app
[pub.dev]: {{site.pub}}
[`result_dart`]: {{site.pub-pkg}}/result_dart
[`result_type`]: {{site.pub-pkg}}/result_type
[`multiple_result`]: {{site.pub-pkg}}/multiple_result
[`sealed`]: {{site.dart-site}}/language/class-modifiers#sealed
[switch result or expression]: {{site.dart-site}}/language/branches#switch-statements
