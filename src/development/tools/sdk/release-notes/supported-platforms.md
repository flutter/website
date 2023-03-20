---
title: Supported deployment platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

## Support tiers

We define three tiers of support for the platforms on
which built Flutter might be deployed:

1. **Supported**, Google-tested platforms
   are automatically tested at every commit
   by continuous integration testing.
1. **Best-effort** platforms, supported through community
   testing, are platforms we believe we support through
   coding practices and ad-hoc testing,
   but rely on the community for testing.
1. **Unsupported** platforms, which are platforms that
   might work, but that the development team
   doesn't directly test or support.
   
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
|Platform version        | Supported | Best effort | Unsupported |
|------------------------|-----------|-------------|-------------|
| Android SDK 19-30<sup>1</sup> | ✓  |             |             |
| Android SDK 16-18      |           |      ✓      |             |
| Android SDK 15 & below |           |             |      ✓      |
| iOS 14-15              |     ✓     |             |             |
| iOS 11-13              |           |      ✓      |             |
| [iOS 10 & below & `arm7v` 32-bit iOS][] |        |      ✓      |
| Linux Debian 11        |           |      ✓      |             |
| Linux Debian 10        |     ✓     |             |             |
| Linux Debian 9 & below |           |      ✓      |             |
| Linux Ubuntu 22.04 |(aspirational) |      ✓      |             |
| Linux Ubuntu 20.04     |           |      ✓      |             |
| Linux Ubuntu 18.04 LTS |     ✓     |             |             |
| Linux (any 32-bit platform) |      |             |      ✓      |
| macOS Monterey (12) & above |  ✓   |             |             |
| macOS Mojave (10.14) - Big Sur (11) | |   ✓      |             |
| macOS High Sierra (10.13) & below | |            |      ✓      |
| web - Chrome 84        |     ✓     |             |             |
| web - Firefox 72.0     |     ✓     |             |             |
| web - Safari/Catalina  |     ✓     |             |             |
| web - Edge 1.2.0       |     ✓     |             |             |
| Windows 10             |     ✓     |             |             |
| Windows 11          |(aspirational)|      ✓      |             |
| Windows 8              |           |      ✓      |             |
| Windows 7              |           |      ✓      |             |
| Windows Vista & below  |           |             |      ✓      |
| Windows (any 32-bit platform)|     |             |      ✓      |
{:.table.table-striped}
</div>

<sup>1</sup> Passing tests on Android SDK 19 also
  confers a passing result on SDK 20.
  This is because Android SDK 20 has
  additional support for Android Wear,
  but otherwise no new or deprecated API.

[iOS 10 & below & `arm7v` 32-bit iOS]: {{site.url}}/go/rfc-32-bit-ios-unsupported

