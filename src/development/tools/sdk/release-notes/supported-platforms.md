---
title: Supported deployment platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

## Support tiers

We define three tiers of support for the platforms on
which built Flutter might be deployed:

1. **Supported**<br>
   Google-tested platforms that
   are automatically tested at every commit
   by continuous integration testing.
1. **Best effort**<br>
   Platforms that we intend to support through
   coding practices,
   but are only tested on an ad-hoc basis.
1. **Unsupported**<br>
   Platforms that we don't test or support.
   
{% comment %}
**IMPORTANT NOTE**:
When changing the minimum support version of macOS, Windows, or Linux,
make sure to make a corresponding change in the get started pages:
  * /src/get-started/install/macos.md
  * /src/get-started/install/windows.md
  * /src/get-started/install/linux.md
{% endcomment %}


## Deploying Flutter

As of the current stable release,
support for deploying Flutter apps is shown in the
following table:

<div class="table-wrapper" markdown="1">
|Platform version|<center>Supported</center>|<center>Best effort</center>|<center>Unsupported</center>|
|----------------|---------|-----------|-----------|
| Android SDK 21-30        |<center>✓</center>| | |
| Android SDK 19-20        | |<center>✓</center>| |
| Android SDK 18 & below   | | |<center>✓</center>|
| iOS 14-15                |<center>✓</center>| | |
| iOS 11-13                | |<center>✓</center>| |
| [iOS 10 & below & `arm7v` 32-bit iOS][] | | |<center>✓</center>|
| Linux Debian 11          | |<center>✓</center>| |
| Linux Debian 10          |<center>✓</center>| | |
| Linux Debian 9 & below   | |<center>✓</center>| |
| Linux Ubuntu 22.04       |in progress|<center>✓</center>| |
| Linux Ubuntu 20.04       | |<center>✓</center>| |
| Linux Ubuntu 18.04 LTS   |<center>✓</center>| | |
| Linux (any 32-bit platform)| | |<center>✓</center>|
| macOS Monterey (12) & above|<center>✓</center>| | |
| macOS Mojave (10.14) - Big Sur (11) | |<center>✓</center>| |
| macOS High Sierra (10.13) & below | | |<center>✓</center>|
| web - Chrome 84          |<center>✓</center>| | |
| web - Firefox 72.0       |<center>✓</center>| | |
| web - Safari/Catalina    |<center>✓</center>| | |
| web - Edge 111.0         |<center>✓</center>|           |        |
| Windows 11               |in progress|<center>✓</center>|        |
| Windows 10               |<center>✓</center>|           |        |
| Windows 8                | |<center>✓</center>| |
| Windows 7                | |<center>✓</center>| |
| Windows Vista & below    | | |<center>✓</center>|
| Windows (any 32-bit platform)| | |<center>✓</center>|
{:.table.table-striped}
</div>

[iOS 10 & below & `arm7v` 32-bit iOS]: {{site.url}}/go/rfc-32-bit-ios-unsupported

