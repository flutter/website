---
title: Supported platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

## Support Tiers

We define three tiers of support for the platforms on
which Flutter runs:

1. Google-tested platforms
  are automatically tested at every commit
  by continuous integration testing.
1. Best-effort platforms, supported through community
   testing, are platforms we believe we support through
   coding practices and ad-hoc testing,
   but rely on the community for testing.
1. Unsupported platforms, which are platforms that
   might work, but that the development team
   doesn't directly test or support.
   
## Supported platforms

As of the current release,
Flutter supports the following platforms as part of Google-tested and best-effort platform tier:

<div class="table-wrapper" markdown="1">
|Platform|Version                       |Channels |
|--------|------------------------------|---------|
|Android | API 16 (Android 4.1) & above | All     |
|iOS     | iOS 11 & above               | All     |
|Linux   | Debian, 64-bit               | All     |
|macOS   | El Capitan (10.11) & above   | All     |
|Web     | Chrome 84  & above           | All     |
|Web     | Firefox 72.0 & above         | All     |
|Web     | Safari on El Capitan & above | All     |
|Web     | Edge 1.2.0 & above           | All     |
|Windows | Windows 7 & above, 64-bit    | All     |
{:.table.table-striped}
</div>

All channels include master, beta,
and stable channels.

### Google-tested platforms

<div class="table-wrapper" markdown="1">
|Platform|Version               |
|--------|----------------------|
|Android |Android SDK 19–30*    |
|iOS     |14-15                 |
|Linux   |Debian 10             |
|Linux   |Ubuntu 18.04 LTS      |
|macOS   |Monterey (12) & above |
|Web     |Chrome 84             |
|Web     |Firefox 72.0          |
|Web     |Safari / Catalina     |
|Web     |Edge 1.2.0            |
|Windows |Windows 10            |
{:.table.table-striped}
</div>

\* Passing tests on Android SDK 19 also confers a passing result on SDK 20.
  This is because Android SDK 20 has additional support for Android Wear,
  but otherwise no new or deprecated API.

### Best-effort platforms

<div class="table-wrapper" markdown="1">
|Platform|Version             |
|--------|--------------------|
|Android |Android SDK 16–18   |
|iOS     |iOS 11-13           |
|Linux   |Debian 11           |
|Linux   |Debian 9 & below    |
|Linux   |Ubuntu 20.04        |
|Linux   |Ubuntu 22.04 (Aspirational Google-tested platform)        |
|macOS   |El Capitan (10.11) - Big Sur (11)*   |
|Windows |Windows 11 (Aspirational Google-tested platform)          |
|Windows |Windows 8           |
|Windows |Windows 7           |
{:.table.table-striped}
</div>

\* Flutter 3.3 is the last stable release with macOS 10.11 and 10.12 best-effort support.

### Unsupported platforms

<div class="table-wrapper" markdown="1">
|Platform|Version                                     |
|--------|--------------------------------------------|
|Android |Android SDK 15 & below                      |
|iOS     |[iOS 10 & below and `arm7v` 32-bit iOS][]   |
|Linux   |Any 32-bit platform                         |
|macOS   |Yosemite (10.10) & below                    |
|Windows |Windows Vista & below                       |
|Windows |Any 32-bit platform                         |

{:.table.table-striped}
</div>
[iOS 10 & below and `arm7v` 32-bit iOS]: {{site.url}}/go/rfc-32-bit-ios-unsupported
