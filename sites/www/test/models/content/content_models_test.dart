// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_website/src/models/content/ai_content.dart';
import 'package:flutter_website/src/models/content/banner_content.dart';
import 'package:flutter_website/src/models/content/community_content.dart';
import 'package:flutter_website/src/models/content/consultants_content.dart';
import 'package:flutter_website/src/models/content/events_content.dart';
import 'package:flutter_website/src/models/content/games_content.dart';
import 'package:flutter_website/src/models/content/home_content.dart';
import 'package:flutter_website/src/models/content/ios_content.dart';
import 'package:flutter_website/src/models/content/showcase_content.dart';
import 'package:flutter_website/src/models/layout/nav_content.dart';
import 'package:test/test.dart';

final Matcher _throwsMapperException = throwsA(isA<MapperException>());

final Matcher _throwsValidationError = throwsA(
  anyOf(isA<FormatException>(), isA<MapperException>()),
);

void main() {
  group('ConsultantPartner.fromJson', () {
    final valid = <String, Object?>{
      'title': 'VGV',
      'summary': 'Consultancy summary',
      'card': 'images/third_party/partners/vgv.png',
      'external_url': 'https://verygood.ventures',
      'options_location': ['North America'],
      'options_customer_size': ['Enterprise'],
      'options_GCP_partner': true,
    };

    test('decodes valid data', () {
      final decoded = ConsultantPartner.fromJson(valid);

      expect(decoded.title, 'VGV');
      expect(decoded.locations, [Continent.northAmerica]);
      expect(decoded.customerSizes, [CustomerSize.enterprise]);
      expect(decoded.isGcpPartner, isTrue);
      expect(decoded.gcpPartnerLabel, 'Yes');
    });

    test('decodes false into non-partner', () {
      final nonPartner = {...valid}..['options_GCP_partner'] = false;
      final decoded = ConsultantPartner.fromJson(nonPartner);

      expect(decoded.isGcpPartner, isFalse);
      expect(decoded.gcpPartnerLabel, 'No');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('title');

      expect(() => ConsultantPartner.fromJson(invalid), _throwsMapperException);
    });

    test('throws when gcp partner value is null', () {
      final invalid = {...valid}..['options_GCP_partner'] = null;

      expect(() => ConsultantPartner.fromJson(invalid), _throwsMapperException);
    });

    test('throws when external_url is not an absolute HTTP URL', () {
      final invalid = {...valid}..['external_url'] = 'not-a-url';

      expect(() => ConsultantPartner.fromJson(invalid), _throwsValidationError);
    });

    test('throws when external_url is not HTTPS', () {
      final invalid = {...valid}..['external_url'] = 'http://example.com';

      expect(() => ConsultantPartner.fromJson(invalid), _throwsValidationError);
    });

    test('throws when card is not under images/', () {
      final invalid = {...valid}..['card'] = 'other/path.png';

      expect(() => ConsultantPartner.fromJson(invalid), _throwsValidationError);
    });

    test('throws when options_location is empty', () {
      final invalid = {...valid}..['options_location'] = <Object?>[];

      expect(() => ConsultantPartner.fromJson(invalid), _throwsValidationError);
    });

    test('throws when options_location contains invalid continent value', () {
      final invalid = {...valid}..['options_location'] = ['antarctica'];

      expect(() => ConsultantPartner.fromJson(invalid), _throwsMapperException);
    });

    test('throws when options_customer_size contains invalid value', () {
      final invalid = {...valid}..['options_customer_size'] = ['Micro'];

      expect(() => ConsultantPartner.fromJson(invalid), _throwsMapperException);
    });
  });

  group('ConsultantResource.fromJson', () {
    final valid = <String, Object?>{
      'title': 'Resource title',
      'summary': 'Resource summary',
      'card': 'images/third_party/resources/resource.png',
      'external_url': 'https://flutter.dev',
      'background_color': '#027DFD',
      'button_text': 'Read',
    };

    test('decodes valid data', () {
      final decoded = ConsultantResource.fromJson(valid);
      expect(decoded.backgroundColor, '#027DFD');
      expect(decoded.buttonText, 'Read');
    });

    test('coerces primitive values to strings when possible', () {
      final withNumericButtonText = {...valid}..['button_text'] = 42;
      final decoded = ConsultantResource.fromJson(withNumericButtonText);
      expect(decoded.buttonText, '42');
    });

    test('throws when background_color is not a valid hex color', () {
      final invalid = {...valid}..['background_color'] = 'red';

      expect(
        () => ConsultantResource.fromJson(invalid),
        _throwsValidationError,
      );
    });

    test('throws when external_url is not an absolute HTTP URL', () {
      final invalid = {...valid}..['external_url'] = '/relative/path';

      expect(
        () => ConsultantResource.fromJson(invalid),
        _throwsValidationError,
      );
    });
  });

  group('AiSample.fromJson', () {
    final valid = <String, Object?>{
      'title': 'Ask Dash',
      'href': 'https://flutter.dev',
      'image': 'images/ask-dash.png',
    };

    test('decodes valid data', () {
      final decoded = AiSample.fromJson(valid);
      expect(decoded.href, 'https://flutter.dev');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('href');
      expect(() => AiSample.fromJson(invalid), _throwsMapperException);
    });

    test('throws when href is not a URL or root-relative path', () {
      final invalid = {...valid}..['href'] = 'relative/path';
      expect(() => AiSample.fromJson(invalid), _throwsValidationError);
    });

    test('throws when image is not an image asset path', () {
      final invalid = {...valid}..['image'] = 'images/sample.txt';
      expect(() => AiSample.fromJson(invalid), _throwsValidationError);
    });
  });

  group('GameIntegration.fromJson', () {
    final valid = <String, Object?>{
      'title': 'Ads',
      'description': 'Description',
      'url': 'https://docs.flutter.dev',
      'image': 'images/integration/ads.png',
    };

    test('decodes valid data', () {
      final decoded = GameIntegration.fromJson(valid);
      expect(decoded.title, 'Ads');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('url');
      expect(() => GameIntegration.fromJson(invalid), _throwsMapperException);
    });

    test('throws when image is not under images/', () {
      final invalid = {...valid}..['image'] = '/images/integration/ads.png';
      expect(() => GameIntegration.fromJson(invalid), _throwsValidationError);
    });
  });

  group('FeaturedGame.fromJson', () {
    final valid = <String, Object?>{
      'title': 'Game',
      'url': '/showcase/game',
      'image': 'images/featured/game.png',
    };

    test('decodes valid data', () {
      final decoded = FeaturedGame.fromJson(valid);
      expect(decoded.url, '/showcase/game');
    });

    test('throws when title is missing', () {
      final invalid = {...valid}..remove('title');
      expect(() => FeaturedGame.fromJson(invalid), _throwsMapperException);
    });

    test('throws when url is not a URL or root-relative path', () {
      final invalid = {...valid}..['url'] = 'games/game';
      expect(() => FeaturedGame.fromJson(invalid), _throwsValidationError);
    });
  });

  group('ShowcaseGoogleApp.fromJson', () {
    final valid = <String, Object?>{
      'title': 'NotebookLM',
      'image': 'images/google_apps/image_1.png',
      'url': '/showcase/notebooklm',
    };

    test('decodes valid data with optional url', () {
      final decoded = ShowcaseGoogleApp.fromJson(valid);
      expect(decoded.url, '/showcase/notebooklm');
    });

    test('decodes valid data when optional url is absent', () {
      final withoutUrl = {...valid}..remove('url');
      final decoded = ShowcaseGoogleApp.fromJson(withoutUrl);
      expect(decoded.url, isNull);
    });

    test('throws when optional url is empty', () {
      final invalid = {...valid}..['url'] = '';
      expect(() => ShowcaseGoogleApp.fromJson(invalid), _throwsValidationError);
    });

    test('throws when optional url is not a URL or root-relative path', () {
      final invalid = {...valid}..['url'] = 'showcase/notebooklm';
      expect(() => ShowcaseGoogleApp.fromJson(invalid), _throwsValidationError);
    });
  });

  group('ShowcaseDemo.fromJson', () {
    final valid = <String, Object?>{
      'title': 'I/O Flip',
      'description': 'Description',
      'image': 'images/demos/flip.png',
      'url': 'https://flip.withgoogle.com',
    };

    test('decodes valid data', () {
      final decoded = ShowcaseDemo.fromJson(valid);
      expect(decoded.title, 'I/O Flip');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('description');
      expect(() => ShowcaseDemo.fromJson(invalid), _throwsMapperException);
    });

    test('throws when image is not an image asset path', () {
      final invalid = {...valid}..['image'] = 'images/demos/flip';
      expect(() => ShowcaseDemo.fromJson(invalid), _throwsValidationError);
    });
  });

  group('ShowcaseCompany.fromJson', () {
    final valid = <String, Object?>{
      'name': 'Alibaba',
      'logo': '/images/third_party/logos/alibaba.svg',
    };

    test('decodes valid data', () {
      final decoded = ShowcaseCompany.fromJson(valid);
      expect(decoded.logo, '/images/third_party/logos/alibaba.svg');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('name');
      expect(() => ShowcaseCompany.fromJson(invalid), _throwsMapperException);
    });

    test('throws when logo is not root-relative', () {
      final invalid = {...valid}..['logo'] = 'images/third_party/logos/a.svg';
      expect(() => ShowcaseCompany.fromJson(invalid), _throwsValidationError);
    });
  });

  group('FeaturedEvent.fromJson', () {
    final valid = <String, Object?>{
      'title': 'Google I/O 2025',
      'description': 'Join us',
      'image': 'images/calendar/io_header.png',
      'link': 'https://io.google/2025/',
      'backgroundColor': '#0a7aeb',
    };

    test('decodes valid data', () {
      final decoded = FeaturedEvent.fromJson(valid);
      expect(decoded.hasExternalLink, isTrue);
    });

    test('throws when description is blank', () {
      final invalid = {...valid}..['description'] = ' ';
      expect(() => FeaturedEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when backgroundColor is not a hex color', () {
      final invalid = {...valid}..['backgroundColor'] = 'black';
      expect(() => FeaturedEvent.fromJson(invalid), _throwsValidationError);
    });
  });

  group('CalendarEvent.fromJson', () {
    final valid = <String, Object?>{
      'title': 'FlutterCon',
      'description': 'Conference',
      'startDate': '2025-09-24',
      'endDate': '2025-09-26',
      'card': 'images/calendar/fluttercon.png',
      'location': 'EMEA',
      'host': 'Community',
      'backgroundColor': '#eebb22',
    };

    test('decodes valid data and computes derived state', () {
      final decoded = CalendarEvent.fromJson(valid);
      expect(decoded.hasExternalLink, isFalse);
      expect(decoded.startDate, DateTime(2025, 9, 24));
      expect(decoded.endDate, DateTime(2025, 9, 26));
      expect(decoded.backgroundColor, '#eebb22');
      expect(decoded.location, EventLocation.emea);
      expect(decoded.host, EventHost.community);
    });

    test('throws when host is missing', () {
      final invalid = {...valid}..remove('host');
      expect(() => CalendarEvent.fromJson(invalid), _throwsMapperException);
    });

    test('throws when location is not an event filter value', () {
      final invalid = {...valid}..['location'] = 'Las Vegas, NV';
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when host is not an event filter value', () {
      final invalid = {...valid}..['host'] = 'Partner';
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when date is used', () {
      final invalid = {
        ...valid,
        'date': '2025-09-24',
      };
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when startDate includes a time', () {
      final invalid = {
        ...valid,
      }..['startDate'] = DateTime(2025, 9, 24, 12);
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when endDate includes a time', () {
      final invalid = {
        ...valid,
      }..['endDate'] = DateTime(2025, 9, 26, 12);
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when endDate is before startDate', () {
      final invalid = {
        ...valid,
      }..['endDate'] = '2025-09-23';
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });

    test('throws when backgroundColor is not a hex color', () {
      final invalid = {...valid}..['backgroundColor'] = 'yellow';
      expect(() => CalendarEvent.fromJson(invalid), _throwsValidationError);
    });
  });

  group('CommunityGroup.fromJson', () {
    final valid = <String, Object?>{
      'href': 'https://discord.gg/flutter',
      'imgSrc': 'images/icons/flutter-discord.png',
      'imgAlt': 'Flutter Discord',
      'title': 'Flutter Discord',
      'description': 'Community',
      'isFramed': true,
      'hasSubscribeButton': false,
    };

    test('decodes valid data', () {
      final decoded = CommunityGroup.fromJson(valid);
      expect(decoded.isFramed, isTrue);
    });

    test('defaults optional bools when omitted', () {
      final noOptionalBools = {...valid}
        ..remove('isFramed')
        ..remove('hasSubscribeButton');
      final decoded = CommunityGroup.fromJson(noOptionalBools);
      expect(decoded.isFramed, isFalse);
      expect(decoded.hasSubscribeButton, isFalse);
    });

    test('throws when href is not an absolute HTTP URL', () {
      final invalid = {...valid}..['href'] = '/community';
      expect(() => CommunityGroup.fromJson(invalid), _throwsValidationError);
    });
  });

  group('HomeNewsItem.fromJson', () {
    final valid = <String, Object?>{
      'title': 'What\'s new',
      'url': 'https://blog.flutter.dev/',
      'image': '/news/images/featured/news.png',
    };

    test('decodes valid data with optional alt', () {
      final decoded = HomeNewsItem.fromJson(valid);
      expect(decoded.alt, isNull);
    });

    test('throws when optional alt is empty', () {
      final invalid = {...valid}..['alt'] = '';
      expect(() => HomeNewsItem.fromJson(invalid), _throwsValidationError);
    });

    test('throws when image is not root-relative', () {
      final invalid = {...valid}..['image'] = 'news/images/featured/news.png';
      expect(() => HomeNewsItem.fromJson(invalid), _throwsValidationError);
    });
  });

  group('IosTopBrand.fromJson', () {
    final valid = <String, Object?>{
      'name': 'Alibaba',
      'src': 'images/top-brands-alibaba.svg',
      'href': '/showcase/alibaba-group',
    };

    test('decodes valid data', () {
      final decoded = IosTopBrand.fromJson(valid);
      expect(decoded.href, '/showcase/alibaba-group');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('src');
      expect(() => IosTopBrand.fromJson(invalid), _throwsMapperException);
    });

    test('throws when href is not a URL or root-relative path', () {
      final invalid = {...valid}..['href'] = 'showcase/alibaba-group';
      expect(() => IosTopBrand.fromJson(invalid), _throwsValidationError);
    });
  });

  group('BannerContent.fromJson', () {
    final valid = <String, Object?>{
      'text': 'Flutter 3.41 is here',
      'link': 'https://blog.flutter.dev',
    };

    test('decodes valid data', () {
      final decoded = BannerContent.fromJson(valid);
      expect(decoded.text, 'Flutter 3.41 is here');
      expect(decoded.toMap()['text'], 'Flutter 3.41 is here');
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('link');
      expect(() => BannerContent.fromJson(invalid), _throwsMapperException);
    });

    test('throws when link is not a URL or root-relative path', () {
      final invalid = {...valid}..['link'] = 'blog/flutter';
      expect(() => BannerContent.fromJson(invalid), _throwsValidationError);
    });
  });

  group('NavItem.fromJson', () {
    final valid = <String, Object?>{
      'label': 'Ecosystem',
      'href': '/ecosystem',
      'items': [
        {'label': 'Community', 'href': '/community'},
      ],
    };

    test('decodes valid data', () {
      final decoded = NavItem.fromJson(valid);
      expect(decoded.label, 'Ecosystem');
      expect(decoded.hasDropdown, isTrue);
      expect(decoded.items, hasLength(1));
    });

    test('decodes without optional items', () {
      final minimal = <String, Object?>{
        'label': 'Blog',
        'href': 'https://blog.flutter.dev',
      };
      final decoded = NavItem.fromJson(minimal);
      expect(decoded.hasDropdown, isFalse);
      expect(decoded.secondColumn, isNull);
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('label');
      expect(() => NavItem.fromJson(invalid), _throwsMapperException);
    });

    test('throws when href is not a URL or root-relative path', () {
      final invalid = {...valid}..['href'] = 'not-a-path';
      expect(() => NavItem.fromJson(invalid), _throwsValidationError);
    });

    test('throws when secondColumn is set without items', () {
      final invalid = <String, Object?>{
        'label': 'Bad',
        'href': '/bad',
        'secondColumn': [
          {'label': 'Link', 'href': '/link'},
        ],
      };
      expect(() => NavItem.fromJson(invalid), _throwsValidationError);
    });
  });

  group('NavLink.fromJson', () {
    final valid = <String, Object?>{
      'label': 'Community',
      'href': '/community',
    };

    test('decodes valid data', () {
      final decoded = NavLink.fromJson(valid);
      expect(decoded.label, 'Community');
      expect(decoded.isExternal, isFalse);
      expect(decoded.subItems, isEmpty);
    });

    test('decodes with optional fields', () {
      final withOptional = <String, Object?>{
        'label': 'Overview',
        'href': '/ecosystem',
        'subItems': [
          {'label': 'Sub', 'href': '/sub'},
        ],
      };
      final decoded = NavLink.fromJson(withOptional);
      expect(decoded.label, equals('Overview'));
      expect(decoded.subItems, hasLength(1));
    });

    test('detects external links', () {
      final external = <String, Object?>{
        'label': 'Learn',
        'href': 'https://docs.flutter.dev/learn',
      };
      final decoded = NavLink.fromJson(external);
      expect(decoded.isExternal, isTrue);
    });

    test('throws when required field is missing', () {
      final invalid = {...valid}..remove('href');
      expect(() => NavLink.fromJson(invalid), _throwsMapperException);
    });

    test('throws when label is blank', () {
      final invalid = {...valid}..['label'] = '  ';
      expect(() => NavLink.fromJson(invalid), _throwsValidationError);
    });

    test('throws when href is not a URL or root-relative path', () {
      final invalid = {...valid}..['href'] = 'relative/path';
      expect(() => NavLink.fromJson(invalid), _throwsValidationError);
    });
  });
}
