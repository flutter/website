---
title: "Offline-first Support"
description: Create an app with offline-first support.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="app-architecture/offline_first"?>

An offline-first application is an app capable of offering most or all its functionality while being disconnected from the Internet. Offline-first applications usually rely on stored data to offer users a temporal access to data that would otherwise only be available online.

Some offline-first applications will combine local and remote data seamlessly, while other applications will inform the user when the application is using cached data. In the same way, some applications will synchronize data in the background while others will require the user to explicitly synchronize it. It all depends on the application requirements and the functionality it offers, and it’s up to the developer to decide which implementation fits their needs.

In this guide, you will learn how to implement different approaches to offline-first applications in Flutter, following the Flutter Architecture guidelines.

## Offline-first architecture

As explained in the common architecture concepts guide, repositories act as the single source of truth. They are responsible for presenting local or remote data, and should be the only place where data can be modified. In offline-first applications, repositories combine different local and remote data sources to present data in a single access point, independently of the connectivity state of the device.

This example uses the UserProfileRepository, a repository that allows to obtain and store UserProfile objects with offline-first support.

The UserProfileRepository uses two different data services: one works remote data, and the other works with a local database. 

The  API client is named ApiClientService, and it connects to a remote service using HTTP REST calls.

<?code-excerpt "lib/data/services/api_client_service.dart (ApiClientService)"?>
```dart
class ApiClientService {
  /// performs GET network request
  Future<UserProfile> getUserProfile() async {
// ···
  }

  /// performs a network PUT request
  Future<void> putUserProfile(UserProfile userProfile) async {
// ···
  }
}
```



