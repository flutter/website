// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

// #docregion auth-import
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
// #enddocregion auth-import

// #docregion google-import
// Provides the `GoogleSignIn` class.
import 'package:google_sign_in/google_sign_in.dart';
// #enddocregion google-import

// #docregion youtube-import
// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';
// #enddocregion youtube-import

import 'package:googleapis_auth/googleapis_auth.dart'
    show AccessDeniedException;
import 'package:material_ui/material_ui.dart';

import 'sign_in_button_stub.dart'
    if (dart.library.js_interop) 'package:google_sign_in_web/web_only.dart'
    as web;

const _title = 'My YouTube Favorites';

// #docregion youtube-scopes
const List<String> _youtubeScopes = [YouTubeApi.youtubeReadonlyScope];
// #enddocregion youtube-scopes

void main() {
  runApp(const MaterialApp(title: _title, home: _LikedVideosPage()));
}

// #docregion init
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
// #enddocregion init

class _LikedVideosWidget extends StatefulWidget {
  const _LikedVideosWidget();

  @override
  State<_LikedVideosWidget> createState() => _LikedVideosWidgetState();
}

class _LikedVideosWidgetState extends State<_LikedVideosWidget> {
  // #docregion post-init
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  late final StreamSubscription<GoogleSignInAuthenticationEvent> _subscription;

  // #enddocregion post-init
  GoogleSignInAccount? _currentUser;
  List<PlaylistItemSnippet>? _favoriteVideos;
  bool _loadingVideos = false;

  // #docregion post-init
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

  // #enddocregion post-init

  // #docregion auth-event
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

  // #enddocregion auth-event

  // #docregion post-init
  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
  // #enddocregion post-init

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(children: _widgets()),
    );
  }

  List<Widget> _widgets() {
    if (_currentUser case final currentUser?) {
      return [
        ListTile(
          leading: GoogleUserCircleAvatar(identity: currentUser),
          title: Text(currentUser.displayName ?? ''),
          subtitle: Text(currentUser.email),
        ),
        ElevatedButton(onPressed: _onSignOut, child: const Text('Sign out')),
        if (_loadingVideos)
          const CircularProgressIndicator()
        else if (_favoriteVideos case [])
          const Text('No liked videos.')
        else if (_favoriteVideos case final videos?)
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                final thumbnailUrl = video.thumbnails?.default_?.url;
                return ListTile(
                  minVerticalPadding: 20,
                  leading: thumbnailUrl == null
                      ? null
                      : Image.network(
                          thumbnailUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                  title: Text(video.title ?? '<unknown>'),
                );
              },
            ),
          )
        else
          // #docregion request-access
          ElevatedButton(
            onPressed: () => _loadLikedVideos(currentUser, requestAccess: true),
            child: const Text('Load liked videos'),
          ),
        // #enddocregion request-access
      ];
    }

    return [
      const Padding(
        padding: EdgeInsets.all(8),
        child: Text('You are not currently signed in.'),
      ),
      if (_googleSignIn.supportsAuthenticate())
        ElevatedButton(onPressed: _onSignIn, child: const Text('Sign in'))
      else
        web.renderButton(),
    ];
  }

  Future<void> _loadLikedVideos(
    GoogleSignInAccount user, {
    bool requestAccess = false,
  }) async {
    if (_loadingVideos || !identical(user, _currentUser)) return;
    if (requestAccess) _lastMessage = null;
    setState(() => _loadingVideos = true);
    List<PlaylistItemSnippet>? videos;
    try {
      // #docregion scope-authorize
      final authorizationClient = user.authorizationClient;
      final authorization = requestAccess
          ? await authorizationClient.authorizeScopes(_youtubeScopes)
          : await authorizationClient.authorizationForScopes(_youtubeScopes);
      if (!mounted || !identical(user, _currentUser)) return;
      if (authorization != null) {
        videos = await _downloadLikedList(authorizationClient, authorization);
      }
      // #enddocregion scope-authorize
    } on Exception catch (error) {
      if (mounted && identical(user, _currentUser)) {
        _snackbarError(error.toString());
      }
    } finally {
      // Reset the loading state even if an unexpected error is thrown.
      if (mounted && identical(user, _currentUser)) {
        setState(() {
          _favoriteVideos = videos;
          _loadingVideos = false;
        });
      }
    }
  }

  Future<List<PlaylistItemSnippet>> _downloadLikedList(
    GoogleSignInAuthorizationClient authorizationClient,
    GoogleSignInClientAuthorization authorization,
  ) async {
    // #docregion auth-client
    final authenticatedClient = authorization.authClient(
      scopes: _youtubeScopes,
    );
    // #enddocregion auth-client
    // #docregion playlist
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
    // #enddocregion playlist
  }

  Future<void> _onSignIn() async {
    _lastMessage = null;
    try {
      await _googleSignIn.authenticate();
    } on GoogleSignInException catch (error) {
      _snackbarError(error.toString());
    }
  }

  Future<void> _onSignOut() async {
    try {
      await _googleSignIn.signOut();
    } on GoogleSignInException catch (error) {
      _snackbarError(error.toString());
    }
  }

  String? _lastMessage;

  void _snackbarError(String message) {
    if (!mounted || message == _lastMessage) return;
    _lastMessage = message;

    for (final entry in _errorMessageMap.entries) {
      if (message.contains(entry.key)) {
        message = 'NOTE: ${entry.value}';
        break;
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static const _errorMessageMap = {
    'Not a valid origin for the client':
        'You must run your web app on a registered port. '
        'Try setting an explicit port with '
        '`flutter run --web-port [PORT]`.',
  };
}
