// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../models/diff_entry.dart';
import '../models/diff_manifest.dart';
import '../models/diff_route.dart';
import 'canvas.dart';
import 'header.dart';
import 'shortcuts_dialog.dart';
import 'sidebar.dart';

/// The root interactive Jaspr application for the Visual Diff Reviewer.
class VisualDiffApp extends StatefulComponent {
  final DiffManifest? initialManifest;

  const VisualDiffApp({this.initialManifest, super.key});

  @override
  State<VisualDiffApp> createState() => _VisualDiffAppState();
}

class _VisualDiffAppState extends State<VisualDiffApp> {
  DiffManifest? manifest;
  String? selectedRoutePath;
  String searchQuery = '';
  String statusFilter = 'all';
  String activeViewport = 'desktop';
  ReviewMode currentMode = ReviewMode.swipe;
  bool isDarkMode = true;
  bool showShortcuts = false;
  bool isLoading = true;

  JSFunction? _keydownListener;

  Map<String, DiffRoute> get routeGroups {
    final currentManifest = manifest;
    if (currentManifest == null) return const {};
    return DiffRoute.groupEntries(currentManifest.entries);
  }

  DiffRoute? get selectedRoute {
    final groups = routeGroups;
    if (selectedRoutePath == null) return null;
    return groups[selectedRoutePath];
  }

  DiffEntry? get selectedEntry {
    return selectedRoute?.entryForViewport(activeViewport);
  }

  @override
  void initState() {
    super.initState();
    manifest = component.initialManifest;

    if (manifest != null) {
      isLoading = false;
      _selectInitialRoute();
    } else if (kIsWeb) {
      unawaited(_loadManifestFromNetwork());
    }

    if (kIsWeb) {
      _setupKeyboardListeners();
    }
  }

  void _setupKeyboardListeners() {
    _keydownListener = ((web.KeyboardEvent e) {
      // Don't trigger shortcuts if user is typing in the search box.
      final activeEl = web.document.activeElement;
      final isInputActive =
          activeEl != null &&
          (activeEl.isA<web.HTMLInputElement>() ||
              activeEl.isA<web.HTMLTextAreaElement>());

      if (e.key == '/' && !isInputActive) {
        e.preventDefault();
        (web.document.getElementById('vd-search-input') as web.HTMLElement?)
            ?.focus();
        return;
      }

      if (isInputActive) {
        if (e.key == 'Escape') {
          (activeEl as web.HTMLElement).blur();
        }
        return;
      }

      switch (e.key) {
        case '1':
          setState(() => currentMode = ReviewMode.sideBySide);
        case '2':
          setState(() => currentMode = ReviewMode.swipe);
        case '3':
          setState(() => currentMode = ReviewMode.onionSkin);
        case '4':
          setState(() => currentMode = ReviewMode.diffMask);
        case '5':
          setState(() => currentMode = ReviewMode.toggle);
        case 'v':
        case 'V':
          setState(() {
            activeViewport = activeViewport == 'desktop' ? 'mobile' : 'desktop';
          });
        case 'k':
        case 'ArrowUp':
          e.preventDefault();
          _navigateRelative(-1);
        case 'j':
        case 'ArrowDown':
          e.preventDefault();
          _navigateRelative(1);
        case 't':
        case 'T':
          setState(() => isDarkMode = !isDarkMode);
        case '?':
          setState(() => showShortcuts = !showShortcuts);
        case 'Escape':
          if (showShortcuts) {
            setState(() => showShortcuts = false);
          }
      }
    }).toJS;

    web.window.addEventListener('keydown', _keydownListener!);
  }

  @override
  void dispose() {
    if (kIsWeb && _keydownListener != null) {
      web.window.removeEventListener('keydown', _keydownListener!);
    }
    super.dispose();
  }

  Future<void> _loadManifestFromNetwork() async {
    try {
      final response = await web.window
          .fetch(
            '/diff_manifest.json'.toJS,
          )
          .toDart;

      if (!response.ok) {
        throw StateError('HTTP ${response.status}: Failed to fetch manifest');
      }

      final text = (await response.text().toDart).toDart;
      final json = jsonDecode(text) as Map<String, dynamic>;
      final parsed = DiffManifest.fromJson(json);

      setState(() {
        manifest = parsed;
        isLoading = false;
        _selectInitialRoute();
      });
    } catch (_) {
      // Fallback: If no server manifest exists (e.g. running mock).
      final fallback = _createMockManifest();
      setState(() {
        manifest = fallback;
        isLoading = false;
        _selectInitialRoute();
      });
    }
  }

  Future<void> _updateRouteBaseline(DiffRoute route) async {
    if (!kIsWeb) return;
    try {
      final res = await web.window
          .fetch(
            '/api/update-baseline?route=${Uri.encodeComponent(route.route)}'
                .toJS,
            web.RequestInit(method: 'POST'),
          )
          .toDart;
      if (res.ok) {
        await _loadManifestFromNetwork();
      }
    } catch (_) {}
  }

  void _selectInitialRoute() {
    final routes = filteredRoutes;
    if (routes.isNotEmpty) {
      // Prefer the first changed route, else the first route.
      final changed = routes.where((r) => r.hasDiff);
      selectedRoutePath = changed.isNotEmpty
          ? changed.first.route
          : routes.first.route;
    }
  }

  void _navigateRelative(int delta) {
    final routes = filteredRoutes;
    if (routes.isEmpty) return;

    final currentIndex = selectedRoutePath != null
        ? routes.indexWhere((r) => r.route == selectedRoutePath)
        : -1;

    var newIndex = currentIndex + delta;
    if (newIndex < 0) newIndex = routes.length - 1;
    if (newIndex >= routes.length) newIndex = 0;

    setState(() {
      selectedRoutePath = routes[newIndex].route;
    });
  }

  List<DiffRoute> get filteredRoutes {
    final currentManifest = manifest;
    if (currentManifest == null) return const [];

    final routes = routeGroups.values.where((r) {
      // Status filter
      if (statusFilter != 'all' && r.status.name != statusFilter) {
        return false;
      }

      // Search query filter
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        if (!r.route.toLowerCase().contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();

    // Sort routes: changed first (highest max diff % first),
    // then added, removed, then unchanged.
    routes.sort((routeA, routeB) {
      if (routeA.status != routeB.status) {
        final order = {
          DiffStatus.changed: 0,
          DiffStatus.added: 1,
          DiffStatus.removed: 2,
          DiffStatus.unchanged: 3,
        };
        return (order[routeA.status] ?? 4).compareTo(order[routeB.status] ?? 4);
      }
      return routeB.maxDiffPercentage.compareTo(routeA.maxDiffPercentage);
    });

    return routes;
  }

  @override
  Component build(BuildContext context) {
    final currentManifest = manifest;

    if (isLoading || currentManifest == null) {
      return div(
        attributes: {
          'data-theme': isDarkMode ? 'dark' : 'light',
          'style':
              'display: flex; height: 100vh; width: 100vw; '
              'align-items: center; justify-content: center; '
              'background: var(--vd-bg); color: var(--vd-text-primary);',
        },
        const [
          div(
            attributes: {'style': 'text-align: center; font-size: 14px;'},
            [
              span(
                attributes: {
                  'style':
                      'font-size: 32px; display: block; margin-bottom: 12px;',
                },
                [.text('⌛')],
              ),
              .text('Loading visual diff manifest...'),
            ],
          ),
        ],
      );
    }

    final allRoutesMap = routeGroups;
    final changedRoutesCount = allRoutesMap.values
        .where((r) => r.status == DiffStatus.changed)
        .length;

    return div(
      classes: 'vd-app',
      attributes: {'data-theme': isDarkMode ? 'dark' : 'light'},
      [
        // Header
        HeaderComponent(
          manifest: currentManifest,
          changedRoutesCount: changedRoutesCount,
          currentMode: currentMode,
          onModeChanged: (m) => setState(() => currentMode = m),
          isDarkMode: isDarkMode,
          onToggleTheme: () => setState(() => isDarkMode = !isDarkMode),
          onOpenShortcuts: () => setState(() => showShortcuts = true),
        ),

        // Main Workspace
        div(classes: 'vd-body', [
          SidebarComponent(
            manifest: currentManifest,
            filteredRoutes: filteredRoutes,
            allRoutes: allRoutesMap,
            selectedRoute: selectedRoute,
            onSelectRoute: (r) => setState(() => selectedRoutePath = r.route),
            searchQuery: searchQuery,
            onSearchChanged: (q) => setState(() => searchQuery = q),
            statusFilter: statusFilter,
            onStatusFilterChanged: (f) => setState(() => statusFilter = f),
          ),
          CanvasComponent(
            route: selectedRoute,
            entry: selectedEntry,
            activeViewport: activeViewport,
            onViewportChanged: (vp) => setState(() => activeViewport = vp),
            mode: currentMode,
            onUpdateRouteBaseline: _updateRouteBaseline,
          ),
        ]),

        // Shortcuts modal dialog
        if (showShortcuts)
          ShortcutsDialog(onClose: () => setState(() => showShortcuts = false)),
      ],
    );
  }

  static DiffManifest _createMockManifest() {
    return DiffManifest(
      site: 'docs',
      timestamp: DateTime.now(),
      baseRef: 'main',
      totalCount: 4,
      changedCount: 2,
      addedCount: 1,
      removedCount: 0,
      unchangedCount: 1,
      entries: const [
        DiffEntry(
          id: 'reference__flutter-cli@desktop',
          route: '/reference/flutter-cli',
          viewport: 'desktop',
          filename: 'reference__flutter-cli@desktop.png',
          status: DiffStatus.changed,
          diffPercentage: 1.54,
          diffPixels: 59720,
          totalPixels: 3878400,
          width: 1280,
          height: 3030,
          baselineRelativePath: 'baseline/reference__flutter-cli@desktop.png',
          currentRelativePath: 'current/reference__flutter-cli@desktop.png',
          diffRelativePath: 'diff/reference__flutter-cli@desktop.png',
        ),
        DiffEntry(
          id: 'reference__flutter-cli@mobile',
          route: '/reference/flutter-cli',
          viewport: 'mobile',
          filename: 'reference__flutter-cli@mobile.png',
          status: DiffStatus.changed,
          diffPercentage: 0.82,
          diffPixels: 15420,
          totalPixels: 1878400,
          width: 375,
          height: 2500,
          baselineRelativePath: 'baseline/reference__flutter-cli@mobile.png',
          currentRelativePath: 'current/reference__flutter-cli@mobile.png',
          diffRelativePath: 'diff/reference__flutter-cli@mobile.png',
        ),
        DiffEntry(
          id: 'ui__new-feature@desktop',
          route: '/ui/new-feature',
          viewport: 'desktop',
          filename: 'ui__new-feature@desktop.png',
          status: DiffStatus.added,
          diffPercentage: 100.0,
          diffPixels: 1024000,
          totalPixels: 1024000,
          width: 1280,
          height: 800,
          currentRelativePath: 'current/ui__new-feature@desktop.png',
        ),
        DiffEntry(
          id: '404@desktop',
          route: '/404',
          viewport: 'desktop',
          filename: '404@desktop.png',
          status: DiffStatus.unchanged,
          diffPercentage: 0.0,
          diffPixels: 0,
          totalPixels: 1342720,
          width: 1280,
          height: 1049,
          baselineRelativePath: 'baseline/404@desktop.png',
          currentRelativePath: 'current/404@desktop.png',
        ),
      ],
    );
  }
}
