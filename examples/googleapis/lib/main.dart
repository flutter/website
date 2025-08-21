// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

// #docregion auth-import
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
// #enddocregion auth-import

import 'package:flutter/material.dart';

// #docregion google-import
/// Provides the `GoogleSignIn` class.
import 'package:google_sign_in/google_sign_in.dart';
// #enddocregion google-import

// #docregion youtube-import
/// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';
// #enddocregion youtube-import

const _title = 'My YouTube Favorites';

void main() {
  runApp(const MaterialApp(title: _title, home: _LikedVideosWidget()));
}

class _LikedVideosWidget extends StatefulWidget {
  const _LikedVideosWidget();

  @override
  State<_LikedVideosWidget> createState() => _LikedVideosWidgetState();
}

class _LikedVideosWidgetState extends State<_LikedVideosWidget> {
  // #docregion post-init
  GoogleSignInAccount? _currentUser;

  // #enddocregion post-init
  List<PlaylistItemSnippet>? _favoriteVideos;

  // #docregion init
  final _googleSignIn = GoogleSignIn.instance;

  // #docregion post-init
  @override
  void initState() {
    super.initState();
    // #enddocregion post-init
    _googleSignIn.initialize();
    // #enddocregion init

    // #docregion post-init
    _googleSignIn.initialize().then((_) {
      _googleSignIn.authenticationEvents.listen((event) {
        setState(() {
          _currentUser = switch (event) {
            GoogleSignInAuthenticationEventSignIn() => event.user,
            _ => null,
          };
        });
        // #enddocregion post-init
        if (_currentUser case final currentUser?) {
          _downloadLikedList(currentUser);
        }
        // #docregion post-init
      });
      // #enddocregion post-init

      // Attempt to authenticate a previously signed in user.
      _googleSignIn.attemptLightweightAuthentication();
      // #docregion post-init
    });
    // #docregion init
  }
  // #enddocregion init, post-init

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _widgets(),
          ),
        ),
      ),
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
        if (_favoriteVideos case final favoriteVideos?)
          ListView.builder(
            shrinkWrap: true,
            itemCount: favoriteVideos.length,
            itemBuilder: (ctx, index) {
              final favVideo = favoriteVideos[index];
              final thumbnailUrl = favVideo.thumbnails!.default_!.url!;
              return ListTile(
                minVerticalPadding: 20,
                leading: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    Timer.run(
                      () => _snackbarError(
                        LineSplitter.split(error.toString()).first,
                      ),
                    );
                    return const Icon(Icons.error, color: Colors.red);
                  },
                ),
                title: Text(favVideo.title ?? '<unknown>'),
              );
            },
          ),
      ];
    }

    return [
      const Padding(
        padding: EdgeInsets.all(8),
        child: Text('You are not currently signed in.'),
      ),
      ElevatedButton(onPressed: _onSignIn, child: const Text('Sign in')),
    ];
  }

  Future<void> _downloadLikedList(GoogleSignInAccount currentUser) async {
    // #docregion scope-authorize
    const relevantScopes = [YouTubeApi.youtubeReadonlyScope];
    final authorization = await currentUser.authorizationClient
        .authorizationForScopes(relevantScopes);
    // #enddocregion scope-authorize
    // #docregion auth-client
    final authenticatedClient = authorization!.authClient(
      scopes: relevantScopes,
    );
    // #enddocregion auth-client

    // #docregion playlist
    final youTubeApi = YouTubeApi(authenticatedClient);

    final favorites = await youTubeApi.playlistItems.list(
      ['snippet'],
      playlistId: 'LL', // Liked List
    );
    // #enddocregion playlist

    setState(() {
      _favoriteVideos = favorites.items!.map((e) => e.snippet!).toList();
    });
  }

  Future<void> _onSignIn() async {
    _lastMessage = null;
    try {
      await _googleSignIn.authenticate();
    } catch (error) {
      _snackbarError(error.toString());
    }
  }

  Future<void> _onSignOut() => _googleSignIn.disconnect();

  String? _lastMessage;

  void _snackbarError(String message) {
    if (message == _lastMessage) return;
    _lastMessage = message;

    for (final entry in _errorMessageMap.entries) {
      if (message.contains(entry.key)) {
        message = 'NOTE: ${entry.value}';
        break;
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static const _errorMessageMap = {
    'Not a valid origin for the client':
        'You must run your web app on a registered port. '
        'Trying setting an explicit port with '
        '`flutter run --web-port [PORT]`.',
    'Failed to load network image':
        'Cannot display cross-domain images with CanvasKit renderer. '
        'Try the Flutter Web HTML renderer.',
  };
}
