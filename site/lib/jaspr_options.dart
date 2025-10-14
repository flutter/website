// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:docs_flutter_dev_site/src/client/global_scripts.dart'
    as prefix0;
import 'package:docs_flutter_dev_site/src/components/client/on_this_page_button.dart'
    as prefix1;
import 'package:docs_flutter_dev_site/src/components/header/menu_toggle.dart'
    as prefix2;
import 'package:docs_flutter_dev_site/src/components/header/site_switcher.dart'
    as prefix3;
import 'package:docs_flutter_dev_site/src/components/header/theme_switcher.dart'
    as prefix4;
import 'package:docs_flutter_dev_site/src/components/cookie_notice.dart'
    as prefix5;
import 'package:docs_flutter_dev_site/src/components/copy_button.dart'
    as prefix6;
import 'package:docs_flutter_dev_site/src/components/feedback.dart' as prefix7;

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

    prefix1.OnThisPageButton: ClientTarget<prefix1.OnThisPageButton>(
      'src/components/client/on_this_page_button',
    ),

    prefix5.CookieNotice: ClientTarget<prefix5.CookieNotice>(
      'src/components/cookie_notice',
    ),

    prefix6.CopyButton: ClientTarget<prefix6.CopyButton>(
      'src/components/copy_button',
      params: _prefix6CopyButton,
    ),

    prefix7.FeedbackComponent: ClientTarget<prefix7.FeedbackComponent>(
      'src/components/feedback',
      params: _prefix7FeedbackComponent,
    ),

    prefix2.MenuToggle: ClientTarget<prefix2.MenuToggle>(
      'src/components/header/menu_toggle',
    ),

    prefix3.SiteSwitcher: ClientTarget<prefix3.SiteSwitcher>(
      'src/components/header/site_switcher',
    ),

    prefix4.ThemeSwitcher: ClientTarget<prefix4.ThemeSwitcher>(
      'src/components/header/theme_switcher',
    ),
  },
  styles: () => [],
);

Map<String, dynamic> _prefix6CopyButton(prefix6.CopyButton c) => {
  'toCopy': c.toCopy,
  'buttonText': c.buttonText,
  'classes': c.classes,
  'title': c.title,
};
Map<String, dynamic> _prefix7FeedbackComponent(prefix7.FeedbackComponent c) => {
  'issueUrl': c.issueUrl,
};
