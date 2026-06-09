// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'community_content.dart';

class CommunityGroupMapper extends ClassMapperBase<CommunityGroup> {
  CommunityGroupMapper._();

  static CommunityGroupMapper? _instance;
  static CommunityGroupMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CommunityGroupMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CommunityGroup';

  static String _$href(CommunityGroup v) => v.href;
  static const Field<CommunityGroup, String> _f$href = Field('href', _$href);
  static String _$imgSrc(CommunityGroup v) => v.imgSrc;
  static const Field<CommunityGroup, String> _f$imgSrc = Field(
    'imgSrc',
    _$imgSrc,
  );
  static String _$imgAlt(CommunityGroup v) => v.imgAlt;
  static const Field<CommunityGroup, String> _f$imgAlt = Field(
    'imgAlt',
    _$imgAlt,
  );
  static String _$title(CommunityGroup v) => v.title;
  static const Field<CommunityGroup, String> _f$title = Field('title', _$title);
  static String _$description(CommunityGroup v) => v.description;
  static const Field<CommunityGroup, String> _f$description = Field(
    'description',
    _$description,
  );
  static bool _$isFramed(CommunityGroup v) => v.isFramed;
  static const Field<CommunityGroup, bool> _f$isFramed = Field(
    'isFramed',
    _$isFramed,
    opt: true,
    def: false,
  );
  static bool _$hasSubscribeButton(CommunityGroup v) => v.hasSubscribeButton;
  static const Field<CommunityGroup, bool> _f$hasSubscribeButton = Field(
    'hasSubscribeButton',
    _$hasSubscribeButton,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<CommunityGroup> fields = const {
    #href: _f$href,
    #imgSrc: _f$imgSrc,
    #imgAlt: _f$imgAlt,
    #title: _f$title,
    #description: _f$description,
    #isFramed: _f$isFramed,
    #hasSubscribeButton: _f$hasSubscribeButton,
  };

  static CommunityGroup _instantiate(DecodingData data) {
    return CommunityGroup(
      href: data.dec(_f$href),
      imgSrc: data.dec(_f$imgSrc),
      imgAlt: data.dec(_f$imgAlt),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      isFramed: data.dec(_f$isFramed),
      hasSubscribeButton: data.dec(_f$hasSubscribeButton),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CommunityGroup fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CommunityGroup>(map);
  }

  static CommunityGroup fromJson(String json) {
    return ensureInitialized().decodeJson<CommunityGroup>(json);
  }
}

mixin CommunityGroupMappable {
  String toJson() {
    return CommunityGroupMapper.ensureInitialized().encodeJson<CommunityGroup>(
      this as CommunityGroup,
    );
  }

  Map<String, dynamic> toMap() {
    return CommunityGroupMapper.ensureInitialized().encodeMap<CommunityGroup>(
      this as CommunityGroup,
    );
  }

  CommunityGroupCopyWith<CommunityGroup, CommunityGroup, CommunityGroup>
  get copyWith => _CommunityGroupCopyWithImpl<CommunityGroup, CommunityGroup>(
    this as CommunityGroup,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CommunityGroupMapper.ensureInitialized().stringifyValue(
      this as CommunityGroup,
    );
  }

  @override
  bool operator ==(Object other) {
    return CommunityGroupMapper.ensureInitialized().equalsValue(
      this as CommunityGroup,
      other,
    );
  }

  @override
  int get hashCode {
    return CommunityGroupMapper.ensureInitialized().hashValue(
      this as CommunityGroup,
    );
  }
}

extension CommunityGroupValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CommunityGroup, $Out> {
  CommunityGroupCopyWith<$R, CommunityGroup, $Out> get $asCommunityGroup =>
      $base.as((v, t, t2) => _CommunityGroupCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CommunityGroupCopyWith<$R, $In extends CommunityGroup, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? href,
    String? imgSrc,
    String? imgAlt,
    String? title,
    String? description,
    bool? isFramed,
    bool? hasSubscribeButton,
  });
  CommunityGroupCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CommunityGroupCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CommunityGroup, $Out>
    implements CommunityGroupCopyWith<$R, CommunityGroup, $Out> {
  _CommunityGroupCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CommunityGroup> $mapper =
      CommunityGroupMapper.ensureInitialized();
  @override
  $R call({
    String? href,
    String? imgSrc,
    String? imgAlt,
    String? title,
    String? description,
    bool? isFramed,
    bool? hasSubscribeButton,
  }) => $apply(
    FieldCopyWithData({
      if (href != null) #href: href,
      if (imgSrc != null) #imgSrc: imgSrc,
      if (imgAlt != null) #imgAlt: imgAlt,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (isFramed != null) #isFramed: isFramed,
      if (hasSubscribeButton != null) #hasSubscribeButton: hasSubscribeButton,
    }),
  );
  @override
  CommunityGroup $make(CopyWithData data) => CommunityGroup(
    href: data.get(#href, or: $value.href),
    imgSrc: data.get(#imgSrc, or: $value.imgSrc),
    imgAlt: data.get(#imgAlt, or: $value.imgAlt),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    isFramed: data.get(#isFramed, or: $value.isFramed),
    hasSubscribeButton: data.get(
      #hasSubscribeButton,
      or: $value.hasSubscribeButton,
    ),
  );

  @override
  CommunityGroupCopyWith<$R2, CommunityGroup, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CommunityGroupCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

