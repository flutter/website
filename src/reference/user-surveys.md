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

Your responses submitted via survey will be used to improve 
Flutter and Dart. This information will be stored independently 
from the information sent to Google via analytics. You can see 
how previous surveys were used to improve Flutter and Dart on 
[Medium][]. 

## How can I disable it?

You may mute survey announcements by clicking a button on the 
message. Or you may choose to opt-out of analytics and crash 
reporting, by following the steps described in the “Disabling 
analytics reporting” section of the [Flutter crash reporting page]({{site.url}}/reference/crash-reporting).

[Medium]: https://medium.com/flutter/search?q=survey
