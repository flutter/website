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
import 'package:docs_flutter_dev_site/src/components/common/client/simple_tooltip.dart'
    as prefix9;
import 'package:docs_flutter_dev_site/src/components/dartpad/dartpad_injector.dart'
    as prefix10;
import 'package:docs_flutter_dev_site/src/components/layout/client/pagenav.dart'
    as prefix11;
import 'package:docs_flutter_dev_site/src/components/layout/menu_toggle.dart'
    as prefix12;
import 'package:docs_flutter_dev_site/src/components/layout/site_switcher.dart'
    as prefix13;
import 'package:docs_flutter_dev_site/src/components/layout/theme_switcher.dart'
    as prefix14;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    as prefix15;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    as prefix16;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    as prefix17;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    as prefix18;
import 'package:docs_flutter_dev_site/src/components/tutorial/client/quiz.dart'
    as prefix19;
import 'package:jaspr_content/components/file_tree.dart' as prefix20;

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

    prefix9.SimpleTooltip: ClientTarget<prefix9.SimpleTooltip>(
      'src/components/common/client/simple_tooltip',
      params: _prefix9SimpleTooltip,
    ),

    prefix10.DartPadInjector: ClientTarget<prefix10.DartPadInjector>(
      'src/components/dartpad/dartpad_injector',
      params: _prefix10DartPadInjector,
    ),

    prefix11.PageNav: ClientTarget<prefix11.PageNav>(
      'src/components/layout/client/pagenav',
      params: _prefix11PageNav,
    ),

    prefix12.MenuToggle: ClientTarget<prefix12.MenuToggle>(
      'src/components/layout/menu_toggle',
    ),

    prefix13.SiteSwitcher: ClientTarget<prefix13.SiteSwitcher>(
      'src/components/layout/site_switcher',
    ),

    prefix14.ThemeSwitcher: ClientTarget<prefix14.ThemeSwitcher>(
      'src/components/layout/theme_switcher',
    ),

    prefix15.ArchiveTable: ClientTarget<prefix15.ArchiveTable>(
      'src/components/pages/archive_table',
      params: _prefix15ArchiveTable,
    ),

    prefix16.GlossarySearchSection:
        ClientTarget<prefix16.GlossarySearchSection>(
          'src/components/pages/glossary_search_section',
        ),

    prefix17.LearningResourceFilters:
        ClientTarget<prefix17.LearningResourceFilters>(
          'src/components/pages/learning_resource_filters',
        ),

    prefix18.LearningResourceFiltersSidebar:
        ClientTarget<prefix18.LearningResourceFiltersSidebar>(
          'src/components/pages/learning_resource_filters_sidebar',
        ),

    prefix19.InteractiveQuiz: ClientTarget<prefix19.InteractiveQuiz>(
      'src/components/tutorial/client/quiz',
      params: _prefix19InteractiveQuiz,
    ),
  },
  styles: () => [...prefix20.FileTree.styles],
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
Map<String, dynamic> _prefix9SimpleTooltip(prefix9.SimpleTooltip c) => {
  'target': c.target.toId(),
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix10DartPadInjector(prefix10.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix11PageNav(prefix11.PageNav c) => {
  'breadcrumbs': c.breadcrumbs,
  'initialHeading': c.initialHeading,
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix15ArchiveTable(prefix15.ArchiveTable c) => {
  'os': c.os,
  'channel': c.channel,
};
Map<String, dynamic> _prefix19InteractiveQuiz(prefix19.InteractiveQuiz c) => {
  'title': c.title,
  'questions': c.questions.map((i) => i.toJson()).toList(),
};
