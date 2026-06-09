// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'nav_content.dart';

class NavItemMapper extends ClassMapperBase<NavItem> {
  NavItemMapper._();

  static NavItemMapper? _instance;
  static NavItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NavItemMapper._());
      NavLinkMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NavItem';

  static String _$label(NavItem v) => v.label;
  static const Field<NavItem, String> _f$label = Field('label', _$label);
  static String _$href(NavItem v) => v.href;
  static const Field<NavItem, String> _f$href = Field('href', _$href);
  static List<NavLink> _$items(NavItem v) => v.items;
  static const Field<NavItem, List<NavLink>> _f$items = Field(
    'items',
    _$items,
    opt: true,
    def: const [],
  );
  static List<NavLink>? _$secondColumn(NavItem v) => v.secondColumn;
  static const Field<NavItem, List<NavLink>> _f$secondColumn = Field(
    'secondColumn',
    _$secondColumn,
    opt: true,
  );

  @override
  final MappableFields<NavItem> fields = const {
    #label: _f$label,
    #href: _f$href,
    #items: _f$items,
    #secondColumn: _f$secondColumn,
  };

  static NavItem _instantiate(DecodingData data) {
    return NavItem(
      label: data.dec(_f$label),
      href: data.dec(_f$href),
      items: data.dec(_f$items),
      secondColumn: data.dec(_f$secondColumn),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static NavItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NavItem>(map);
  }

  static NavItem fromJson(String json) {
    return ensureInitialized().decodeJson<NavItem>(json);
  }
}

mixin NavItemMappable {
  String toJson() {
    return NavItemMapper.ensureInitialized().encodeJson<NavItem>(
      this as NavItem,
    );
  }

  Map<String, dynamic> toMap() {
    return NavItemMapper.ensureInitialized().encodeMap<NavItem>(
      this as NavItem,
    );
  }

  NavItemCopyWith<NavItem, NavItem, NavItem> get copyWith =>
      _NavItemCopyWithImpl<NavItem, NavItem>(
        this as NavItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return NavItemMapper.ensureInitialized().stringifyValue(this as NavItem);
  }

  @override
  bool operator ==(Object other) {
    return NavItemMapper.ensureInitialized().equalsValue(
      this as NavItem,
      other,
    );
  }

  @override
  int get hashCode {
    return NavItemMapper.ensureInitialized().hashValue(this as NavItem);
  }
}

extension NavItemValueCopy<$R, $Out> on ObjectCopyWith<$R, NavItem, $Out> {
  NavItemCopyWith<$R, NavItem, $Out> get $asNavItem =>
      $base.as((v, t, t2) => _NavItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NavItemCopyWith<$R, $In extends NavItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, NavLink, NavLinkCopyWith<$R, NavLink, NavLink>> get items;
  ListCopyWith<$R, NavLink, NavLinkCopyWith<$R, NavLink, NavLink>>?
  get secondColumn;
  $R call({
    String? label,
    String? href,
    List<NavLink>? items,
    List<NavLink>? secondColumn,
  });
  NavItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NavItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NavItem, $Out>
    implements NavItemCopyWith<$R, NavItem, $Out> {
  _NavItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NavItem> $mapper =
      NavItemMapper.ensureInitialized();
  @override
  ListCopyWith<$R, NavLink, NavLinkCopyWith<$R, NavLink, NavLink>> get items =>
      ListCopyWith(
        $value.items,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(items: v),
      );
  @override
  ListCopyWith<$R, NavLink, NavLinkCopyWith<$R, NavLink, NavLink>>?
  get secondColumn => $value.secondColumn != null
      ? ListCopyWith(
          $value.secondColumn!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(secondColumn: v),
        )
      : null;
  @override
  $R call({
    String? label,
    String? href,
    List<NavLink>? items,
    Object? secondColumn = $none,
  }) => $apply(
    FieldCopyWithData({
      if (label != null) #label: label,
      if (href != null) #href: href,
      if (items != null) #items: items,
      if (secondColumn != $none) #secondColumn: secondColumn,
    }),
  );
  @override
  NavItem $make(CopyWithData data) => NavItem(
    label: data.get(#label, or: $value.label),
    href: data.get(#href, or: $value.href),
    items: data.get(#items, or: $value.items),
    secondColumn: data.get(#secondColumn, or: $value.secondColumn),
  );

  @override
  NavItemCopyWith<$R2, NavItem, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NavItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class NavLinkMapper extends ClassMapperBase<NavLink> {
  NavLinkMapper._();

  static NavLinkMapper? _instance;
  static NavLinkMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NavLinkMapper._());
      NavLinkMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NavLink';

  static String _$label(NavLink v) => v.label;
  static const Field<NavLink, String> _f$label = Field('label', _$label);
  static String _$href(NavLink v) => v.href;
  static const Field<NavLink, String> _f$href = Field('href', _$href);
  static List<NavLink> _$subItems(NavLink v) => v.subItems;
  static const Field<NavLink, List<NavLink>> _f$subItems = Field(
    'subItems',
    _$subItems,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<NavLink> fields = const {
    #label: _f$label,
    #href: _f$href,
    #subItems: _f$subItems,
  };

  static NavLink _instantiate(DecodingData data) {
    return NavLink(
      label: data.dec(_f$label),
      href: data.dec(_f$href),
      subItems: data.dec(_f$subItems),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static NavLink fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NavLink>(map);
  }

  static NavLink fromJson(String json) {
    return ensureInitialized().decodeJson<NavLink>(json);
  }
}

mixin NavLinkMappable {
  String toJson() {
    return NavLinkMapper.ensureInitialized().encodeJson<NavLink>(
      this as NavLink,
    );
  }

  Map<String, dynamic> toMap() {
    return NavLinkMapper.ensureInitialized().encodeMap<NavLink>(
      this as NavLink,
    );
  }

  NavLinkCopyWith<NavLink, NavLink, NavLink> get copyWith =>
      _NavLinkCopyWithImpl<NavLink, NavLink>(
        this as NavLink,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return NavLinkMapper.ensureInitialized().stringifyValue(this as NavLink);
  }

  @override
  bool operator ==(Object other) {
    return NavLinkMapper.ensureInitialized().equalsValue(
      this as NavLink,
      other,
    );
  }

  @override
  int get hashCode {
    return NavLinkMapper.ensureInitialized().hashValue(this as NavLink);
  }
}

extension NavLinkValueCopy<$R, $Out> on ObjectCopyWith<$R, NavLink, $Out> {
  NavLinkCopyWith<$R, NavLink, $Out> get $asNavLink =>
      $base.as((v, t, t2) => _NavLinkCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NavLinkCopyWith<$R, $In extends NavLink, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, NavLink, NavLinkCopyWith<$R, NavLink, NavLink>> get subItems;
  $R call({String? label, String? href, List<NavLink>? subItems});
  NavLinkCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NavLinkCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NavLink, $Out>
    implements NavLinkCopyWith<$R, NavLink, $Out> {
  _NavLinkCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NavLink> $mapper =
      NavLinkMapper.ensureInitialized();
  @override
  ListCopyWith<$R, NavLink, NavLinkCopyWith<$R, NavLink, NavLink>>
  get subItems => ListCopyWith(
    $value.subItems,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(subItems: v),
  );
  @override
  $R call({String? label, String? href, List<NavLink>? subItems}) => $apply(
    FieldCopyWithData({
      if (label != null) #label: label,
      if (href != null) #href: href,
      if (subItems != null) #subItems: subItems,
    }),
  );
  @override
  NavLink $make(CopyWithData data) => NavLink(
    label: data.get(#label, or: $value.label),
    href: data.get(#href, or: $value.href),
    subItems: data.get(#subItems, or: $value.subItems),
  );

  @override
  NavLinkCopyWith<$R2, NavLink, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NavLinkCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

