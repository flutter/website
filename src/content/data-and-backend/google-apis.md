---
title: Google APIs
description: How to use Google APIs with Flutter.
---

<?code-excerpt path-base="googleapis/"?>

The [Google APIs package][] exposes dozens of Google
services that you can use from Dart projects.

This page describes how to use APIs that interact with
end-user data by using Google authentication.

Examples of user-data APIs include
[Calendar][], [Gmail][], [YouTube][], and Firebase.

:::note
The only APIs you should use directly from your Flutter
project are those that access user data using Google authentication.

APIs that require [service accounts][] **should not**
be used directly from a Flutter application.
Doing so requires shipping service credentials as part
of your application, which is not secure.
To use these APIs,
we recommend creating an intermediate service.
:::

To add authentication to Firebase explicitly, check out the
[Add a user authentication flow to a Flutter app using FirebaseUI][fb-lab]
codelab and the
[Get Started with Firebase Authentication on Flutter][fb-auth] docs.

[fb-lab]: {{site.firebase}}/codelabs/firebase-auth-in-flutter-apps
[Calendar]: {{site.pub-api}}/googleapis/latest/calendar_v3/calendar_v3-library.html
[fb-auth]: {{site.firebase}}/docs/auth/flutter/start
[Gmail]: {{site.pub-api}}/googleapis/latest/gmail_v1/gmail_v1-library.html
[Google APIs package]: {{site.pub-pkg}}/googleapis
[service accounts]: https://cloud.google.com/iam/docs/service-account-overview
[YouTube]: {{site.pub-api}}/googleapis/latest/youtube_v3/youtube_v3-library.html

## Overview

To use Google APIs, follow these steps:

1. Pick the desired API
1. Enable the API
1. Authenticate and determine the current user
1. Obtain an authenticated HTTP client
1. Create and use the desired API class

## 1. Pick the desired API

The documentation for [`package:googleapis`][] lists
each API as a separate Dart library&emdash;in a
`name_version` format.
Check out [`youtube_v3`][] as an example.

Each library might provide many types,
but there is one _root_ class that ends in `Api`.
For YouTube, it's [`YouTubeApi`][].

Not only is the `Api` class the one you need to
instantiate (see step 3), but it also
exposes the scopes that represent the permissions
needed to use the API. For example,
the [Constants section][] of the
`YouTubeApi` class lists the available scopes.
To request access to read (but not write) an end-user's
YouTube data, authenticate the user with
[`youtubeReadonlyScope`][].

<?code-excerpt "lib/main.dart (youtube-import)"?>
```dart
/// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';
```

[Constants section]: {{site.pub-api}}/googleapis/latest/youtube_v3/YouTubeApi-class.html#constants
[`package:googleapis`]: {{site.pub-api}}/googleapis
[`youtube_v3`]: {{site.pub-api}}/googleapis/latest/youtube_v3/youtube_v3-library.html
[`YouTubeApi`]: {{site.pub-api}}/googleapis/latest/youtube_v3/YouTubeApi-class.html
[`youtubeReadonlyScope`]: {{site.pub-api}}/googleapis/latest/youtube_v3/YouTubeApi/youtubeReadonlyScope-constant.html

## 2. Enable the API

To use Google APIs you must have a Google account
and a Google project. You also
need to enable your desired API.

This example enables [YouTube Data API v3][].
For details, see the [getting started instructions][].

[getting started instructions]: https://cloud.google.com/apis/docs/getting-started
[YouTube Data API v3]: https://console.cloud.google.com/apis/library/youtube.googleapis.com

## 3. Authenticate and determine the current user

Use the [google_sign_in][gsi-pkg] package to
authenticate users with their Google identity.
Configure sign in for each platform you want to support.

<?code-excerpt "lib/main.dart (google-import)"?>
```dart
/// Provides the `GoogleSignIn` class.
import 'package:google_sign_in/google_sign_in.dart';
```

The package's functionality is accessed through
a static instance of the [`GoogleSignIn`][] class.
Before interacting with the instance,
the `initialize` method must be called and allowed to complete.

<?code-excerpt "lib/main.dart (init)"?>
```dart
final _googleSignIn = GoogleSignIn.instance;

@override
void initState() {
  super.initState();
  _googleSignIn.initialize();
  // ···
}
```

Once initialization is complete but before user authentication,
listen to authentication events to determine if a user signed in.

<?code-excerpt "lib/main.dart (post-init)" plaster="none"?>
```dart highlightLines=1,7,9-12
GoogleSignInAccount? _currentUser;

@override
void initState() {
  super.initState();
  _googleSignIn.initialize().then((_) {
    _googleSignIn.authenticationEvents.listen((event) {
      setState(() {
        _currentUser = switch (event) {
          GoogleSignInAuthenticationEventSignIn() => event.user,
          _ => null,
        };
      });
    });
  });
}
```

Once you're listening to any relevant authentication events,
you can attempt to authenticate a previously signed-in user.

```dart highlightLines=5-6
void initState() {
  super.initState();
  _googleSignIn.initialize().then((_) {
    // ...
    // Attempt to authenticate a previously signed in user.
    _googleSignIn.attemptLightweightAuthentication();
  });
}
```

To also allow for new users to authenticate,
follow the instructions provided by
[`package:google_sign_in`][gsi-pkg].

Once a user has been authenticated,
you must obtain an authenticated HTTP client.

[gsi-pkg]: {{site.pub-pkg}}/google_sign_in
[`GoogleSignIn`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignIn-class.html

## 4. Obtain an authenticated HTTP client

Once you have a signed-in user, request the
relevant client authorization tokens using [`authorizationForScopes`][]
for the API scopes that your app requires.

<?code-excerpt "lib/main.dart (scope-authorize)"?>
```dart
const relevantScopes = [YouTubeApi.youtubeReadonlyScope];
final authorization = await currentUser.authorizationClient
    .authorizationForScopes(relevantScopes);
```

:::note
If your scopes require user interaction,
you'll need to use [`authorizeScopes`][] from an interaction handler
instead of `authorizationForScopes`.
:::

Once you have the relevant authorization tokens,
use the [`authClient`][] extension from
[`package:extension_google_sign_in_as_googleapis_auth`][] to
set up an authenticated HTTP client with the relevant credentials applied.

<?code-excerpt "lib/main.dart (auth-import)"?>
```dart
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
```

<?code-excerpt "lib/main.dart (auth-client)"?>
```dart
final authenticatedClient = authorization!.authClient(
  scopes: relevantScopes,
);
```

[`authorizationForScopes`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignInAuthorizationClient/authorizationForScopes.html
[`authorizeScopes`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignInAuthorizationClient/authorizeScopes.html
[`authClient`]: {{site.pub-api}}/extension_google_sign_in_as_googleapis_auth/latest/extension_google_sign_in_as_googleapis_auth/GoogleApisGoogleSignInAuth/authClient.html
[`package:extension_google_sign_in_as_googleapis_auth`]: {{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth

## 5. Create and use the desired API class

Use the API to create the desired API type and call methods.
For instance:

<?code-excerpt "lib/main.dart (playlist)"?>
```dart
final youTubeApi = YouTubeApi(authenticatedClient);

final favorites = await youTubeApi.playlistItems.list(
  ['snippet'],
  playlistId: 'LL', // Liked List
);
```

## More information

You might want to check out the following:

* The [`extension_google_sign_in_as_googleapis_auth` example][auth-ex]
  is a working implementation of the concepts described on this page.

[auth-ex]: {{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth/example
