// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A lightweight client for the Google Developer Profiles API
/// (`developers.googleapis.com`), also known as the
/// Google Developer Program (GDP) API.
library;

import 'dart:convert';

import 'package:http/http.dart' as http;

/// The OAuth 2.0 scope required to read and write
/// the signed-in user's Google Developer profile.
const String developerProfilesScope =
    'https://www.googleapis.com/auth/devprofiles.full_control';

/// The Nomenclature node ID that represents the Flutter product.
///
/// Add it to a profile with [DeveloperProfilesClient.addInterests]
/// to mark the user as interested in Flutter.
const String flutterInterestNodeId = 'E-product-Flutter';

/// The Nomenclature node ID that represents the Dart programming language.
///
/// Add it to a profile with [DeveloperProfilesClient.addInterests]
/// to mark the user as interested in Dart.
const String dartInterestNodeId = 'E-language-DartLang';

/// The ID of the Flutter Developer Community program group
/// (`FLUTTER_DEV`, Gamma product ID `2484`).
///
/// Enroll a profile in this program with
/// [DeveloperProfilesClient.joinProgramGroup].
const String flutterProgramGroupId = 'flutter';

/// The email preference ID for Flutter updates on the
/// [flutterProgramGroupId] community program (`flutter_dev_updates`).
const String flutterDevUpdatesEmailPreferenceId =
    'flutter_dev_updates_email_preference';

/// A deployment of the Google Developer Profiles API.
enum DeveloperProfilesEnvironment {
  /// The staging deployment, used for development and testing.
  staging('https://staging-developers.sandbox.googleapis.com'),

  /// The production deployment.
  production('https://developers.googleapis.com');

  const DeveloperProfilesEnvironment(this.baseUrl);

  /// The base URL of the API in this environment.
  final String baseUrl;
}

/// A user's preference for receiving a category of email.
enum EmailPreference {
  /// The user opted out of this category of email.
  disabled('DISABLED', 'EMAIL_DISABLED'),

  /// The user opted in to this category of email.
  enabled('ENABLED', 'EMAIL_ENABLED');

  const EmailPreference(this.value, this.programValue);

  /// The value of this preference as expected on a profile resource.
  final String value;

  /// The value of this preference as expected on a program membership
  /// (`ProfileProgramData`) resource.
  final String programValue;
}

/// The save state of an interest on a profile.
enum InterestState {
  /// The user manually selected the interest.
  selected('STATE_SELECTED'),

  /// The interest was inferred from the user's previous behavior.
  inferred('STATE_INFERRED');

  const InterestState(this.value);

  /// The value of this state as expected by the API.
  final String value;
}

/// An error returned by the Google Developer Profiles API.
final class DeveloperProfilesException implements Exception {
  /// Creates an exception for a failed request
  /// with the specified HTTP [statusCode] and [message].
  const DeveloperProfilesException(this.statusCode, this.message);

  /// The HTTP status code of the failed response.
  final int statusCode;

  /// The error message returned by the API, if any.
  final String message;

  @override
  String toString() => 'DeveloperProfilesException($statusCode): $message';
}

/// A client for the Google Developer Profiles API that
/// acts on behalf of the user who granted its access token.
///
/// The access token must be granted the [developerProfilesScope].
/// When running in the browser, obtain it with
/// Google Identity Services' OAuth 2.0 token client.
final class DeveloperProfilesClient {
  /// Creates a client that authenticates requests with `accessToken`.
  ///
  /// Requests go to the [environment] deployment, which
  /// defaults to [DeveloperProfilesEnvironment.staging].
  DeveloperProfilesClient({
    required this._accessToken,
    this.environment = .staging,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client(),
       _shouldCloseClient = httpClient == null;

  /// The deployment of the API that requests are sent to.
  final DeveloperProfilesEnvironment environment;

  final String _accessToken;
  final http.Client _httpClient;
  final bool _shouldCloseClient;

  /// Returns the resource name (`profiles/{id}`) of
  /// the signed-in user's profile, or `null` if they don't have one.
  Future<String?> hasProfile() async {
    final response = await _send('GET', 'profile:has');
    return switch (response) {
      {'obfuscatedProfileId': final String id} when id.isNotEmpty =>
        'profiles/$id',
      _ => null,
    };
  }

  /// Returns the signed-in user's profile as decoded JSON.
  Future<Map<String, Object?>> getProfile() => _send('GET', 'profile:get');

  /// Creates a profile for the signed-in user and
  /// returns its resource name (`profiles/{id}`).
  ///
  /// Use [eventEmail] and [newsletterEmail] to record the user's
  /// consent to event and newsletter emails, and [originUri] to
  /// attribute the profile creation to the page it happened on.
  Future<String> createProfile({
    EmailPreference? eventEmail,
    EmailPreference? newsletterEmail,
    String? originUri,
  }) async {
    final response = await _send(
      'POST',
      'profiles',
      body: {
        'eventEmail': ?eventEmail?.value,
        'newsletterEmail': ?newsletterEmail?.value,
        if (originUri != null) 'creationOrigin': {'originUri': originUri},
      },
    );
    return switch (response) {
      {'name': final String name} when name.isNotEmpty => name,
      _ => throw const DeveloperProfilesException(
        200,
        'CreateProfile response did not include a profile name.',
      ),
    };
  }

  /// Returns the resource name of the signed-in user's profile,
  /// creating the profile with [createProfile] if it doesn't exist yet.
  Future<({String name, bool created})> ensureProfile({
    EmailPreference? eventEmail,
    EmailPreference? newsletterEmail,
    String? originUri,
  }) async {
    if (await hasProfile() case final existingName?) {
      return (name: existingName, created: false);
    }

    final name = await createProfile(
      eventEmail: eventEmail,
      newsletterEmail: newsletterEmail,
      originUri: originUri,
    );
    return (name: name, created: true);
  }

  /// Adds the Nomenclature [nodeIds] as interests of
  /// the profile with resource name [profileName].
  ///
  /// Interests that are already present on the profile are left as is.
  /// At most 100 interests can be added in a single call.
  Future<void> addInterests(
    String profileName,
    List<String> nodeIds, {
    InterestState state = .selected,
  }) async {
    await _send(
      'POST',
      '$profileName/interests:batchUpdate',
      body: {
        'requests': [
          for (final nodeId in nodeIds)
            {
              'interest': {
                'name': '$profileName/interests/$nodeId',
                'nodeId': nodeId,
                'interestState': state.value,
              },
            },
        ],
      },
    );
  }

  /// Enrolls the profile with resource name [profileName] in the
  /// community program [programGroupId], or updates its program settings
  /// if the user is already a member.
  ///
  /// Pass [emailPreferences] to set program-specific email preferences,
  /// keyed by preference ID such as [flutterDevUpdatesEmailPreferenceId],
  /// and [originUri] to record the page where the user joined.
  Future<Map<String, Object?>> joinProgramGroup(
    String profileName,
    String programGroupId, {
    Map<String, EmailPreference> emailPreferences = const {},
    String? originUri,
  }) {
    final resourceName = '$profileName/programs/$programGroupId';
    final awardingUri = originUri?.replaceFirst(RegExp(r'^https?://'), '');
    return _send(
      'PATCH',
      resourceName,
      queryParameters: {
        'allowMissing': 'true',
        if (emailPreferences.isNotEmpty)
          'updateMask': 'profile_program_data.email_preferences',
      },
      body: {
        'name': resourceName,
        if (awardingUri != null && awardingUri.isNotEmpty)
          'awardingUri': awardingUri,
        if (emailPreferences.isNotEmpty)
          'emailPreferences': {
            for (final MapEntry(:key, :value) in emailPreferences.entries)
              key: {
                'id': key,
                'emailPreference': value.programValue,
              },
          },
      },
    );
  }

  /// Closes the underlying HTTP client if it was created by this client.
  void close() {
    if (_shouldCloseClient) {
      _httpClient.close();
    }
  }

  Future<Map<String, Object?>> _send(
    String method,
    String path, {
    Map<String, String>? queryParameters,
    Map<String, Object?>? body,
  }) async {
    final baseUri = Uri.parse('${environment.baseUrl}/v1beta1/$path');
    final uri = queryParameters == null || queryParameters.isEmpty
        ? baseUri
        : baseUri.replace(queryParameters: queryParameters);
    final request = http.Request(method, uri)
      ..headers['Authorization'] = 'Bearer $_accessToken';
    if (body != null) {
      request
        ..headers['Content-Type'] = 'application/json'
        ..body = jsonEncode(body);
    }

    final response = await http.Response.fromStream(
      await _httpClient.send(request),
    );
    final decoded = response.body.isEmpty
        ? const <String, Object?>{}
        : jsonDecode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = switch (decoded) {
        {'error': {'message': final String message}} => message,
        _ => response.reasonPhrase ?? 'Unknown error',
      };
      throw DeveloperProfilesException(response.statusCode, message);
    }

    return switch (decoded) {
      final Map<String, Object?> json => json,
      _ => const <String, Object?>{},
    };
  }
}
