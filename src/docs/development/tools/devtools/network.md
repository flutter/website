---
title: Using the Network View
description: How to use the DevTools network view.
---

{{site.alert.note}}
  The network view works with all Flutter and Dart applications.
{{site.alert.end}}

## What is it?

The network view allows you to inspect HTTP network traffic from your Dart or
Flutter application.

![Screenshot of the network tab]({% asset tools/devtools/network_screenshot.png @path %}){:width="100%"}

## How to use it

HTTP traffic should be recording by default when you open the Network page. If
it is not, click the **Record HTTP traffic** button in the upper left to begin
polling.

Select an HTTP request from the table (left) to view details (right). You can
inspect general information about the request, as well as response and request
headers. You can also view timing information by selecting the **Timing** tab
(upper right). 

## Other resources

HTTP traffic is also surfaced in the [Timeline][timeline] as asynchronous timeline events.
Viewing network activity in the timeline can be useful if you want to see how
HTTP traffic aligns with other events happening in your app or in the Flutter
framework.

[timeline]: /docs/development/tools/devtools/timeline#timeline-events-chart
