---
title: Using the Logging view
description: Learn how to use the DevTools logging view.
---

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

![Screenshot of a logging view]({% asset tools/devtools/logging_log_entries.png @path %}){:width="100%"}

## Logging from your application

To implement logging in your code,
see the [Logging][] and
[Showing network traffic][] sections in the
[Debugging Flutter apps programmatically][] page.

## Clearing logs

To clear the log entries in the logging view,
click the **Clear logs** button.

[Logging]: /docs/testing/code-debugging#logging
[Debugging Flutter apps programmatically]: /docs/testing/code-debugging
[Showing network traffic]: /docs/testing/code-debugging#showing-network-traffic
