---
title: Web FAQ
description: Some gotchas and differences when writing or running web apps in Flutter.
---

### Is the web version of Flutter ready for production?

As of the 1.9 release, the web version of Flutter is available as
an early release on the master/(dev by Sept?) channel.
Web support has been added to the main Flutter repo,
but is missing features and has known performance issues.
**We don't recommend deploying a web app to production.**

### How do I create an app that also runs on the web?

See [building a web app with
Flutter](/docs/get-started/web).

### Does hot reload work with a web app?

Not yet.

### Can I use Flutter plugins?

Not yet.

### How do I file an issue against web support?

You can [file an issue](https://goo.gle/flutter_web_issue)
on the main Flutter repo. Make sure that "web" is
included in the title.

### How do I refresh the app running in the browser?

Using the browser's refresh button doesn't work,
but you can enter "R" in the console where
"flutter run -d chrome" is running.

### Can I build, run, and deploy web apps in any of the IDEs?

You can select **Chrome** as the target device in
Android Studio and IntelliJ if you are using the
master channel of Flutter and have enabled web support.
To enable support, run the following in the terminal:

```terminal
flutter config --enable-web
```

You need only run this once.

If Android Studio or IntelliJ is already running, restart
it. The device pulldown should now include the **Chrome**
option.

### How do I build a responsive app for the web?

See [Creating responsive
apps](/docs/development/ui/layout/responsive).

## Can I use the `dart:io` package with a web app?

No. You'll use the
[`http`](https://pub.dev/packages/http)
package, though security works somewhat
differently because the browser controls the
headers on an HTTP request.

## How are forward and backward buttons presented in the web UI?

TBD

## How do copy/paste work?

TBD

## Implementing CORS

I don't know, but the browser controls the headers on
HTTP requests.

### How do I debug a web app?

Use [Flutter DevTools](/docs/development/tools/devtools/overview)
for the following tasks:

* [Debugging](/docs/development/tools/devtools/debugger)
* [Logging](/docs/development/tools/devtools/logging)
* [Running Flutter inspector](/docs/development/tools/devtools/inspector)

Use [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools/)
for the following tasks:

* [Generating event
  timeline](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference)
* [Analyzing
  performance](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/)

### How do I test a web app?

Unit tests can be run on the web with the argument
`--platform=chrome`. This compiles the tests to
JavaScript and runs them in a headless Chrome browser.
Note that there are compatibility issues with many
flutter tests and bugs with the test bootstrap itself
that need to be resolved.

```terminal
$ flutter test --platform=chrome
> Downloading Web SDK...                       1.1s
> Running "flutter pub get" in flutter...      0.4s
>                                                                        
> Compiling test/scheduler/debug_test.dart for the Web...   
```

Driver tests are not yet supported.

### How do I internationalize a web app?

TBD

## How do I deploy a web app?

See [Preparing a web app for
release](/docs/deployment/web).
