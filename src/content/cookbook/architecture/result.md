---
title: Result class
description: Handle errors and return values with the result class
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/architecture/result"?>

Dart provides a built-in error handling mechanism 
through the ability to throw and catch exceptions.

As mentioned in the [Error handling documentation][], 
Dart’s exceptions are unhandled exceptions, 
meaning that methods that throw don’t need to declare them, 
and calling methods are not required to catch them either.

This can lead to situations where exceptions are not handled properly. 
In large projects, 
developers might forget to catch exceptions, 
and the different application layers and components 
could throw exceptions that aren’t documented. 
This can lead to errors and crashes.

In this guide, 
you will learn about this limitation 
and how to mitigate it using the result class pattern.

## Error flow in Flutter applications

Applications following the [Flutter Architecture guidelines][]
are usually composed of ViewModels, 
Repositories, and Services, among other parts. 
When a function in one of these components fails, 
it will have to communicate the error to the calling component.

Typically, that would be done using exceptions. 
For example, 
an API client Service failing to communicate with the remote server
might throw an HTTP Error Exception. 
The calling component, 
for example a Repository, 
would have to either capture this exception 
or ignore it and let the calling ViewModel handle it.

This can be observed in the following example. Consider these classes:

- A service named `ApiClientService` 
that performs API calls to a remote service.
- A repository named `UserProfileRepository` 
that uses the `ApiClientService` to provide the `UserProfile`.
- A ViewModel named `UserProfileViewModel` 
that uses the `UserProfileRepository`.

The `ApiClientService` contains a method named `getUserProfile`
 hat can throw exceptions in different situations:

- The method throws an `HttpException` if the response code isn’t 200.
- The JSON parsing method might throw an exception 
if the response is not formatted correctly.
- The Http Client might throw an exception due to networking issues.

For example:

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
However, as multiple developers can work on the same codebase, 
it is not unusual that a developer might forget to properly capture exceptions. 
The following code will compile and run, 
but will crash if one of the exceptions mentioned previously occurs:

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
warning about the possible exceptions it may throw. 
However, since the ViewModel doesn’t use the service directly, 
this information may be missed by other developers working in the codebase.

## Using the result pattern

An alternative to throwing exceptions 
is to wrap the function output into a `Result`.

When the function runs successfully, 
the `Result` contains the returned value. 
However, if the function did not complete successfully,
the `Result` object will contain the error.

A `Result` is a `sealed class` 
that can either be of the subclass `Ok` or the subclass `Error`. 
Return the successful value with the subclass `Ok`,
and the captured error with the subclass `Error`.

The following is what a `Result` class might look like.
It’s been simplified for demo purposes. 
You can see a full implementation at the end of this page.

<?code-excerpt "lib/simple_result.dart"?>
```dart
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
which can be as simple as a `String` or an `int` 
but also can be used for custom data classes like the `UserProfile`.

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
As well, capture any thrown exceptions by the code 
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
        return Result.error(const HttpException('Invalid response'));
      }
    } on Exception catch (exception) {
      return Result.error(exception);
    } finally {
      client.close();
    }
  }
}
```

The original return statement has been replaced 
with returning the value using `Result.ok`. 
The `throw HttpException()` 
has been replaced with returning `Result.error(HttpException())` 
wrapping the error into a `Result`. 
As well, the method is wrapped with a try-catch 
to capture any thrown exception by the Http Client 
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

Now the ViewModel doesn't receive the `UserProfile` directly, 
but instead it receives a `Result` containing a `UserProfile`.

This enforces the developer implementing the ViewModel 
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

The `Result` class is implemented using a `sealed class`, 
meaning it can only either be an `Ok` or an `Error`, 
so this operation can be done using a switch case.

In the `Ok<UserProfile>` case, 
obtain the value using the `value` property. 

In the Error<UserProfile> case,
obtain the error object using the `error` property.

## Improving control flow

Wrapping code with a try-catch 
is a quick way to ensure that any exception thrown 
is captured by the calling method. 
Catching stops the exception from propagating to other methods, h
owever it also disrupts the normal code flow.

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
using the `ApiClientService`, 
and if it fails, 
then tries to create a temporary user in a `DatabaseService`.

Because either Service methods can fail, 
the code must catch the exceptions in both cases.

This can be improved using the `Result` pattern:


<?code-excerpt "lib/main.dart (getUserProfile)"?>
```dart
Future<Result<UserProfile>> getUserProfile() async {
  final apiResult = await _apiClientService.getUserProfile();
  if (apiResult is Ok) {
    return apiResult;
  }

  final databaseResult = await _databaseService.createTemporalUser();
  if (databaseResult is Ok) {
    return databaseResult;
  }

  return Result.error(Exception('Failed to get user profile'));
}
```

In this case, if the `Result` object is an `Ok`, 
then the function returns that object, 
otherwise at the end of the function returns a `Result.Error` if none worked.

## Putting it all together

In this guide, you have learned 
how to use a `Result` class to return result values.

The key takeaways are:

- `Result` classes enforce calling methods to check for errors, 
reducing the amount of bugs caused by uncaught exceptions.
- `Result` classes help improve control flow compared to try-catch blocks.
- `Result` classes are `sealed classes` that can only be `Ok` or `Error`, 
allowing you to use switch statements to unwrap them.

Below you can find the full `Result` class 
as implemented in the [Compass App example][] 
for the [Flutter Architecture guidelines][].

:::note
Check [pub.dev][] for different ready-to-use 
implementations of the `Result` class,
like the [result_dart][], [result_type][] or [multiple_result][] packages.
:::

<?code-excerpt "lib/result.dart"?>
```dart
// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Utility class to wrap result data
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

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Ok(value);

  /// Create an instance of Result containing an error
  factory Result.error(Exception error) => Error(error);

  /// Convenience method to cast to Ok
  Ok<T> get asOk => this as Ok<T>;

  /// Convenience method to cast to Error
  Error get asError => this as Error<T>;
}

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

[Error handling documentation]:{{site.dart-site}}/language/error-handling
[Flutter Architecture guidelines]:/app-architecture
[Compass App example]:{{site.repo.samples}}/tree/main/compass_app
[pub.dev]:{{site.pub}}
[result_dart]:{{site.pub-pkg}}/result_dart
[result_type]:{{site.pub-pkg}}/result_type
[multiple_result]:{{site.pub-pkg}}/multiple_result
