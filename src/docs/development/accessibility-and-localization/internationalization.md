---
title: 플러터 앱 국제화
short-title: i18n
description: 플러터 앱을 국제화 하는 방법
---

{{site.alert.secondary}}
  <h4 class="no_toc">다음을 배우게 됩니다.</h4>

  * 장치의 Locale(사용자가 선호하는 언어) 추적하기.
  * Locale에 따라 달라지는 값을 관리하는 방법.
  * 앱에서 지원하는 Locale을 정의하는 방법.
{{site.alert.end}}

다른 언어를 사용하는 사용자에게 앱을 배포할 수 있는 경우 앱을 국제화해야 합니다.
즉 앱이 지원하는 "지역(Locale)"이나 언어 별로 텍스트, 레이아웃 같은 값들이 
"현지화(Localize)" 될 수 있는 방법으로 앱을 개발해야 합니다. 플러터는 국제화를
지원하는 클래스나 위젯들을 제공하고 있으며 플러터 라이브러리들은 자체적으로 국제화되어 있습니다.

아래 튜토리얼들은 대부분의 플러터 앱에서 사용되는 `MaterialApp` 클래스로 작성되어 있습니다.
더 하위 레벨인 `WidgetsApp` 클래스로 작성된 앱에서도 동일한 클래스와 로직을 사용하여
국제화를 적용할 수 있습니다.

{{site.alert.secondary}}
  <h4 class="no_toc">국제화 앱 예제</h4>

  국제화된 플러터앱 코드를 먼저 살펴보고 싶으신 분들을 위해 2가지 예제를 제공합니다.
  첫번째는 가능한한 단순하게 구현된 예제이며, 두번째는 [`intl`][] 패키지에 의해 제공되는
  API와 도구를 사용한 예제입니다.
  다트 Intl 패키지를 처음 사용하시는 분들은 [Using the Dart intl tools][]를 확인해주세요.

  * [Minimal internationalization][]
  * [Internationalization based on the `intl` package][]
{{site.alert.end}}

## 국제화된 앱 설정: flutter<wbr>_localizations 패키지 {#setting-up}

기본적으로 플러터는 US English 지역화만 제공합니다.
다른 언어에 대한 지원을 추가하려면, `flutter_localizations` 패키지를 추가하고
`MaterialApp`에 관련 속성들을 정의해야합니다. 2020년 2월 기준으로 이 패키지는
77개 언어를 지원하고 있습니다.

flutter_localizations를 사용하려면 `pubspec.yaml`을 열고
아래와 같이 패키지를 추가해주세요:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```

다음으로 flutter_localizations에 대한 import 구문을 추가하고
`MaterialApp`의 `localizationsDelegates`와 `supportedLocales` 속성을
정의해야합니다:

<!-- skip -->
```dart
import 'package:flutter_localizations/flutter_localizations.dart';

MaterialApp(
 localizationsDelegates: [
   // ... 앱 별 Localization Delegate를 여기에 정의
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en', ''), // 영어, no country code
    const Locale('he', ''), // 히브리어, no country code
    const Locale.fromSubtags(languageCode: 'zh'), // 중국어 *상세한 Locale 설정은 아래 참고*
    // ... 앱이 지원하는 Locale 정보
  ],
  // ...
)
```

`WidgetsApp`를 기반으로 작성된 앱의 경우 대부분 동일하게 설정하면 되지만
`GlobalMaterialLocalizations.delegate`는 필요하지 않습니다.

`Locale` 기본 생성자도 충분하지만, scriptCode에 대한 지원이 필요하다면
`Locale.fromSubtags` 생성자를 사용할 수 있습니다.

`localizationsDelegates` 리스트의 인자들은 팩토리 클래스이며,
지역화된 값들을 포함하고 있는 컬렉션을 생성하는 역할을 합니다.
`GlobalMaterialLocalizations.delegate`는 Material Components 라이브러리를 위한
지역화된 문자열을 제공합니다. `GlobalWidgetsLocalizations.delegate`는 위젯 라이브러리가
텍스트를 나열하는 방향(왼쪽에서 오른쪽 또는 오른쪽에서 왼쪽으로 텍스트를 나열하는 설정)에 대한 기본 값을 정의하고 있습니다. 

이러한 설정에 대한 자세한 정보나 관련된 Type 정보, 그리고 국제회된
플러터 앱이 일반적으로 어떻게 구성되는지에 대한 정보는 아래에서 살펴볼 수 있습니다.

<a name="advanced-locale"></a>
## Locale 정의에 대한 상세정보

여러 변형이 존재하는 일부 언어에 대해서는 언어 코드 외에 더 많은 정보를 제공해야
적절하게 지역화될 수 있습니다.

예를들어, 중국어의 다양한 변형을 모두 지원하기 위해서는 언어코드(languageCode), 문자코드(scriptCode),
국가코드(countryCode)를 모두 정의해야 합니다. 왜냐하면 문자유형의 차이(간자체, 번자체)도 존재하며
동일한 문자유형 일지라도 지역에 따라 문자가 쓰이는 방법이 다르기 때문입니다.

국가코드 `CN`, `TW`, `HK`에 대한 모든 중국어 변형을 표현하기 위해서는
다음 Locale에 대한 지원을 모두 포함해야합니다.

<!-- skip -->
```dart
// CN, TW, HK에 대한 모든 중국어 지원
supportedLocales: [
  const Locale.fromSubtags(languageCode: 'zh'), // 일반적인 중국어 'zh'
  const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), // 일반적인 중국어 간자체 'zh_Hans'
  const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), // 일반적인 중국어 번자체 'zh_Hant'
  const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'), // 'zh_Hans_CN'
  const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'), // 'zh_Hant_TW'
  const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'), // 'zh_Hant_HK'
],
```

이러한 완전하면서 구체적인 정의는 여러 분의 앱이 
제공된 국가코드의 모든 조합을 구별할 수 있게 해주며
섬세하면서도 완전히 현지화된 컨텐트를 제공할 수 있게 해줍니다.
만약 사용자가 선호하는 Locale이 정의되지 않으면 가장 가까운 Locale 값이 대신 사용되지만,
이러한 동작은 사용자가 기대하는 것과 다를 수 있습니다.
플러터는 `supportedLocales`에 정의되어 있는 값만 사용할 것입니다.
플러터는 공통적으로 사용되는 언어(languageCode)에 대해서 문자코드(scriptCode) 별로 
차별화된 지역화 컨텐트를 제공합니다. 앱에서 지원되는 Locale과 사용자가 선호하는 Locale이
어떻게 처리되는지 자세한 정보를 원하시면 [`Localizations`][]를 확인해보세요.

중국어에 대한 예제를 주로 다루었지만, 프랑스어(fr_FR, fr_CA)와 같은 다른 언어들도
섬세한 지역화를 위해 완전히 세분화된 정보를 제공해야합니다.

<a name="tracking-locale"></a>
## Locale 추적: Locale 클래스 및 Localizations 위젯

[`Locale`][] 클래스는 사용자의 언어를 식별하는데 사용됩니다.
모바일 장치는 일반적으로 시스템 설정 메뉴를 통해 모든 어플리케이션에 대한
Locale 설정을 지원합니다. 국제화가 진행된 앱이라면 Locale 별로 정의된 값들을 출력할 것입니다.
예를들어 사용자가 장치의 Locale을 영어에서 프랑스어로 전환하면 "Hello World"를 표시하던
`Text` 위젯은 "Bonjour le monde"를 출력하도록 다시 빌드됩니다.

[`Localizations`][widgets-global] 위젯은 자식 위젯을 위한 Locale과
자식이 의존하는 지역화된 리소스를 정의합니다.
[`WidgetsApp`][] 위젯은 `Localizations` 위젯을 생성하고 
시스템의 Locale이 변경되면 이를 재구축합니다.

`Localizations.localeOf()`를 사용하여 언제든지 앱의
현재 Locale을 조회할 수 있습니다:

<!-- skip -->
```dart
Locale myLocale = Localizations.localeOf(context);
```

<a name="loading-and-retrieving"></a>
## 지역화된 값 로드 및 검색

`Localizations` 위젯은 지역화된 값 컬렉션을 포함하는 객체를 로드하고 검색하는데 사용됩니다. 
앱에서는 [`Localizations.of(context,type)`][]을 사용하여 로드된
객체를 참조하게 됩니다.
만약 장치의 Locale이 변경되면 `Localizations` 위젯은 새 Locale에
해당하는 값을 자동으로 로드하고 이 값을 사용하는 위젯들을 재구성합니다.
이러한 동작은 `Localizations` 위젯이 [`InheritedWidget`][] 처럼 작동 하기 때문에 발생합니다.
build 함수에서 Inherited 위젯을 참조하면 해당 Inherited 위젯에 대한
암시적인 의존성이 생성됩니다. Inherited 위젯이 변경되면(`Localizations` 위젯의
Locale이 변경될 때) 이 의존성 컨텍스트도 재구성됩니다.

지역화된 값들은 `Localizations` 위젯의 [`LocalizationsDelegate`][] 리스트에 의해 로드됩니다.
리스트에 포함된 각 Delegate는 비동기 [`load()`][]메서드를 정의하고 있습니다.
이 메서드는 지역화된 값 컬렉션을 캡슐화하는 객체를 생성하여 리턴합니다. 일반적으로 이러한 객체들은 
지역화된 값 마다 하나의 메서드를 정의하고 있습니다.

대형 앱에서는 다양한 모듈과 패키지들이 자신만의 Localizations과 함께 포함되어 있습니다.
이것이 바로 `Localizations` 위젯이 `LocalizationsDelegate` 당 하나씩 
객체 테이블을 관리하는 이유입니다.
`LocalizationsDelegate`의 `load` 메서드 중 하나가 생성한 특정 객체를 검색하려면
`BuildContext`와 객체 유형을 지정하면 됩니다.

예를들어, Material Components 위젯의 지역화된 문자열들은 
 [`MaterialLocalizations`][] 클래스에 정의되어 있습니다.
이 클래스의 인스턴스는 [`MaterialApp`][]에서 제공하는 `LocalizationDelegate`에 의해
생성되며, `Localizations.of()`을 사용하여 검색 할 수 있습니다.

<!-- skip -->
```dart
Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
```

이러한 특정 `Localizations.of()` 표현식은 자주 사용되므로
`MaterialLocalizations` 클래스는 편리한 단축표현식을 제공합니다.

<!-- skip -->
```dart
static MaterialLocalizations of(BuildContext context) {
  return Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
}

/// MaterialLocalizations에 정의된 지역화된 값에 대한 참조는
/// 일반적으로 다음과 같이 작성됩니다.:

tooltip: MaterialLocalizations.of(context).backButtonTooltip,
```

<a name="using-bundles">
## 번들된 Localizations&shy;Delegates 사용하기

가능한 작고 단순하게 유지하기 위해, 플러터 패키지에는 
US English에 대한 값을 제공하는
`MaterialLocalizations`와 `WidgetsLocalizations` 인터페이스에 대한
구현이 포함되고 있습니다.
이러한 구현 클래스들은 각각 `DefaultMaterialLocalizations`와
`DefaultWidgetsLocalizations`로 불립니다.
동일한 기본 유형의 다른 구현 Delegate가 `localizationsDelegates`에
지정되지 않는한 자동으로 포함됩니다.

`flutter_localizations` 패키지에는 Localizations 인터페이스의 다국어 
구현이 포함되어 있습니다. 이는 [`GlobalMaterialLocalizations`][material-global]와
[`GlobalWidgetsLocalizations`][widgets-global]로 불립니다.
국제화된 앱은 [Setting up an internationalized app][]의 설명대로
이러한 클래스들에 대한 Localization Delegates를 반드시 지정해야합니다.

<!-- skip -->
```dart
import 'package:flutter_localizations/flutter_localizations.dart';

MaterialApp(
 localizationsDelegates: [
   // ... 앱 별 Localization Delegate를 여기에 정의
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en', ''), // 영어, no country code
    const Locale('he', ''), // 히브리어, no country code
    const Locale('zh', ''), // 중국어, no country code
    // ... 앱이 지원하는 Locale 정보
  ],
  // ...
)
```

전역 Localization Delegates는 해당하는 클래스의 인스턴스를 Locale 별로 생성합니다.
예를들어, `GlobalMaterialLocalizations.delegate`는 
`GlobalMaterialLocalizations` 인스턴스를 생성하는 `LocalizationsDelegate`입니다.

2020년 2월까지 전역 Localization 클래스는 [77개 언어][77 languages]를 지원합니다.

<a name="defining-class"></a>
## 앱의 지역화된 리소스에 대한 클래스 정의

Putting all of this together for an internationalized app usually
starts with the class that encapsulates the app's localized values.
The example that follows is typical of such classes.

Complete source code for the [`intl_example`][] for this app.

This example is based on the APIs and tools provided by the
[`intl`][] package.
[An alternative class for the app's localized resources][]
describes [an example][] that doesn't depend on the `intl` package.

The `DemoLocalizations` class contains the app's strings
(just one for the example) translated into the locales
that the app supports.
It uses the `initializeMessages()` function
generated by Dart's [`intl`][] package,
[`Intl.message()`][], to look them up.

<!-- skip -->
```dart
class DemoLocalizations {
  DemoLocalizations(this.localeName);

  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return DemoLocalizations(localeName);
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
      locale: localeName,
    );
  }
}
```

A class based on the `intl` package imports a generated
message catalog that provides the `initializeMessages()`
function and the per-locale backing store for `Intl.message()`.
The message catalog is produced by an [`intl` tool][]
that analyzes the source code for classes that contain
`Intl.message()` calls.  In this case that would just be the
`DemoLocalizations` class.

<a name="specifying-supportedlocales"></a>
## Specifying the app's supported&shy;Locales parameter

Although Flutter's flutter_localizations library includes support
for 77 languages, only English language translations are available
by default. It's up to the developer to decide exactly which languages
to support, since it wouldn't make sense for the toolkit
libraries to support a different set of locales than the app does.

The `MaterialApp` [`supportedLocales`][]
parameter limits locale changes. When the user changes the locale
setting on their device, the app's `Localizations` widget only
follows suit if the new locale is a member of the this list.
If an exact match for the device locale isn't found,
then the first supported locale with a matching [`languageCode`][]
is used. If that fails, then the first element of the
`supportedLocales` list is used.

In terms of the previous DemoApp example, the app only accepts the
US English or French Canadian locales, and it substitutes US
English (the first locale in the list) for anything else.

An app that wants to use a different "locale resolution"
method can provide a [`localeResolutionCallback`][].
For example, to have your app unconditionally accept
whatever locale the user selects:

<!-- skip -->
```dart
class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
         return locale;
       }
       // ...
    );
  }
}
```

<a name="alternative-class"></a>
## An alternative class for the app's localized resources

The previous DemoApp example was defined in terms of the Dart `intl`
package. Developers can choose their own approach for managing
localized values for the sake of simplicity or perhaps to integrate
with a different i18n framework.

Complete source code for the [`minimal`][] app.

In this version of DemoApp the class that contains the app's
localizations, DemoLocalizations, includes all of its translations
directly in per language Maps.


<!-- skip -->
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
```

In the minimal app the `DemoLocalizationsDelegate` is slightly
different. Its `load` method returns a [`SynchronousFuture`][]
because no asynchronous loading needs to take place.

<!-- skip -->
```dart
class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
```

<a name="adding-language"></a>
## Adding support for a new language

An app that needs to support a language that's not included in
[`GlobalMaterialLocalizations`][] has to do some extra work:
it must provide about 70 translations ("localizations")
for words or phrases.

See the following for an example of how to add
support for the Belarusian language.

A new `GlobalMaterialLocalizations` subclass defines the
localizations that the Material library depends on.
A new `LocalizationsDelegate` subclass, which serves
as factory for the `GlobalMaterialLocalizations` subclass,
must also be defined.

Here's the source code for the complete [`add_language`][] example,
minus the actual Belarusian translations.

The locale-specific `GlobalMaterialLocalizations` subclass
is called `BeMaterialLocalizations`,
and the `LocalizationsDelegate` subclass is
`_BeMaterialLocalizationsDelegate`.
The value of `BeMaterialLocalizations.delegate`
is an instance of the delegate, and is all
that's needed by an app that uses these localizations.

The delegate class includes basic date and number format
localizations. All of the other localizations are defined by `String`
valued property getters in `BeMaterialLocalizations`, like this:

<!-- skip -->
```dart
@override
String get backButtonTooltip => r'Back';

@override
String get cancelButtonLabel => r'CANCEL';

@override
String get closeButtonLabel => r'CLOSE';

// etc..
```

These are the English translations, of course.
To complete the job you need to change the return
value of each getter to an appropriate Belarusian string.

The getters return "raw" Dart strings that have an r prefix,
like `r'About $applicationName'`,
because sometimes the strings contain variables with a `$` prefix.
The variables are expanded by parameterized localization methods:

<!-- skip -->
```dart
@override
String get aboutListTileTitleRaw => r'About $applicationName';

@override
String aboutListTileTitle(String applicationName) {
  final String text = aboutListTileTitleRaw;
  return text.replaceFirst(r'$applicationName', applicationName);
}
```

For more information about localization strings, see the
[flutter_localizations README][].

Once you've implemented your language-specific subclasses of
`GlobalMaterialLocalizations` and `LocalizationsDelegate`,
you just need to add the language and a delegate instance to your app.
Here's some code that sets the app's language to Belarusian and
adds the `BeMaterialLocalizations` delegate instance to the app's
`localizationsDelegates` list:

<!-- skip -->
```dart
MaterialApp(
  localizationsDelegates: [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    BeMaterialLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('be', 'BY')
  ],
  home: ...
)
```

<a name="dart-tools"></a>
## Appendix: Using the Dart intl tools

Before building an API using the Dart [`intl`][] package
you'll want to review the `intl` package's documentation.
Here's a summary of the process
for localizing an app that depends on the `intl` package.

The demo app depends on a generated source file called
`l10n/messages_all.dart`, which defines all of the
localizable strings used by the app.

Rebuilding `l10n/messages_all.dart` requires two steps.

 1. With the app's root directory as the current directory,
    generate `l10n/intl_messages.arb` from `lib/main.dart`:

    ```terminal
    $ flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/main.dart
    ```

    The `intl_messages.arb` file is a JSON format map with one entry for
    each `Intl.message()` function defined in `main.dart`. This
    file serves as a template for the English and Spanish translations,
    `intl_en.arb` and `intl_es.arb`.
    These translations are created by you, the developer.

 2. With the app's root directory as the current directory,
    generate `intl_messages_<locale>.dart` for each
    `intl_<locale>.arb` file and `intl_messages_all.dart`,
    which imports all of the messages files:

    ```terminal
    $ flutter pub run intl_translation:generate_from_arb \
        --output-dir=lib/l10n --no-use-deferred-loading \
        lib/main.dart lib/l10n/intl_*.arb
    ```
    
    ***Windows does not support file name wildcarding.***
    Instead, list the .arb files that were generated by the `intl_translation:extract_to_arb` command.
    ```terminal
    $ flutter pub run intl_translation:generate_from_arb \
        --output-dir=lib/l10n --no-use-deferred-loading \
        lib/main.dart \
        lib/l10n/intl_en.arb lib/l10n/intl_fr.arb lib/l10n/intl_messages.arb
    ```

    The `DemoLocalizations` class uses the generated `initializeMessages()`
    function (defined in `intl_messages_all.dart`)
    to load the localized messages and `Intl.message()` to look them up.

<a name="ios-specifics"></a>
## Appendix: Updating the iOS app bundle

iOS applications define key application metadata,
including supported locales, in an `Info.plist` file
that is built into the application bundle.
To configure the locales supported by your app,
you'll need to edit this file.

First, open your project's `ios/Runner.xcworkspace` Xcode
workspace file then, in the **Project Navigator**,
open the `Info.plist` file under the `Runner`
project's `Runner` folder.

Next, select the **Information Property List** item,
select **Add Item** from the **Editor** menu,
then select **Localizations** from the pop-up menu.

Select and expand the newly-created `Localizations` item then,
for each locale your application supports,
add a new item and select the locale you wish to add
from the pop-up menu in the **Value** field.
This list should be consistent with the languages listed
in the [supportedLocales][] parameter.

Once all supported locales have been added, save the file.


[77 languages]: {{site.api}}/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html
[`add_language`]: {{site.github}}/flutter/website/tree/master/examples/internationalization/add_language/lib/main.dart
[An alternative class for the app's localized resources]: #alternative-class
[an example]: {{site.github}}/flutter/website/tree/master/examples/internationalization/minimal
[`intl_example`]: {{site.github}}/flutter/website/tree/master/examples/internationalization/intl_example
[flutter_localizations README]: {{site.github}}/flutter/flutter/blob/master/packages/flutter_localizations/lib/src/l10n/README.md
[`GlobalMaterialLocalizations`]: {{site.api}}/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html
[`InheritedWidget`]: {{site.api}}/flutter/widgets/InheritedWidget-class.html
[Internationalization based on the `intl` package]: {{site.github}}/flutter/website/tree/master/examples/internationalization/intl_example
[`intl`]: {{site.pub-pkg}}/intl
[`intl` tool]: #dart-tools
[`Intl.message()`]: {{site.pub-api}}/intl/latest/intl/Intl/message.html
[`languageCode`]: {{site.api}}/flutter/dart-ui/Locale/languageCode.html
[`load()`]: {{site.api}}/flutter/widgets/LocalizationsDelegate/load.html
[`Locale`]: {{site.api}}/flutter/dart-ui/Locale-class.html
[`localeResolutionCallback`]: {{site.api}}/flutter/widgets/LocaleResolutionCallback.html
[`Localizations`]: {{site.api}}/flutter/widgets/WidgetsApp/supportedLocales.html
[`Localizations.of(context,type)`]: {{site.api}}/flutter/widgets/Localizations/of.html
[`LocalizationsDelegate`]: {{site.api}}/flutter/widgets/LocalizationsDelegate-class.html
[material-global]: {{site.api}}/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[`MaterialLocalizations`]: {{site.api}}/flutter/material/MaterialLocalizations-class.html
[`minimal`]: {{site.github}}/flutter/website/tree/master/examples/internationalization/minimal
[Minimal internationalization]: {{site.github}}/flutter/website/tree/master/examples/internationalization/minimal
[Setting up an internationalized app]: #setting-up
[`SynchronousFuture`]: {{site.api}}/flutter/foundation/SynchronousFuture-class.html
[`supportedLocales`]: {{site.api}}/flutter/material/MaterialApp/supportedLocales.html
[supportedLocales]: #specifying-supportedlocales
[Using the Dart intl tools]: #dart-tools
[widgets-local]: {{site.api}}/flutter/widgets/Localizations-class.html
[widgets-global]: {{site.api}}/flutter/flutter_localizations/GlobalWidgetsLocalizations-class.html
[`WidgetsApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html

