// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:docs_flutter_dev_site/src/client/global_scripts.dart'
    as prefix0;
import 'package:docs_flutter_dev_site/src/components/client/dartpad_injector.dart'
    as prefix1;
import 'package:docs_flutter_dev_site/src/components/client/on_this_page_button.dart'
    as prefix2;
import 'package:docs_flutter_dev_site/src/components/header/menu_toggle.dart'
    as prefix3;
import 'package:docs_flutter_dev_site/src/components/header/site_switcher.dart'
    as prefix4;
import 'package:docs_flutter_dev_site/src/components/header/theme_switcher.dart'
    as prefix5;
import 'package:docs_flutter_dev_site/src/components/cookie_notice.dart'
    as prefix6;
import 'package:docs_flutter_dev_site/src/components/copy_button.dart'
    as prefix7;
import 'package:docs_flutter_dev_site/src/components/feedback.dart' as prefix8;
import 'package:docs_flutter_dev_site/src/components/os_selector.dart'
    as prefix9;

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

    prefix1.DartPadInjector: ClientTarget<prefix1.DartPadInjector>(
      'src/components/client/dartpad_injector',
      params: _prefix1DartPadInjector,
    ),

    prefix2.OnThisPageButton: ClientTarget<prefix2.OnThisPageButton>(
      'src/components/client/on_this_page_button',
    ),

    prefix6.CookieNotice: ClientTarget<prefix6.CookieNotice>(
      'src/components/cookie_notice',
    ),

    prefix7.CopyButton: ClientTarget<prefix7.CopyButton>(
      'src/components/copy_button',
      params: _prefix7CopyButton,
    ),

    prefix8.FeedbackComponent: ClientTarget<prefix8.FeedbackComponent>(
      'src/components/feedback',
      params: _prefix8FeedbackComponent,
    ),

    prefix3.MenuToggle: ClientTarget<prefix3.MenuToggle>(
      'src/components/header/menu_toggle',
    ),

    prefix4.SiteSwitcher: ClientTarget<prefix4.SiteSwitcher>(
      'src/components/header/site_switcher',
    ),

    prefix5.ThemeSwitcher: ClientTarget<prefix5.ThemeSwitcher>(
      'src/components/header/theme_switcher',
    ),

    prefix9.OsSelector: ClientTarget<prefix9.OsSelector>(
      'src/components/os_selector',
    ),
  },
  styles: () => [],
);

Map<String, dynamic> _prefix1DartPadInjector(prefix1.DartPadInjector c) => {
  'title': c.title,
  'theme': c.theme,
  'height': c.height,
  'runAutomatically': c.runAutomatically,
};
Map<String, dynamic> _prefix7CopyButton(prefix7.CopyButton c) => {
  'toCopy': c.toCopy,
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix8FeedbackComponent(prefix8.FeedbackComponent c) => {
  'issueUrl': c.issueUrl,
};
