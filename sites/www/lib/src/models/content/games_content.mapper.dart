// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'games_content.dart';

class GameIntegrationMapper extends ClassMapperBase<GameIntegration> {
  GameIntegrationMapper._();

  static GameIntegrationMapper? _instance;
  static GameIntegrationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameIntegrationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameIntegration';

  static String _$title(GameIntegration v) => v.title;
  static const Field<GameIntegration, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$description(GameIntegration v) => v.description;
  static const Field<GameIntegration, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$url(GameIntegration v) => v.url;
  static const Field<GameIntegration, String> _f$url = Field('url', _$url);
  static String _$image(GameIntegration v) => v.image;
  static const Field<GameIntegration, String> _f$image = Field(
    'image',
    _$image,
  );

  @override
  final MappableFields<GameIntegration> fields = const {
    #title: _f$title,
    #description: _f$description,
    #url: _f$url,
    #image: _f$image,
  };

  static GameIntegration _instantiate(DecodingData data) {
    return GameIntegration(
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      url: data.dec(_f$url),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameIntegration fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameIntegration>(map);
  }

  static GameIntegration fromJson(String json) {
    return ensureInitialized().decodeJson<GameIntegration>(json);
  }
}

mixin GameIntegrationMappable {
  String toJson() {
    return GameIntegrationMapper.ensureInitialized()
        .encodeJson<GameIntegration>(this as GameIntegration);
  }

  Map<String, dynamic> toMap() {
    return GameIntegrationMapper.ensureInitialized().encodeMap<GameIntegration>(
      this as GameIntegration,
    );
  }

  GameIntegrationCopyWith<GameIntegration, GameIntegration, GameIntegration>
  get copyWith =>
      _GameIntegrationCopyWithImpl<GameIntegration, GameIntegration>(
        this as GameIntegration,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameIntegrationMapper.ensureInitialized().stringifyValue(
      this as GameIntegration,
    );
  }

  @override
  bool operator ==(Object other) {
    return GameIntegrationMapper.ensureInitialized().equalsValue(
      this as GameIntegration,
      other,
    );
  }

  @override
  int get hashCode {
    return GameIntegrationMapper.ensureInitialized().hashValue(
      this as GameIntegration,
    );
  }
}

extension GameIntegrationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameIntegration, $Out> {
  GameIntegrationCopyWith<$R, GameIntegration, $Out> get $asGameIntegration =>
      $base.as((v, t, t2) => _GameIntegrationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameIntegrationCopyWith<$R, $In extends GameIntegration, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? description, String? url, String? image});
  GameIntegrationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GameIntegrationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameIntegration, $Out>
    implements GameIntegrationCopyWith<$R, GameIntegration, $Out> {
  _GameIntegrationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameIntegration> $mapper =
      GameIntegrationMapper.ensureInitialized();
  @override
  $R call({String? title, String? description, String? url, String? image}) =>
      $apply(
        FieldCopyWithData({
          if (title != null) #title: title,
          if (description != null) #description: description,
          if (url != null) #url: url,
          if (image != null) #image: image,
        }),
      );
  @override
  GameIntegration $make(CopyWithData data) => GameIntegration(
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    url: data.get(#url, or: $value.url),
    image: data.get(#image, or: $value.image),
  );

  @override
  GameIntegrationCopyWith<$R2, GameIntegration, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameIntegrationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FeaturedGameMapper extends ClassMapperBase<FeaturedGame> {
  FeaturedGameMapper._();

  static FeaturedGameMapper? _instance;
  static FeaturedGameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeaturedGameMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FeaturedGame';

  static String _$title(FeaturedGame v) => v.title;
  static const Field<FeaturedGame, String> _f$title = Field('title', _$title);
  static String _$url(FeaturedGame v) => v.url;
  static const Field<FeaturedGame, String> _f$url = Field('url', _$url);
  static String _$image(FeaturedGame v) => v.image;
  static const Field<FeaturedGame, String> _f$image = Field('image', _$image);

  @override
  final MappableFields<FeaturedGame> fields = const {
    #title: _f$title,
    #url: _f$url,
    #image: _f$image,
  };

  static FeaturedGame _instantiate(DecodingData data) {
    return FeaturedGame(
      title: data.dec(_f$title),
      url: data.dec(_f$url),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FeaturedGame fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeaturedGame>(map);
  }

  static FeaturedGame fromJson(String json) {
    return ensureInitialized().decodeJson<FeaturedGame>(json);
  }
}

mixin FeaturedGameMappable {
  String toJson() {
    return FeaturedGameMapper.ensureInitialized().encodeJson<FeaturedGame>(
      this as FeaturedGame,
    );
  }

  Map<String, dynamic> toMap() {
    return FeaturedGameMapper.ensureInitialized().encodeMap<FeaturedGame>(
      this as FeaturedGame,
    );
  }

  FeaturedGameCopyWith<FeaturedGame, FeaturedGame, FeaturedGame> get copyWith =>
      _FeaturedGameCopyWithImpl<FeaturedGame, FeaturedGame>(
        this as FeaturedGame,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FeaturedGameMapper.ensureInitialized().stringifyValue(
      this as FeaturedGame,
    );
  }

  @override
  bool operator ==(Object other) {
    return FeaturedGameMapper.ensureInitialized().equalsValue(
      this as FeaturedGame,
      other,
    );
  }

  @override
  int get hashCode {
    return FeaturedGameMapper.ensureInitialized().hashValue(
      this as FeaturedGame,
    );
  }
}

extension FeaturedGameValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeaturedGame, $Out> {
  FeaturedGameCopyWith<$R, FeaturedGame, $Out> get $asFeaturedGame =>
      $base.as((v, t, t2) => _FeaturedGameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeaturedGameCopyWith<$R, $In extends FeaturedGame, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? url, String? image});
  FeaturedGameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeaturedGameCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeaturedGame, $Out>
    implements FeaturedGameCopyWith<$R, FeaturedGame, $Out> {
  _FeaturedGameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeaturedGame> $mapper =
      FeaturedGameMapper.ensureInitialized();
  @override
  $R call({String? title, String? url, String? image}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (url != null) #url: url,
      if (image != null) #image: image,
    }),
  );
  @override
  FeaturedGame $make(CopyWithData data) => FeaturedGame(
    title: data.get(#title, or: $value.title),
    url: data.get(#url, or: $value.url),
    image: data.get(#image, or: $value.image),
  );

  @override
  FeaturedGameCopyWith<$R2, FeaturedGame, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FeaturedGameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

