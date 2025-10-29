// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:docs_flutter_dev_site/src/client/global_scripts.dart'
    as prefix0;
import 'package:docs_flutter_dev_site/src/components/common/client/cookie_notice.dart'
    as prefix1;
import 'package:docs_flutter_dev_site/src/components/common/client/copy_button.dart'
    as prefix2;
import 'package:docs_flutter_dev_site/src/components/common/client/download_latest_button.dart'
    as prefix3;
import 'package:docs_flutter_dev_site/src/components/common/client/feedback.dart'
    as prefix4;
import 'package:docs_flutter_dev_site/src/components/common/client/on_this_page_button.dart'
    as prefix5;
import 'package:docs_flutter_dev_site/src/components/common/client/os_selector.dart'
    as prefix6;
import 'package:docs_flutter_dev_site/src/components/dartpad/dartpad_injector.dart'
    as prefix7;
import 'package:docs_flutter_dev_site/src/components/layout/menu_toggle.dart'
    as prefix8;
import 'package:docs_flutter_dev_site/src/components/layout/site_switcher.dart'
    as prefix9;
import 'package:docs_flutter_dev_site/src/components/layout/theme_switcher.dart'
    as prefix10;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    as prefix11;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    as prefix12;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    as prefix13;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    as prefix14;

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

    prefix1.CookieNotice: ClientTarget<prefix1.CookieNotice>(
      'src/components/common/client/cookie_notice',
    ),

    prefix2.CopyButton: ClientTarget<prefix2.CopyButton>(
      'src/components/common/client/copy_button',
      params: _prefix2CopyButton,
    ),

    prefix3.DownloadLatestButton: ClientTarget<prefix3.DownloadLatestButton>(
      'src/components/common/client/download_latest_button',
      params: _prefix3DownloadLatestButton,
    ),

    prefix4.FeedbackComponent: ClientTarget<prefix4.FeedbackComponent>(
      'src/components/common/client/feedback',
      params: _prefix4FeedbackComponent,
    ),

    prefix5.OnThisPageButton: ClientTarget<prefix5.OnThisPageButton>(
      'src/components/common/client/on_this_page_button',
    ),

    prefix6.OsSelector: ClientTarget<prefix6.OsSelector>(
      'src/components/common/client/os_selector',
    ),

    prefix7.DartPadInjector: ClientTarget<prefix7.DartPadInjector>(
      'src/components/dartpad/dartpad_injector',
      params: _prefix7DartPadInjector,
    ),

    prefix8.MenuToggle: ClientTarget<prefix8.MenuToggle>(
      'src/components/layout/menu_toggle',
    ),

    prefix9.SiteSwitcher: ClientTarget<prefix9.SiteSwitcher>(
      'src/components/layout/site_switcher',
    ),

    prefix10.ThemeSwitcher: ClientTarget<prefix10.ThemeSwitcher>(
      'src/components/layout/theme_switcher',
    ),

    prefix11.ArchiveTable: ClientTarget<prefix11.ArchiveTable>(
      'src/components/pages/archive_table',
      params: _prefix11ArchiveTable,
    ),

    prefix12.GlossarySearchSection:
        ClientTarget<prefix12.GlossarySearchSection>(
          'src/components/pages/glossary_search_section',
        ),

    prefix13.LearningResourceFilters:
        ClientTarget<prefix13.LearningResourceFilters>(
          'src/components/pages/learning_resource_filters',
        ),

    prefix14.LearningResourceFiltersSidebar:
        ClientTarget<prefix14.LearningResourceFiltersSidebar>(
          'src/components/pages/learning_resource_filters_sidebar',
        ),
  },
  styles: () => [],
);

Map<String, dynamic> _prefix2CopyButton(prefix2.CopyButton c) => {
  'toCopy': c.toCopy,
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix3DownloadLatestButton(
  prefix3.DownloadLatestButton c,
) => {'os': c.os, 'arch': c.arch};
Map<String, dynamic> _prefix4FeedbackComponent(prefix4.FeedbackComponent c) => {
  'issueUrl': c.issueUrl,
};
Map<String, dynamic> _prefix7DartPadInjector(prefix7.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix11ArchiveTable(prefix11.ArchiveTable c) => {
  'os': c.os,
  'channel': c.channel,
};
