// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part 'consultants_content.mapper.dart';

/// Consultant directory entry loaded from `consultants.data.partners`.
///
/// Expected data format:
/// - `title`: non-empty company name.
/// - `summary`: non-empty company description.
/// - `card`: non-empty image asset path under `images/`.
/// - `external_url`: absolute HTTPS URL.
/// - `options_location`: non-empty list of continent labels
///    (for example `North America`), mapped to [Continent].
/// - `options_customer_size`: non-empty list of customer-size labels,
///    mapped to [CustomerSize].
/// - `options_GCP_partner`: `true` or `false`.
@MappableClass()
class ConsultantPartner with ConsultantPartnerMappable {
  ConsultantPartner({
    required this.title,
    required this.summary,
    required this.card,
    required this.externalUrl,
    required this.locations,
    required this.customerSizes,
    required this.isGcpPartner,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(isNotBlank(summary), 'summary must be a non-empty string.');
    checkFormat(isNotBlank(card), 'card must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(card),
      'card must be an image asset path under images/.',
    );
    checkFormat(
      isNotBlank(externalUrl),
      'external_url must be a non-empty string.',
    );
    checkFormat(
      isAbsoluteHttpUrl(externalUrl, requireHttps: true),
      'external_url must be an absolute https URL.',
    );
    checkFormat(
      locations.isNotEmpty,
      'options_location must contain at least one value.',
    );
    checkFormat(
      customerSizes.isNotEmpty,
      'options_customer_size must contain at least one value.',
    );
  }

  /// Company name shown on cards and consultant listings.
  final String title;

  /// Company description displayed in consultant cards.
  final String summary;

  /// Image asset path (for example `images/third_party/partners/Example.png`).
  final String card;

  /// External consultant website URL.
  @MappableField(key: 'external_url')
  final String externalUrl;

  /// Continents used by the location filter.
  @MappableField(
    key: 'options_location',
    hook: _ContinentListHook(fieldName: 'options_location'),
  )
  final List<Continent> locations;

  /// Customer-size values used by the customer-size filter.
  @MappableField(
    key: 'options_customer_size',
    hook: _CustomerSizeListHook(fieldName: 'options_customer_size'),
  )
  final List<CustomerSize> customerSizes;

  /// Google Cloud Partner status represented as a boolean.
  @MappableField(key: 'options_GCP_partner')
  final bool isGcpPartner;

  /// Parses a consultant partner model from YAML/JSON data.
  static ConsultantPartner fromJson(Map<String, Object?> json) =>
      ConsultantPartnerMapper.fromMap(json);

  /// Convenience label used in existing UI filtering code.
  String get gcpPartnerLabel => isGcpPartner ? 'Yes' : 'No';

  /// Convenience labels used by existing UI filtering code.
  List<String> get locationLabels =>
      locations.map((continent) => continent.label).toList(growable: false);

  /// Convenience labels used by existing UI filtering code.
  List<String> get customerSizeLabels => customerSizes
      .map((customerSize) => customerSize.label)
      .toList(growable: false);
}

/// Featured consultant resource entry loaded from `consultants.data.resources`.
///
/// Expected data format:
/// - `title`: non-empty resource title.
/// - `summary`: non-empty summary text.
/// - `card`: non-empty image asset path under `images/`.
/// - `external_url`: absolute HTTPS URL.
/// - `background_color`: hex color in `#RRGGBB` or `#RRGGBBAA`.
/// - `button_text`: non-empty CTA label.
@MappableClass()
class ConsultantResource with ConsultantResourceMappable {
  ConsultantResource({
    required this.title,
    required this.summary,
    required this.card,
    required this.externalUrl,
    required this.backgroundColor,
    required this.buttonText,
  }) {
    checkFormat(isNotBlank(title), 'title must be a non-empty string.');
    checkFormat(isNotBlank(summary), 'summary must be a non-empty string.');
    checkFormat(isNotBlank(card), 'card must be a non-empty string.');
    checkFormat(
      looksLikeImageAssetPath(card),
      'card must be an image asset path under images/.',
    );
    checkFormat(
      isNotBlank(externalUrl),
      'external_url must be a non-empty string.',
    );
    checkFormat(
      isAbsoluteHttpUrl(externalUrl, requireHttps: true),
      'external_url must be an absolute https URL.',
    );
    checkFormat(
      isNotBlank(backgroundColor),
      'background_color must be a non-empty string.',
    );
    checkFormat(
      isHexColor(backgroundColor),
      'background_color must be a hex color in #RRGGBB or #RRGGBBAA format.',
    );
    checkFormat(
      isNotBlank(buttonText),
      'button_text must be a non-empty string.',
    );
  }

  /// Resource title shown in the featured carousel.
  final String title;

  /// Resource summary shown under the title.
  final String summary;

  /// Image asset path (for example `images/third_party/resources/example.png`).
  final String card;

  /// External destination URL for the call-to-action button.
  @MappableField(key: 'external_url')
  final String externalUrl;

  /// Card background color in hex format.
  @MappableField(key: 'background_color')
  final String backgroundColor;

  /// Call-to-action label displayed on the card button.
  @MappableField(key: 'button_text')
  final String buttonText;

  /// Parses a consultant resource model from YAML/JSON data.
  static ConsultantResource fromJson(Map<String, Object?> json) =>
      ConsultantResourceMapper.fromMap(json);
}

/// Supported consultant partner continents.
///
/// Serialized values are kept compatible with existing YAML labels.
@MappableEnum()
enum Continent {
  africa,
  asia,
  europe,
  northAmerica,
  oceania,
  southAmerica;

  /// Human-readable label used in YAML and filter UIs.
  String get label => switch (this) {
    Continent.africa => 'Africa',
    Continent.asia => 'Asia',
    Continent.europe => 'Europe',
    Continent.northAmerica => 'North America',
    Continent.oceania => 'Oceania',
    Continent.southAmerica => 'South America',
  };

  /// Parses raw continent labels into a [Continent].
  ///
  /// Accepts both legacy display labels (for example `North America`) and
  /// enum-like tokens (for example `northAmerica`).
  // TODO(parlough): Update the YAML and remove the legacy tokens.
  static Continent fromSerialized(String value) =>
      switch (value.trim().toLowerCase()) {
        'africa' => Continent.africa,
        'asia' => Continent.asia,
        'europe' => Continent.europe,
        'north america' || 'northamerica' => Continent.northAmerica,
        'oceania' => Continent.oceania,
        'south america' || 'southamerica' => Continent.southAmerica,
        _ => throw FormatException('Unsupported partnercontinent "$value".'),
      };
}

/// Supported consultant partner customer-size segments.
@MappableEnum()
enum CustomerSize {
  /// Startup companies.
  startup,

  /// Small-to-medium businesses.
  smallToMediumBusiness,

  /// Enterprise organizations.
  enterprise;

  /// Human-readable label used in YAML and filter UIs.
  String get label => switch (this) {
    CustomerSize.startup => 'Startup',
    CustomerSize.smallToMediumBusiness => 'Small-to-medium Business',
    CustomerSize.enterprise => 'Enterprise',
  };

  /// Parses raw customer-size labels into a [CustomerSize].
  ///
  /// Accepts the current display labels and a few spacing/hyphen variants.
  // TODO(parlough): Update the YAML and remove the legacy tokens.
  static CustomerSize fromSerialized(String value) => switch (value
      .trim()
      .toLowerCase()) {
    'startup' => CustomerSize.startup,
    'small-to-medium business' ||
    'small to medium business' ||
    'smalltomediumbusiness' => CustomerSize.smallToMediumBusiness,
    'enterprise' => CustomerSize.enterprise,
    _ => throw FormatException('Unsupported partnercustomer size "$value".'),
  };
}

/// Maps location label lists from YAML into [Continent] enum values.
class _ContinentListHook extends MappingHook {
  /// Creates a hook for mapping a specific field.
  const _ContinentListHook({required this.fieldName});

  /// Name of the source field used in error messages.
  final String fieldName;

  /// Decodes a mixed list of labels/tokens into [Continent] values.
  @override
  Object? beforeDecode(Object? value) {
    if (value is List<Continent>) {
      return value;
    }

    if (value is List<Object?>) {
      return value.map(_decodeContinent).toList(growable: false);
    }

    throw FormatException(
      '$fieldName must be a list, got ${value.runtimeType}.',
    );
  }

  /// Encodes [Continent] values back to human-readable labels.
  @override
  Object? beforeEncode(Object? value) {
    if (value is List<Continent>) {
      return value.map((continent) => continent.label).toList(growable: false);
    }

    throw FormatException(
      'Expected List<Continent> for $fieldName encoding, got ${value.runtimeType}.',
    );
  }

  Continent _decodeContinent(Object? value) {
    if (value is Continent) {
      return value;
    }
    if (value is String) {
      return Continent.fromSerialized(value);
    }
    throw FormatException(
      '$fieldName entries must be strings, got ${value.runtimeType}.',
    );
  }
}

/// Maps customer-size label lists from YAML into [CustomerSize] enum values.
class _CustomerSizeListHook extends MappingHook {
  /// Creates a hook for mapping a specific field.
  const _CustomerSizeListHook({required this.fieldName});

  /// Name of the source field used in error messages.
  final String fieldName;

  /// Decodes a mixed list of labels/tokens into [CustomerSize] values.
  @override
  Object? beforeDecode(Object? value) {
    if (value is List<CustomerSize>) {
      return value;
    }

    if (value is List<Object?>) {
      return value.map(_decodeCustomerSize).toList(growable: false);
    }

    throw FormatException(
      '$fieldName must be a list, got ${value.runtimeType}.',
    );
  }

  /// Encodes [CustomerSize] values back to human-readable labels.
  @override
  Object? beforeEncode(Object? value) {
    if (value is List<CustomerSize>) {
      return value
          .map((customerSize) => customerSize.label)
          .toList(growable: false);
    }

    throw FormatException(
      'Expected List<CustomerSize> for $fieldName encoding, got ${value.runtimeType}.',
    );
  }

  CustomerSize _decodeCustomerSize(Object? value) {
    if (value is CustomerSize) {
      return value;
    }
    if (value is String) {
      return CustomerSize.fromSerialized(value);
    }
    throw FormatException(
      '$fieldName entries must be strings, got ${value.runtimeType}.',
    );
  }
}
