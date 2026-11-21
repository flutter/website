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
import 'gdp_signin_elements.dart';
import 'icon.dart';

/// A sign-up component that uses Google Sign-In to create or update the
/// user's Google Developer profile, enrolling them in the Flutter Developer
/// Community (with badge), adding Flutter and Dart as interests, and opting
/// them in to event and Flutter update emails.
@client
class NewsletterSignup extends StatefulComponent {
  /// Creates a GDP-backed newsletter sign-up component.
  const NewsletterSignup({super.key});

  @override
  State<NewsletterSignup> createState() => _NewsletterSignupState();
}

enum _SignupStatus { idle, working, success, error }

/// The `localStorage` key that records a successful GDP sign-up in this
/// browser.
const String _signupStorageKey = 'flutter-gdp-signup';

/// The class added to the root `<html>` element when this browser has a
/// recorded GDP sign-up.
const String _signedUpClass = 'gdp-signed-up';

/// A small inline script to run before the sign-up section is painted.
///
/// If this browser has a recorded sign-up, it adds a class to the root
/// element so the section shows its success state from the first paint,
/// without briefly showing the sign-in button.
const String newsletterSignupStateScript =
    "try{if(localStorage.getItem('$_signupStorageKey'))"
    "document.documentElement.classList.add('$_signedUpClass')}catch(e){}";

/// Whether a profile was newly created by the recorded sign-up,
/// or `null` if this browser hasn't signed up.
///
/// Shared by every [NewsletterSignup] on the page, and initialized from
/// `localStorage` so the state persists across visits.
bool? _sharedSignupResult = _readStoredSignup();

/// Notifies every [NewsletterSignup] on the page when [_sharedSignupResult]
/// changes.
final StreamController<bool?> _signupChanges =
    StreamController<bool?>.broadcast();

/// Records a successful sign-up in this browser and shows the success state.
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

/// Forgets the recorded sign-up so the sign-in button is shown again.
void _clearSignup() {
  _sharedSignupResult = null;
  web.document.documentElement?.classList.remove(_signedUpClass);
  _writeStorage(null);
  _signupChanges.add(null);
}

/// Reads the sign-up recorded in `localStorage`, if any.
///
/// Returns `null`, and removes the record, if it is invalid.
bool? _readStoredSignup() {
  if (!kIsWeb) return null;
  try {
    final stored = web.window.localStorage.getItem(_signupStorageKey);
    if (stored == null) return null;
    final parsed = switch (jsonDecode(stored)) {
      {'created': final bool created} => created,
      _ => null,
    };
    if (parsed == null) {
      _writeStorage(null);
      web.document.documentElement?.classList.remove(_signedUpClass);
    }
    return parsed;
  } on Object {
    // Storage might be unavailable, such as in some private browsing modes,
    // or contain an unexpected value.
    web.document.documentElement?.classList.remove(_signedUpClass);
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

class _NewsletterSignupState extends State<NewsletterSignup> {
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

      // Persist the sign-up and notify every sign-up component on the page.
      _recordSignup(created: profile.created);
    } on Object catch (e) {
      web.console.error('Flutter GDP sign-in failed: $e'.toJS);
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
    // the same grid cell, so the section keeps a stable height when switching.
    // Which one is visible is controlled by CSS through the `gdp-signed-up`
    // class on the root element. That class is set before the first paint
    // by an inline script, so returning visitors never see the sign-in UI.
    return div(classes: 'newsletter-signup newsletter-swap', [
      div(classes: 'newsletter-swap-signin', [
        const h3([
          .text(
            'Keep up with the latest Flutter news, releases, and events.',
          ),
        ]),
        button(
          classes: 'gdp-google-btn',
          type: ButtonType.button,
          disabled: _status == .working || gdpOauthClientId.isEmpty,
          onClick: () => unawaited(_onSignIn()),
          [
            const GoogleLogo(classes: 'gdp-google-logo'),
            span([
              .text(
                _status == .working ? 'Signing you in…' : 'Sign in with Google',
              ),
            ]),
          ],
        ),
        if (gdpOauthClientId.isEmpty)
          const p(classes: 'newsletter-signup-error', [
            .text('Sign-in is not configured for this build.'),
          ]),
        if (_errorMessage case final message?)
          p(classes: 'newsletter-signup-error', [.text(message)]),
        const GdpSignInDisclosure(classes: 'newsletter-fine-print'),
      ]),
      div(classes: 'newsletter-swap-done newsletter-signup-success', [
        const div(classes: 'newsletter-success-header', [
          span(classes: 'newsletter-success-icon', [
            Icon(symbol: 'celebration'),
          ]),
          h3([.text("You're in!")]),
        ]),
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
        const div(classes: 'newsletter-signup-actions', [
          a(
            classes: 'btn',
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
}

/// A link-style button that forgets the recorded sign-up,
/// so a different Google account can sign up.
class _SwitchAccountButton extends StatelessComponent {
  const _SwitchAccountButton();

  @override
  Component build(BuildContext context) {
    return const button(
      classes: 'newsletter-switch-account',
      type: ButtonType.button,
      onClick: _clearSignup,
      [.text('Use a different account')],
    );
  }
}
