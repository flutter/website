// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/developer_profiles.dart';
import 'package:site_shared/util.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../common/icon.dart';

/// The OAuth 2.0 client ID used to request
/// Google Developer Profiles API access tokens.
///
/// Provide it at build time with
/// `--dart-define=GDP_OAUTH_CLIENT_ID=<client-id>`.
const String _oauthClientId = String.fromEnvironment('GDP_OAUTH_CLIENT_ID');

/// An optional API key sent along with Developer Profiles API requests.
///
/// Provide it at build time with `--dart-define=GDP_API_KEY=<api-key>`.
const String _apiKey = String.fromEnvironment('GDP_API_KEY');

const String _gisScriptUrl = 'https://accounts.google.com/gsi/client';

/// A sign-up form that uses Google Sign-In to
/// create or update the user's Google Developer profile,
/// opting them in to event emails and adding Flutter as an interest.
@client
class FlutterCreateSignup extends StatefulComponent {
  /// Creates a sign-up form.
  ///
  /// If [compact] is `true`, renders only a sign-in button and a short
  /// caption, suitable for placing on the dark hero background.
  const FlutterCreateSignup({this.compact = false, super.key});

  /// Whether to render the compact hero variant of the form.
  final bool compact;

  @override
  State<FlutterCreateSignup> createState() => _FlutterCreateSignupState();
}

enum _SignupStatus { idle, working, success, error }

/// The `localStorage` key that records a successful sign-up in this browser.
const String _signupStorageKey = 'flutter-create-2026-signup';

/// The moment after which a recorded sign-up is no longer relevant,
/// the day after the livestream.
final DateTime _signupExpiry = DateTime(2026, 11, 12);

/// The class added to the root `<html>` element when
/// this browser has a recorded sign-up.
const String _signedUpClass = 'fc-signed-up';

/// A small inline script to run before the sign-up forms are painted.
///
/// If this browser has a recorded, unexpired sign-up, it adds a class to the
/// root element so the forms show their success state from the first paint,
/// without briefly showing the sign-in button.
const String flutterCreateSignupStateScript =
    "try{if(localStorage.getItem('$_signupStorageKey')&&"
    'Date.now()<new Date(2026,10,12).getTime())'
    "document.documentElement.classList.add('$_signedUpClass')}catch(e){}";

/// Whether a profile was newly created by the recorded sign-up,
/// or `null` if this browser hasn't signed up.
///
/// Shared by every [FlutterCreateSignup] on the page, so that signing in
/// from one form also shows the success state in the others.
/// Initialized from `localStorage` so the state persists across visits.
bool? _sharedSignupResult = _readStoredSignup();

/// Notifies every form on the page when [_sharedSignupResult] changes.
final StreamController<bool?> _signupChanges =
    StreamController<bool?>.broadcast();

/// Records a successful sign-up in this browser and
/// shows the success state in every form on the page.
void _recordSignup({required bool created}) {
  _sharedSignupResult = created;
  web.document.documentElement?.classList.add(_signedUpClass);
  _writeStorage(
    jsonEncode({
      'created': created,
      'at': DateTime.now().toUtc().toIso8601String(),
    }),
  );
  _signupChanges.add(created);
}

/// Forgets the recorded sign-up, so every form on the page
/// shows its sign-in button again.
void _clearSignup() {
  _sharedSignupResult = null;
  web.document.documentElement?.classList.remove(_signedUpClass);
  _writeStorage(null);
  _signupChanges.add(null);
}

/// Reads the sign-up recorded in `localStorage`, if any.
///
/// Returns `null`, and removes the record, if it has expired or is invalid.
bool? _readStoredSignup() {
  if (!kIsWeb) return null;
  try {
    final stored = web.window.localStorage.getItem(_signupStorageKey);
    if (stored == null) return null;
    if (DateTime.now().isAfter(_signupExpiry)) {
      _writeStorage(null);
      web.document.documentElement?.classList.remove(_signedUpClass);
      return null;
    }
    return switch (jsonDecode(stored)) {
      {'created': final bool created} => created,
      _ => null,
    };
  } on Object {
    // Storage might be unavailable, such as in some private browsing modes,
    // or contain an unexpected value.
    return null;
  }
}

/// Writes [value] to `localStorage`, or removes the entry if it's `null`.
void _writeStorage(String? value) {
  try {
    if (value == null) {
      web.window.localStorage.removeItem(_signupStorageKey);
    } else {
      web.window.localStorage.setItem(_signupStorageKey, value);
    }
  } on Object {
    // Ignore unavailable storage; the state then only lasts for this visit.
  }
}

class _FlutterCreateSignupState extends State<FlutterCreateSignup> {
  _SignupStatus _status = .idle;
  bool _createdProfile = false;
  String? _errorMessage;

  StreamSubscription<bool?>? _signupSubscription;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      if (_sharedSignupResult != null) {
        // Only describe a newly created profile right after signing up,
        // so the message doesn't change between visits.
        _status = .success;
      }
      _signupSubscription = _signupChanges.stream.listen((created) {
        if (!mounted) return;
        setState(() {
          _errorMessage = null;
          if (created == null) {
            _status = .idle;
          } else {
            _status = .success;
            _createdProfile = created;
          }
        });
      });
    }
    // Load Google Identity Services up front, so that clicking the button
    // can open the sign-in popup synchronously, within the user gesture.
    // Otherwise, browsers might block the popup.
    if (kIsWeb && _oauthClientId.isNotEmpty) {
      unawaited(_loadGoogleIdentityServices().catchError((Object _) {}));
    }
  }

  @override
  void dispose() {
    unawaited(_signupSubscription?.cancel());
    super.dispose();
  }

  Future<void> _onSignIn() async {
    setState(() {
      _status = .working;
      _errorMessage = null;
    });

    try {
      final accessToken = await _requestAccessToken();
      final client = DeveloperProfilesClient(
        accessToken: accessToken,
        environment: .staging,
        apiKey: _apiKey.isEmpty ? null : _apiKey,
      );

      try {
        final profile = await client.ensureProfile(
          eventEmail: .enabled,
          originUri: web.window.location.href,
        );
        await client.addInterests(profile.name, const [flutterInterestNodeId]);

        // Persist the sign-up and notify every form on the page,
        // including this one.
        _recordSignup(created: profile.created);
      } finally {
        client.close();
      }
    } on Object catch (e) {
      web.console.error('Flutter Create sign-in failed: $e'.toJS);
      if (!mounted) return;
      setState(() {
        _status = .error;
        _errorMessage = switch (e) {
          _SignInError(:final message) => message,
          DeveloperProfilesException(:final statusCode, :final message)
              when !productionBuild =>
            'Developer Profiles API error ($statusCode): $message',
          _ => 'Something went wrong. Please try again later.',
        };
      });
    }
  }

  @override
  Component build(BuildContext context) {
    // Both the sign-in and success states are always rendered, stacked in
    // the same grid cell, so the form keeps a stable size when switching.
    // Which one is visible is controlled by CSS through the `fc-signed-up`
    // class on the root element. That class is set before the first paint
    // by an inline script, so returning visitors never see the sign-in UI.
    if (component.compact) {
      return div(classes: 'fc-hero-signup fc-swap', [
        div(classes: 'fc-swap-signin', [
          _buildSignInButton(hero: true),
          const p(classes: 'fc-hero-signup-caption', [
            .text(
              "Sign in and we'll email you with updates to the livestream.",
            ),
          ]),
          ..._buildErrors(),
          const _FinePrint(),
        ]),
        const div(classes: 'fc-swap-done', [
          div(classes: 'fc-hero-signup-done', [
            Icon(symbol: 'check_circle', filled: true),
            span([.text("We'll keep you informed about the stream.")]),
          ]),
          _SwitchAccountButton(),
        ]),
      ]);
    }

    return div(classes: 'flutter-create-signup fc-swap', [
      div(classes: 'fc-swap-signin', [
        const p(classes: 'fc-signup-lede', [
          .text(
            'Sign in with Google to stay informed about updates to the livestream.',
          ),
        ]),
        _buildSignInButton(hero: false),
        ..._buildErrors(),
        const _FinePrint(),
      ]),
      div(classes: 'fc-swap-done fc-signup-success', [
        const span(classes: 'fc-success-icon', [Icon(symbol: 'celebration')]),
        const h3([.text("You're on the list!")]),
        p([
          .text(
            _status == .success && _createdProfile
                ? 'We created your Google Developer Program profile and '
                      "added Flutter to your interests. We'll let you know "
                      'when the livestream is about to start.'
                : "We'll let you know when the livestream is about to start.",
          ),
        ]),
        const div(classes: 'fc-signup-success-actions', [
          a(
            classes: 'btn fc-btn-outline-dark',
            href: 'https://developers.google.com/profile/u/me',
            target: Target.blank,
            [.text('View your profile')],
          ),
          _SwitchAccountButton(),
        ]),
      ]),
    ]);
  }

  Component _buildSignInButton({required bool hero}) {
    return button(
      classes: hero ? 'fc-google-btn fc-google-btn-hero' : 'fc-google-btn',
      disabled: _status == .working || _oauthClientId.isEmpty,
      onClick: () => unawaited(_onSignIn()),
      [
        const _GoogleLogo(),
        span([
          .text(
            _status == .working ? 'Signing you in…' : 'Sign in with Google',
          ),
        ]),
      ],
    );
  }

  List<Component> _buildErrors() => [
    if (_oauthClientId.isEmpty)
      const p(classes: 'fc-signup-error', [
        .text('Sign-in is not configured for this build.'),
      ]),
    if (_errorMessage case final message?)
      p(classes: 'fc-signup-error', [.text(message)]),
  ];
}

/// A link-style button that forgets the recorded sign-up,
/// so a different Google account can sign up.
class _SwitchAccountButton extends StatelessComponent {
  const _SwitchAccountButton();

  @override
  Component build(BuildContext context) {
    return const button(
      classes: 'fc-switch-account',
      type: ButtonType.button,
      onClick: _clearSignup,
      [.text('Use a different account')],
    );
  }
}

/// The disclosure shown next to each sign-in button.
class _FinePrint extends StatelessComponent {
  const _FinePrint();

  @override
  Component build(BuildContext context) {
    return const p(classes: 'fc-fine-print', [
      .text(
        'Signing up creates or updates your Google Developer Program '
        'profile, adds Flutter to your interests, and opts you in to '
        'event emails. ',
      ),
      a(
        href: 'https://developers.google.com/profile/terms',
        target: Target.blank,
        [.text('Program terms')],
      ),
      .text(' · '),
      a(
        href: 'https://policies.google.com/privacy',
        target: Target.blank,
        [.text('Privacy policy')],
      ),
    ]);
  }
}

/// The multicolor Google "G" logo.
class _GoogleLogo extends StatelessComponent {
  const _GoogleLogo();

  @override
  Component build(BuildContext context) {
    return const RawText(
      '<svg class="fc-google-logo" viewBox="0 0 48 48" aria-hidden="true">'
      '<path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85'
      'C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19'
      'C12.43 13.72 17.74 9.5 24 9.5z"/>'
      '<path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02'
      'h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 '
      '7.09-17.65z"/>'
      '<path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59'
      's.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 '
      '2.56 10.78l7.97-6.19z"/>'
      '<path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6'
      'c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19'
      'C6.51 42.62 14.62 48 24 48z"/>'
      '</svg>',
    );
  }
}

/// Thrown when Google Sign-In doesn't return an access token.
final class _SignInError implements Exception {
  const _SignInError(this.message, {this.code});

  /// Creates an error for the specified Google Identity Services error [code].
  factory _SignInError.fromCode(String code, {String? description}) {
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
    return _SignInError(message, code: code);
  }

  /// A user-facing description of the error.
  final String message;

  /// The Google Identity Services error code, if any.
  final String? code;

  @override
  String toString() => '_SignInError(${code ?? 'unknown'}): $message';
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
      client_id: _oauthClientId,
      scope: developerProfilesScope,
      callback: (_TokenResponse response) {
        if (completer.isCompleted) return;
        if (response.access_token case final token? when token.isNotEmpty) {
          completer.complete(token);
        } else {
          completer.completeError(
            _SignInError.fromCode(
              response.error ?? 'unknown',
              description: response.error_description,
            ),
          );
        }
      }.toJS,
      error_callback: (_TokenClientError error) {
        if (completer.isCompleted) return;
        completer.completeError(
          _SignInError.fromCode(
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
