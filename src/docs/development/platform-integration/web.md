---
title: Web FAQ
description: Some gotchas and differences when writing or running web apps in Flutter.
---

### Is the web version of Flutter ready for production?

As of the 1.9 release, the web version of Flutter is available as
a technical preview on the master/(dev by Sept?) channel.
Web support has been added to the main Flutter repo,
but is missing features and has known performance issues.
**We don't recommend deploying a web app to production.**

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

Using the browser's refresh button doesn't work,
but you can enter "R" in the console where
"flutter run -d chrome" is running.

(Still true?)

### Can I build, run, and deploy web apps in any of the IDEs?

You can select **Chrome** as the target device in
Android Studio/IntelliJ and VS Code if you are using the
master channel of Flutter and have enabled web support.
To enable support, run the following in the terminal:

```terminal
flutter config --enable-web
```

You need only run this once.

If the IDE is already running, restart it.
The device pulldown should now include the **Chrome (web)**
option.

### How do I build a responsive app for the web?

See [Creating responsive
apps](/docs/development/ui/layout/responsive).

## Can I use the `dart:io` package with a web app?

No. The file system is not accessible from the browser.
For network functionality, use the [`http`][]
package. Note that security works somewhat
differently because the browser (and not the app)
controls the headers on an HTTP request.

## How are forward and backward buttons presented in the web UI?

The browser's back button is supported for web apps.
The forward button is not yet enabled.
For more information, see [Issue 32248][].

## How do copy/paste work?

Copy/paste works on mobile. If you encounter problems,
please [file an issue][].

## How do I embed a web app in a web page?

IDK.

## Implementing CORS

HTTP requests work on mobile, but not on the web.
Web applications have special security restrictions.
If you experience problems,
check that the web server you are accessing is setting
CORS headers that accept requests from the domain
hosting your Flutter app.

## How do I avoid JS lockout with CORS?

IDK

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

## How do I deploy a web app?

See [Preparing a web app for
release](/docs/deployment/web).


[Analyzing performance]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance
[Chrome DevTools]: https://developers.google.com/web/tools/chrome-devtools
[Debugging]: /docs/development/tools/devtools/debugger
[file an issue]: https://goo.gle/flutter_web_issue
[Flutter DevTools]: /docs/development/tools/devtools/overview
[Generating event timeline]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference
[`http`]: https://pub.dev/packages/http
[Issue 32248]: {{site.github}}/flutter/flutter/issues/32248
[Logging]: /docs/development/tools/devtools/logging
[Running Flutter inspector]: /docs/development/tools/devtools/inspector
[widget tests]: /docs/testing#widget-tests
