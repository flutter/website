// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_content.dart';

class HomeNewsItemMapper extends ClassMapperBase<HomeNewsItem> {
  HomeNewsItemMapper._();

  static HomeNewsItemMapper? _instance;
  static HomeNewsItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeNewsItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HomeNewsItem';

  static String _$title(HomeNewsItem v) => v.title;
  static const Field<HomeNewsItem, String> _f$title = Field('title', _$title);
  static String _$url(HomeNewsItem v) => v.url;
  static const Field<HomeNewsItem, String> _f$url = Field('url', _$url);
  static String _$image(HomeNewsItem v) => v.image;
  static const Field<HomeNewsItem, String> _f$image = Field('image', _$image);
  static String? _$alt(HomeNewsItem v) => v.alt;
  static const Field<HomeNewsItem, String> _f$alt = Field(
    'alt',
    _$alt,
    opt: true,
  );

  @override
  final MappableFields<HomeNewsItem> fields = const {
    #title: _f$title,
    #url: _f$url,
    #image: _f$image,
    #alt: _f$alt,
  };

  static HomeNewsItem _instantiate(DecodingData data) {
    return HomeNewsItem(
      title: data.dec(_f$title),
      url: data.dec(_f$url),
      image: data.dec(_f$image),
      alt: data.dec(_f$alt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeNewsItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeNewsItem>(map);
  }

  static HomeNewsItem fromJson(String json) {
    return ensureInitialized().decodeJson<HomeNewsItem>(json);
  }
}

mixin HomeNewsItemMappable {
  String toJson() {
    return HomeNewsItemMapper.ensureInitialized().encodeJson<HomeNewsItem>(
      this as HomeNewsItem,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeNewsItemMapper.ensureInitialized().encodeMap<HomeNewsItem>(
      this as HomeNewsItem,
    );
  }

  HomeNewsItemCopyWith<HomeNewsItem, HomeNewsItem, HomeNewsItem> get copyWith =>
      _HomeNewsItemCopyWithImpl<HomeNewsItem, HomeNewsItem>(
        this as HomeNewsItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeNewsItemMapper.ensureInitialized().stringifyValue(
      this as HomeNewsItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeNewsItemMapper.ensureInitialized().equalsValue(
      this as HomeNewsItem,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeNewsItemMapper.ensureInitialized().hashValue(
      this as HomeNewsItem,
    );
  }
}

extension HomeNewsItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeNewsItem, $Out> {
  HomeNewsItemCopyWith<$R, HomeNewsItem, $Out> get $asHomeNewsItem =>
      $base.as((v, t, t2) => _HomeNewsItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeNewsItemCopyWith<$R, $In extends HomeNewsItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? url, String? image, String? alt});
  HomeNewsItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeNewsItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeNewsItem, $Out>
    implements HomeNewsItemCopyWith<$R, HomeNewsItem, $Out> {
  _HomeNewsItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeNewsItem> $mapper =
      HomeNewsItemMapper.ensureInitialized();
  @override
  $R call({String? title, String? url, String? image, Object? alt = $none}) =>
      $apply(
        FieldCopyWithData({
          if (title != null) #title: title,
          if (url != null) #url: url,
          if (image != null) #image: image,
          if (alt != $none) #alt: alt,
        }),
      );
  @override
  HomeNewsItem $make(CopyWithData data) => HomeNewsItem(
    title: data.get(#title, or: $value.title),
    url: data.get(#url, or: $value.url),
    image: data.get(#image, or: $value.image),
    alt: data.get(#alt, or: $value.alt),
  );

  @override
  HomeNewsItemCopyWith<$R2, HomeNewsItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeNewsItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

