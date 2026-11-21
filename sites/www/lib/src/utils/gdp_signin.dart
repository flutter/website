// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:site_shared/developer_profiles.dart';
import 'package:site_shared/util.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// The OAuth 2.0 client ID used to request
/// Google Developer Profiles API access tokens.
///
/// Provide or override it at build time with
/// `--dart-define=GDP_OAUTH_CLIENT_ID=<client-id>`.
///
/// Production builds default to [_prodOauthClientId]. Non-production builds,
/// including local development and PR previews, have no default, so they must
/// provide a client ID explicitly.
const String gdpOauthClientId = String.fromEnvironment(
  'GDP_OAUTH_CLIENT_ID',
  defaultValue: productionBuild ? _prodOauthClientId : '',
);

/// The OAuth 2.0 client for `flutter.dev` in production.
///
/// OAuth client IDs for browser apps are public by design. Which sites can use
/// this one is restricted by the authorized JavaScript origins configured on
/// the client (`https://flutter.dev`).
const String _prodOauthClientId =
    '689428580108-90tt42dajs2fkt6rgjp69bq8itila8st.apps.googleusercontent.com';

const String _gisScriptUrl = 'https://accounts.google.com/gsi/client';

/// Thrown when Google Sign-In doesn't return an access token.
final class GdpSignInException implements Exception {
  /// Creates an exception with a user-facing [message] and optional GIS [code].
  const GdpSignInException(this.message, {this.code});

  /// Creates an error for the specified Google Identity Services error [code].
  factory GdpSignInException.fromCode(String code, {String? description}) {
    final message = switch (code) {
      'popup_closed' ||
      'access_denied' => 'Sign-in was cancelled. Please try again.',
      'popup_failed_to_open' =>
        'Your browser blocked the sign-in popup. '
            'Allow popups for this site and try again.',
      _ when productionBuild =>
        "Google couldn't sign you in. Please try again later.",
      _ =>
        "Google couldn't sign you in ($code)"
            '${description != null ? ': $description' : ''}.',
    };
    return GdpSignInException(message, code: code);
  }

  /// A user-facing description of the error.
  final String message;

  /// The Google Identity Services error code, if any.
  final String? code;

  @override
  String toString() => 'GdpSignInException(${code ?? 'unknown'}): $message';
}

/// Formats an error thrown during GDP sign-in into a user-facing message.
String formatGdpSignInError(Object error) {
  return switch (error) {
    GdpSignInException(:final message) => message,
    DeveloperProfilesException(:final statusCode, :final message)
        when !productionBuild =>
      'Developer Profiles API error ($statusCode): $message',
    _ => 'Something went wrong. Please try again later.',
  };
}

/// Preloads the Google Identity Services client library on the web so that
/// clicking a sign-in button can open the popup synchronously within the user
/// gesture.
void preloadGoogleIdentityServices() {
  if (kIsWeb && gdpOauthClientId.isNotEmpty) {
    unawaited(_loadGoogleIdentityServices().catchError((Object _) {}));
  }
}

/// Creates or updates the signed-in user's Google Developer profile using
/// [client], enrolling them in the Flutter Developer Community program (which
/// awards the community badge), adding Flutter and Dart as interests, and
/// opting them in to event and Flutter update emails.
Future<({String name, bool created})> enrollFlutterDeveloperProfile(
  DeveloperProfilesClient client, {
  required String originUri,
}) async {
  final profile = await client.ensureProfile(
    eventEmail: .enabled,
    originUri: originUri,
  );
  await client.addInterests(profile.name, const [
    flutterInterestNodeId,
    dartInterestNodeId,
  ]);
  await client.joinProgramGroup(
    profile.name,
    flutterProgramGroupId,
    emailPreferences: const {
      flutterDevUpdatesEmailPreferenceId: .enabled,
    },
    originUri: originUri,
  );
  return profile;
}

/// Prompts the user to sign in with Google and enrolls their Google Developer
/// profile in the Flutter Developer Community with Flutter and Dart interests
/// and email preferences enabled.
Future<({String name, bool created})> signInAndEnrollFlutterGdp() async {
  final accessToken = await _requestAccessToken();
  final client = DeveloperProfilesClient(
    accessToken: accessToken,
    environment: productionBuild ? .production : .staging,
  );

  try {
    return await enrollFlutterDeveloperProfile(
      client,
      originUri: web.window.location.href,
    );
  } finally {
    client.close();
  }
}

/// Prompts the user to sign in with Google and
/// returns an access token for the Developer Profiles API.
Future<String> _requestAccessToken() async {
  // Only wait if the library isn't loaded yet, since awaiting can cause
  // the browser to treat the popup as not initiated by the user.
  if (!_gisLoaded) await _loadGoogleIdentityServices();

  final completer = Completer<String>();
  final tokenClient = _initTokenClient(
    _TokenClientConfig(
      client_id: gdpOauthClientId,
      scope: developerProfilesScope,
      callback: (_TokenResponse response) {
        if (completer.isCompleted) return;
        if (response.access_token case final token? when token.isNotEmpty) {
          completer.complete(token);
        } else {
          completer.completeError(
            GdpSignInException.fromCode(
              response.error ?? 'unknown',
              description: response.error_description,
            ),
          );
        }
      }.toJS,
      error_callback: (_TokenClientError error) {
        if (completer.isCompleted) return;
        completer.completeError(
          GdpSignInException.fromCode(
            error.type ?? 'unknown',
            description: error.message,
          ),
        );
      }.toJS,
    ),
  );
  tokenClient.requestAccessToken();

  return await completer.future;
}

/// Whether the Google Identity Services library has finished loading.
bool _gisLoaded = false;

Future<void>? _gisLoading;

/// Loads the Google Identity Services client library, at most once.
Future<void> _loadGoogleIdentityServices() {
  return _gisLoading ??= () {
    final completer = Completer<void>();
    final script = web.HTMLScriptElement()
      ..src = _gisScriptUrl
      ..async = true
      ..defer = true;
    script
      ..addEventListener(
        'load',
        (web.Event _) {
          _gisLoaded = true;
          completer.complete();
        }.toJS,
      )
      ..addEventListener(
        'error',
        (web.Event _) {
          _gisLoading = null;
          completer.completeError(
            StateError('Failed to load Google Identity Services.'),
          );
        }.toJS,
      );
    web.document.head!.append(script);
    return completer.future;
  }();
}

@JS('google.accounts.oauth2.initTokenClient')
external _TokenClient _initTokenClient(_TokenClientConfig config);

extension type _TokenClient(JSObject _) implements JSObject {
  external void requestAccessToken();
}

// The property names must match the snake_case names
// expected by Google Identity Services.
// ignore_for_file: non_constant_identifier_names

@anonymous
extension type _TokenClientConfig._(JSObject _) implements JSObject {
  external factory _TokenClientConfig({
    required String client_id,
    required String scope,
    required JSFunction callback,
    JSFunction? error_callback,
  });
}

extension type _TokenResponse(JSObject _) implements JSObject {
  external String? get access_token;
  external String? get error;
  external String? get error_description;
}

extension type _TokenClientError(JSObject _) implements JSObject {
  external String? get type;
  external String? get message;
}
