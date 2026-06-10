// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'showcase_content.dart';

class ShowcaseGoogleAppMapper extends ClassMapperBase<ShowcaseGoogleApp> {
  ShowcaseGoogleAppMapper._();

  static ShowcaseGoogleAppMapper? _instance;
  static ShowcaseGoogleAppMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShowcaseGoogleAppMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShowcaseGoogleApp';

  static String _$title(ShowcaseGoogleApp v) => v.title;
  static const Field<ShowcaseGoogleApp, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$image(ShowcaseGoogleApp v) => v.image;
  static const Field<ShowcaseGoogleApp, String> _f$image = Field(
    'image',
    _$image,
  );
  static String? _$url(ShowcaseGoogleApp v) => v.url;
  static const Field<ShowcaseGoogleApp, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
  );

  @override
  final MappableFields<ShowcaseGoogleApp> fields = const {
    #title: _f$title,
    #image: _f$image,
    #url: _f$url,
  };

  static ShowcaseGoogleApp _instantiate(DecodingData data) {
    return ShowcaseGoogleApp(
      title: data.dec(_f$title),
      image: data.dec(_f$image),
      url: data.dec(_f$url),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShowcaseGoogleApp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShowcaseGoogleApp>(map);
  }

  static ShowcaseGoogleApp fromJson(String json) {
    return ensureInitialized().decodeJson<ShowcaseGoogleApp>(json);
  }
}

mixin ShowcaseGoogleAppMappable {
  String toJson() {
    return ShowcaseGoogleAppMapper.ensureInitialized()
        .encodeJson<ShowcaseGoogleApp>(this as ShowcaseGoogleApp);
  }

  Map<String, dynamic> toMap() {
    return ShowcaseGoogleAppMapper.ensureInitialized()
        .encodeMap<ShowcaseGoogleApp>(this as ShowcaseGoogleApp);
  }

  ShowcaseGoogleAppCopyWith<
    ShowcaseGoogleApp,
    ShowcaseGoogleApp,
    ShowcaseGoogleApp
  >
  get copyWith =>
      _ShowcaseGoogleAppCopyWithImpl<ShowcaseGoogleApp, ShowcaseGoogleApp>(
        this as ShowcaseGoogleApp,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShowcaseGoogleAppMapper.ensureInitialized().stringifyValue(
      this as ShowcaseGoogleApp,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShowcaseGoogleAppMapper.ensureInitialized().equalsValue(
      this as ShowcaseGoogleApp,
      other,
    );
  }

  @override
  int get hashCode {
    return ShowcaseGoogleAppMapper.ensureInitialized().hashValue(
      this as ShowcaseGoogleApp,
    );
  }
}

extension ShowcaseGoogleAppValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShowcaseGoogleApp, $Out> {
  ShowcaseGoogleAppCopyWith<$R, ShowcaseGoogleApp, $Out>
  get $asShowcaseGoogleApp => $base.as(
    (v, t, t2) => _ShowcaseGoogleAppCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ShowcaseGoogleAppCopyWith<
  $R,
  $In extends ShowcaseGoogleApp,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? image, String? url});
  ShowcaseGoogleAppCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShowcaseGoogleAppCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShowcaseGoogleApp, $Out>
    implements ShowcaseGoogleAppCopyWith<$R, ShowcaseGoogleApp, $Out> {
  _ShowcaseGoogleAppCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShowcaseGoogleApp> $mapper =
      ShowcaseGoogleAppMapper.ensureInitialized();
  @override
  $R call({String? title, String? image, Object? url = $none}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (image != null) #image: image,
      if (url != $none) #url: url,
    }),
  );
  @override
  ShowcaseGoogleApp $make(CopyWithData data) => ShowcaseGoogleApp(
    title: data.get(#title, or: $value.title),
    image: data.get(#image, or: $value.image),
    url: data.get(#url, or: $value.url),
  );

  @override
  ShowcaseGoogleAppCopyWith<$R2, ShowcaseGoogleApp, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShowcaseGoogleAppCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShowcaseDemoMapper extends ClassMapperBase<ShowcaseDemo> {
  ShowcaseDemoMapper._();

  static ShowcaseDemoMapper? _instance;
  static ShowcaseDemoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShowcaseDemoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShowcaseDemo';

  static String _$title(ShowcaseDemo v) => v.title;
  static const Field<ShowcaseDemo, String> _f$title = Field('title', _$title);
  static String _$description(ShowcaseDemo v) => v.description;
  static const Field<ShowcaseDemo, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$image(ShowcaseDemo v) => v.image;
  static const Field<ShowcaseDemo, String> _f$image = Field('image', _$image);
  static String _$url(ShowcaseDemo v) => v.url;
  static const Field<ShowcaseDemo, String> _f$url = Field('url', _$url);

  @override
  final MappableFields<ShowcaseDemo> fields = const {
    #title: _f$title,
    #description: _f$description,
    #image: _f$image,
    #url: _f$url,
  };

  static ShowcaseDemo _instantiate(DecodingData data) {
    return ShowcaseDemo(
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      image: data.dec(_f$image),
      url: data.dec(_f$url),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShowcaseDemo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShowcaseDemo>(map);
  }

  static ShowcaseDemo fromJson(String json) {
    return ensureInitialized().decodeJson<ShowcaseDemo>(json);
  }
}

mixin ShowcaseDemoMappable {
  String toJson() {
    return ShowcaseDemoMapper.ensureInitialized().encodeJson<ShowcaseDemo>(
      this as ShowcaseDemo,
    );
  }

  Map<String, dynamic> toMap() {
    return ShowcaseDemoMapper.ensureInitialized().encodeMap<ShowcaseDemo>(
      this as ShowcaseDemo,
    );
  }

  ShowcaseDemoCopyWith<ShowcaseDemo, ShowcaseDemo, ShowcaseDemo> get copyWith =>
      _ShowcaseDemoCopyWithImpl<ShowcaseDemo, ShowcaseDemo>(
        this as ShowcaseDemo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShowcaseDemoMapper.ensureInitialized().stringifyValue(
      this as ShowcaseDemo,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShowcaseDemoMapper.ensureInitialized().equalsValue(
      this as ShowcaseDemo,
      other,
    );
  }

  @override
  int get hashCode {
    return ShowcaseDemoMapper.ensureInitialized().hashValue(
      this as ShowcaseDemo,
    );
  }
}

extension ShowcaseDemoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShowcaseDemo, $Out> {
  ShowcaseDemoCopyWith<$R, ShowcaseDemo, $Out> get $asShowcaseDemo =>
      $base.as((v, t, t2) => _ShowcaseDemoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShowcaseDemoCopyWith<$R, $In extends ShowcaseDemo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? description, String? image, String? url});
  ShowcaseDemoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ShowcaseDemoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShowcaseDemo, $Out>
    implements ShowcaseDemoCopyWith<$R, ShowcaseDemo, $Out> {
  _ShowcaseDemoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShowcaseDemo> $mapper =
      ShowcaseDemoMapper.ensureInitialized();
  @override
  $R call({String? title, String? description, String? image, String? url}) =>
      $apply(
        FieldCopyWithData({
          if (title != null) #title: title,
          if (description != null) #description: description,
          if (image != null) #image: image,
          if (url != null) #url: url,
        }),
      );
  @override
  ShowcaseDemo $make(CopyWithData data) => ShowcaseDemo(
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    image: data.get(#image, or: $value.image),
    url: data.get(#url, or: $value.url),
  );

  @override
  ShowcaseDemoCopyWith<$R2, ShowcaseDemo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShowcaseDemoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShowcaseCompanyMapper extends ClassMapperBase<ShowcaseCompany> {
  ShowcaseCompanyMapper._();

  static ShowcaseCompanyMapper? _instance;
  static ShowcaseCompanyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShowcaseCompanyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShowcaseCompany';

  static String _$name(ShowcaseCompany v) => v.name;
  static const Field<ShowcaseCompany, String> _f$name = Field('name', _$name);
  static String _$logo(ShowcaseCompany v) => v.logo;
  static const Field<ShowcaseCompany, String> _f$logo = Field('logo', _$logo);

  @override
  final MappableFields<ShowcaseCompany> fields = const {
    #name: _f$name,
    #logo: _f$logo,
  };

  static ShowcaseCompany _instantiate(DecodingData data) {
    return ShowcaseCompany(name: data.dec(_f$name), logo: data.dec(_f$logo));
  }

  @override
  final Function instantiate = _instantiate;

  static ShowcaseCompany fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShowcaseCompany>(map);
  }

  static ShowcaseCompany fromJson(String json) {
    return ensureInitialized().decodeJson<ShowcaseCompany>(json);
  }
}

mixin ShowcaseCompanyMappable {
  String toJson() {
    return ShowcaseCompanyMapper.ensureInitialized()
        .encodeJson<ShowcaseCompany>(this as ShowcaseCompany);
  }

  Map<String, dynamic> toMap() {
    return ShowcaseCompanyMapper.ensureInitialized().encodeMap<ShowcaseCompany>(
      this as ShowcaseCompany,
    );
  }

  ShowcaseCompanyCopyWith<ShowcaseCompany, ShowcaseCompany, ShowcaseCompany>
  get copyWith =>
      _ShowcaseCompanyCopyWithImpl<ShowcaseCompany, ShowcaseCompany>(
        this as ShowcaseCompany,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShowcaseCompanyMapper.ensureInitialized().stringifyValue(
      this as ShowcaseCompany,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShowcaseCompanyMapper.ensureInitialized().equalsValue(
      this as ShowcaseCompany,
      other,
    );
  }

  @override
  int get hashCode {
    return ShowcaseCompanyMapper.ensureInitialized().hashValue(
      this as ShowcaseCompany,
    );
  }
}

extension ShowcaseCompanyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShowcaseCompany, $Out> {
  ShowcaseCompanyCopyWith<$R, ShowcaseCompany, $Out> get $asShowcaseCompany =>
      $base.as((v, t, t2) => _ShowcaseCompanyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShowcaseCompanyCopyWith<$R, $In extends ShowcaseCompany, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? logo});
  ShowcaseCompanyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShowcaseCompanyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShowcaseCompany, $Out>
    implements ShowcaseCompanyCopyWith<$R, ShowcaseCompany, $Out> {
  _ShowcaseCompanyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShowcaseCompany> $mapper =
      ShowcaseCompanyMapper.ensureInitialized();
  @override
  $R call({String? name, String? logo}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (logo != null) #logo: logo,
    }),
  );
  @override
  ShowcaseCompany $make(CopyWithData data) => ShowcaseCompany(
    name: data.get(#name, or: $value.name),
    logo: data.get(#logo, or: $value.logo),
  );

  @override
  ShowcaseCompanyCopyWith<$R2, ShowcaseCompany, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShowcaseCompanyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

