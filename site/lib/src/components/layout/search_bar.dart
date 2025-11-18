import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../common/dropdown.dart';
import '../common/material_icon.dart';

@client
class SearchBar extends StatefulComponent {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  SearchResponse? activeResult;

  List<SearchResultData> searchResultData = [];

  final inputKey = GlobalNodeKey<web.HTMLInputElement>();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      pagefind.options(ConfigOptions(excerptLength: 15));
    }
  }

  static const pageSize = 10;

  Object? _loadLock;
  Future<void> loadResultPage(int page) async {
    final lock = _loadLock = Object();
    if (activeResult case final result?) {
      for (final r
          in result.results.toDart.skip(page * pageSize).take(pageSize)) {
        final data = await r.data().toDart;
        if (lock != _loadLock) return;
        setState(() {
          searchResultData.add(data);
        });
      }
    }
  }

  void onFocusOut(web.Event event) {
    event as web.FocusEvent;
    if ((event.relatedTarget as web.Element?)?.closest('#search-bar') != null) {
      return;
    }
    setState(() {
      activeResult = null;
      searchResultData = [];
    });
    inputKey.currentNode?.value = '';
  }

  @override
  Component build(BuildContext context) {
    return .fragment([
      Dropdown(
        id: 'search-bar',
        toggle: form(
          id: 'header-search',
          [
            input<String>(
              key: inputKey,
              classes: 'search-field',
              type: InputType.search,
              name: 'q',
              id: 'q',
              attributes: {
                'autocomplete': 'off',
                'placeholder': 'Search',
                'aria-label': 'Search',
              },
              onInput: (query) async {
                final result = await pagefind.debouncedSearch(query).toDart;
                if (result != null) {
                  setState(() {
                    activeResult = result;
                    searchResultData = [];
                  });
                  await loadResultPage(1);
                }
              },
              events: {'focusout': onFocusOut},
            ),
          ],
        ),
        content: div(
          classes: 'search-results',
          events: {'focusout': onFocusOut},
          [
            ul([
              for (final (index, result) in searchResultData.indexed) ...[
                if (index != 0)
                  const li(
                    classes: 'dropdown-divider',
                    attributes: {'aria-hidden': 'true', 'role': 'separator'},
                    [],
                  ),
                li([
                  a(href: result.url, [
                    if (result.meta.breadcrumbs case final breadcrumbs?)
                      span([
                        for (final (index, crumb)
                            in breadcrumbs.split(';').indexed) ...[
                          if (index != 0) const MaterialIcon('chevron_right'),
                          .text(crumb),
                        ],
                      ]),
                    h3([.text(result.meta.title)]),
                    p([
                      RawText(result.excerpt),
                    ]),
                  ]),
                ]),
              ],
            ]),
          ],
        ),
        expanded: searchResultData.isNotEmpty,
      ),
      const a(
        id: 'fallback-search-button',
        classes: 'icon-button',
        href: '/search',
        attributes: {
          'aria-label': 'Navigate to the docs.flutter.dev search page.',
          'title': 'Navigate to the docs.flutter.dev search page.',
        },
        [
          MaterialIcon('search'),
        ],
      ),
    ]);
  }
}

@JS()
external PageFind get pagefind;

extension type PageFind(JSObject object) implements JSObject {
  external JSPromise<JSAny> options(ConfigOptions options);
  external JSPromise<SearchResponse> search(String query);
  external JSPromise<SearchResponse?> debouncedSearch(
    String query, [
    SearchOptions? options,
    int? debounceMs,
  ]);
}

@anonymous
extension type ConfigOptions._(JSObject object) implements JSObject {
  external factory ConfigOptions({
    int? excerptLength,
  });
}

@anonymous
extension type SearchOptions._(JSObject object) implements JSObject {
  external factory SearchOptions();
}

extension type SearchResponse(JSObject object) implements JSObject {
  external JSArray<SearchResult> get results;
}

extension type SearchResult(JSObject object) implements JSObject {
  external String get id;
  external JSPromise<SearchResultData> data();
}

extension type SearchResultData(JSObject object) implements JSObject {
  external String get url;
  external String get excerpt;
  external SearchResultMeta get meta;
}

extension type SearchResultMeta(JSObject object) implements JSObject {
  external String get title;
  external String? get image;
  @JS('image_alt')
  external String? get imageAlt;
  external String? get breadcrumbs;
}
