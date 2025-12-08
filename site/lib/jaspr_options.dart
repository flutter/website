// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:docs_flutter_dev_site/src/client/global_scripts.dart'
    as prefix0;
import 'package:docs_flutter_dev_site/src/components/common/client/collapse_button.dart'
    as prefix1;
import 'package:docs_flutter_dev_site/src/components/common/client/cookie_notice.dart'
    as prefix2;
import 'package:docs_flutter_dev_site/src/components/common/client/copy_button.dart'
    as prefix3;
import 'package:docs_flutter_dev_site/src/components/common/client/download_button.dart'
    as prefix4;
import 'package:docs_flutter_dev_site/src/components/common/client/download_latest_button.dart'
    as prefix5;
import 'package:docs_flutter_dev_site/src/components/common/client/feedback.dart'
    as prefix6;
import 'package:docs_flutter_dev_site/src/components/common/client/on_this_page_button.dart'
    as prefix7;
import 'package:docs_flutter_dev_site/src/components/common/client/os_selector.dart'
    as prefix8;
import 'package:docs_flutter_dev_site/src/components/common/client/page_header_options.dart'
    as prefix9;
import 'package:docs_flutter_dev_site/src/components/common/client/simple_tooltip.dart'
    as prefix10;
import 'package:docs_flutter_dev_site/src/components/dartpad/dartpad_injector.dart'
    as prefix11;
import 'package:docs_flutter_dev_site/src/components/layout/client/pagenav.dart'
    as prefix12;
import 'package:docs_flutter_dev_site/src/components/layout/menu_toggle.dart'
    as prefix13;
import 'package:docs_flutter_dev_site/src/components/layout/site_switcher.dart'
    as prefix14;
import 'package:docs_flutter_dev_site/src/components/layout/theme_switcher.dart'
    as prefix15;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    as prefix16;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    as prefix17;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    as prefix18;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    as prefix19;
import 'package:docs_flutter_dev_site/src/components/tutorial/client/quiz.dart'
    as prefix20;
import 'package:jaspr_content/components/file_tree.dart' as prefix21;

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

    prefix1.CollapseButton: ClientTarget<prefix1.CollapseButton>(
      'src/components/common/client/collapse_button',
      params: _prefix1CollapseButton,
    ),

    prefix2.CookieNotice: ClientTarget<prefix2.CookieNotice>(
      'src/components/common/client/cookie_notice',
    ),

    prefix3.CopyButton: ClientTarget<prefix3.CopyButton>(
      'src/components/common/client/copy_button',
      params: _prefix3CopyButton,
    ),

    prefix4.DownloadButton: ClientTarget<prefix4.DownloadButton>(
      'src/components/common/client/download_button',
      params: _prefix4DownloadButton,
    ),

    prefix5.DownloadLatestButton: ClientTarget<prefix5.DownloadLatestButton>(
      'src/components/common/client/download_latest_button',
      params: _prefix5DownloadLatestButton,
    ),

    prefix6.FeedbackComponent: ClientTarget<prefix6.FeedbackComponent>(
      'src/components/common/client/feedback',
      params: _prefix6FeedbackComponent,
    ),

    prefix7.OnThisPageButton: ClientTarget<prefix7.OnThisPageButton>(
      'src/components/common/client/on_this_page_button',
    ),

    prefix8.OsSelector: ClientTarget<prefix8.OsSelector>(
      'src/components/common/client/os_selector',
    ),

    prefix9.PageHeaderOptions: ClientTarget<prefix9.PageHeaderOptions>(
      'src/components/common/client/page_header_options',
      params: _prefix9PageHeaderOptions,
    ),

    prefix10.SimpleTooltip: ClientTarget<prefix10.SimpleTooltip>(
      'src/components/common/client/simple_tooltip',
      params: _prefix10SimpleTooltip,
    ),

    prefix11.DartPadInjector: ClientTarget<prefix11.DartPadInjector>(
      'src/components/dartpad/dartpad_injector',
      params: _prefix11DartPadInjector,
    ),

    prefix12.PageNav: ClientTarget<prefix12.PageNav>(
      'src/components/layout/client/pagenav',
      params: _prefix12PageNav,
    ),

    prefix13.MenuToggle: ClientTarget<prefix13.MenuToggle>(
      'src/components/layout/menu_toggle',
    ),

    prefix14.SiteSwitcher: ClientTarget<prefix14.SiteSwitcher>(
      'src/components/layout/site_switcher',
    ),

    prefix15.ThemeSwitcher: ClientTarget<prefix15.ThemeSwitcher>(
      'src/components/layout/theme_switcher',
    ),

    prefix16.ArchiveTable: ClientTarget<prefix16.ArchiveTable>(
      'src/components/pages/archive_table',
      params: _prefix16ArchiveTable,
    ),

    prefix17.GlossarySearchSection:
        ClientTarget<prefix17.GlossarySearchSection>(
          'src/components/pages/glossary_search_section',
        ),

    prefix18.LearningResourceFilters:
        ClientTarget<prefix18.LearningResourceFilters>(
          'src/components/pages/learning_resource_filters',
        ),

    prefix19.LearningResourceFiltersSidebar:
        ClientTarget<prefix19.LearningResourceFiltersSidebar>(
          'src/components/pages/learning_resource_filters_sidebar',
        ),

    prefix20.InteractiveQuiz: ClientTarget<prefix20.InteractiveQuiz>(
      'src/components/tutorial/client/quiz',
      params: _prefix20InteractiveQuiz,
    ),
  },
  styles: () => [...prefix21.FileTree.styles],
);

Map<String, dynamic> _prefix1CollapseButton(prefix1.CollapseButton c) => {
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix3CopyButton(prefix3.CopyButton c) => {
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix4DownloadButton(prefix4.DownloadButton c) => {
  'name': c.name,
};
Map<String, dynamic> _prefix5DownloadLatestButton(
  prefix5.DownloadLatestButton c,
) => {'os': c.os, 'arch': c.arch};
Map<String, dynamic> _prefix6FeedbackComponent(prefix6.FeedbackComponent c) => {
  'issueUrl': c.issueUrl,
};
Map<String, dynamic> _prefix9PageHeaderOptions(prefix9.PageHeaderOptions c) => {
  'title': c.title,
  'sourceUrl': c.sourceUrl,
  'issueUrl': c.issueUrl,
};
Map<String, dynamic> _prefix10SimpleTooltip(prefix10.SimpleTooltip c) => {
  'target': c.target.toId(),
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix11DartPadInjector(prefix11.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix12PageNav(prefix12.PageNav c) => {
  'breadcrumbs': c.breadcrumbs,
  'pageNumber': c.pageNumber,
  'initialHeading': c.initialHeading,
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix16ArchiveTable(prefix16.ArchiveTable c) => {
  'os': c.os,
  'channel': c.channel,
};
Map<String, dynamic> _prefix20InteractiveQuiz(prefix20.InteractiveQuiz c) => {
  'title': c.title,
  'questions': c.questions.map((i) => i.toJson()).toList(),
};
