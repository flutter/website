---
title: Use the Network View
description: How to use the DevTools network view.
---

:::note
The network view works with all Flutter and Dart applications.
:::

## What is it?

The network view allows you to inspect HTTP, HTTPS, and web socket traffic from
your Dart or Flutter application.

![Screenshot of the network screen](/assets/images/docs/tools/devtools/network_screenshot.png){:width="100%"}

## How to use it

Network traffic should be recording by default when you open the Network page.
If it is not, click the **Resume** button in the upper left to
begin polling.

Select a network request from the table (left) to view details (right). You can
inspect general and timing information about the request, as well as the content
of response and request headers and bodies.

### Search and filtering

You can use the search and filter controls to find a specific request or filter
requests out of the request table.

![Screenshot of the network screen](/assets/images/docs/tools/devtools/network_search_and_filter.png)

To apply a filter, press the filter button (right of the search bar). You will
see a filter dialog pop up:

![Screenshot of the network screen](/assets/images/docs/tools/devtools/network_filter_dialog.png)

The filter query syntax is described in the dialog. You can filter network
requests by the following keys:
* `method`, `m`: this filter corresponds to the value in the "Method" column
* `status`, `s`: this filter corresponds to the value in the "Status" column
* `type`, `t`: this filter corresponds to the value in the "Type" column

Any text that is not paired with an available filter key will be queried against
all categories (method, uri, status, type).

Example filter queries:

```plaintext
my-endpoint m:get t:json s:200
```

```plaintext
https s:404
```

### Recording network requests on app startup

To record network traffic on app startup, you can start your app in a paused
state then, begin recording before your app starts:

1. Start your app in a paused state:
    * `flutter run --start-paused ...`
    * `dart run --pause-isolates-on-start ...`
2. Open DevTools from the IDE where you started your app, or from the link that
   was printed to the command line if you started your app from the CLI.
3. Navigate to the Network screen and ensure that recording has started.
4. Resume your app.
   ![Screenshot of the app resumption experience on the Network screen](/assets/images/docs/tools/devtools/network_startup_resume.png){:width="100%"}
5. The Network profiler will now record all network traffic from your app,
   including traffic from app startup.

## Other resources

HTTP and HTTPs requests are also surfaced in the [Timeline][timeline] as
asynchronous timeline events. Viewing network activity in the timeline can be
useful if you want to see how HTTP traffic aligns with other events happening
in your app or in the Flutter framework.

To learn how to monitor an app's network traffic and inspect
different types of requests using the DevTools,
check out a guided [Network View tutorial][network-tutorial].
The tutorial also uses the view to identify network activity that
causes poor app performance.

[timeline]: /tools/devtools/performance#timeline-events-tab
[network-tutorial]: {{site.medium}}/@fluttergems/mastering-dart-flutter-devtools-network-view-part-4-of-8-afce2463687c
