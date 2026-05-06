---
title: Validate deep links
description: Learn how to validate deep links in your app.
---

:::note
As of release 3.27, the deep link validator tool
works for _both_ Android and iOS.

To see a demo of the deep link validator,
check out the Google I/O 2024 video,
[No more broken links: Deep linking success in Flutter][].
:::

[No more broken links: Deep linking success in Flutter]: {{site.youtube-site}}/watch?v=d7sZL6h1Elw

The deep link view validates any deep links
that are defined in your app.

To use this feature, open DevTools,
click into the **Deep Links** tab,
and import a Flutter project that contains deep links.

![Screenshot of the Deep Link Validator](/assets/images/docs/tools/devtools/deep-link-validator.png){:width="100%"}

This tool helps you identify and troubleshoot any errors
in your mobile deep link setup,
from website configuration to manifest files.
DevTools provides instructions on how to fix any issues,
making the implementation process easier.
