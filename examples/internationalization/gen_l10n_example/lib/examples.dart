// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

void examples(BuildContext context) {
  // #docregion material-app
  const MaterialApp(
    title: 'Localizations Sample App',
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
  // #enddocregion material-app

  // #docregion locale-resolution
  MaterialApp(
    localeResolutionCallback: (locale, supportedLocales) {
      return locale;
    },
  );
  // #enddocregion locale-resolution

  // #docregion my-locale
  Locale myLocale = Localizations.localeOf(context);
  // #enddocregion my-locale

  const MaterialApp(
    // #docregion supported-locales
    supportedLocales: [
      Locale.fromSubtags(languageCode: 'zh'), // generic Chinese 'zh'
      Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans',
      ), // generic simplified Chinese 'zh_Hans'
      Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
      ), // generic traditional Chinese 'zh_Hant'
      Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans',
        countryCode: 'CN',
      ), // 'zh_Hans_CN'
      Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'TW',
      ), // 'zh_Hant_TW'
      Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'HK',
      ), // 'zh_Hant_HK'
    ],
    // #enddocregion supported-locales
  );
}

class PageWithDatePicker extends StatefulWidget {
  const PageWithDatePicker({super.key});

  final String title = 'Localizations Sample App';

  @override
  State<PageWithDatePicker> createState() => _PageWithDatePickerState();
}

class _PageWithDatePickerState extends State<PageWithDatePicker> {
  @override
  // #docregion date-picker
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add the following code
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              // Using a Builder to get the correct BuildContext.
              // Alternatively, you can create a new widget and Localizations.override
              // will pass the updated BuildContext to the new widget.
              child: Builder(
                builder: (context) {
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

  // #enddocregion date-picker
}
