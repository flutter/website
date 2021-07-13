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
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _widgets(),
              ),
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
            for (final fav in _favoriteVideos!)
              ListTile(
                minVerticalPadding: 20,
                leading: Image.network(
                  fav.thumbnails!.default_!.url!,
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
              ),
        ],
      ];

  Future<void> _downloadLikedList() async {
    final httpClient = (await _googleSignIn.authenticatedClient())!;
    final youTubeApi = YouTubeApi(httpClient);
    final resource = youTubeApi.playlistItems;
    String? pageToken;
    _favoriteVideos = [];

    do {
      var favorites = await resource.list(
        ['snippet'],
        playlistId: 'LL', // Liked List
        pageToken: pageToken,
      );
      setState(() {
        _favoriteVideos!.addAll(favorites.items!
            .map((e) => e.snippet!)
            .where(
                (e) => e.thumbnails != null && e.thumbnails!.default_ != null)
            .toList());
      });
      pageToken = favorites.nextPageToken;
      // Sleep 250ms between page requests
      await Future.delayed(const Duration(milliseconds: 250), () => null);
    } while (pageToken != null);
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
