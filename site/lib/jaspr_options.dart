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
import 'package:docs_flutter_dev_site/src/components/common/client/simple_tooltip.dart'
    as prefix7;
import 'package:docs_flutter_dev_site/src/components/dartpad/dartpad_injector.dart'
    as prefix8;
import 'package:docs_flutter_dev_site/src/components/layout/client/pagenav.dart'
    as prefix9;
import 'package:docs_flutter_dev_site/src/components/layout/menu_toggle.dart'
    as prefix10;
import 'package:docs_flutter_dev_site/src/components/layout/site_switcher.dart'
    as prefix11;
import 'package:docs_flutter_dev_site/src/components/layout/theme_switcher.dart'
    as prefix12;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    as prefix13;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    as prefix14;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    as prefix15;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    as prefix16;
import 'package:docs_flutter_dev_site/src/components/tutorial/client/quiz.dart'
    as prefix17;
import 'package:jaspr_content/components/file_tree.dart' as prefix18;

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

    prefix7.SimpleTooltip: ClientTarget<prefix7.SimpleTooltip>(
      'src/components/common/client/simple_tooltip',
      params: _prefix7SimpleTooltip,
    ),

    prefix8.DartPadInjector: ClientTarget<prefix8.DartPadInjector>(
      'src/components/dartpad/dartpad_injector',
      params: _prefix8DartPadInjector,
    ),

    prefix9.PageNav: ClientTarget<prefix9.PageNav>(
      'src/components/layout/client/pagenav',
      params: _prefix9PageNav,
    ),

    prefix10.MenuToggle: ClientTarget<prefix10.MenuToggle>(
      'src/components/layout/menu_toggle',
    ),

    prefix11.SiteSwitcher: ClientTarget<prefix11.SiteSwitcher>(
      'src/components/layout/site_switcher',
    ),

    prefix12.ThemeSwitcher: ClientTarget<prefix12.ThemeSwitcher>(
      'src/components/layout/theme_switcher',
    ),

    prefix13.ArchiveTable: ClientTarget<prefix13.ArchiveTable>(
      'src/components/pages/archive_table',
      params: _prefix13ArchiveTable,
    ),

    prefix14.GlossarySearchSection:
        ClientTarget<prefix14.GlossarySearchSection>(
          'src/components/pages/glossary_search_section',
        ),

    prefix15.LearningResourceFilters:
        ClientTarget<prefix15.LearningResourceFilters>(
          'src/components/pages/learning_resource_filters',
        ),

    prefix16.LearningResourceFiltersSidebar:
        ClientTarget<prefix16.LearningResourceFiltersSidebar>(
          'src/components/pages/learning_resource_filters_sidebar',
        ),

    prefix17.InteractiveQuiz: ClientTarget<prefix17.InteractiveQuiz>(
      'src/components/tutorial/client/quiz',
      params: _prefix17InteractiveQuiz,
    ),
  },
  styles: () => [...prefix18.FileTree.styles],
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
Map<String, dynamic> _prefix7SimpleTooltip(prefix7.SimpleTooltip c) => {
  'target': c.target.toId(),
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix8DartPadInjector(prefix8.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix9PageNav(prefix9.PageNav c) => {
  'title': c.title,
  'content': c.content.toId(),
};
Map<String, dynamic> _prefix13ArchiveTable(prefix13.ArchiveTable c) => {
  'os': c.os,
  'channel': c.channel,
};
Map<String, dynamic> _prefix17InteractiveQuiz(prefix17.InteractiveQuiz c) => {
  'title': c.title,
  'questions': c.questions.map((i) => i.toJson()).toList(),
};
