// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:docs_flutter_dev_site/src/components/common/client/collapse_button.dart'
    as _collapse_button;
import 'package:docs_flutter_dev_site/src/components/common/client/cookie_notice.dart'
    as _cookie_notice;
import 'package:docs_flutter_dev_site/src/components/common/client/copy_button.dart'
    as _copy_button;
import 'package:docs_flutter_dev_site/src/components/common/client/download_button.dart'
    as _download_button;
import 'package:docs_flutter_dev_site/src/components/common/client/download_latest_button.dart'
    as _download_latest_button;
import 'package:docs_flutter_dev_site/src/components/common/client/feedback.dart'
    as _feedback;
import 'package:docs_flutter_dev_site/src/components/common/client/on_this_page_button.dart'
    as _on_this_page_button;
import 'package:docs_flutter_dev_site/src/components/common/client/os_selector.dart'
    as _os_selector;
import 'package:docs_flutter_dev_site/src/components/common/client/page_header_options.dart'
    as _page_header_options;
import 'package:docs_flutter_dev_site/src/components/common/client/simple_tooltip.dart'
    as _simple_tooltip;
import 'package:docs_flutter_dev_site/src/components/dartpad/dartpad_injector.dart'
    as _dartpad_injector;
import 'package:docs_flutter_dev_site/src/components/layout/client/pagenav.dart'
    as _pagenav;
import 'package:docs_flutter_dev_site/src/components/layout/menu_toggle.dart'
    as _menu_toggle;
import 'package:docs_flutter_dev_site/src/components/layout/site_switcher.dart'
    as _site_switcher;
import 'package:docs_flutter_dev_site/src/components/layout/theme_switcher.dart'
    as _theme_switcher;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    as _archive_table;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    as _glossary_search_section;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    as _learning_resource_filters;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    as _learning_resource_filters_sidebar;
import 'package:docs_flutter_dev_site/src/components/tutorial/client/quiz.dart'
    as _quiz;
import 'package:jaspr_content/components/file_tree.dart' as _file_tree;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _collapse_button.CollapseButton:
        ClientTarget<_collapse_button.CollapseButton>(
          'collapse_button',
          params: __collapse_buttonCollapseButton,
        ),
    _cookie_notice.CookieNotice: ClientTarget<_cookie_notice.CookieNotice>(
      'cookie_notice',
    ),
    _copy_button.CopyButton: ClientTarget<_copy_button.CopyButton>(
      'copy_button',
      params: __copy_buttonCopyButton,
    ),
    _download_button.DownloadButton:
        ClientTarget<_download_button.DownloadButton>(
          'download_button',
          params: __download_buttonDownloadButton,
        ),
    _download_latest_button.DownloadLatestButton:
        ClientTarget<_download_latest_button.DownloadLatestButton>(
          'download_latest_button',
          params: __download_latest_buttonDownloadLatestButton,
        ),
    _feedback.FeedbackComponent: ClientTarget<_feedback.FeedbackComponent>(
      'feedback',
      params: __feedbackFeedbackComponent,
    ),
    _on_this_page_button.OnThisPageButton:
        ClientTarget<_on_this_page_button.OnThisPageButton>(
          'on_this_page_button',
        ),
    _os_selector.OsSelector: ClientTarget<_os_selector.OsSelector>(
      'os_selector',
    ),
    _page_header_options.PageHeaderOptions:
        ClientTarget<_page_header_options.PageHeaderOptions>(
          'page_header_options',
          params: __page_header_optionsPageHeaderOptions,
        ),
    _simple_tooltip.SimpleTooltip: ClientTarget<_simple_tooltip.SimpleTooltip>(
      'simple_tooltip',
      params: __simple_tooltipSimpleTooltip,
    ),
    _dartpad_injector.DartPadInjector:
        ClientTarget<_dartpad_injector.DartPadInjector>(
          'dartpad_injector',
          params: __dartpad_injectorDartPadInjector,
        ),
    _pagenav.PageNav: ClientTarget<_pagenav.PageNav>(
      'pagenav',
      params: __pagenavPageNav,
    ),
    _menu_toggle.MenuToggle: ClientTarget<_menu_toggle.MenuToggle>(
      'menu_toggle',
    ),
    _site_switcher.SiteSwitcher: ClientTarget<_site_switcher.SiteSwitcher>(
      'site_switcher',
    ),
    _theme_switcher.ThemeSwitcher: ClientTarget<_theme_switcher.ThemeSwitcher>(
      'theme_switcher',
    ),
    _archive_table.ArchiveTable: ClientTarget<_archive_table.ArchiveTable>(
      'archive_table',
      params: __archive_tableArchiveTable,
    ),
    _glossary_search_section.GlossarySearchSection:
        ClientTarget<_glossary_search_section.GlossarySearchSection>(
          'glossary_search_section',
        ),
    _learning_resource_filters.LearningResourceFilters:
        ClientTarget<_learning_resource_filters.LearningResourceFilters>(
          'learning_resource_filters',
        ),
    _learning_resource_filters_sidebar.LearningResourceFiltersSidebar:
        ClientTarget<
          _learning_resource_filters_sidebar.LearningResourceFiltersSidebar
        >('learning_resource_filters_sidebar'),
    _quiz.InteractiveQuiz: ClientTarget<_quiz.InteractiveQuiz>(
      'quiz',
      params: __quizInteractiveQuiz,
    ),
  },
  styles: () => [..._file_tree.FileTree.styles],
);

Map<String, Object?> __collapse_buttonCollapseButton(
  _collapse_button.CollapseButton c,
) => {'classes': c.classes, 'title': c.title};
Map<String, Object?> __copy_buttonCopyButton(_copy_button.CopyButton c) => {
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, Object?> __download_buttonDownloadButton(
  _download_button.DownloadButton c,
) => {'name': c.name};
Map<String, Object?> __download_latest_buttonDownloadLatestButton(
  _download_latest_button.DownloadLatestButton c,
) => {'os': c.os, 'arch': c.arch};
Map<String, Object?> __feedbackFeedbackComponent(
  _feedback.FeedbackComponent c,
) => {'issueUrl': c.issueUrl};
Map<String, Object?> __page_header_optionsPageHeaderOptions(
  _page_header_options.PageHeaderOptions c,
) => {'title': c.title, 'sourceUrl': c.sourceUrl, 'issueUrl': c.issueUrl};
Map<String, Object?> __simple_tooltipSimpleTooltip(
  _simple_tooltip.SimpleTooltip c,
) => {'target': c.target.toId(), 'content': c.content.toId()};
Map<String, Object?> __dartpad_injectorDartPadInjector(
  _dartpad_injector.DartPadInjector c,
) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, Object?> __pagenavPageNav(_pagenav.PageNav c) => {
  'breadcrumbs': c.breadcrumbs,
  'pageNumber': c.pageNumber,
  'initialHeading': c.initialHeading,
  'content': c.content.toId(),
};
Map<String, Object?> __archive_tableArchiveTable(
  _archive_table.ArchiveTable c,
) => {'os': c.os, 'channel': c.channel};
Map<String, Object?> __quizInteractiveQuiz(_quiz.InteractiveQuiz c) => {
  'title': c.title,
  'questions': c.questions.map((i) => i.toJson()).toList(),
};
