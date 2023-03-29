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
{% endcomment %}


## Deploying Flutter

As of the current stable release,
support for deploying Flutter apps is shown in the
following table:

<div class="table-wrapper" markdown="1">
|Platform version|<center>Supported</center>|<center>Best effort</center>|<center>Unsupported</center>|
|----------------|---------|-----------|-----------|
| Android SDK    |<center>21-30</center>|<center>19-20</center>|<center>18-</center>|
| iOS            |<center>14-15</center>|<center>11-13</center>|<center>10-, arm7v 32-bit</center>|
| Linux Debian   |<center>10-11</center>|<center>9-</center>|<center></center>|
| Linux Ubuntu   |<center>18.04 LTS</center>|<center>20.04</center>|<center>any 32-bit</center>|
| macOS          |<center>Monterey (12+)</center>|<center>Mojave (10.14) to Big Sur (11)</center>|<center>High Sierra (10.13-)</center> |
| web - Chrome   |<center>latest 2 releases</center>|<center>96+</center>| |
| web - Firefox  |<center>latest 2 releases</center>|<center>99+</center>| |
| web - Safari   |<center>latest 2 releases</center>|<center>| |
| web - Edge     | |<center>96+</center>| |
| Windows        |<center>10</center>|<center>7 & 8</center>|<center>Vista-, any 32-bit</center>|
{:.table.table-striped}
</div>

{{site.alert.note}}
  A `plus` sign (`+`) in the table indicates "and higher releases".
  A `minus` (`-`) sign directly following a version (with no spaces)
  indicates "and lower releases".
{{site.alert.end}}
