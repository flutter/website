// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';

/// Provides the `GoogleSignIn` class
import 'package:google_sign_in/google_sign_in.dart';

/// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';

const _title = 'My YouTube Favorites';

void main() {
  runApp(
    const MaterialApp(
      title: _title,
      home: _LikedVideosWidget(),
    ),
  );
}

class _LikedVideosWidget extends StatefulWidget {
  const _LikedVideosWidget({Key? key}) : super(key: key);

  @override
  State createState() => _LikedVideosWidgetState();
}

class _LikedVideosWidgetState extends State<_LikedVideosWidget> {
  final _googleSignIn = GoogleSignIn(
    scopes: <String>[YouTubeApi.youtubeReadonlyScope],
  );

  GoogleSignInAccount? _currentUser;
  List<PlaylistItemSnippet>? _favoriteVideos;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _downloadLikedList();
      }
    });
    //_googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
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

  List<Widget> _widgets() => <Widget>[
        if (_currentUser == null) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('You are not currently signed in.'),
          ),
          ElevatedButton(
            onPressed: _onSignIn,
            child: const Text('Sign in'),
          ),
        ],
        if (_currentUser != null) ...[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser!,
            ),
            title: Text(_currentUser!.displayName ?? ''),
            subtitle: Text(_currentUser!.email),
          ),
          ElevatedButton(
            onPressed: _onSignOut,
            child: const Text('Sign out'),
          ),
          if (_favoriteVideos != null)
            ListView.builder(
              shrinkWrap: true,
              itemCount: _favoriteVideos!.length,
              itemBuilder: (ctx, index) {
                final fav = _favoriteVideos![index];
                final thumbnailUrl = fav.thumbnails!.default_!.url!;
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
                      return Icon(Icons.error, color: Colors.red);
                    },
                  ),
                  title: Text(fav.title ?? '<unknown>'),
                );
              },
            ),
        ],
      ];

  Future<void> _downloadLikedList() async {
    var httpClient = (await _googleSignIn.authenticatedClient())!;
    var youTubeApi = YouTubeApi(httpClient);

    var favorites = await youTubeApi.playlistItems.list(
      ['snippet'],
      playlistId: 'LL', // Liked List
    );

    setState(() {
      _favoriteVideos = favorites.items!.map((e) => e.snippet!).toList();
    });
  }

  Future<void> _onSignIn() async {
    _lastMessage = null;
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      _snackbarError(error.toString());
    }
  }

  Future<void> _onSignOut() => _googleSignIn.disconnect();

  String? _lastMessage;

  void _snackbarError(String message) {
    if (message == _lastMessage) return;
    _lastMessage = message;

    for (var entry in _errorMessageMap.entries) {
      if (message.contains(entry.key)) {
        message = 'NOTE: ${entry.value}';
        break;
      }
    }

    print(message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
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
