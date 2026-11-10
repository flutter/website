// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:site_shared/developer_profiles.dart';
import 'package:test/test.dart';

void main() {
  group('DeveloperProfilesClient', () {
    test(
      'joinProgramGroup sends PATCH with allowMissing, updateMask, '
      'scheme-less awardingUri, and EMAIL_ENABLED state',
      () async {
        late http.Request capturedRequest;
        final mockHttp = MockClient((request) async {
          capturedRequest = request;
          return http.Response(
            jsonEncode({
              'name': 'profiles/12345/programs/flutter',
              'awards': [
                'profiles/12345/awards/'
                    'developers.google.com%2Fprofile%2Fbadges%2Fcommunity%2Fflutter%2Fflutter-dev',
              ],
            }),
            200,
          );
        });

        final client = DeveloperProfilesClient(
          accessToken: 'test-token',
          environment: .staging,
          httpClient: mockHttp,
        );
        addTearDown(client.close);

        final response = await client.joinProgramGroup(
          'profiles/12345',
          flutterProgramGroupId,
          emailPreferences: const {
            flutterDevUpdatesEmailPreferenceId: .enabled,
          },
          originUri: 'https://flutter.dev/create',
        );

        expect(capturedRequest.method, equals('PATCH'));
        expect(
          capturedRequest.url.origin,
          equals('https://staging-developers.sandbox.googleapis.com'),
        );
        expect(
          capturedRequest.url.path,
          equals('/v1beta1/profiles/12345/programs/flutter'),
        );
        expect(
          capturedRequest.url.queryParameters,
          equals({
            'allowMissing': 'true',
            'updateMask': 'profile_program_data.email_preferences',
          }),
        );
        expect(
          capturedRequest.headers['Authorization'],
          equals('Bearer test-token'),
        );

        final body = jsonDecode(capturedRequest.body) as Map<String, Object?>;
        expect(
          body,
          equals({
            'name': 'profiles/12345/programs/flutter',
            'awardingUri': 'flutter.dev/create',
            'emailPreferences': {
              'flutter_dev_updates_email_preference': {
                'id': 'flutter_dev_updates_email_preference',
                'emailPreference': 'EMAIL_ENABLED',
              },
            },
          }),
        );
        expect(response['name'], equals('profiles/12345/programs/flutter'));
      },
    );

    test('createProfile still uses ENABLED for profile email fields', () async {
      late http.Request capturedRequest;
      final mockHttp = MockClient((request) async {
        capturedRequest = request;
        return http.Response(jsonEncode({'name': 'profiles/12345'}), 200);
      });

      final client = DeveloperProfilesClient(
        accessToken: 'test-token',
        httpClient: mockHttp,
      );
      addTearDown(client.close);

      final profileName = await client.createProfile(
        eventEmail: .enabled,
        newsletterEmail: .disabled,
        originUri: 'https://flutter.dev/create',
      );

      expect(profileName, equals('profiles/12345'));
      expect(capturedRequest.url.queryParameters, isEmpty);
      final body = jsonDecode(capturedRequest.body) as Map<String, Object?>;
      expect(
        body,
        equals({
          'eventEmail': 'ENABLED',
          'newsletterEmail': 'DISABLED',
          'creationOrigin': {'originUri': 'https://flutter.dev/create'},
        }),
      );
    });

    test('addInterests sends Flutter and Dart Nomenclature node IDs', () async {
      late http.Request capturedRequest;
      final mockHttp = MockClient((request) async {
        capturedRequest = request;
        return http.Response('{}', 200);
      });

      final client = DeveloperProfilesClient(
        accessToken: 'test-token',
        httpClient: mockHttp,
      );
      addTearDown(client.close);

      await client.addInterests('profiles/12345', const [
        flutterInterestNodeId,
        dartInterestNodeId,
      ]);

      expect(capturedRequest.method, equals('POST'));
      expect(
        capturedRequest.url.path,
        equals('/v1beta1/profiles/12345/interests:batchUpdate'),
      );
      final body = jsonDecode(capturedRequest.body) as Map<String, Object?>;
      expect(
        body,
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
    });

    test('close does not close a caller-supplied http.Client', () async {
      final sharedHttp = _CloseTrackingClient(
        MockClient((_) async => http.Response('{}', 200)),
      );

      final client = DeveloperProfilesClient(
        accessToken: 'test-token',
        httpClient: sharedHttp,
      )..close();

      expect(sharedHttp.isClosed, isFalse);
      await expectLater(client.getProfile(), completes);
    });
  });
}

final class _CloseTrackingClient extends http.BaseClient {
  _CloseTrackingClient(this._inner);

  final http.Client _inner;
  bool isClosed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (isClosed) {
      throw http.ClientException('Client is already closed.');
    }
    return _inner.send(request);
  }

  @override
  void close() {
    isClosed = true;
    _inner.close();
  }
}
