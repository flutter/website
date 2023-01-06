import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore_for_file: unused_local_variable

// #docregion Create
flutter create <name_of_flutter_app>
// #enddocregion Create

void examples(BuildContext context) {
// #docregion MaterialAppExample
  const MaterialApp(
    title: 'Localizations Sample App',
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
// #enddocregion MaterialAppExample

// #docregion LocaleResolution
  MaterialApp(
    localeResolutionCallback: (
      locale,
      supportedLocales,
    ) {
      return locale;
    },
  );
// #enddocregion LocaleResolution

// #docregion CalendarDatePicker
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add the following code
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              // Using a Builder here to get the correct BuildContext.
              // Alternatively, you can create a new widget and Localizations.override
              // will pass the updated BuildContext to the new widget.
              child: Builder(
                builder: (BuildContext context) {
                  // A toy example for an internationalized Material widget.
                  return CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    onDateChanged: (value) {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
// #enddocregion CalendarDatePicker
// #docregion Example
  Text(AppLocalizations.of(context)!.helloWorld);
// #enddocregion Example

// #docregion PlaceholderSyntax
"{placeholder}"
// #enddocregion PlaceholderSyntax
// #docregion PluralSyntax
"{countPlaceholder, plural, =0{message0} =1{message1} ... other{messageOther}}"
// #enddocregion PluralSyntax
// #docregion SelectSyntax
"{selectPlaceholder, select, case{message} ... other{messageOther}}"
// #enddocregion SelectSyntax

// #docregion MyLocale
  Locale myLocale = Localizations.localeOf(context);
// #enddocregion MyLocale

// #docregion PluralSyntax
"{countPlaceholder, plural, =0{message0} =1{message1} =2{message2} few{messageFew} many{messageMany} other{messageOther}}"
// #enddocregion PluralSyntax

  const MaterialApp(
// #docregion SupportedLocales
    supportedLocales: [
      Locale.fromSubtags(languageCode: 'zh'), // generic Chinese 'zh'
      Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hans'), // generic simplified Chinese 'zh_Hans'
      Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant'), // generic traditional Chinese 'zh_Hant'
      Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hans',
          countryCode: 'CN'), // 'zh_Hans_CN'
      Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant',
          countryCode: 'TW'), // 'zh_Hant_TW'
      Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant',
          countryCode: 'HK'), // 'zh_Hant_HK'
    ],
// #enddocregion SupportedLocales
  );
}
