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
1. Authenticate user with the required scopes
1. Obtain an authenticated HTTP client
1. Create and use the desired API class

## 1. Pick the desired API

The documentation for [package:googleapis][] lists
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
To request access to read (but not write) an end-users
YouTube data, authenticate the user with
[`youtubeReadonlyScope`][].

<?code-excerpt "lib/main.dart (youtube-import)"?>
```dart
/// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';
```

[Constants section]: {{site.pub-api}}/googleapis/latest/youtube_v3/YouTubeApi-class.html#constants
[package:googleapis]: {{site.pub-api}}/googleapis
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

## 3. Authenticate the user with the required scopes

Use the [google_sign_in][gsi-pkg] package to
authenticate users with their Google identity.
Configure signin for each platform you want to support.

<?code-excerpt "lib/main.dart (google-import)"?>
```dart
/// Provides the `GoogleSignIn` class
import 'package:google_sign_in/google_sign_in.dart';
```

When instantiating the [`GoogleSignIn`][] class,
provide the desired scopes as discussed
in the previous section.

<?code-excerpt "lib/main.dart (init)"?>
```dart
final _googleSignIn = GoogleSignIn.instance;
final _scopes = [YouTubeApi.youtubeReadonlyScope];
```

Follow the instructions provided by
[`package:google_sign_in`][gsi-pkg]
to allow a user to authenticate.

Once authenticated,
you must obtain an authenticated HTTP client.

[gsi-pkg]: {{site.pub-pkg}}/google_sign_in
[`GoogleSignIn`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignIn-class.html

## 4. Obtain an authenticated HTTP client

The [extension_google_sign_in_as_googleapis_auth][]
package provides an [extension method][] on `GoogleSignIn`
called [`authenticatedClient`][].

<?code-excerpt "lib/main.dart (auth-import)"?>
```dart
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
```

Add a listener to [`onCurrentUserChanged`][]
and when the event value isn't `null`,
you can create an authenticated client.

<?code-excerpt "lib/main.dart (signin-call)"?>
```dart
var httpClient =
    (await _currentUser!.authorizationClient.authorizationForScopes(
      _scopes,
    ))!.authClient(scopes: _scopes);
```

This [`Client`][] instance includes the necessary
credentials when invoking Google API classes.

[`authenticatedClient`]: {{site.pub-api}}/extension_google_sign_in_as_googleapis_auth/latest/extension_google_sign_in_as_googleapis_auth/GoogleApisGoogleSignInAuth/authenticatedClient.html
[`Client`]: {{site.pub-api}}/http/latest/http/Client-class.html
[extension_google_sign_in_as_googleapis_auth]: {{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth
[extension method]: {{site.dart-site}}/guides/language/extension-methods
[`onCurrentUserChanged`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignIn/onCurrentUserChanged.html

## 5. Create and use the desired API class

Use the API to create the desired API type and call methods.
For instance:

<?code-excerpt "lib/main.dart (playlist)"?>
```dart
var youTubeApi = YouTubeApi(httpClient);

var favorites = await youTubeApi.playlistItems.list(
  ['snippet'],
  playlistId: 'LL', // Liked List
);
```

## More information

You might want to check out the following:

* The [`extension_google_sign_in_as_googleapis_auth` example][auth-ex]
  is a working implementation of the concepts described on this page.

[auth-ex]: {{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth/example
