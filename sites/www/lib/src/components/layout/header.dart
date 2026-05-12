// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../data/nav_items.dart';
import '../../models/content/banner_content.dart';
import '../../models/layout/nav_content.dart';
import '../../utils/scroll_spy.dart';
import '../common/icon.dart';
import 'banner.dart';

@client
class Header extends StatefulComponent {
  const Header({
    super.key,
    required this.contrastLogoSrc,
    required this.defaultLogoSrc,
    required this.banner,
    required this.pageUrl,
  });

  final String contrastLogoSrc;
  final String defaultLogoSrc;
  final BannerContent banner;
  final String pageUrl;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // TODO: This state should be handled outside this component,
  //  and handled with CSS.
  bool _inHomeHero = false;
  bool _navOpen = false;
  bool _searchActive = false;
  bool _isMobile = false;
  String? _expandedMenuKey;
  StreamSubscription<void>? _resizeSubscription;

  void _toggleMobileNav() {
    setState(() {
      _navOpen = !_navOpen;

      // Close the search field when toggling nav.
      _searchActive = false;
      if (kIsWeb) {
        web.document.body?.style.overflow = _navOpen ? 'hidden' : 'auto';
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      _searchActive = !_searchActive;
      if (_searchActive) {
        // Focus search input after small delay
        if (kIsWeb) {
          Future<void>.delayed(const Duration(milliseconds: 100), () {
            (web.document.getElementById('q') as web.HTMLInputElement?)
                ?.focus();
          });
        }
      }
    });
  }

  void _handleMobileClick(String key, web.Event e) {
    if (!_isMobile) return;

    e.preventDefault();
    setState(() {
      _expandedMenuKey = _expandedMenuKey == key ? null : key;
    });
  }

  /// Checks if any internal path within [item] matches the current page.
  bool _isActive(NavItem item) {
    final pageUrl = component.pageUrl;
    if (_matchesPage(item.href, pageUrl)) return true;

    for (final link in [...item.items, ...?item.secondColumn]) {
      if (_matchesPage(link.href, pageUrl)) return true;
      for (final subItem in link.subItems) {
        if (_matchesPage(subItem.href, pageUrl)) return true;
      }
    }
    return false;
  }

  void _onResize(web.Event e) {
    final wasMobile = _isMobile;
    _updateIsMobile();
    if (!_isMobile && _navOpen) {
      // If the navigation menu is open and the window is
      // no longer mobile width, close the navigation menu.
      _toggleMobileNav();
    } else if (_isMobile != wasMobile) {
      setState(() {});
    }
  }

  void _updateIsMobile() {
    _isMobile = kIsWeb && web.window.innerWidth < 1024;
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _updateIsMobile();
      _resizeSubscription = web.EventStreamProviders.resizeEvent
          .forTarget(web.window)
          .listen(_onResize);
      scroll.addListener(_onScrollChanged);
    }
  }

  @override
  void dispose() {
    if (_resizeSubscription case final resizeSubscription?) {
      unawaited(resizeSubscription.cancel());
    }
    scroll.removeListener(_onScrollChanged);
    super.dispose();
  }

  void _onScrollChanged() {
    setState(() {
      _inHomeHero = scroll.activeIds.contains(ScrollId.inHero);
    });
  }

  @override
  Component build(BuildContext context) {
    final headerClasses = [
      if (!_navOpen && _inHomeHero) 'hide',
      if (_isMobile) 'mobile',
      if (_isMobile && _navOpen) 'mobile-nav-open',
      if (_searchActive) 'searching',
      'site-header',
    ].join(' ');

    return header(
      classes: headerClasses,
      attributes: const {'role': 'banner'},
      [
        Banner(banner: component.banner),
        div(classes: 'content', [
          div([
            div(classes: 'logo logo-contrast', [
              a(href: '/', [
                img(src: component.contrastLogoSrc, alt: 'Flutter'),
              ]),
            ]),
            div(classes: 'logo logo-default', [
              a(href: '/', [
                img(src: component.defaultLogoSrc, alt: 'Flutter'),
              ]),
            ]),
          ]),
          div(classes: 'tray', [
            nav(
              attributes: const {'role': 'navigation'},
              [
                ul([
                  for (final item in headerNavItems)
                    _NavEntry(
                      data: item,
                      isActive: _isActive(item),
                      isExpanded: _isMobile && _expandedMenuKey == item.id,
                      onMobileClick: item.hasDropdown
                          ? (e) => _handleMobileClick(item.id, e)
                          : null,
                      pageUrl: component.pageUrl,
                    ),
                ]),
              ],
            ),
            div(
              classes: [
                'icon-btn',
                'search',
                if (_navOpen || _searchActive) 'active',
              ].join(' '),
              [
                span(
                  events: {'click': (_) => _toggleSearch()},
                  const [
                    Icon(symbol: 'search'),
                  ],
                ),
                const form(action: 'https://docs.flutter.dev/search', [
                  input(
                    type: InputType.text,
                    attributes: {
                      'placeholder': 'Search...',
                      'aria-label': 'Search',
                      'name': 'q',
                      'id': 'q',
                      'autocomplete': 'off',
                    },
                  ),
                ]),
                if (_searchActive)
                  span(
                    events: {'click': (_) => _toggleSearch()},
                    const [Icon(symbol: 'close')],
                  ),
              ],
            ),
            const a(
              href: 'https://docs.flutter.dev/get-started/quick',
              id: 'get-started__header',
              classes: 'btn',
              [.text('Get started')],
            ),
            if (!_navOpen)
              button(
                classes: 'icon-btn hamburger',
                events: {'click': (_) => _toggleMobileNav()},
                const [
                  Icon(
                    symbol: 'menu',
                    label: 'Open navigation menu',
                    size: .md,
                  ),
                ],
              ),
            if (_navOpen)
              button(
                classes: 'icon-btn close',
                events: {'click': (_) => _toggleMobileNav()},
                const [
                  Icon(
                    symbol: 'close',
                    label: 'Close navigation menu',
                    size: .md,
                  ),
                ],
              ),
          ]),
        ]),
      ],
    );
  }
}

/// Whether [path] matches [pageUrl] for active-state highlighting.
bool _matchesPage(String path, String pageUrl) {
  if (path.startsWith('http')) return false;
  if (path == '/') return pageUrl == '/';
  return pageUrl == path || pageUrl.startsWith('$path/');
}

/// A top-level navigation entry in the header.
class _NavEntry extends StatelessComponent {
  const _NavEntry({
    required this.data,
    this.isActive = false,
    this.isExpanded = false,
    this.onMobileClick,
    required this.pageUrl,
  });

  final NavItem data;
  final bool isActive;
  final bool isExpanded;
  final void Function(web.Event)? onMobileClick;
  final String pageUrl;

  @override
  Component build(BuildContext context) {
    if (!data.hasDropdown) {
      return li([
        a(
          href: data.href,
          classes: ['btn', 'top-level', if (isActive) 'active'].join(' '),
          [.text(data.label)],
        ),
      ]);
    }

    return li(
      classes: isExpanded ? 'selected' : null,
      [
        a(
          href: data.href,
          classes: ['btn', 'top-level', if (isActive) 'active'].join(' '),
          events: {
            'click': ?onMobileClick,
          },
          [
            .text('${data.label} '),
            const Icon(symbol: 'arrow_drop_down', size: .md),
          ],
        ),
        const div(classes: 'dd-connector', []),
        div(
          classes: ['dd', if (data.secondColumn != null) 'dd-double'].join(' '),
          [
            ul([
              _NavDropdownLink(
                NavLink(
                  label: 'Overview',
                  href: data.href,
                ),
                mobileOnly: true,
                pageUrl: pageUrl,
              ),
              for (final link in data.items)
                _NavDropdownLink(link, pageUrl: pageUrl),
            ]),
            if (data.secondColumn case final secondColumn?)
              ul([
                for (final link in secondColumn)
                  _NavDropdownLink(link, pageUrl: pageUrl),
              ]),
          ],
        ),
      ],
    );
  }
}

/// A link within a navigation dropdown menu.
class _NavDropdownLink extends StatelessComponent {
  const _NavDropdownLink(
    this.link, {
    this.mobileOnly = false,
    this.isNested = false,
    required this.pageUrl,
  });

  final NavLink link;
  final bool mobileOnly;
  final bool isNested;
  final String pageUrl;

  @override
  Component build(BuildContext context) {
    return li(
      classes: mobileOnly ? 'mobile-only' : null,
      [
        a(
          classes: [
            'btn',
            if (isNested) 'subMenu',
            if (pageUrl == link.href) 'active',
          ].join(' '),
          href: link.href,
          target: link.isExternal ? Target.blank : null,
          [.text(link.label)],
        ),
        if (link.subItems.isNotEmpty)
          ul([
            for (final subItem in link.subItems)
              _NavDropdownLink(subItem, isNested: true, pageUrl: pageUrl),
          ]),
      ],
    );
  }
}
