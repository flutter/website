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
[Calendar]: https://developers.google.com/workspace/calendar/api/guides/overview
[fb-auth]: {{site.firebase}}/docs/auth/flutter/start
[Gmail]: https://developers.google.com/workspace/gmail/api/guides
[Google APIs package]: {{site.pub-pkg}}/googleapis
[service accounts]: https://cloud.google.com/iam/docs/service-account-overview
[YouTube]: https://developers.google.com/youtube/v3

## Overview

To use Google APIs, follow these steps:

1. Pick the desired API
1. Enable the API
1. Authenticate and determine the current user
1. Obtain an authenticated HTTP client
1. Create and use the desired API class

## 1. Pick the desired API

From your Flutter project directory, add `googleapis`
and the packages for sign-in and authorization.

```console
$ flutter pub add googleapis googleapis_auth
$ flutter pub add google_sign_in extension_google_sign_in_as_googleapis_auth
```

The [Google APIs package][] lists the available APIs and their import paths.
Each library provides a client class, such as [`YouTubeApi`][],
that exposes the API's resources and authorization scopes.
To read the signed-in user's YouTube data, request [`youtubeReadonlyScope`][].

<?code-excerpt "lib/main.dart (youtube-import)"?>
```dart
// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';
```

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
// Provides the `GoogleSignIn` class.
import 'package:google_sign_in/google_sign_in.dart';
```

Store the [`GoogleSignIn`][] initialization future so the app initializes
the plugin only once.
Use a `FutureBuilder` to show progress while the plugin initializes
and display an error if initialization fails.
Show the sign-in controls when initialization succeeds.

<?code-excerpt "lib/main.dart (init)"?>
```dart
class _LikedVideosPage extends StatelessWidget {
  const _LikedVideosPage();

  static final Future<void> _initialization = GoogleSignIn.instance
      .initialize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Center(
        child: FutureBuilder<void>(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.error case final error?) {
              return Text(
                error is UnimplementedError
                    ? 'Google Sign-In is unavailable on this platform.'
                    : 'Check your Google Sign-In configuration.\n$error',
              );
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }
            return const _LikedVideosWidget();
          },
        ),
      ),
    );
  }
}
```

Subscribe to `authenticationEvents` before calling
`attemptLightweightAuthentication()` so your app receives a sign-in event
if the plugin restores a previous session.
Import `dart:async` for `StreamSubscription` and `unawaited`.
Cancel the subscription when the widget is disposed.

<?code-excerpt "lib/main.dart (post-init)" plaster="none"?>
```dart
final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
late final StreamSubscription<GoogleSignInAuthenticationEvent> _subscription;

@override
void initState() {
  super.initState();
  _subscription = _googleSignIn.authenticationEvents.listen(
    _onAuthenticationEvent,
    onError: (Object error) => _snackbarError(error.toString()),
  );
  unawaited(_restoreSignIn());
}

Future<void> _restoreSignIn() async {
  try {
    await _googleSignIn.attemptLightweightAuthentication();
  } on Exception catch (error) {
    _snackbarError(error.toString());
  }
}

@override
void dispose() {
  unawaited(_subscription.cancel());
  super.dispose();
}
```

On sign-in, check whether the account already has access to YouTube.
On sign-out or an account change, clear the previous account's videos.

<?code-excerpt "lib/main.dart (auth-event)"?>
```dart
void _onAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
  final user = switch (event) {
    GoogleSignInAuthenticationEventSignIn() => event.user,
    GoogleSignInAuthenticationEventSignOut() => null,
  };
  setState(() {
    _currentUser = user;
    _favoriteVideos = null;
    _loadingVideos = false;
  });
  if (user != null) {
    unawaited(_loadLikedVideos(user));
  }
}
```

For interactive sign-in, call `authenticate()` from a button press
on platforms where `supportsAuthenticate()` returns true.
For web apps, run `flutter pub add google_sign_in_web` and
[render the sign-in button provided by Google][web-sign-in].
Both flows report the signed-in account through `authenticationEvents`.

[web-sign-in]: {{site.pub-pkg}}/google_sign_in_web#authentication
[gsi-pkg]: {{site.pub-pkg}}/google_sign_in
[`GoogleSignIn`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignIn-class.html

## 4. Obtain an authenticated HTTP client

Signing in identifies the account.
To read its liked videos, request the YouTube read-only scope.

<?code-excerpt "lib/main.dart (youtube-scopes)"?>
```dart
const List<String> _youtubeScopes = [YouTubeApi.youtubeReadonlyScope];
```

When a user signs in, call [`authorizationForScopes`][] to check for
an existing grant without opening a consent prompt.
If it returns `null`, let the user choose when to grant access.

<?code-excerpt "lib/main.dart (request-access)"?>
```dart
ElevatedButton(
  onPressed: () => _loadLikedVideos(currentUser, requestAccess: true),
  child: const Text('Load liked videos'),
),
```

Only the button handler sets `requestAccess` to `true`.
It calls [`authorizeScopes`][] as part of that user interaction.
If the user declines, keep the button available so they can try again.

<?code-excerpt "lib/main.dart (scope-authorize)"?>
```dart
final authorizationClient = user.authorizationClient;
final authorization = requestAccess
    ? await authorizationClient.authorizeScopes(_youtubeScopes)
    : await authorizationClient.authorizationForScopes(_youtubeScopes);
if (!mounted || !identical(user, _currentUser)) return;
if (authorization != null) {
  videos = await _downloadLikedList(authorizationClient, authorization);
}
```

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
final authenticatedClient = authorization.authClient(
  scopes: _youtubeScopes,
);
```

[`authorizationForScopes`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignInAuthorizationClient/authorizationForScopes.html
[`authorizeScopes`]: {{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignInAuthorizationClient/authorizeScopes.html
[`authClient`]: {{site.pub-api}}/extension_google_sign_in_as_googleapis_auth/latest/extension_google_sign_in_as_googleapis_auth/GoogleApisGoogleSignInAuth/authClient.html
[`package:extension_google_sign_in_as_googleapis_auth`]: {{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth

## 5. Create and use the desired API class

Pass the authenticated client to `YouTubeApi` and request the
signed-in user's liked videos.
If YouTube rejects the access token, clear it from the sign-in cache
so the next button press can request a fresh token.
To handle an authentication challenge from the HTTP client,
import and check for `AccessDeniedException` from
`package:googleapis_auth/googleapis_auth.dart`.
Close the client when the request finishes, even if it fails.

<?code-excerpt "lib/main.dart (playlist)"?>
```dart
try {
  final youTubeApi = YouTubeApi(authenticatedClient);
  final favorites = await youTubeApi.playlistItems.list(
    ['snippet'],
    playlistId: 'LL', // Liked List
  );
  return [
    for (final item in favorites.items ?? <PlaylistItem>[]) ?item.snippet,
  ];
} on Exception catch (error) {
  if (error is AccessDeniedException ||
      (error is DetailedApiRequestError && error.status == 401)) {
    await authorizationClient.clearAuthorizationToken(
      accessToken: authorization.accessToken,
    );
  }
  rethrow;
} finally {
  authenticatedClient.close();
}
```

## More information

* [Complete YouTube sign-in and liked videos example][youtube-example]
* [Google People API example using the same sign-in flow][auth-ex]

[youtube-example]: {{site.repo.this}}/tree/main/examples/googleapis
[auth-ex]: {{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth/example
