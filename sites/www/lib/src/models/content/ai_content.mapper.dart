// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ai_content.dart';

class AiSampleMapper extends ClassMapperBase<AiSample> {
  AiSampleMapper._();

  static AiSampleMapper? _instance;
  static AiSampleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AiSampleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AiSample';

  static String _$title(AiSample v) => v.title;
  static const Field<AiSample, String> _f$title = Field('title', _$title);
  static String _$href(AiSample v) => v.href;
  static const Field<AiSample, String> _f$href = Field('href', _$href);
  static String _$image(AiSample v) => v.image;
  static const Field<AiSample, String> _f$image = Field('image', _$image);

  @override
  final MappableFields<AiSample> fields = const {
    #title: _f$title,
    #href: _f$href,
    #image: _f$image,
  };

  static AiSample _instantiate(DecodingData data) {
    return AiSample(
      title: data.dec(_f$title),
      href: data.dec(_f$href),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AiSample fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AiSample>(map);
  }

  static AiSample fromJson(String json) {
    return ensureInitialized().decodeJson<AiSample>(json);
  }
}

mixin AiSampleMappable {
  String toJson() {
    return AiSampleMapper.ensureInitialized().encodeJson<AiSample>(
      this as AiSample,
    );
  }

  Map<String, dynamic> toMap() {
    return AiSampleMapper.ensureInitialized().encodeMap<AiSample>(
      this as AiSample,
    );
  }

  AiSampleCopyWith<AiSample, AiSample, AiSample> get copyWith =>
      _AiSampleCopyWithImpl<AiSample, AiSample>(
        this as AiSample,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AiSampleMapper.ensureInitialized().stringifyValue(this as AiSample);
  }

  @override
  bool operator ==(Object other) {
    return AiSampleMapper.ensureInitialized().equalsValue(
      this as AiSample,
      other,
    );
  }

  @override
  int get hashCode {
    return AiSampleMapper.ensureInitialized().hashValue(this as AiSample);
  }
}

extension AiSampleValueCopy<$R, $Out> on ObjectCopyWith<$R, AiSample, $Out> {
  AiSampleCopyWith<$R, AiSample, $Out> get $asAiSample =>
      $base.as((v, t, t2) => _AiSampleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AiSampleCopyWith<$R, $In extends AiSample, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? href, String? image});
  AiSampleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AiSampleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AiSample, $Out>
    implements AiSampleCopyWith<$R, AiSample, $Out> {
  _AiSampleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AiSample> $mapper =
      AiSampleMapper.ensureInitialized();
  @override
  $R call({String? title, String? href, String? image}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (href != null) #href: href,
      if (image != null) #image: image,
    }),
  );
  @override
  AiSample $make(CopyWithData data) => AiSample(
    title: data.get(#title, or: $value.title),
    href: data.get(#href, or: $value.href),
    image: data.get(#image, or: $value.image),
  );

  @override
  AiSampleCopyWith<$R2, AiSample, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AiSampleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

