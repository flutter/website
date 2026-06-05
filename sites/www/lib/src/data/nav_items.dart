// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import '../models/layout/nav_content.dart';

/// Items to render in the site-wide header.
final List<NavItem> headerNavItems = [
  NavItem(
    label: 'Development',
    href: '/development',
    items: [
      NavLink(label: 'Mobile', href: '/development/mobile'),
      NavLink(label: 'Flutter on iOS', href: '/development/ios'),
      NavLink(label: 'Web', href: '/development/web'),
      NavLink(label: 'Desktop', href: '/development/desktop'),
      NavLink(label: 'Embedded', href: '/development/embedded'),
    ],
    secondColumn: [
      NavLink(label: 'AI', href: '/ai'),
      NavLink(label: 'Google integrations', href: '/google-integrations'),
      NavLink(label: 'Game development', href: '/games'),
      NavLink(label: 'Monetization', href: '/monetization'),
    ],
  ),
  NavItem(
    label: 'Ecosystem',
    href: '/ecosystem',
    items: [
      NavLink(label: 'Community', href: '/community'),
      NavLink(label: 'Culture', href: '/culture'),
      NavLink(label: 'Packages', href: 'https://pub.dev'),
      NavLink(label: 'Events', href: '/events'),
      NavLink(label: 'Consultants', href: '/consultants'),
    ],
  ),
  NavItem(
    label: 'Showcase',
    href: '/showcase',
  ),
  NavItem(
    label: 'Docs',
    href: 'https://docs.flutter.dev',
    items: [
      NavLink(
        label: "What's new",
        href: 'https://docs.flutter.dev/release',
      ),
      NavLink(
        label: 'Editor support',
        href: 'https://docs.flutter.dev/tools/editors',
      ),
      NavLink(
        label: 'Hot reload',
        href: 'https://docs.flutter.dev/tools/hot-reload',
      ),
      NavLink(
        label: 'Profiling',
        href: 'https://docs.flutter.dev/perf/ui-performance',
      ),
    ],
    secondColumn: [
      NavLink(
        label: 'Install Flutter',
        href: 'https://docs.flutter.dev/install',
      ),
      NavLink(
        label: 'App architecture',
        href: 'https://docs.flutter.dev/app-architecture',
      ),
      NavLink(
        label: 'Learning Flutter',
        href: 'https://docs.flutter.dev/learn',
      ),
      NavLink(
        label: 'DevTools',
        href: 'https://docs.flutter.dev/tools/devtools',
      ),
    ],
  ),
  NavItem(
    label: 'Blog',
    href: 'https://blog.flutter.dev',
  ),
];
