// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_website/src/utils/gdp_signin.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:site_shared/developer_profiles.dart';
import 'package:test/test.dart';

void main() {
  group('enrollFlutterDeveloperProfile', () {
    test(
      'creates profile, adds Flutter and Dart interests, and joins Flutter '
      'community program with badge awardingUri and email preferences',
      () async {
        final requests = <http.Request>[];
        final mockHttp = MockClient((request) async {
          requests.add(request);
          return switch ((request.method, request.url.path)) {
            ('GET', '/v1beta1/profile:has') => http.Response('{}', 200),
            ('POST', '/v1beta1/profiles') => http.Response(
              jsonEncode({'name': 'profiles/12345'}),
              200,
            ),
            ('POST', '/v1beta1/profiles/12345/interests:batchUpdate') =>
              http.Response('{}', 200),
            ('PATCH', '/v1beta1/profiles/12345/programs/flutter') =>
              http.Response(
                jsonEncode({
                  'name': 'profiles/12345/programs/flutter',
                  'awards': [
                    'profiles/12345/awards/'
                        'developers.google.com%2Fprofile%2Fbadges%2Fcommunity%2Fflutter%2Fflutter-dev',
                  ],
                }),
                200,
              ),
            _ => http.Response('Unexpected request', 500),
          };
        });

        final client = DeveloperProfilesClient(
          accessToken: 'test-token',
          environment: .staging,
          httpClient: mockHttp,
        );
        addTearDown(client.close);

        final result = await enrollFlutterDeveloperProfile(
          client,
          originUri: 'https://flutter.dev/',
        );

        expect(result, equals((name: 'profiles/12345', created: true)));
        expect(requests, hasLength(4));

        // 1. Check for existing profile.
        expect(requests[0].method, equals('GET'));
        expect(requests[0].url.path, equals('/v1beta1/profile:has'));

        // 2. Create profile with eventEmail enabled and origin URI.
        expect(requests[1].method, equals('POST'));
        expect(requests[1].url.path, equals('/v1beta1/profiles'));
        expect(
          jsonDecode(requests[1].body),
          equals({
            'eventEmail': 'ENABLED',
            'creationOrigin': {'originUri': 'https://flutter.dev/'},
          }),
        );

        // 3. Add Flutter and Dart interests.
        expect(requests[2].method, equals('POST'));
        expect(
          requests[2].url.path,
          equals('/v1beta1/profiles/12345/interests:batchUpdate'),
        );
        expect(
          jsonDecode(requests[2].body),
          equals({
            'requests': [
              {
                'interest': {
                  'name': 'profiles/12345/interests/E-product-Flutter',
                  'nodeId': 'E-product-Flutter',
                  'interestState': 'STATE_SELECTED',
                },
              },
              {
                'interest': {
                  'name': 'profiles/12345/interests/E-language-DartLang',
                  'nodeId': 'E-language-DartLang',
                  'interestState': 'STATE_SELECTED',
                },
              },
            ],
          }),
        );

        // 4. Join Flutter community program (awarding badge) and opt in to
        //    Flutter update emails.
        expect(requests[3].method, equals('PATCH'));
        expect(
          requests[3].url.path,
          equals('/v1beta1/profiles/12345/programs/flutter'),
        );
        expect(
          requests[3].url.queryParameters,
          equals({
            'allowMissing': 'true',
            'updateMask': 'profile_program_data.email_preferences',
          }),
        );
        expect(
          jsonDecode(requests[3].body),
          equals({
            'name': 'profiles/12345/programs/flutter',
            'awardingUri': 'flutter.dev/',
            'emailPreferences': {
              'flutter_dev_updates_email_preference': {
                'id': 'flutter_dev_updates_email_preference',
                'emailPreference': 'EMAIL_ENABLED',
              },
            },
          }),
        );
      },
    );

    test(
      'reuses existing profile while still adding interests and joining '
      'the Flutter community program',
      () async {
        final requests = <http.Request>[];
        final mockHttp = MockClient((request) async {
          requests.add(request);
          return switch ((request.method, request.url.path)) {
            ('GET', '/v1beta1/profile:has') => http.Response(
              jsonEncode({'obfuscatedProfileId': '67890'}),
              200,
            ),
            ('POST', '/v1beta1/profiles/67890/interests:batchUpdate') =>
              http.Response('{}', 200),
            ('PATCH', '/v1beta1/profiles/67890/programs/flutter') =>
              http.Response(
                jsonEncode({'name': 'profiles/67890/programs/flutter'}),
                200,
              ),
            _ => http.Response('Unexpected request', 500),
          };
        });

        final client = DeveloperProfilesClient(
          accessToken: 'test-token',
          environment: .staging,
          httpClient: mockHttp,
        );
        addTearDown(client.close);

        final result = await enrollFlutterDeveloperProfile(
          client,
          originUri: 'https://flutter.dev/community',
        );

        expect(result, equals((name: 'profiles/67890', created: false)));
        expect(requests, hasLength(3));
        expect(
          requests.map((r) => '${r.method} ${r.url.path}').toList(),
          equals([
            'GET /v1beta1/profile:has',
            'POST /v1beta1/profiles/67890/interests:batchUpdate',
            'PATCH /v1beta1/profiles/67890/programs/flutter',
          ]),
        );
        expect(
          jsonDecode(requests[2].body),
          equals({
            'name': 'profiles/67890/programs/flutter',
            'awardingUri': 'flutter.dev/community',
            'emailPreferences': {
              'flutter_dev_updates_email_preference': {
                'id': 'flutter_dev_updates_email_preference',
                'emailPreference': 'EMAIL_ENABLED',
              },
            },
          }),
        );
      },
    );
  });

  group('formatGdpSignInError', () {
    test('returns friendly messages for GIS errors', () {
      expect(
        formatGdpSignInError(GdpSignInException.fromCode('popup_closed')),
        equals('Sign-in was cancelled. Please try again.'),
      );
      expect(
        formatGdpSignInError(GdpSignInException.fromCode('access_denied')),
        equals('Sign-in was cancelled. Please try again.'),
      );
      expect(
        formatGdpSignInError(
          GdpSignInException.fromCode('popup_failed_to_open'),
        ),
        contains('blocked the sign-in popup'),
      );
    });

    test('includes API error details in non-production builds', () {
      expect(
        formatGdpSignInError(
          const DeveloperProfilesException(403, 'Permission denied'),
        ),
        equals('Developer Profiles API error (403): Permission denied'),
      );
    });

    test('returns generic message for unexpected errors', () {
      expect(
        formatGdpSignInError(StateError('boom')),
        equals('Something went wrong. Please try again later.'),
      );
    });
  });
}
