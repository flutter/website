// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../utils/gdp_signin.dart';
import '../common/gdp_signin_elements.dart';
import '../common/icon.dart';

/// A sign-up form that uses Google Sign-In to
/// create or update the user's Google Developer profile,
/// enrolling them in the Flutter Developer Community, adding Flutter and Dart
/// as interests, and opting them in to event and Flutter update emails.
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
    preloadGoogleIdentityServices();
  }

  @override
  void dispose() {
    // `dispose` is synchronous, so the broadcast subscription cancel future
    // cannot be awaited.
    unawaited(_signupSubscription?.cancel());
    super.dispose();
  }

  Future<void> _onSignIn() async {
    setState(() {
      _status = .working;
      _errorMessage = null;
    });

    try {
      final profile = await signInAndEnrollFlutterGdp();

      // Persist the sign-up and notify every form on the page,
      // including this one.
      _recordSignup(created: profile.created);
    } on Object catch (e) {
      web.console.error('Flutter Create sign-in failed: $e'.toJS);
      if (!mounted) return;
      setState(() {
        _status = .error;
        _errorMessage = formatGdpSignInError(e);
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
              "Sign in and we'll keep you updated with the latest from Flutter.",
            ),
          ]),
          ..._buildErrors(),
          const GdpSignInDisclosure(classes: 'fc-fine-print'),
        ]),
        const div(classes: 'fc-swap-done', [
          div(classes: 'fc-hero-signup-done', [
            Icon(symbol: 'check_circle', filled: true),
            span([
              .text("We'll keep you updated with the latest from Flutter."),
            ]),
          ]),
          _SwitchAccountButton(),
        ]),
      ]);
    }

    return div(classes: 'flutter-create-signup fc-swap', [
      div(classes: 'fc-swap-signin', [
        const p(classes: 'fc-signup-lede', [
          .text(
            'Sign in with Google to stay updated on Flutter news, events, '
            'and releases.',
          ),
        ]),
        _buildSignInButton(hero: false),
        ..._buildErrors(),
        const GdpSignInDisclosure(classes: 'fc-fine-print'),
      ]),
      div(classes: 'fc-swap-done fc-signup-success', [
        const span(classes: 'fc-success-icon', [Icon(symbol: 'celebration')]),
        const h3([.text("You're on the list!")]),
        p([
          .text(
            _status == .success && _createdProfile
                ? 'We created your Google Developer Program profile, '
                      'joined the Flutter Developer Community, and '
                      'added Flutter and Dart to your interests. '
                      "We'll keep you updated on Flutter news, events, and "
                      'releases.'
                : "We'll keep you updated on Flutter news, events, and "
                      'releases.',
          ),
        ]),
        const div(classes: 'fc-signup-success-actions', [
          a(
            classes: 'btn fc-btn-outline-dark',
            href: 'https://developers.google.com/profile/u/me',
            target: Target.blank,
            attributes: {'rel': 'noopener'},
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
      type: ButtonType.button,
      disabled: _status == .working || gdpOauthClientId.isEmpty,
      // Jaspr's `onClick` callback is synchronous; `_onSignIn` manages its own
      // loading and error state.
      onClick: () => unawaited(_onSignIn()),
      [
        const GoogleLogo(classes: 'fc-google-logo'),
        span([
          .text(
            _status == .working ? 'Signing you in…' : 'Sign in with Google',
          ),
        ]),
      ],
    );
  }

  List<Component> _buildErrors() => [
    if (gdpOauthClientId.isEmpty)
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
