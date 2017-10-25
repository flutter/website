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

## Internationalizing Flutter Applications

If your app might be deployed to users who speak another language then
you'll need to "internationalize" it. That means you'll need to write
the app in a way that makes it possible to "localize" values like text
and layouts for each language or "locale" that the app
supports. Flutter provides widgets and classes that help with
internationalization and the Flutter libraries themselves are
internationalized.

The tutorial that follows is largely written in terms of the Flutter
`MaterialApp` class, since most applications are written that way.
Applications written in terms of the lower level `WidgetsApp` class
can also be internationalized using the same classes and logic.

<aside class="alert alert-info" markdown="1">
**Sample Internationlized Apps**<br>

If you'd like to start out by reading the code for a internationalized Flutter app, here are two small samples. The first one is intended to be as simple as possible, and the second one uses the APIs and tools provided by the [intl](https://pub.dartlang.org/packages/intl) package.

* [Minimal internationalization](https://github.com/flutter/website/tree/master/_includes/code/internationalization/minimal/)
* [Internationaliation based on the `intl` package](https://github.com/flutter/website/tree/master/_includes/code/internationalization/intl/)
</aside>

<a name="setting-up"></a>
### Setting up an Internationalized app: the `flutter_localizations` package

By default Flutter only provides US English localizations. To add
support for other languages, applications must specify some additional
`MaterialApp` properties and include a separate package called
`flutter_localizations`.  As of October 2017, this package supports 15
languages.

To use flutter_localizations, add the package as a dependency to your
`pubspec.yaml` file:

```dart
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```

Next, import the flutter_localizations library and specify
`localizationsDelegates` and `supportedLocales` for MaterialApp:

```dart
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
```

Apps based on `WidgetsApp` are similar except that the
`GlobalMaterialLocalizations.delegate` isn't needed.

The elements of the `localizationsDelegates` list are factories that produce
collections of localized values. `GlobalMaterialLocalizations.delegate`
provides localized strings and other values for the material
library. `GlobalWidgetsLocalizations.delegate` defines the default
text direction, either left to right or right to left, for the widgets
library.

More information about these app properties, the types they
depend on, and how internationalized Flutter apps are typically
structured, can be found below.

### Tracking the Locale: The `Locale` class and the `Localizations` Widget

The [`Locale`](https://docs.flutter.io/flutter/dart-ui/Locale-class.html)
class is used to identify the user's language. Mobile devices support
setting the locale for all applications, usually via a system settings
menu. Internationalized apps respond by displaying values that are
locale-specific. For example if the user switches the device's locale
from English to French then a Text widget that displayed "Hello World"
would be rebuilt with "Bonjour le monde".

The
[`Localizations`](https://docs.flutter.io/flutter/widgets/Localizations-class.html)
widget defines the locale for its child and the localized resources
that the child depends on. The
[`WidgetsApp`](https://docs.flutter.io/flutter/widgets/WidgetsApp-class.html)
widget creates a Localizations widget and rebuilds it if the system's locale changes.

You can always lookup an app's current locale with `Localizations.localeOf()`:
```
Locale myLocale = Localizations.localeOf(context);
```

### Loading and Retrieving Localized Values

The `Localizations` widget is used to load and lookup objects that
contain collections of localized values. Apps refer to these objects
with [`Localizations.of(context,type)`](https://docs.flutter.io/flutter/widgets/Localizations/of.html).
If the device's locale changes, the Localizations widget automatically
loads values for the new locale and then rebuilds widgets that used
it. This happens because Localizations works like an
[`InheritedWidget`](https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html). When
a build function refers to an inherited widget an implicit dependency
on the inherited widget is created. When an inherited widget changes
(when the Localizations widget's locale changes), its dependent
contexts are rebuilt.

Localized values are loaded by the Localizations widget's list of
[`LocalizationsDelegate`](https://docs.flutter.io/flutter/widgets/LocalizationsDelegate-class.html)s. Each
delegate must define an async
[`load()`](https://docs.flutter.io/flutter/widgets/LocalizationsDelegate/load.html)
method that produces an object which encapsulates a collection of
localized values. Typically these objects define one method per localized value.

In a large app, different modules or packages might be bundled with
their own localizations. That's why the Localizations widget manages a
table of objects, one per LocalizationsDelegate. To retrieve the
object produced by one of the LocalizationsDelegate's `load` methods,
you specify a BuildContext and the object's type.

For example the localized strings for the Material widgets are defined
by the
[`MaterialLocalizations`](https://docs.flutter.io/flutter/material/MaterialLocalizations-class.html)
class. Instances of this class are created by a LocalizationDelegate
provided by the
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
 class. They can be retrieved with `Localizations.of`:

```dart
Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
```

This particular `Localizations.of()` expression is used frequently, so the
MaterialLocalizations class provides a convenient shortand:

```dart
static MaterialLocalizations of(BuildContext context) {
  return Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
}

/// References to the localized values defined by MaterialLocalizations
/// are typically written like this:

tooltip: MaterialLocalizations.of(context).backButtonTooltip,
```

### Using the bundled LocalizationsDelegates

To keep things as small and uncomplicated as possible, the flutter
package includes implementations of the `MaterialLocalizations` and
`WidgetsLocalizations` interfaces that only provide US English
values. These implementation classes are called
`DefaultMaterialLocalizations` and
`DefaultWidgetsLocalizations`. They're included automatically unless a
different delegate of the same base type is specified with the app's
`localizationsDelegates` parameter.

The flutter_localizations package includes multi-language
implementations of the localizations interfaces called `GlobalMaterialLocalizations`
and `GlobalWidgetsLocalizations`. International apps must specify
localization delegates for these classes as described in the  <a href="#setting-up">Setting up an Internationalized app section</a>.

```dart
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
```

The global localization delegates construct locale-specific instances
of the corresponding classes. For example
`GlobalMaterialLocalizations.delegate` is a `LocalizationsDelegate`
that produces an instance of `GlobalMaterialLocalizations`.

As of October 2017, the global localization classes support
[15 langauges](https://github.com/flutter/flutter/tree/master/packages/flutter_localizations/lib/src/l10n).
Applications can add support for additional
languages by subclassing. For example one could add support for
a language called `foo` by subclassing GlobalMaterialLocalizations:

```dart
class FooMaterialLocalizations extends GlobalMaterialLocalizations {
  FooMaterialLocalizations(Locale locale) : super(locale);

  @override
  String get backButtonTooltip {
    if (locale.languageCode == 'foo')
      return 'foo';
    return super.backButtonTooltip;
  }

  // ...

  static final LocalizationsDelegate<MaterialLocalizations> delegate =
    new FooMaterialLocalizationsDelegate();
}
```

A `LocalizationsDelegate` that produced an instance of
`FooMaterialLocalizations` could be written like this:

```dart
class FooMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  Future<FooMaterialLocalizations> load(Locale locale) {
    return new Future<FooMaterialLocalizations>.value(new FooMaterialLocalizations(locale));
  }

  @override
  bool shouldReload(FooMaterialLocalizationsDelegate old) => false;
}
```

And finally the app would be configured with the `FooMaterialLocalizations.delegate`:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';

new MaterialApp(
 localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   FooMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
 ],
 // ...
)
```

### Defining a Class for the App's Localized Resources

Putting all of this together for an internationalized app usually
starts with the class that encapsulates the app's localized
values. The example that follows is typical of such classes.

[Complete source code](https://github.com/flutter/website/tree/master/_includes/code/internationalization/intl/) for this example app.

This example is based on the APIs and tools provided by the
[intl](https://pub.dartlang.org/packages/intl) package. The next
section describes an example that does not depend in the intl package.

The `DemoLocalizations` class contains the app's strings (just one for the example)
translated into the locales that the app supports. It uses the `initializeMessages()` function
generated by the [Dart `intl` package](https://pub.dartlang.org/packages/intl)
to load the translated strings and
[`Intl.message()`](https://www.dartdocs.org/documentation/intl/0.15.1/intl/Intl/message.html)
to look them up.

```dart
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
```

A class based on the `intl` package imports a generated message catalog that provides
the `initializeMessages()` function and the per-locale backing store for `Intl.message()`.
The message catalog is produced by an `intl` tool that analyzes the source code for
classes that contain `Intl.message()` calls. In this case that would just be the
`DemoLocalizations` class.

<aside class="alert alert-info" markdown="1">
**Using the Dart intl Tools**<br>
Before building an Api using the [Dart `intl` package](https://pub.dartlang.org/packages/intl) package you'll want to review its documentation. Here's a review of the process for localizing an app that depends on this package.

The demo app depends on a generated source file called `l10n/messages_all.dart`
which defines all of the localizable strings used by the app.

Rebuilding `l10n/messages_all.dart` requires two steps.

With the app's root directory as the current directory, generate
`l10n/intl_messages.arb` from `lib/main.dart`:
```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i10n lib/main.dart
```
The `intl_messages.arb` file is a JSON format map with one entry for
each `Intl.message()` function defined in `main.dart`. This
file serves as a template for the the English and Spanish translations,
`intl_en.arb` and `intl_es.arb`.

With the app's root directory as the current directory, generate
`intl_messages_<locale>.dart` for each `intl_<locale>.arb` file and
`intl_messages_all.dart`, which imports all of the messages files:
```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \
   --no-use-deferred-loading lib/main.dart lib/l10n/intl_*.arb
```

The `DemoLocalizations` class uses the generated `initializeMessages()`
function (defined in `intl_messages_all.dart`) to load the localized messages
and `Intl.message()` to look them up.
</aside>

One could choose another approach for loading localized resources and looking them up
while still conforming to the structure of DemoLocalizations.

An instance of `DemoLocalizations` is created by a simple `LocalizationsDelegate`:

```dart
class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true; // rely on the app's supportedLocales

  @override
  Future<DemoLocalizations> load(Locale locale) => DemoLocalizations.load(locale);

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
```

An instance of `DemoLocalizationsDelegate` is provided to the application's
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
(or its [`WidgetsApp`](https://docs.flutter.io/flutter/widgets/WidgetsApp-class.html)
for non-material applications):

```dart
class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(DemoLocalizations.of(context).title),
      ),
      body: new Center(
        child: new Text(DemoLocalizations.of(context).title),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      home: new DemoApp(),
    );
  }
}
```

As you can see, the app's `AppBar` title comes from an instance of
`DemoLocalizations` that was produced by `DemoLocalizations.load()` via
`DemoLocalizationsDelegate`. If the device's locale changes, then the
app will be rebuilt with a new `DemoLocalizations` object, one
constructed for the new locale. Any reference to
`DemoLocalizations.of()` anywhere in the app causes its context to
be rebuilt if the locale changes.

The MaterialApp creates a Localizations widget with the specified
delegates. `DemoLocalizations.of()` will only find the app's
Localizations widget if its context is a child of the app, so we've
made the app's `home` a separate widget.


### Specifying the App's `supportedLocales` Parameter

Although the Flutter's Material library includes support for about 16
languages, only English language translations are available by
default. It's up to applications to decide exactly which languages
they'll support, since it wouldn't make sense for the toolkit
libraries to support a different set of locales than the app does.

The `MaterialApp`
[`supportedLocales`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
parameter limits locale changes. When the user changes the locale
setting on their device, the app's `Localizations` widget will only
follow suit if the new locale is a member of the this list. If an
exact match for the device locale isn't found, then the first
supported locale with a matching
[`languageCode`](https://docs.flutter.io/flutter/dart-ui/Locale/languageCode.html)
is used. If that fails, then the first element of the
`supportedLocales` list is used.

In terms of the previous `DemoApp` example, the app will only accept the
US English or French Canadian locales and it will substitute US
English (the first locale in the list) for anything else.

An app that wants to use a different "locale resolution" method, can
provide a
[`localeResolutionCallback`](https://docs.flutter.io/flutter/material/MaterialApp-class.html).
For example to have your app unconditionally accept whatever locale the
user selects:

```dart
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

```

### An Alternative Class for the App's Localized Resources

The previous `DemoApp` example was defined in terms of the Dart `intl`
package. Developers can choose their own approach for managing
localized values for the sake of simplicity or perhaps to integrate
with a different i18n framework.

[Complete source code](https://github.com/flutter/website/tree/master/_includes/code/internationalization/minimal/)
for this example app.

In this version of DemoApp the class that contains the
app's localizations, `DemoLocalizations`, includes all of its translations
directly in per language `Map`s.


```dart
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
}
```

In the minimal app the `DemoLocalizationsDelegate` is slightly
different. Its `load` method returns a
[`SynchronousFuture`](https://docs.flutter.io/flutter/foundation/SynchronousFuture-class.html)
because no asynnchronous loading needs to take place.


```dart
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
```
