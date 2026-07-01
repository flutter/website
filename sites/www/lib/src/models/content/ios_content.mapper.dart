// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ios_content.dart';

class IosTopBrandMapper extends ClassMapperBase<IosTopBrand> {
  IosTopBrandMapper._();

  static IosTopBrandMapper? _instance;
  static IosTopBrandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IosTopBrandMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'IosTopBrand';

  static String _$name(IosTopBrand v) => v.name;
  static const Field<IosTopBrand, String> _f$name = Field('name', _$name);
  static String _$src(IosTopBrand v) => v.src;
  static const Field<IosTopBrand, String> _f$src = Field('src', _$src);
  static String _$href(IosTopBrand v) => v.href;
  static const Field<IosTopBrand, String> _f$href = Field('href', _$href);

  @override
  final MappableFields<IosTopBrand> fields = const {
    #name: _f$name,
    #src: _f$src,
    #href: _f$href,
  };

  static IosTopBrand _instantiate(DecodingData data) {
    return IosTopBrand(
      name: data.dec(_f$name),
      src: data.dec(_f$src),
      href: data.dec(_f$href),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static IosTopBrand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IosTopBrand>(map);
  }

  static IosTopBrand fromJson(String json) {
    return ensureInitialized().decodeJson<IosTopBrand>(json);
  }
}

mixin IosTopBrandMappable {
  String toJson() {
    return IosTopBrandMapper.ensureInitialized().encodeJson<IosTopBrand>(
      this as IosTopBrand,
    );
  }

  Map<String, dynamic> toMap() {
    return IosTopBrandMapper.ensureInitialized().encodeMap<IosTopBrand>(
      this as IosTopBrand,
    );
  }

  IosTopBrandCopyWith<IosTopBrand, IosTopBrand, IosTopBrand> get copyWith =>
      _IosTopBrandCopyWithImpl<IosTopBrand, IosTopBrand>(
        this as IosTopBrand,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return IosTopBrandMapper.ensureInitialized().stringifyValue(
      this as IosTopBrand,
    );
  }

  @override
  bool operator ==(Object other) {
    return IosTopBrandMapper.ensureInitialized().equalsValue(
      this as IosTopBrand,
      other,
    );
  }

  @override
  int get hashCode {
    return IosTopBrandMapper.ensureInitialized().hashValue(this as IosTopBrand);
  }
}

extension IosTopBrandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IosTopBrand, $Out> {
  IosTopBrandCopyWith<$R, IosTopBrand, $Out> get $asIosTopBrand =>
      $base.as((v, t, t2) => _IosTopBrandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class IosTopBrandCopyWith<$R, $In extends IosTopBrand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? src, String? href});
  IosTopBrandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IosTopBrandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IosTopBrand, $Out>
    implements IosTopBrandCopyWith<$R, IosTopBrand, $Out> {
  _IosTopBrandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IosTopBrand> $mapper =
      IosTopBrandMapper.ensureInitialized();
  @override
  $R call({String? name, String? src, String? href}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (src != null) #src: src,
      if (href != null) #href: href,
    }),
  );
  @override
  IosTopBrand $make(CopyWithData data) => IosTopBrand(
    name: data.get(#name, or: $value.name),
    src: data.get(#src, or: $value.src),
    href: data.get(#href, or: $value.href),
  );

  @override
  IosTopBrandCopyWith<$R2, IosTopBrand, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _IosTopBrandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

