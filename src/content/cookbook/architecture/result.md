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



[Error handling documentation]:{{site.dart-site}}/language/error-handling
[Flutter Architecture guidelines]:/app-architecture
