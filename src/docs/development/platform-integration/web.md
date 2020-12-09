---
title: Web FAQ
description: Some gotchas and differences when writing or running web apps in Flutter.
---

### Is the web version of Flutter ready for production?

Flutter web support is available on the beta channel.
As is typical for beta software, we're still making
changes to improve performance and quality, and you
may discover rendering bugs compared to the stable
mobile platforms. While web support is in beta,
we recommend careful testing on a variety of platforms
before deploying to production, and that you track and
apply Flutter updates to your deployed site on a regular
basis.

### What scenarios are ideal for Flutter on the web?

While traditional web approaches remain a great choice,
we envision the web support available in Flutter being
valuable in many scenarios. For example:

* Rich interactive single page applications
* Connected Progressive Web Applications (PWAs)
* Embedding dynamic/interactive content in an existing website

Not every HTML scenario is ideally suited for Flutter at
this time. For example, text-rich flow-based content such
as blog articles benefit from the document-centric model that
the web is built around, rather than the app-centric services
that a UI framework like Flutter can deliver.
However, you _can_ use Flutter to
embed interactive experiences into these websites.

For more information on how you can use Flutter on the web,
see [Web support for Flutter][].

### How do I file an issue about web support?

You can [file an issue][] on the main Flutter repo.
Make sure that "web" is included in the title.

### How do I migrate a web app built using the flutter_web repo to the flutter repo?

See [Upgrading from package:flutter_web to the Flutter SDK][].

### How do I create an app that also runs on the web?

See [building a web app with Flutter][].

### Does hot reload work with a web app?

No, but you can use hot restart.

### How do I refresh the app running in the browser?

You can either use the browser's refresh button,
or you can enter "R" in the console where
"flutter run -d chrome" is running.

### Which web browsers are supported by Flutter?

Flutter web apps can run on the following browsers:

* Chrome (mobile & desktop)
* Safari (mobile & desktop)
* Edge (mobile & desktop)
* Firefox (desktop)

During development, Chrome (on macOS, Windows, and Linux) and Edge (on Windows)
are supported as the default browsers for debugging your app. In order to test
your web app on other browsers use the `Web server` device option to get a URL
serving the app. Learn more on how to [run your web apps in any supported
browser][]

### Can I build, run, and deploy web apps in any of the IDEs?

You can select a browser as the target device, such as **Chrome**, in
Android Studio/IntelliJ and VS Code if you are using the
latest beta channel of Flutter and have enabled web support.
To enable support, run the following in the terminal:

```terminal
flutter config --enable-web
```

You need only run this once.
This command modifies (or creates) the
`~/.flutter_settings` file (on Mac/Linux)
with the following:

```shell
{
  "enable-web": true
}
```

If the IDE is already running, restart it.
The device pulldown should now include the **Chrome (web)**
option.

### What version of the IDE and corresponding Flutter plugin is required?

Because web support is in active development,
we recommend that you use the latest version of
your IDE, and the latest version of the Flutter
and Dart plugins.

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

### How are forward and backward buttons presented in the web UI?

The browser's back button is supported for web apps.
The forward button is not yet enabled.
For more information, see [Issue 32248][].

### How does copy/paste work?

Copy/paste works on mobile. If you encounter problems,
please [file an issue][].

### How do I embed a Flutter web app in a web page?

You can embed a Flutter web app,
as you would embed other content,
in an [`iframe`][] tag of an HTML file.
In the following example, replace "URL"
with the location of your hosted HTML page:

```html
<iframe src="URL"></iframe>
```

### Implementing CORS

Web applications have special security restrictions.
If you experience problems,
check that the web server you are accessing is setting
CORS headers that accept requests from the domain
hosting your Flutter app.

### How do I avoid JavaScript lockout with CORS?

TBD

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

Use the normal [widget tests][].

Driver tests are not yet supported.

### How do I internationalize a web app?

TBD

### How do I deploy a web app?

See [Preparing a web app for release][].

### Does `Platform.is` work on the web?

Not currently.

### How can I compare notes with others who are playing with this feature?

Check out the **#hackers-web-🌍** discussion board on [Discord][].
Flutter engineers routinely read and respond on Discord.


[Analyzing performance]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance
[building a web app with Flutter]: /docs/get-started/web
[Chrome DevTools]: https://developers.google.com/web/tools/chrome-devtools
[Creating responsive apps]: /docs/development/ui/layout/responsive
[Debugging]: /docs/development/tools/devtools/debugger
[Discord]: https://discord.gg/N7Yshp4
[file an issue]: https://goo.gle/flutter_web_issue
[Flutter DevTools]: /docs/development/tools/devtools/overview
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
[run your web apps in any supported browser]: https://flutter.dev/docs/get-started/web#create-and-run
