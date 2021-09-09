{{site.alert.warning}}
  The Flutter tool may occasionally download resources from Google servers.
  By downloading or using the Flutter SDK you agree to the [Google Terms of Service][].

  For example, when installed from GitHub (as opposed to from a prepackaged archive),
  the Flutter tool will download the Dart SDK from Google servers immediately when
  first run, as it is used to execute the `flutter` tool itself. This will also
  occur when Flutter is upgraded (e.g. by running the `flutter upgrade` command).

  The `flutter` tool uses Google Analytics to report feature usage
  statistics and send [crash reports][]. This data is used to help improve Flutter
  tools over time.

  Flutter tool analytics are not sent on the very first run. To disable
  reporting, run `flutter config --no-analytics`. To display the current
  setting, use `flutter config`. If you opt out of analytics, an opt-out
  event is sent, and then no further information is sent by the
  Flutter tool.
  
  Dart tools may also send usage metrics and crash reports to Google.
  To control the submission of these metrics, use the following options on the
  [`dart` tool][]:

   * `--enable-analytics`: Enables anonymous analytics.
   * `--disable-analytics`: Disables anonymous analytics.

  The Google [Privacy Policy][] describes how data is handled by these services.

  [Google Terms of Service]: https://policies.google.com/terms
  [Privacy Policy]: https://policies.google.com/privacy
  [crash reports]: https://github.com/flutter/flutter/wiki/Flutter-CLI-crash-reporting
  [`dart` tool]: https://dart.dev/tools/dart-tool
{{site.alert.end}}
