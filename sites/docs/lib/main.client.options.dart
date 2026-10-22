// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:docs_flutter_dev_site/src/components/common/client/download_latest_button.dart'
    deferred as _download_latest_button;
import 'package:docs_flutter_dev_site/src/components/common/client/os_selector.dart'
    deferred as _os_selector;
import 'package:docs_flutter_dev_site/src/components/layout/client/pagenav.dart'
    deferred as _pagenav;
import 'package:docs_flutter_dev_site/src/components/pages/cuj/cuj_filters.dart'
    deferred as _cuj_filters;
import 'package:docs_flutter_dev_site/src/components/pages/cuj/cuj_filters_sidebar.dart'
    deferred as _cuj_filters_sidebar;
import 'package:docs_flutter_dev_site/src/components/pages/archive_table.dart'
    deferred as _archive_table;
import 'package:docs_flutter_dev_site/src/components/pages/glossary_search_section.dart'
    deferred as _glossary_search_section;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters.dart'
    deferred as _learning_resource_filters;
import 'package:docs_flutter_dev_site/src/components/pages/learning_resource_filters_sidebar.dart'
    deferred as _learning_resource_filters_sidebar;
import 'package:site_shared/components/common/client/collapse_button.dart'
    deferred as _collapse_button;
import 'package:site_shared/components/common/client/copy_button.dart'
    deferred as _copy_button;
import 'package:site_shared/components/common/client/download_button.dart'
    deferred as _download_button;
import 'package:site_shared/components/common/client/feedback.dart'
    deferred as _feedback;
import 'package:site_shared/components/common/client/on_this_page_button.dart'
    deferred as _on_this_page_button;
import 'package:site_shared/components/common/client/page_header_options.dart'
    deferred as _page_header_options;
import 'package:site_shared/components/common/client/simple_tooltip.dart'
    deferred as _simple_tooltip;
import 'package:site_shared/components/dartpad/dartpad_injector.dart'
    deferred as _dartpad_injector;
import 'package:site_shared/components/layout/menu_toggle.dart'
    deferred as _menu_toggle;
import 'package:site_shared/components/layout/site_switcher.dart'
    deferred as _site_switcher;
import 'package:site_shared/components/layout/theme_switcher.dart'
    deferred as _theme_switcher;
import 'package:site_shared/components/tutorial/client/quiz.dart'
    deferred as _quiz;
import 'package:site_shared/components/tutorial/client/stepper.dart'
    deferred as _stepper;
import 'package:site_shared/components/tutorial/models/quiz_model.dart'
    as _quiz_model;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'download_latest_button': ClientLoader(
      (p) => _download_latest_button.DownloadLatestButton(
        os: p.get<String>('os'),
        arch: p.get<String?>('arch'),
      ),
      loader: _download_latest_button.loadLibrary,
    ),
    'os_selector': ClientLoader(
      (p) => _os_selector.OsSelector(),
      loader: _os_selector.loadLibrary,
    ),
    'pagenav': ClientLoader(
      (p) => _pagenav.PageNav(
        breadcrumbs: p.get<List<Object?>>('breadcrumbs').cast<String>(),
        pageNumber: p.get<int?>('pageNumber'),
        initialHeading: p.get<String>('initialHeading'),
        content: p.mount(p.get<String>('content')),
      ),
      loader: _pagenav.loadLibrary,
    ),
    'archive_table': ClientLoader(
      (p) => _archive_table.ArchiveTable(
        os: p.get<String>('os'),
        channel: p.get<String>('channel'),
      ),
      loader: _archive_table.loadLibrary,
    ),
    'cuj_filters': ClientLoader(
      (p) => _cuj_filters.CujFilters(),
      loader: _cuj_filters.loadLibrary,
    ),
    'cuj_filters_sidebar': ClientLoader(
      (p) => _cuj_filters_sidebar.CujFiltersSidebar(),
      loader: _cuj_filters_sidebar.loadLibrary,
    ),
    'glossary_search_section': ClientLoader(
      (p) => _glossary_search_section.GlossarySearchSection(),
      loader: _glossary_search_section.loadLibrary,
    ),
    'learning_resource_filters': ClientLoader(
      (p) => _learning_resource_filters.LearningResourceFilters(),
      loader: _learning_resource_filters.loadLibrary,
    ),
    'learning_resource_filters_sidebar': ClientLoader(
      (p) =>
          _learning_resource_filters_sidebar.LearningResourceFiltersSidebar(),
      loader: _learning_resource_filters_sidebar.loadLibrary,
    ),
    'site_shared:collapse_button': ClientLoader(
      (p) => _collapse_button.CollapseButton(
        classes: p.get<List<Object?>>('classes').cast<String>(),
        title: p.get<String?>('title'),
      ),
      loader: _collapse_button.loadLibrary,
    ),
    'site_shared:copy_button': ClientLoader(
      (p) => _copy_button.CopyButton(
        buttonText: p.get<String?>('buttonText'),
        toCopy: p.get<String?>('toCopy'),
        classes: p.get<List<Object?>>('classes').cast<String>(),
        title: p.get<String?>('title'),
      ),
      loader: _copy_button.loadLibrary,
    ),
    'site_shared:download_button': ClientLoader(
      (p) => _download_button.DownloadButton(name: p.get<String>('name')),
      loader: _download_button.loadLibrary,
    ),
    'site_shared:feedback': ClientLoader(
      (p) => _feedback.FeedbackComponent(issueUrl: p.get<String>('issueUrl')),
      loader: _feedback.loadLibrary,
    ),
    'site_shared:on_this_page_button': ClientLoader(
      (p) => _on_this_page_button.OnThisPageButton(),
      loader: _on_this_page_button.loadLibrary,
    ),
    'site_shared:page_header_options': ClientLoader(
      (p) => _page_header_options.PageHeaderOptions(
        title: p.get<String>('title'),
        markdownUrl: p.get<String?>('markdownUrl'),
        sourceUrl: p.get<String?>('sourceUrl'),
        issueUrl: p.get<String?>('issueUrl'),
      ),
      loader: _page_header_options.loadLibrary,
    ),
    'site_shared:simple_tooltip': ClientLoader(
      (p) => _simple_tooltip.SimpleTooltip(
        target: p.mount(p.get<String>('target')),
        content: p.mount(p.get<String>('content')),
      ),
      loader: _simple_tooltip.loadLibrary,
    ),
    'site_shared:dartpad_injector': ClientLoader(
      (p) => _dartpad_injector.DartPadInjector(
        title: p.get<String>('title'),
        theme: p.get<String?>('theme'),
        height: p.get<String?>('height'),
        runAutomatically: p.get<bool>('runAutomatically'),
      ),
      loader: _dartpad_injector.loadLibrary,
    ),
    'site_shared:menu_toggle': ClientLoader(
      (p) => _menu_toggle.MenuToggle(),
      loader: _menu_toggle.loadLibrary,
    ),
    'site_shared:site_switcher': ClientLoader(
      (p) => _site_switcher.SiteSwitcher(isFlutter: p.get<bool>('isFlutter')),
      loader: _site_switcher.loadLibrary,
    ),
    'site_shared:theme_switcher': ClientLoader(
      (p) => _theme_switcher.ThemeSwitcher(),
      loader: _theme_switcher.loadLibrary,
    ),
    'site_shared:quiz': ClientLoader(
      (p) => _quiz.InteractiveQuiz(
        title: p.get<String?>('title'),
        questions: p
            .get<List<Object?>>('questions')
            .cast<Map<Object?, Object?>>()
            .map((i) => _quiz_model.Question.fromMap(i))
            .toList(),
      ),
      loader: _quiz.loadLibrary,
    ),
    'site_shared:stepper': ClientLoader(
      (p) => _stepper.InteractiveStepper(
        titles: p
            .get<List<Object?>>('titles')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
        steps: p
            .get<List<Object?>>('steps')
            .cast<String>()
            .map((i) => p.mount(i))
            .toList(),
        collapsible: p.get<bool>('collapsible'),
        showActions: p.get<bool>('showActions'),
        showFinish: p.get<bool>('showFinish'),
      ),
      loader: _stepper.loadLibrary,
    ),
  },
);
