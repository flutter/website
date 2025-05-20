---
title: Building a web application with Flutter
description: Instructions for creating a Flutter app for the web.
short-title: Web development
---

This page provides an overview of how to configure, run, and build a web
application using Flutter.

## Requirements

Before you can build a web application with Flutter,
make sure that you have the [Flutter SDK][] and a web browser installed.
See the [Set up web development for Flutter][Setup-web] instructions
for details.

## Set up a Flutter project

To set up your project, you can create a
new Flutter project or add web support
to an existing project.

### Create a new project

To create a new app that includes web support, run the following command:

```console
$ flutter create my_app 
```

### Add web support to an existing project

If you already have a project,
run the `flutter create` command in your project directory:

```console
$ flutter create . --platforms web
```

This creates a `web/` directory containing the web assets used to bootstrap
and run your Flutter app. 

## Run your app

Select [Chrome][] as your app's target device to run and debug
a Flutter web app:

```console
$ flutter run -d chrome
```

You can also choose Chrome as a target device in your IDE.

If you prefer, you can use the `edge` device type on Windows,
or use `web-server` to
navigate to a local URL in the browser of your choice.

<a id="hot-reload-web" aria-hidden="true" ></a>

:::note Hot reload on the web
As of the Flutter 3.32 release, you can experiment
with hot reload on the web behind a flag.
[Hot restart][], which restarts your app
without refreshing the web page,
doesn't require a flag.

If you discover any issues we ask that you file a bug
using our new [Web Hot Reload issue template][].
Note this is in the Dart SDK repository where it's easier
for us to track issues. Known issues can be seen in the
associated [GitHub project][]. 

To try hot reload for the web, pass the `--web-experimental-hot-reload` flag
wherever you invoke `flutter run -d chrome`.

### Running from VS Code

If you use debug configurations in VS code,
you can add this extra configuration to your
[`launch.json` file][].

### Running from the command line

If you use `flutter run` from the command line,
you can now run hot reload on the web with the
following command:

```console
flutter run -d chrome --web-experimental-hot-reload
```

When hot reload is enabled,
you can reload your application by pressing "r"
in the running terminal, or "R" to hot restart.

### Reloading in DartPad

Hot reload is also enabled in DartPad with a new "Reload" button.
The feature is only available if Flutter is detected
in the running application. You can begin a hot reloadable
session by selecting a sample app provided by DartPad.

:::

[Hot restart]: /tools/hot-reload
[How to switch channels]: /install/upgrade#switching-flutter-channels
[`launch.json` file]: https://code.visualstudio.com/docs/debugtest/debugging-configuration
[Web Hot Reload issue template]: {{site.github}}/dart-lang/sdk/issues/new?template=6_web_hot_reload.yml
[GitHub project]: {{site.github}}/orgs/dart-lang/projects/107/views/1

### Run your app using WebAssembly

You can pass the `--wasm` flag to run your app using WebAssembly:

```console
$ flutter run -d chrome --wasm
```

Flutter web offers multiple build modes and renderers.
For more information, see [Web renderers][].

## Build your app

Run the following command to generate a release build:

```console
$ flutter build web
```

### Build your app using WebAssembly
You can also pass the `--wasm` flag to build your app using WebAssembly:

```console
$ flutter build web --wasm
```

This populates a `build/web` directory
with built files, including an `assets` directory,
which need to be served together.

To learn more about how to deploy these assets to the web, see
[Build and release a web app][].
For answers to other common questions, see the [Web FAQ][].

## Debugging

Use [Flutter DevTools][] for the following tasks:

* [Debugging][]
* [Logging][]
* [Running Flutter inspector][]

Use [Chrome DevTools][] for the following tasks:

* [Generating event timeline][]
* [Analyzing performance][]&mdash;make sure to use a
  profile build

## Testing

Use [widget tests][Widget tests] or integration tests. To learn more about
running integration tests in a browser, see the [Integration testing][] page.

[Analyzing performance]: {{site.developers}}/web/tools/chrome-devtools/evaluate-performance
[Build and release a web app]: /deployment/web
[Chrome DevTools]: {{site.developers}}/web/tools/chrome-devtools
[Chrome]: https://www.google.com/chrome/
[Debugging]: /tools/devtools/debugger
[Flutter DevTools]: /tools/devtools
[Flutter SDK]: /get-started/install
[Generating event timeline]: {{site.developers}}/web/tools/chrome-devtools/evaluate-performance/performance-reference
[Integration testing]: /testing/integration-tests#test-in-a-web-browser
[Logging]: /tools/devtools/logging
[Running Flutter inspector]: /tools/devtools/inspector
[Setup-web]: {{site.url}}/platform-integration/web/setup
[Web FAQ]: /platform-integration/web/faq
[Web renderers]: /platform-integration/web/renderers
[Widget tests]: /testing/overview#widget-tests

