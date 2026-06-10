// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'consultants_content.dart';

class ContinentMapper extends EnumMapper<Continent> {
  ContinentMapper._();

  static ContinentMapper? _instance;
  static ContinentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContinentMapper._());
    }
    return _instance!;
  }

  static Continent fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Continent decode(dynamic value) {
    switch (value) {
      case r'africa':
        return Continent.africa;
      case r'asia':
        return Continent.asia;
      case r'europe':
        return Continent.europe;
      case r'northAmerica':
        return Continent.northAmerica;
      case r'oceania':
        return Continent.oceania;
      case r'southAmerica':
        return Continent.southAmerica;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Continent self) {
    switch (self) {
      case Continent.africa:
        return r'africa';
      case Continent.asia:
        return r'asia';
      case Continent.europe:
        return r'europe';
      case Continent.northAmerica:
        return r'northAmerica';
      case Continent.oceania:
        return r'oceania';
      case Continent.southAmerica:
        return r'southAmerica';
    }
  }
}

extension ContinentMapperExtension on Continent {
  String toValue() {
    ContinentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Continent>(this) as String;
  }
}

class CustomerSizeMapper extends EnumMapper<CustomerSize> {
  CustomerSizeMapper._();

  static CustomerSizeMapper? _instance;
  static CustomerSizeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomerSizeMapper._());
    }
    return _instance!;
  }

  static CustomerSize fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CustomerSize decode(dynamic value) {
    switch (value) {
      case r'startup':
        return CustomerSize.startup;
      case r'smallToMediumBusiness':
        return CustomerSize.smallToMediumBusiness;
      case r'enterprise':
        return CustomerSize.enterprise;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CustomerSize self) {
    switch (self) {
      case CustomerSize.startup:
        return r'startup';
      case CustomerSize.smallToMediumBusiness:
        return r'smallToMediumBusiness';
      case CustomerSize.enterprise:
        return r'enterprise';
    }
  }
}

extension CustomerSizeMapperExtension on CustomerSize {
  String toValue() {
    CustomerSizeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CustomerSize>(this) as String;
  }
}

class ConsultantPartnerMapper extends ClassMapperBase<ConsultantPartner> {
  ConsultantPartnerMapper._();

  static ConsultantPartnerMapper? _instance;
  static ConsultantPartnerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConsultantPartnerMapper._());
      ContinentMapper.ensureInitialized();
      CustomerSizeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConsultantPartner';

  static String _$title(ConsultantPartner v) => v.title;
  static const Field<ConsultantPartner, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$summary(ConsultantPartner v) => v.summary;
  static const Field<ConsultantPartner, String> _f$summary = Field(
    'summary',
    _$summary,
  );
  static String _$card(ConsultantPartner v) => v.card;
  static const Field<ConsultantPartner, String> _f$card = Field('card', _$card);
  static String _$externalUrl(ConsultantPartner v) => v.externalUrl;
  static const Field<ConsultantPartner, String> _f$externalUrl = Field(
    'externalUrl',
    _$externalUrl,
    key: r'external_url',
  );
  static List<Continent> _$locations(ConsultantPartner v) => v.locations;
  static const Field<ConsultantPartner, List<Continent>> _f$locations = Field(
    'locations',
    _$locations,
    key: r'options_location',
    hook: _ContinentListHook(fieldName: 'options_location'),
  );
  static List<CustomerSize> _$customerSizes(ConsultantPartner v) =>
      v.customerSizes;
  static const Field<ConsultantPartner, List<CustomerSize>> _f$customerSizes =
      Field(
        'customerSizes',
        _$customerSizes,
        key: r'options_customer_size',
        hook: _CustomerSizeListHook(fieldName: 'options_customer_size'),
      );
  static bool _$isGcpPartner(ConsultantPartner v) => v.isGcpPartner;
  static const Field<ConsultantPartner, bool> _f$isGcpPartner = Field(
    'isGcpPartner',
    _$isGcpPartner,
    key: r'options_GCP_partner',
  );

  @override
  final MappableFields<ConsultantPartner> fields = const {
    #title: _f$title,
    #summary: _f$summary,
    #card: _f$card,
    #externalUrl: _f$externalUrl,
    #locations: _f$locations,
    #customerSizes: _f$customerSizes,
    #isGcpPartner: _f$isGcpPartner,
  };

  static ConsultantPartner _instantiate(DecodingData data) {
    return ConsultantPartner(
      title: data.dec(_f$title),
      summary: data.dec(_f$summary),
      card: data.dec(_f$card),
      externalUrl: data.dec(_f$externalUrl),
      locations: data.dec(_f$locations),
      customerSizes: data.dec(_f$customerSizes),
      isGcpPartner: data.dec(_f$isGcpPartner),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ConsultantPartner fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConsultantPartner>(map);
  }

  static ConsultantPartner fromJson(String json) {
    return ensureInitialized().decodeJson<ConsultantPartner>(json);
  }
}

mixin ConsultantPartnerMappable {
  String toJson() {
    return ConsultantPartnerMapper.ensureInitialized()
        .encodeJson<ConsultantPartner>(this as ConsultantPartner);
  }

  Map<String, dynamic> toMap() {
    return ConsultantPartnerMapper.ensureInitialized()
        .encodeMap<ConsultantPartner>(this as ConsultantPartner);
  }

  ConsultantPartnerCopyWith<
    ConsultantPartner,
    ConsultantPartner,
    ConsultantPartner
  >
  get copyWith =>
      _ConsultantPartnerCopyWithImpl<ConsultantPartner, ConsultantPartner>(
        this as ConsultantPartner,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ConsultantPartnerMapper.ensureInitialized().stringifyValue(
      this as ConsultantPartner,
    );
  }

  @override
  bool operator ==(Object other) {
    return ConsultantPartnerMapper.ensureInitialized().equalsValue(
      this as ConsultantPartner,
      other,
    );
  }

  @override
  int get hashCode {
    return ConsultantPartnerMapper.ensureInitialized().hashValue(
      this as ConsultantPartner,
    );
  }
}

extension ConsultantPartnerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConsultantPartner, $Out> {
  ConsultantPartnerCopyWith<$R, ConsultantPartner, $Out>
  get $asConsultantPartner => $base.as(
    (v, t, t2) => _ConsultantPartnerCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ConsultantPartnerCopyWith<
  $R,
  $In extends ConsultantPartner,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Continent, ObjectCopyWith<$R, Continent, Continent>>
  get locations;
  ListCopyWith<$R, CustomerSize, ObjectCopyWith<$R, CustomerSize, CustomerSize>>
  get customerSizes;
  $R call({
    String? title,
    String? summary,
    String? card,
    String? externalUrl,
    List<Continent>? locations,
    List<CustomerSize>? customerSizes,
    bool? isGcpPartner,
  });
  ConsultantPartnerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ConsultantPartnerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConsultantPartner, $Out>
    implements ConsultantPartnerCopyWith<$R, ConsultantPartner, $Out> {
  _ConsultantPartnerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConsultantPartner> $mapper =
      ConsultantPartnerMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Continent, ObjectCopyWith<$R, Continent, Continent>>
  get locations => ListCopyWith(
    $value.locations,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(locations: v),
  );
  @override
  ListCopyWith<$R, CustomerSize, ObjectCopyWith<$R, CustomerSize, CustomerSize>>
  get customerSizes => ListCopyWith(
    $value.customerSizes,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(customerSizes: v),
  );
  @override
  $R call({
    String? title,
    String? summary,
    String? card,
    String? externalUrl,
    List<Continent>? locations,
    List<CustomerSize>? customerSizes,
    bool? isGcpPartner,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (summary != null) #summary: summary,
      if (card != null) #card: card,
      if (externalUrl != null) #externalUrl: externalUrl,
      if (locations != null) #locations: locations,
      if (customerSizes != null) #customerSizes: customerSizes,
      if (isGcpPartner != null) #isGcpPartner: isGcpPartner,
    }),
  );
  @override
  ConsultantPartner $make(CopyWithData data) => ConsultantPartner(
    title: data.get(#title, or: $value.title),
    summary: data.get(#summary, or: $value.summary),
    card: data.get(#card, or: $value.card),
    externalUrl: data.get(#externalUrl, or: $value.externalUrl),
    locations: data.get(#locations, or: $value.locations),
    customerSizes: data.get(#customerSizes, or: $value.customerSizes),
    isGcpPartner: data.get(#isGcpPartner, or: $value.isGcpPartner),
  );

  @override
  ConsultantPartnerCopyWith<$R2, ConsultantPartner, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ConsultantPartnerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ConsultantResourceMapper extends ClassMapperBase<ConsultantResource> {
  ConsultantResourceMapper._();

  static ConsultantResourceMapper? _instance;
  static ConsultantResourceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConsultantResourceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ConsultantResource';

  static String _$title(ConsultantResource v) => v.title;
  static const Field<ConsultantResource, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$summary(ConsultantResource v) => v.summary;
  static const Field<ConsultantResource, String> _f$summary = Field(
    'summary',
    _$summary,
  );
  static String _$card(ConsultantResource v) => v.card;
  static const Field<ConsultantResource, String> _f$card = Field(
    'card',
    _$card,
  );
  static String _$externalUrl(ConsultantResource v) => v.externalUrl;
  static const Field<ConsultantResource, String> _f$externalUrl = Field(
    'externalUrl',
    _$externalUrl,
    key: r'external_url',
  );
  static String _$backgroundColor(ConsultantResource v) => v.backgroundColor;
  static const Field<ConsultantResource, String> _f$backgroundColor = Field(
    'backgroundColor',
    _$backgroundColor,
    key: r'background_color',
  );
  static String _$buttonText(ConsultantResource v) => v.buttonText;
  static const Field<ConsultantResource, String> _f$buttonText = Field(
    'buttonText',
    _$buttonText,
    key: r'button_text',
  );

  @override
  final MappableFields<ConsultantResource> fields = const {
    #title: _f$title,
    #summary: _f$summary,
    #card: _f$card,
    #externalUrl: _f$externalUrl,
    #backgroundColor: _f$backgroundColor,
    #buttonText: _f$buttonText,
  };

  static ConsultantResource _instantiate(DecodingData data) {
    return ConsultantResource(
      title: data.dec(_f$title),
      summary: data.dec(_f$summary),
      card: data.dec(_f$card),
      externalUrl: data.dec(_f$externalUrl),
      backgroundColor: data.dec(_f$backgroundColor),
      buttonText: data.dec(_f$buttonText),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ConsultantResource fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConsultantResource>(map);
  }

  static ConsultantResource fromJson(String json) {
    return ensureInitialized().decodeJson<ConsultantResource>(json);
  }
}

mixin ConsultantResourceMappable {
  String toJson() {
    return ConsultantResourceMapper.ensureInitialized()
        .encodeJson<ConsultantResource>(this as ConsultantResource);
  }

  Map<String, dynamic> toMap() {
    return ConsultantResourceMapper.ensureInitialized()
        .encodeMap<ConsultantResource>(this as ConsultantResource);
  }

  ConsultantResourceCopyWith<
    ConsultantResource,
    ConsultantResource,
    ConsultantResource
  >
  get copyWith =>
      _ConsultantResourceCopyWithImpl<ConsultantResource, ConsultantResource>(
        this as ConsultantResource,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ConsultantResourceMapper.ensureInitialized().stringifyValue(
      this as ConsultantResource,
    );
  }

  @override
  bool operator ==(Object other) {
    return ConsultantResourceMapper.ensureInitialized().equalsValue(
      this as ConsultantResource,
      other,
    );
  }

  @override
  int get hashCode {
    return ConsultantResourceMapper.ensureInitialized().hashValue(
      this as ConsultantResource,
    );
  }
}

extension ConsultantResourceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConsultantResource, $Out> {
  ConsultantResourceCopyWith<$R, ConsultantResource, $Out>
  get $asConsultantResource => $base.as(
    (v, t, t2) => _ConsultantResourceCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ConsultantResourceCopyWith<
  $R,
  $In extends ConsultantResource,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    String? summary,
    String? card,
    String? externalUrl,
    String? backgroundColor,
    String? buttonText,
  });
  ConsultantResourceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ConsultantResourceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConsultantResource, $Out>
    implements ConsultantResourceCopyWith<$R, ConsultantResource, $Out> {
  _ConsultantResourceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConsultantResource> $mapper =
      ConsultantResourceMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? summary,
    String? card,
    String? externalUrl,
    String? backgroundColor,
    String? buttonText,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (summary != null) #summary: summary,
      if (card != null) #card: card,
      if (externalUrl != null) #externalUrl: externalUrl,
      if (backgroundColor != null) #backgroundColor: backgroundColor,
      if (buttonText != null) #buttonText: buttonText,
    }),
  );
  @override
  ConsultantResource $make(CopyWithData data) => ConsultantResource(
    title: data.get(#title, or: $value.title),
    summary: data.get(#summary, or: $value.summary),
    card: data.get(#card, or: $value.card),
    externalUrl: data.get(#externalUrl, or: $value.externalUrl),
    backgroundColor: data.get(#backgroundColor, or: $value.backgroundColor),
    buttonText: data.get(#buttonText, or: $value.buttonText),
  );

  @override
  ConsultantResourceCopyWith<$R2, ConsultantResource, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ConsultantResourceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

