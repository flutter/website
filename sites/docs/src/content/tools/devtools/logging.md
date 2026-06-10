---
title: Use the Logging view
description: Learn how to use the DevTools logging view.
---

:::note
The logging view works with all Flutter and Dart applications.
:::

## What is it?

The logging view displays events from the Dart runtime,
application frameworks (like Flutter), and application-level
logging events.

## Standard logging events

By default, the logging view shows:

* Garbage collection events from the Dart runtime
* Flutter framework events, like frame creation events
* `stdout` and `stderr` from applications
* Custom logging events from applications

![Screenshot of a logging view](/assets/images/docs/tools/devtools/logging_log_entries.png){:width="100%"}

## Logging from your application

To implement logging in your code,
see the [Logging][] section in the
[Debugging Flutter apps programmatically][]
page.

## Clearing logs

To clear the log entries in the logging view,
click the **Clear logs** button.

[Logging]: /testing/code-debugging#add-logging-to-your-application
[Debugging Flutter apps programmatically]: /testing/code-debugging

## Other resources

To learn about different methods of logging
and how to effectively use DevTools to
analyze and debug Flutter apps faster,
check out a guided [Logging View tutorial][logging-tutorial].

[logging-tutorial]: {{site.medium}}/@fluttergems/mastering-dart-flutter-devtools-logging-view-part-5-of-8-b634f3a3af26
