---
title: Google APIs
description: How to use Google APIs with Flutter.
---

<?code-excerpt path-base="../null_safety_examples/googleapis/"?>

The [Google APIs package]({{site.pub-pkg}}/googleapis) exposes dozens of Google
services that you can use from Dart projects.

This page describes how to use APIs that interact with end-user data by using
Google authentication.

Examples of user-data APIs include
[Calendar]({{site.pub-api}}/googleapis/latest/calendar.v3/calendar.v3-library.html),
[Gmail]({{site.pub-api}}/googleapis/latest/gmail.v1/gmail.v1-library.html), and
[YouTube]({{site.pub-api}}/googleapis/latest/youtube.v3/youtube.v3-library.html).

{{site.alert.info}} 
  Note: The only APIs you should use directly from your Flutter
  project are those that access user data via Google authentication.

  APIs that require
  [service accounts](https://cloud.google.com/iam/docs/service-accounts) **should
  not** be used directly from a Flutter application. Doing so requires shipping
  service credentials as part of your application, which is not secure. To use
  these APIs, we recommend creating an intermediate service.

<!-- TODO(kevmoo): Add link to public user guide when available. -->

{{site.alert.end}}

## Overview

To use Google APIs, follow these steps.

1. Pick the desired API
1. Enable the API
1. Authenticate user with the required scopes
1. Obtain an authenticated HTTP client
1. Create and use the desired API class

## 1. Pick the desired API

The documentation for [package:googleapis]({{site.pub-api}}/googleapis) lists
each API as a separate Dart library – in a `name.version` format. Let's look at
[`youtube.v3`]({{site.pub-api}}/googleapis/latest/youtube.v3/youtube.v3-library.html)
as an example.

Each library may provide many types, but there is one _root_ class that ends in
`Api`. For YouTube, it's
[`YouTubeApi`]({{site.pub-api}}/googleapis/latest/youtube.v3/YouTubeApi-class.html).

Not only is the `Api` class the one you need to instantiate – see step 3 – but
it also exposes the scopes that represent the permissions needed to use the API.
Look under the
[Constants section]({{site.pub-api}}/googleapis/latest/youtube.v3/YouTubeApi-class.html#constants)
of the `YouTubeApi` class and you'll see the available scopes. To request access
to simply read (but not write) an end-users YouTube data, use the
[`youtubeReadonlyScope`]({{site.pub-api}}/googleapis/latest/youtube.v3/YouTubeApi/youtubeReadonlyScope-constant.html)
when authenticating the user.

<?code-excerpt "lib/main.dart" skip="13" take="2"?>
```dart
/// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';
```

## 2. Enable the API

To use Google APIs you must have a Google account and a Google project. You also
need to enable your desired API.

In this example, you'd enable
[YouTube Data API v3](https://console.cloud.google.com/apis/api/youtube.googleapis.com).

For details, see the
[getting started instructions](https://cloud.google.com/apis/docs/getting-started).

## 3. Authenticate the user with the required scopes

Use the [google_sign_in]({{site.pub-pkg}}/google_sign_in) package to
authenticate users with their Google identity. You will have to configure signin
for each platform you want to support.

<?code-excerpt "lib/main.dart" skip="10" take="2"?>
```dart
/// Provides the `GoogleSignIn` class
import 'package:google_sign_in/google_sign_in.dart';
```

When you instantiate the
[`GoogleSignIn`]({{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignIn-class.html)
class, you provide the desired scopes as discussed in the previous section.

<?code-excerpt "lib/main.dart" skip="35" take="3"?>
```dart
final _googleSignIn = GoogleSignIn(
  scopes: <String>[YouTubeApi.youtubeReadonlyScope],
);
```

Follow the instructions provided by
[package:google_sign_in]({{site.pub-pkg}}/google_sign_in) to allow a user to
authenticate.

Once authenticated, you must obtain an authenticated HTTP client.

## 4. Obtain an authenticated HTTP client

The
[extension_google_sign_in_as_googleapis_auth]({{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth)
package provides an
[extension method]({{site.dart-site}}/guides/language/extension-methods) on
`GoogleSignIn`:
[`authenticatedClient`]({{site.pub-api}}/extension_google_sign_in_as_googleapis_auth/latest/extension_google_sign_in_as_googleapis_auth/GoogleApisGoogleSignInAuth/authenticatedClient.html).

<?code-excerpt "lib/main.dart" skip="7" take="1"?>
```dart
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
```

You can listen to
[`onCurrentUserChanged`]({{site.pub-api}}/google_sign_in/latest/google_sign_in/GoogleSignIn/onCurrentUserChanged.html).
When event value is not `null`, you can create an authenticated client.

<?code-excerpt "lib/main.dart" skip="124" take="1"?>
```dart
var httpClient = (await _googleSignIn.authenticatedClient())!;
```

This [`Client`]({{site.pub-api}}/http/latest/http/Client-class.html) instance
includes the nessesary credentials when invoking Google API classes.

## 5. Create and use the desired API class

Use the API to create the desired API type and call methods, for instance:

<?code-excerpt "lib/main.dart" skip="125" take="6"?>
```dart
var youTubeApi = YouTubeApi(httpClient);

var favorites = await youTubeApi.playlistItems.list(
  ['snippet'],
  playlistId: 'LL', // Liked List
);
```

## More information

- The
  [`extension_google_sign_in_as_googleapis_auth` example]({{site.pub-pkg}}/extension_google_sign_in_as_googleapis_auth/example)
  is a working implementation of the concepts described on this page.
