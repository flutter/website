---
layout: tutorial
title: "Internationalizing Flutter Apps"

permalink: /tutorials/internationalization/
---

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll learn:</b>

* How to track the device's locale (the user's preferred language).
* How to manage locale-specific app values.
* How define the locales an app supports.

</div>

If your app might be deployed to users who speak another language then
you'll need to "internationalize" it. That means you'll need to write
the app in a way that makes it possible to "localize" values like text
and layouts for each language or "locale" that the app
supports. Flutter provides widgets and classes that help with
internationalization and the Flutter libraries themselves are
internationalized.

The tutorial that follows is largely written in terms of the Flutter
MaterialApp class, since most applications are written that way.
Applications written in terms of the lower level WidgetsApp class
can also be internationalized using the same classes and logic.

### Contents

* [Setting up an internationalized app: the flutter_localizations package](#setting-up)
* [Tracking the locale: The Locale class and the Localizations widget](#tracking-locale)
* [Loading and retrieving localized values](#loading-and-retrieving)
* [Using the bundled LocalizationsDelegates](#using-bundles)
* [Defining a class for the app's localized resources](#defining-class)
* [Specifying the app's supportedLocales parameter](#specifying-supportedlocales)
* [An alternative class for the app's localized resources](#alternative-class)
* [Appendix: Using the Dart intl tools](#dart-tools)

<aside class="alert alert-info" markdown="1">
**Sample internationalized apps**<br>

If you'd like to start out by reading the code for an internationalized
Flutter app, here are two small examples. The first one is intended to
be as simple as possible, and the second one uses the APIs and tools
provided by the [intl](https://pub.dartlang.org/packages/intl) package.
If Dart's intl package is new to you, see [Using the Dart intl tools.](#dart-tools)

* [Minimal internationalization](https://github.com/flutter/website/tree/master/_includes/code/internationalization/minimal/)
* [Internationaliation based on the `intl` package](https://github.com/flutter/website/tree/master/_includes/code/internationalization/intl/)
</aside>

<a name="setting-up"></a>
## Setting up an internationalized app: the flutter_localizations package

By default Flutter only provides US English localizations. To add
support for other languages, an application must specify additional
MaterialApp properties, and include a separate package called
`flutter_localizations`.  As of October 2017, this package supports 15
languages.

To use flutter_localizations, add the package as a dependency to your
`pubspec.yaml` file:

{% prettify yaml %}
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
{% endprettify %}

Next, import the flutter_localizations library and specify
`localizationsDelegates` and `supportedLocales` for MaterialApp:

{% prettify dart %}
import 'package:flutter_localizations/flutter_localizations.dart';

new MaterialApp(
 localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en', 'US'), // English
    const Locale('he', 'IL'), // Hebrew
    // ... other locales the app supports
  ],
  // ...
)
{% endprettify %}

Apps based on WidgetsApp are similar except that the
`GlobalMaterialLocalizations.delegate` isn't needed.

The elements of the `localizationsDelegates` list are factories that produce
collections of localized values. `GlobalMaterialLocalizations.delegate`
provides localized strings and other values for the Material Components
library. `GlobalWidgetsLocalizations.delegate` defines the default
text direction, either left to right or right to left, for the widgets
library.

More information about these app properties, the types they
depend on, and how internationalized Flutter apps are typically
structured, can be found below.

<a name="tracking-locale"></a>
## Tracking the locale: The Locale class and the Localizations widget

The [`Locale`](https://docs.flutter.io/flutter/dart-ui/Locale-class.html)
class is used to identify the user's language. Mobile devices support
setting the locale for all applications, usually via a system settings
menu. Internationalized apps respond by displaying values that are
locale-specific. For example, if the user switches the device's locale
from English to French then a Text widget that displayed "Hello World"
would be rebuilt with "Bonjour le monde".

The
[`Localizations`](https://docs.flutter.io/flutter/widgets/Localizations-class.html)
widget defines the locale for its child and the localized resources
that the child depends on. The
[WidgetsApp](https://docs.flutter.io/flutter/widgets/WidgetsApp-class.html)
widget creates a Localizations widget and rebuilds it if the system's locale changes.

You can always lookup an app's current locale with `Localizations.localeOf()`:

{% prettify dart %}
Locale myLocale = Localizations.localeOf(context);
{% endprettify %}

<a name="loading-and-retrieving"></a>
## Loading and retrieving localized values

The Localizations widget is used to load and lookup objects that
contain collections of localized values. Apps refer to these objects with
[`Localizations.of(context,type)`](https://docs.flutter.io/flutter/widgets/Localizations/of.html).
If the device's locale changes, the Localizations widget automatically
loads values for the new locale and then rebuilds widgets that used it.
This happens because Localizations works like an
[InheritedWidget](https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html).
When a build function refers to an inherited widget an implicit dependency
on the inherited widget is created. When an inherited widget changes
(when the Localizations widget's locale changes), its dependent
contexts are rebuilt.

Localized values are loaded by the Localizations widget's list of
[LocalizationsDelegate](https://docs.flutter.io/flutter/widgets/LocalizationsDelegate-class.html)s.
Each delegate must define an async
[`load()`](https://docs.flutter.io/flutter/widgets/LocalizationsDelegate/load.html)
method that produces an object which encapsulates a collection of
localized values. Typically these objects define one method per localized value.

In a large app, different modules or packages might be bundled with
their own localizations. That's why the Localizations widget manages a
table of objects, one per LocalizationsDelegate. To retrieve the
object produced by one of the LocalizationsDelegate's `load` methods,
you specify a BuildContext and the object's type.

For example, the localized strings for the Material Components widgets are defined by the
[MaterialLocalizations](https://docs.flutter.io/flutter/material/MaterialLocalizations-class.html)
class. Instances of this class are created by a LocalizationDelegate
provided by the
[MaterialApp](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
class. They can be retrieved with `Localizations.of`:

{% prettify dart %}
Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
{% endprettify %}

This particular `Localizations.of()` expression is used frequently, so the
MaterialLocalizations class provides a convenient shorthand:

{% prettify dart %}
static MaterialLocalizations of(BuildContext context) {
  return Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
}

/// References to the localized values defined by MaterialLocalizations
/// are typically written like this:

tooltip: MaterialLocalizations.of(context).backButtonTooltip,
{% endprettify %}

<a name="using-bundles">
## Using the bundled LocalizationsDelegates

To keep things as small and uncomplicated as possible, the flutter
package includes implementations of the MaterialLocalizations and
WidgetsLocalizations interfaces that only provide US English
values. These implementation classes are called
DefaultMaterialLocalizations and DefaultWidgetsLocalizations, respectively.
They're included automatically unless a
different delegate of the same base type is specified with the app's
`localizationsDelegates` parameter.

The flutter_localizations package includes multi-language
implementations of the localizations interfaces called GlobalMaterialLocalizations
and GlobalWidgetsLocalizations. International apps must specify
localization delegates for these classes as described in
[Setting up an internationalized app.](#setting-up)

{% prettify dart %}
import 'package:flutter_localizations/flutter_localizations.dart';

new MaterialApp(
 localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en', 'US'), // English
    const Locale('he', 'IL'), // Hebrew
    // ... other locales the app supports
  ],
  // ...
)
{% endprettify %}

The global localization delegates construct locale-specific instances
of the corresponding classes. For example,
`GlobalMaterialLocalizations.delegate` is a LocalizationsDelegate
that produces an instance of GlobalMaterialLocalizations.

As of October 2017, the global localization classes support [about 15
languages.](https://github.com/flutter/flutter/tree/master/packages/flutter_localizations/lib/src/l10n)

<a name="defining-class"></a>
## Defining a class for the app's localized resources

Putting all of this together for an internationalized app usually
starts with the class that encapsulates the app's localized
values. The example that follows is typical of such classes.

[Complete source code](https://github.com/flutter/website/tree/master/_includes/code/internationalization/intl/)
for this example app.

This example is based on the APIs and tools provided by the
[intl](https://pub.dartlang.org/packages/intl) package. [An alternative class
for the app's localized resources](#alternative-class) describes
[an example](https://github.com/flutter/website/tree/master/_includes/code/internationalization/minimal/)
that doesn't depend on the intl package.

The DemoLocalizations class contains the app's strings (just one for the example)
translated into the locales that the app supports. It uses the `initializeMessages()`
function generated by Dart's [intl package](https://pub.dartlang.org/packages/intl)
to load the translated strings, and
[`Intl.message()`](https://www.dartdocs.org/documentation/intl/0.15.1/intl/Intl/message.html)
to look them up.

{% prettify dart %}
class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((Null _) {
      Intl.defaultLocale = localeName;
      return new DemoLocalizations();
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}
{% endprettify %}

A class based on the `intl` package imports a generated message catalog that provides
the `initializeMessages()` function and the per-locale backing store for `Intl.message()`.
The message catalog is produced by an [`intl` tool](#dart-tools) that analyzes the
source code for classes that contain `Intl.message()` calls.
In this case that would just be the DemoLocalizations class.

<a name="specifying-supportedlocales"></a>
## Specifying the app's supportedLocales parameter

Although Flutter's Material Components library includes support for about 16
languages, only English language translations are available by default.
It's up to the developer to decide exactly which languages
to support, since it wouldn't make sense for the toolkit
libraries to support a different set of locales than the app does.

The MaterialApp
[`supportedLocales`](https://docs.flutter.io/flutter/material/MaterialApp/supportedLocales.html)
parameter limits locale changes. When the user changes the locale
setting on their device, the app's `Localizations` widget only
follows suit if the new locale is a member of the this list.
If an exact match for the device locale isn't found, then the first
supported locale with a matching
[`languageCode`](https://docs.flutter.io/flutter/dart-ui/Locale/languageCode.html)
is used. If that fails, then the first element of the
`supportedLocales` list is used.

In terms of the previous DemoApp example, the app only accepts the
US English or French Canadian locales, and it substitutes US
English (the first locale in the list) for anything else.

An app that wants to use a different "locale resolution" method can provide a
[`localeResolutionCallback`.](https://docs.flutter.io/flutter/widgets/LocaleResolutionCallback.html)
For example, to have your app unconditionally accept whatever locale the
user selects:

{% prettify dart %}
class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
       localeResolutionCallback(Locale locale, Iterable<Locale> supportedLocales) {
         return locale;
       }
       // ...
    );
  }
}
{% endprettify %}

<a name="alternative-class"></a>
## An alternative class for the app's localized resources

The previous DemoApp example was defined in terms of the Dart `intl`
package. Developers can choose their own approach for managing
localized values for the sake of simplicity or perhaps to integrate
with a different i18n framework.

[Complete source code](https://github.com/flutter/website/tree/master/_includes/code/internationalization/minimal/)
for this example app.

In this version of DemoApp the class that contains the app's
localizations, DemoLocalizations, includes all of its translations
directly in per language Maps.


{% prettify dart %}
class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
    },
    'es': {
      'title': 'Hola Mundo',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
}
{% endprettify %}

In the minimal app the DemoLocalizationsDelegate is slightly
different. Its `load` method returns a
[SynchronousFuture](https://docs.flutter.io/flutter/foundation/SynchronousFuture-class.html)
because no asynnchronous loading needs to take place.


{% prettify dart %}
class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return new SynchronousFuture<DemoLocalizations>(new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
{% endprettify %}

<a name="dart-tools"></a>
## Appendix: Using the Dart intl tools

Before building an API using the Dart
[`intl`](https://pub.dartlang.org/packages/intl) package
you'll want to review the `intl` package's documentation. Here's a summary of the process
for localizing an app that depends on the `intl` package.

The demo app depends on a generated source file called `l10n/messages_all.dart`
which defines all of the localizable strings used by the app.

Rebuilding `l10n/messages_all.dart` requires two steps.

<ol markdown="1">
<li markdown="1">With the app's root directory as the current directory, generate
`l10n/intl_messages.arb` from `lib/main.dart`:

{% prettify sh %}
$ flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i10n lib/main.dart
{% endprettify %}

The `intl_messages.arb` file is a JSON format map with one entry for
each `Intl.message()` function defined in `main.dart`. This
file serves as a template for the English and Spanish translations,
`intl_en.arb` and `intl_es.arb`. These translations are created by you,
the developer.
</li>

<li markdown="1">With the app's root directory as the current directory, generate
`intl_messages_<locale>.dart` for each `intl_<locale>.arb` file and
`intl_messages_all.dart`, which imports all of the messages files:

{% prettify sh %}
$ flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \
   --no-use-deferred-loading lib/main.dart lib/l10n/intl_*.arb
{% endprettify %}

The DemoLocalizations class uses the generated `initializeMessages()`
function (defined in `intl_messages_all.dart`) to load the localized messages
and `Intl.message()` to look them up.
</li>

</ol>
