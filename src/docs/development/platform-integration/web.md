---
title: Web FAQ
description: Some gotchas and differences when writing or running web apps in Flutter.
---

### Is the web version of Flutter ready for production?

Flutter's web support is now available on the stable channel,
offering an app-centric framework that
builds on the power of the modern web platform.
Find out more details about
[Flutter's production quality support for the web][].

### What scenarios are ideal for Flutter on the web?
Not every web page makes sense in Flutter, but we think Flutter is particularly
suited for app-centric experiences:

* Progressive Web Apps
* Single Page Apps
* Existing Flutter mobile apps

At this time, Flutter is not suitable for static websites with text-rich
flow-based content. For example, blog articles benefit from the document-centric
model that the web is built around, rather than the app-centric services that a
UI framework like Flutter can deliver. However, you _can_ use Flutter to embed
interactive experiences into these websites.

For more information on how you can use Flutter on the web,
see [Web support for Flutter][].

### How do I file an issue about web support?

You can [file an issue][] on the main Flutter repo.
Make sure that "web" is included in the title.

### How do I create an app that also runs on the web?

See [building a web app with Flutter][].

### Does hot reload work with a web app?

No, but you can use hot restart. Hot restart is a fast way of seeing your
changes without having to relaunch your web app and wait for it to compile and
load. This works similarly to the hot reload feature for Flutter mobile
development. The only difference is that hot reload remembers your state and hot
restart doesn't.

### How do I restart the app running in the browser?

You can either use the browser's refresh button,
or you can enter "R" in the console where
"flutter run -d chrome" is running.

### Which web browsers are supported by Flutter?

Flutter web apps can run on the following browsers:

* Chrome (mobile & desktop)
* Safari (mobile & desktop)
* Edge (mobile & desktop)
* Firefox (mobile & desktop)

During development, Chrome (on macOS, Windows, and Linux) and Edge (on Windows)
are supported as the default browsers for debugging your app.

### Can I build, run, and deploy web apps in any of the IDEs?

You can select **Chrome** or **Edge** as the target device in
Android Studio/IntelliJ and VS Code. 

The device pulldown should now include the **Chrome (web)**
option for all channels.

### How do I build a responsive app for the web?

See [Creating responsive apps][].

### Can I use Flutter plugins?

Yes, several plugins have web support. 
Find an updated list of plugins on [pub.dev][] using the web filter.
You can also add web support to existing plugins or
[write your own plugins][] for the web.

### Can I use `dart:io` with a web app?

No. The file system is not accessible from the browser.
For network functionality, use the [`http`][]
package. Note that security works somewhat
differently because the browser (and not the app)
controls the headers on an HTTP request.

### How do I embed a Flutter web app in a web page?

You can embed a Flutter web app,
as you would embed other content,
in an [`iframe`][] tag of an HTML file.
In the following example, replace "URL"
with the location of your hosted HTML page:

```html
<iframe src="URL"></iframe>
```

If you encounter problems, please [file an issue][].

### How do I debug a web app?

Use [Flutter DevTools][] for the following tasks:

* [Debugging][]
* [Logging][]
* [Running Flutter inspector][]

Use [Chrome DevTools][] for the following tasks:

* [Generating event timeline][]
* [Analyzing performance][]&mdash;make sure to use a
  profile build

### How do I test a web app?

Use [widget tests][] or integration tests. To learn more about
running integration tests in a browser, see the [Integration testing][] page.

### How do I internationalize a web app?

This isn’t any different than [internationalizing a Flutter mobile app][].

### How do I deploy a web app?

See [Preparing a web app for release][].

### Does `Platform.is` work on the web?

Not currently.

### How can I compare notes with others who are playing with this feature?

Check out the **#web** discussion channel on [Discord][].
Flutter engineers routinely read and respond on Discord.


[Analyzing performance]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance
[building a web app with Flutter]: /docs/get-started/web
[Chrome DevTools]: https://developers.google.com/web/tools/chrome-devtools
[Creating responsive apps]: /docs/development/ui/layout/responsive
[Debugging]: /docs/development/tools/devtools/debugger
[Discord]: https://discord.gg/N7Yshp4
[file an issue]: {{site.github}}/flutter/flutter/issues/new?title=[web]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version
[Flutter DevTools]: /docs/development/tools/devtools/overview
[Flutter's production quality support for the web]: /web
[Generating event timeline]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference
[`http`]: {{site.pub}}/packages/http
[`iframe`]: https://html.com/tags/iframe/
[Issue 32248]: {{site.github}}/flutter/flutter/issues/32248
[Logging]: /docs/development/tools/devtools/logging
[Preparing a web app for release]: /docs/deployment/web
[Running Flutter inspector]: /docs/development/tools/devtools/inspector
[Upgrading from package:flutter_web to the Flutter SDK]: {{site.github}}/flutter/flutter/wiki/Upgrading-from-package:flutter_web-to-the-Flutter-SDK
[widget tests]: /docs/testing#widget-tests
[pub.dev]: {{site.pub}}/flutter/packages?platform=web
[Web support for Flutter]: /web
[write your own plugins]: {{site.medium}}/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1
[run your web apps in any supported browser]: /docs/get-started/web#create-and-run
[Integration testing]: /docs/testing/integration-tests#running-in-a-browser
[internationalizing a Flutter mobile app]: https://flutter.dev/docs/resources/faq#how-do-i-do-internationalization-i18n-localization-l10n-and-accessibility-a11y-in-flutter
