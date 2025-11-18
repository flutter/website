// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:docs_flutter_dev_site/src/client/global_scripts.dart'
    as prefix0;
import 'package:docs_flutter_dev_site/src/components/common/client/api_link_tooltip.dart'
    as prefix1;
import 'package:docs_flutter_dev_site/src/components/common/client/cookie_notice.dart'
    as prefix2;
import 'package:docs_flutter_dev_site/src/components/common/client/copy_button.dart'
    as prefix3;
import 'package:docs_flutter_dev_site/src/components/common/client/download_latest_button.dart'
    as prefix4;
import 'package:docs_flutter_dev_site/src/components/common/client/feedback.dart'
    as prefix5;
import 'package:docs_flutter_dev_site/src/components/common/client/on_this_page_button.dart'
    as prefix6;
import 'package:docs_flutter_dev_site/src/components/common/client/os_selector.dart'
    as prefix7;
import 'package:docs_flutter_dev_site/src/components/common/client/simple_tooltip.dart'
    as prefix8;
import 'package:docs_flutter_dev_site/src/components/dartpad/dartpad_injector.dart'
    as prefix9;
import 'package:docs_flutter_dev_site/src/components/layout/client/pagenav.dart'
    as prefix10;
import 'package:docs_flutter_dev_site/src/components/layout/menu_toggle.dart'
    as prefix11;
import 'package:docs_flutter_dev_site/src/components/layout/site_switcher.dart'
    as prefix12;
import 'package:docs_flutter_dev_site/src/components/layout/theme_switcher.dart'
    as prefix13;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    as prefix14;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    as prefix15;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    as prefix16;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    as prefix17;
import 'package:docs_flutter_dev_site/src/components/tutorial/client/quiz.dart'
    as prefix18;
import 'package:jaspr_content/components/file_tree.dart' as prefix19;

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

    prefix1.ApiLinkTooltip: ClientTarget<prefix1.ApiLinkTooltip>(
      'src/components/common/client/api_link_tooltip',
      params: _prefix1ApiLinkTooltip,
    ),

    prefix2.CookieNotice: ClientTarget<prefix2.CookieNotice>(
      'src/components/common/client/cookie_notice',
    ),

    prefix3.CopyButton: ClientTarget<prefix3.CopyButton>(
      'src/components/common/client/copy_button',
      params: _prefix3CopyButton,
    ),

    prefix4.DownloadLatestButton: ClientTarget<prefix4.DownloadLatestButton>(
      'src/components/common/client/download_latest_button',
      params: _prefix4DownloadLatestButton,
    ),

    prefix5.FeedbackComponent: ClientTarget<prefix5.FeedbackComponent>(
      'src/components/common/client/feedback',
      params: _prefix5FeedbackComponent,
    ),

    prefix6.OnThisPageButton: ClientTarget<prefix6.OnThisPageButton>(
      'src/components/common/client/on_this_page_button',
    ),

    prefix7.OsSelector: ClientTarget<prefix7.OsSelector>(
      'src/components/common/client/os_selector',
    ),

    prefix8.SimpleTooltip: ClientTarget<prefix8.SimpleTooltip>(
      'src/components/common/client/simple_tooltip',
      params: _prefix8SimpleTooltip,
    ),

    prefix9.DartPadInjector: ClientTarget<prefix9.DartPadInjector>(
      'src/components/dartpad/dartpad_injector',
      params: _prefix9DartPadInjector,
    ),

    prefix10.PageNav: ClientTarget<prefix10.PageNav>(
      'src/components/layout/client/pagenav',
      params: _prefix10PageNav,
    ),

    prefix11.MenuToggle: ClientTarget<prefix11.MenuToggle>(
      'src/components/layout/menu_toggle',
    ),

    prefix12.SiteSwitcher: ClientTarget<prefix12.SiteSwitcher>(
      'src/components/layout/site_switcher',
    ),

    prefix13.ThemeSwitcher: ClientTarget<prefix13.ThemeSwitcher>(
      'src/components/layout/theme_switcher',
    ),

    prefix14.ArchiveTable: ClientTarget<prefix14.ArchiveTable>(
      'src/components/pages/archive_table',
      params: _prefix14ArchiveTable,
    ),

    prefix15.GlossarySearchSection:
        ClientTarget<prefix15.GlossarySearchSection>(
          'src/components/pages/glossary_search_section',
        ),

    prefix16.LearningResourceFilters:
        ClientTarget<prefix16.LearningResourceFilters>(
          'src/components/pages/learning_resource_filters',
        ),

    prefix17.LearningResourceFiltersSidebar:
        ClientTarget<prefix17.LearningResourceFiltersSidebar>(
          'src/components/pages/learning_resource_filters_sidebar',
        ),

    prefix18.InteractiveQuiz: ClientTarget<prefix18.InteractiveQuiz>(
      'src/components/tutorial/client/quiz',
      params: _prefix18InteractiveQuiz,
    ),
  },
  styles: () => [...prefix19.FileTree.styles],
);

Map<String, dynamic> _prefix1ApiLinkTooltip(prefix1.ApiLinkTooltip c) => {
  'url': c.url,
  'text': c.text,
};
Map<String, dynamic> _prefix3CopyButton(prefix3.CopyButton c) => {
  'toCopy': c.toCopy,
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix4DownloadLatestButton(
  prefix4.DownloadLatestButton c,
) => {'os': c.os, 'arch': c.arch};
Map<String, dynamic> _prefix5FeedbackComponent(prefix5.FeedbackComponent c) => {
  'issueUrl': c.issueUrl,
};
Map<String, dynamic> _prefix8SimpleTooltip(prefix8.SimpleTooltip c) => {
  'target': c.target.toId(),
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix9DartPadInjector(prefix9.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix10PageNav(prefix10.PageNav c) => {
  'title': c.title,
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix14ArchiveTable(prefix14.ArchiveTable c) => {
  'os': c.os,
  'channel': c.channel,
};
Map<String, dynamic> _prefix18InteractiveQuiz(prefix18.InteractiveQuiz c) => {
  'title': c.title,
  'questions': c.questions.map((i) => i.toJson()).toList(),
};
