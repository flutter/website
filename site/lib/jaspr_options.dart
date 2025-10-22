// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:docs_flutter_dev_site/src/client/global_scripts.dart'
    as prefix0;
import 'package:docs_flutter_dev_site/src/components/client/archive_table.dart'
    as prefix1;
import 'package:docs_flutter_dev_site/src/components/client/dartpad_injector.dart'
    as prefix2;
import 'package:docs_flutter_dev_site/src/components/client/download_latest_button.dart'
    as prefix3;
import 'package:docs_flutter_dev_site/src/components/client/learning_resource_filters.dart'
    as prefix4;
import 'package:docs_flutter_dev_site/src/components/client/learning_resource_filters_sidebar.dart'
    as prefix5;
import 'package:docs_flutter_dev_site/src/components/client/on_this_page_button.dart'
    as prefix6;
import 'package:docs_flutter_dev_site/src/components/header/menu_toggle.dart'
    as prefix7;
import 'package:docs_flutter_dev_site/src/components/header/site_switcher.dart'
    as prefix8;
import 'package:docs_flutter_dev_site/src/components/header/theme_switcher.dart'
    as prefix9;
import 'package:docs_flutter_dev_site/src/components/cookie_notice.dart'
    as prefix10;
import 'package:docs_flutter_dev_site/src/components/copy_button.dart'
    as prefix11;
import 'package:docs_flutter_dev_site/src/components/feedback.dart' as prefix12;
import 'package:docs_flutter_dev_site/src/components/os_selector.dart'
    as prefix13;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
JasprOptions get defaultJasprOptions => JasprOptions(
  clients: {
    prefix0.GlobalScripts: ClientTarget<prefix0.GlobalScripts>(
      'src/client/global_scripts',
    ),

    prefix1.ArchiveTable: ClientTarget<prefix1.ArchiveTable>(
      'src/components/client/archive_table',
      params: _prefix1ArchiveTable,
    ),

    prefix2.DartPadInjector: ClientTarget<prefix2.DartPadInjector>(
      'src/components/client/dartpad_injector',
      params: _prefix2DartPadInjector,
    ),

    prefix3.DownloadLatestButton: ClientTarget<prefix3.DownloadLatestButton>(
      'src/components/client/download_latest_button',
      params: _prefix3DownloadLatestButton,
    ),

    prefix4.LearningResourceFilters:
        ClientTarget<prefix4.LearningResourceFilters>(
          'src/components/client/learning_resource_filters',
        ),

    prefix5.LearningResourceFiltersSidebar:
        ClientTarget<prefix5.LearningResourceFiltersSidebar>(
          'src/components/client/learning_resource_filters_sidebar',
        ),

    prefix6.OnThisPageButton: ClientTarget<prefix6.OnThisPageButton>(
      'src/components/client/on_this_page_button',
    ),

    prefix10.CookieNotice: ClientTarget<prefix10.CookieNotice>(
      'src/components/cookie_notice',
    ),

    prefix11.CopyButton: ClientTarget<prefix11.CopyButton>(
      'src/components/copy_button',
      params: _prefix11CopyButton,
    ),

    prefix12.FeedbackComponent: ClientTarget<prefix12.FeedbackComponent>(
      'src/components/feedback',
      params: _prefix12FeedbackComponent,
    ),

    prefix7.MenuToggle: ClientTarget<prefix7.MenuToggle>(
      'src/components/header/menu_toggle',
    ),

    prefix8.SiteSwitcher: ClientTarget<prefix8.SiteSwitcher>(
      'src/components/header/site_switcher',
    ),

    prefix9.ThemeSwitcher: ClientTarget<prefix9.ThemeSwitcher>(
      'src/components/header/theme_switcher',
    ),

    prefix13.OsSelector: ClientTarget<prefix13.OsSelector>(
      'src/components/os_selector',
    ),
  },
  styles: () => [],
);

Map<String, dynamic> _prefix1ArchiveTable(prefix1.ArchiveTable c) => {
  'os': c.os,
  'channel': c.channel,
};
Map<String, dynamic> _prefix2DartPadInjector(prefix2.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix3DownloadLatestButton(
  prefix3.DownloadLatestButton c,
) => {'os': c.os, 'arch': c.arch};
Map<String, dynamic> _prefix11CopyButton(prefix11.CopyButton c) => {
  'toCopy': c.toCopy,
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix12FeedbackComponent(prefix12.FeedbackComponent c) =>
    {'issueUrl': c.issueUrl};
