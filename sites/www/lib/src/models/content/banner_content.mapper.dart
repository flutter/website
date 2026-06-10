// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'banner_content.dart';

class BannerContentMapper extends ClassMapperBase<BannerContent> {
  BannerContentMapper._();

  static BannerContentMapper? _instance;
  static BannerContentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BannerContentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BannerContent';

  static String _$text(BannerContent v) => v.text;
  static const Field<BannerContent, String> _f$text = Field('text', _$text);
  static String _$link(BannerContent v) => v.link;
  static const Field<BannerContent, String> _f$link = Field('link', _$link);

  @override
  final MappableFields<BannerContent> fields = const {
    #text: _f$text,
    #link: _f$link,
  };

  static BannerContent _instantiate(DecodingData data) {
    return BannerContent(text: data.dec(_f$text), link: data.dec(_f$link));
  }

  @override
  final Function instantiate = _instantiate;

  static BannerContent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BannerContent>(map);
  }

  static BannerContent fromJson(String json) {
    return ensureInitialized().decodeJson<BannerContent>(json);
  }
}

mixin BannerContentMappable {
  String toJson() {
    return BannerContentMapper.ensureInitialized().encodeJson<BannerContent>(
      this as BannerContent,
    );
  }

  Map<String, dynamic> toMap() {
    return BannerContentMapper.ensureInitialized().encodeMap<BannerContent>(
      this as BannerContent,
    );
  }

  BannerContentCopyWith<BannerContent, BannerContent, BannerContent>
  get copyWith => _BannerContentCopyWithImpl<BannerContent, BannerContent>(
    this as BannerContent,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return BannerContentMapper.ensureInitialized().stringifyValue(
      this as BannerContent,
    );
  }

  @override
  bool operator ==(Object other) {
    return BannerContentMapper.ensureInitialized().equalsValue(
      this as BannerContent,
      other,
    );
  }

  @override
  int get hashCode {
    return BannerContentMapper.ensureInitialized().hashValue(
      this as BannerContent,
    );
  }
}

extension BannerContentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BannerContent, $Out> {
  BannerContentCopyWith<$R, BannerContent, $Out> get $asBannerContent =>
      $base.as((v, t, t2) => _BannerContentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BannerContentCopyWith<$R, $In extends BannerContent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? text, String? link});
  BannerContentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BannerContentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BannerContent, $Out>
    implements BannerContentCopyWith<$R, BannerContent, $Out> {
  _BannerContentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BannerContent> $mapper =
      BannerContentMapper.ensureInitialized();
  @override
  $R call({String? text, String? link}) => $apply(
    FieldCopyWithData({
      if (text != null) #text: text,
      if (link != null) #link: link,
    }),
  );
  @override
  BannerContent $make(CopyWithData data) => BannerContent(
    text: data.get(#text, or: $value.text),
    link: data.get(#link, or: $value.link),
  );

  @override
  BannerContentCopyWith<$R2, BannerContent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BannerContentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

