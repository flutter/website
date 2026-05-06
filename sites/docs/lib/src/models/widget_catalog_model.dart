extension type WidgetCatalogCategory(Map<String, Object?> _data) {
  String get id =>
      _data['id'] as String? ??
      (throw Exception('Missing id for widget catalog category. '));
  String get name =>
      _data['name'] as String? ??
      (throw Exception('Missing name for widget catalog category. '));
  String get description =>
      _data['description'] as String? ??
      (throw Exception(
        'Missing description for widget catalog category "$name".',
      ));
  List<WidgetCatalogSubcategory> get subcategories {
    final value = _data['subcategories'] as List<Object?>?;
    if (value == null) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(WidgetCatalogSubcategory.new)
        .toList(growable: false);
  }

  String get title =>
      '${name.endsWith('s') ? name.substring(0, name.length - 1) : name}'
      ' widgets';
}

extension type WidgetCatalogSubcategory(Map<String, Object?> _data) {
  String get name => _data['name'] as String? ?? '';
  String? get color => _data['color'] as String?;
}

extension type WidgetCatalogWidget(Map<String, Object?> _data) {
  String get name =>
      _data['name'] as String? ??
      (throw Exception('Missing name for widget catalog widget. '));
  String get description =>
      _data['description'] as String? ??
      (throw Exception(
        'Missing description for widget catalog widget "$name".',
      ));
  String get link =>
      _data['link'] as String? ??
      (throw Exception('Missing link for widget catalog widget "$name".'));
  String? get vector => _data['vector'] as String?;
  String? get imageSrc => switch (_data['image']) {
    {'src': final String src} => src,
    _ => null,
  };
  String? get hoverBackgroundSrc => switch (_data['hoverBackground']) {
    {'src': final String src} => src,
    _ => null,
  };

  List<String> get categories => switch (_data['categories']) {
    final List<Object?> categories => categories.cast<String>(),
    _ => const [],
  };
  List<String> get subcategories => switch (_data['subcategories']) {
    final List<Object?> subcategories => subcategories.cast<String>(),
    _ => const [],
  };
}
