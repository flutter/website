// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'events_content.dart';

class EventLocationMapper extends EnumMapper<EventLocation> {
  EventLocationMapper._();

  static EventLocationMapper? _instance;
  static EventLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventLocationMapper._());
    }
    return _instance!;
  }

  static EventLocation fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventLocation decode(dynamic value) {
    switch (value) {
      case r'LATAM':
        return EventLocation.latam;
      case r'NA':
        return EventLocation.na;
      case r'EMEA':
        return EventLocation.emea;
      case r'APAC':
        return EventLocation.apac;
      case 'Virtual':
        return EventLocation.virtual;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventLocation self) {
    switch (self) {
      case EventLocation.latam:
        return r'LATAM';
      case EventLocation.na:
        return r'NA';
      case EventLocation.emea:
        return r'EMEA';
      case EventLocation.apac:
        return r'APAC';
      case EventLocation.virtual:
        return 'Virtual';
    }
  }
}

extension EventLocationMapperExtension on EventLocation {
  dynamic toValue() {
    EventLocationMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventLocation>(this);
  }
}

class EventHostMapper extends EnumMapper<EventHost> {
  EventHostMapper._();

  static EventHostMapper? _instance;
  static EventHostMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventHostMapper._());
    }
    return _instance!;
  }

  static EventHost fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventHost decode(dynamic value) {
    switch (value) {
      case r'Industry':
        return EventHost.industry;
      case r'Google':
        return EventHost.google;
      case r'Community':
        return EventHost.community;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventHost self) {
    switch (self) {
      case EventHost.industry:
        return r'Industry';
      case EventHost.google:
        return r'Google';
      case EventHost.community:
        return r'Community';
    }
  }
}

extension EventHostMapperExtension on EventHost {
  String toValue() {
    EventHostMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventHost>(this) as String;
  }
}

class FeaturedEventMapper extends ClassMapperBase<FeaturedEvent> {
  FeaturedEventMapper._();

  static FeaturedEventMapper? _instance;
  static FeaturedEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeaturedEventMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FeaturedEvent';

  static String _$title(FeaturedEvent v) => v.title;
  static const Field<FeaturedEvent, String> _f$title = Field('title', _$title);
  static String _$description(FeaturedEvent v) => v.description;
  static const Field<FeaturedEvent, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$image(FeaturedEvent v) => v.image;
  static const Field<FeaturedEvent, String> _f$image = Field('image', _$image);
  static String _$link(FeaturedEvent v) => v.link;
  static const Field<FeaturedEvent, String> _f$link = Field('link', _$link);
  static String _$backgroundColor(FeaturedEvent v) => v.backgroundColor;
  static const Field<FeaturedEvent, String> _f$backgroundColor = Field(
    'backgroundColor',
    _$backgroundColor,
  );

  @override
  final MappableFields<FeaturedEvent> fields = const {
    #title: _f$title,
    #description: _f$description,
    #image: _f$image,
    #link: _f$link,
    #backgroundColor: _f$backgroundColor,
  };

  static FeaturedEvent _instantiate(DecodingData data) {
    return FeaturedEvent(
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      image: data.dec(_f$image),
      link: data.dec(_f$link),
      backgroundColor: data.dec(_f$backgroundColor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FeaturedEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeaturedEvent>(map);
  }

  static FeaturedEvent fromJson(String json) {
    return ensureInitialized().decodeJson<FeaturedEvent>(json);
  }
}

mixin FeaturedEventMappable {
  String toJson() {
    return FeaturedEventMapper.ensureInitialized().encodeJson<FeaturedEvent>(
      this as FeaturedEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return FeaturedEventMapper.ensureInitialized().encodeMap<FeaturedEvent>(
      this as FeaturedEvent,
    );
  }

  FeaturedEventCopyWith<FeaturedEvent, FeaturedEvent, FeaturedEvent>
  get copyWith => _FeaturedEventCopyWithImpl<FeaturedEvent, FeaturedEvent>(
    this as FeaturedEvent,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return FeaturedEventMapper.ensureInitialized().stringifyValue(
      this as FeaturedEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return FeaturedEventMapper.ensureInitialized().equalsValue(
      this as FeaturedEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return FeaturedEventMapper.ensureInitialized().hashValue(
      this as FeaturedEvent,
    );
  }
}

extension FeaturedEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeaturedEvent, $Out> {
  FeaturedEventCopyWith<$R, FeaturedEvent, $Out> get $asFeaturedEvent =>
      $base.as((v, t, t2) => _FeaturedEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeaturedEventCopyWith<$R, $In extends FeaturedEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    String? description,
    String? image,
    String? link,
    String? backgroundColor,
  });
  FeaturedEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeaturedEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeaturedEvent, $Out>
    implements FeaturedEventCopyWith<$R, FeaturedEvent, $Out> {
  _FeaturedEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeaturedEvent> $mapper =
      FeaturedEventMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? description,
    String? image,
    String? link,
    String? backgroundColor,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (image != null) #image: image,
      if (link != null) #link: link,
      if (backgroundColor != null) #backgroundColor: backgroundColor,
    }),
  );
  @override
  FeaturedEvent $make(CopyWithData data) => FeaturedEvent(
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    image: data.get(#image, or: $value.image),
    link: data.get(#link, or: $value.link),
    backgroundColor: data.get(#backgroundColor, or: $value.backgroundColor),
  );

  @override
  FeaturedEventCopyWith<$R2, FeaturedEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FeaturedEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CalendarEventMapper extends ClassMapperBase<CalendarEvent> {
  CalendarEventMapper._();

  static CalendarEventMapper? _instance;
  static CalendarEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalendarEventMapper._());
      EventLocationMapper.ensureInitialized();
      EventHostMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalendarEvent';

  static String _$title(CalendarEvent v) => v.title;
  static const Field<CalendarEvent, String> _f$title = Field('title', _$title);
  static DateTime _$startDate(CalendarEvent v) => v.startDate;
  static const Field<CalendarEvent, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static DateTime _$endDate(CalendarEvent v) => v.endDate;
  static const Field<CalendarEvent, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
  );
  static String _$description(CalendarEvent v) => v.description;
  static const Field<CalendarEvent, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$card(CalendarEvent v) => v.card;
  static const Field<CalendarEvent, String> _f$card = Field('card', _$card);
  static EventLocation _$location(CalendarEvent v) => v.location;
  static const Field<CalendarEvent, EventLocation> _f$location = Field(
    'location',
    _$location,
  );
  static EventHost _$host(CalendarEvent v) => v.host;
  static const Field<CalendarEvent, EventHost> _f$host = Field('host', _$host);
  static String? _$link(CalendarEvent v) => v.link;
  static const Field<CalendarEvent, String> _f$link = Field(
    'link',
    _$link,
    opt: true,
  );
  static String? _$backgroundColor(CalendarEvent v) => v.backgroundColor;
  static const Field<CalendarEvent, String> _f$backgroundColor = Field(
    'backgroundColor',
    _$backgroundColor,
    opt: true,
  );

  @override
  final MappableFields<CalendarEvent> fields = const {
    #title: _f$title,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #description: _f$description,
    #card: _f$card,
    #location: _f$location,
    #host: _f$host,
    #link: _f$link,
    #backgroundColor: _f$backgroundColor,
  };

  static CalendarEvent _instantiate(DecodingData data) {
    return CalendarEvent(
      title: data.dec(_f$title),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      description: data.dec(_f$description),
      card: data.dec(_f$card),
      location: data.dec(_f$location),
      host: data.dec(_f$host),
      link: data.dec(_f$link),
      backgroundColor: data.dec(_f$backgroundColor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CalendarEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CalendarEvent>(map);
  }

  static CalendarEvent fromJson(String json) {
    return ensureInitialized().decodeJson<CalendarEvent>(json);
  }
}

mixin CalendarEventMappable {
  String toJson() {
    return CalendarEventMapper.ensureInitialized().encodeJson<CalendarEvent>(
      this as CalendarEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return CalendarEventMapper.ensureInitialized().encodeMap<CalendarEvent>(
      this as CalendarEvent,
    );
  }

  CalendarEventCopyWith<CalendarEvent, CalendarEvent, CalendarEvent>
  get copyWith => _CalendarEventCopyWithImpl<CalendarEvent, CalendarEvent>(
    this as CalendarEvent,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CalendarEventMapper.ensureInitialized().stringifyValue(
      this as CalendarEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return CalendarEventMapper.ensureInitialized().equalsValue(
      this as CalendarEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return CalendarEventMapper.ensureInitialized().hashValue(
      this as CalendarEvent,
    );
  }
}

extension CalendarEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CalendarEvent, $Out> {
  CalendarEventCopyWith<$R, CalendarEvent, $Out> get $asCalendarEvent =>
      $base.as((v, t, t2) => _CalendarEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CalendarEventCopyWith<$R, $In extends CalendarEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? card,
    EventLocation? location,
    EventHost? host,
    String? link,
    String? backgroundColor,
  });
  CalendarEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CalendarEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CalendarEvent, $Out>
    implements CalendarEventCopyWith<$R, CalendarEvent, $Out> {
  _CalendarEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CalendarEvent> $mapper =
      CalendarEventMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? card,
    EventLocation? location,
    EventHost? host,
    Object? link = $none,
    Object? backgroundColor = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (startDate != null) #startDate: startDate,
      if (endDate != null) #endDate: endDate,
      if (description != null) #description: description,
      if (card != null) #card: card,
      if (location != null) #location: location,
      if (host != null) #host: host,
      if (link != $none) #link: link,
      if (backgroundColor != $none) #backgroundColor: backgroundColor,
    }),
  );
  @override
  CalendarEvent $make(CopyWithData data) => CalendarEvent(
    title: data.get(#title, or: $value.title),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    description: data.get(#description, or: $value.description),
    card: data.get(#card, or: $value.card),
    location: data.get(#location, or: $value.location),
    host: data.get(#host, or: $value.host),
    link: data.get(#link, or: $value.link),
    backgroundColor: data.get(#backgroundColor, or: $value.backgroundColor),
  );

  @override
  CalendarEventCopyWith<$R2, CalendarEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CalendarEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

