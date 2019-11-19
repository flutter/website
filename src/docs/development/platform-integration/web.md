---
title: Web FAQ
description: Some gotchas and differences when writing or running web apps in Flutter.
---

### Is the web version of Flutter ready for production?

As of the 1.9 release, the web version of Flutter
is available as a technical preview on the master channel.
Web support has been added to the main Flutter repo,
but is missing features and has known performance issues.
**We don't recommend deploying a web app to production.**

### How do I migrate a web app built using the flutter_web repo to the flutter repo?

See [Upgrading from package:flutter_web
to the Flutter SDK][].

### How do I create an app that also runs on the web?

See [building a web app with
Flutter](/docs/get-started/web).

### Does hot reload work with a web app?

No.

### Can I use Flutter plugins?

Not yet.

### How do I file an issue about web support?

You can [file an issue](https://goo.gle/flutter_web_issue)
on the main Flutter repo. Make sure that "web" is
included in the title.

### How do I refresh the app running in the browser?

You can either use the browser's refresh button,
or you can enter "R" in the console where
"flutter run -d chrome" is running.

### Can I build, run, and deploy web apps in any of the IDEs?

You can select **Chrome** as the target device in
Android Studio/IntelliJ and VS Code if you are using the
latest master channel of Flutter and have enabled web support.
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

See [Creating responsive
apps](/docs/development/ui/layout/responsive).

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

See [Preparing a web app for
release](/docs/deployment/web).

### Does `Platform.is` work on the web?

Not currently.

### How can I compare notes others who are playing with this feature?

Check out the **#web** discussion board on [Discord][].
Flutter engineers routinely read and respond on Discord.



[Analyzing performance]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance
[Chrome DevTools]: https://developers.google.com/web/tools/chrome-devtools
[Debugging]: /docs/development/tools/devtools/debugger
[Discord]: https://discord.gg/N7Yshp4
[file an issue]: https://goo.gle/flutter_web_issue
[Flutter DevTools]: /docs/development/tools/devtools/overview
[Generating event timeline]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference
[`http`]: {{site.pub}}/packages/http
[`iframe`]: https://html.com/tags/iframe/
[Issue 32248]: {{site.github}}/flutter/flutter/issues/32248
[Logging]: /docs/development/tools/devtools/logging
[Running Flutter inspector]: /docs/development/tools/devtools/inspector
[Upgrading from package:flutter_web to the Flutter SDK]: https://github.com/flutter/flutter/wiki/Upgrading-from-package:flutter_web-to-the-Flutter-SDK
[widget tests]: /docs/testing#widget-tests
