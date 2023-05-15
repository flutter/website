---
title: User surveys
description: Why users see a survey announcement, how the data is used, and how to disable.
---

## Why do I see a survey announcement?
If you have not opted-out of Flutter’s 
[analytics and crash reporting]({{site.url}}/reference/crash-reporting), 
you may receive a survey announcement in your IDE. 

We run two types of surveys:
1. Quarterly surveys - For these surveys, we notify all active
 Flutter and Dart users to optionally take the survey.
2. Ad-hoc surveys (experimental): We design and deploy these 
surveys when we want to learn more about specific topics. 
You may see a survey announcement if you meet the criteria of 
the survey  based on data stored in the 
`.dart-tool/dart-flutter-telemetry.log` file under the home directory
`~/` (macOS/Linux) or the `<username>\AppData` (Windows) directory. 

## How will my responses be used?

We use the responses you submit via survey to improve 
Flutter and Dart. We store this information independent 
of the information sent to Google via analytics.
To see how we used prior surveys to improve Flutter and Dart,
check out our blogs on [Medium][]. 

## How can I disable it?

To mute survey announcements, you might do one of the following:

1. Click the button on the message.
2. Opt-out of analytics and crash reporting per the steps
  given in
  [Disabling 
analytics reporting]({{site.url}}/reference/crash-reporting#disabling-analytics-reporting).

[Medium]: https://medium.com/flutter/search?q=survey
