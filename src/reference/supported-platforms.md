---
title: Supported deployment platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

## Support tiers

We define three tiers of support for the platforms on
which apps built with Flutter might be deployed:

1. **Supported**<br>
   Google-tested platforms that
   are automatically tested on every commit
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
{% endcomment -%}


## Deploying Flutter

As of the current stable release,
support for deploying Flutter apps is shown in the
following table:

<div class="table-wrapper" markdown="1">
|Platform version|Supported|Best effort|Unsupported|
|----------------|---------|-----------|-----------|
| Android SDK    |21-31|19-20|18-|
| iOS            |16|11-15|10-, arm7v 32-bit|
| Linux Debian   |10-11|9-|any 32-bit|
| Linux Ubuntu   |18.04 LTS|20.04-22.04|any 32-bit|
| macOS          |Monterey (12+)|Mojave (10.14) to Big Sur (11)|High Sierra (10.13-) |
| web - Chrome   |latest 2 releases|96+| |
| web - Firefox  |latest 2 releases|99+| |
| web - Safari   |latest 2 releases|14+| |
| web - Edge     |latest 2 releases|96+| |
| Windows        |10|7, 8, and 11|Vista-, any 32-bit|
{:.table.table-striped.table-centered-after-first}
</div>

{{site.alert.note}}
  A `plus` sign (`+`) in the table indicates "and higher releases".
  A `minus` (`-`) sign directly following a version (with no spaces)
  indicates "and lower releases".
{{site.alert.end}}
