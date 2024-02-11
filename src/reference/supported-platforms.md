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

| Platform version |     Supported     |                 Best effort                  |           Unsupported            |
|------------------|:-----------------:|:--------------------------------------------:|:--------------------------------:|
| Android SDK      |       21-34       |                    19-20                     |          18 or earlier           |
| iOS              |       16-17       |                    12-15                     |          11 or earlier           |
| macOS            |   Ventura (13)    | Mojave (10.14) to Monterey (12), Sonoma (14) |  High Sierra (10.13) or earlier  |
| Windows          |        10         |                   7, 8, 11                   |   Any 32-bit, Vista or earlier   |
| Linux Debian     |       11-12       |                      10                      |     9 or earlier, any 32-bit     |
| Linux Ubuntu     | 20.04, 22.04 LTS  |                 22.10-23.10                  | Non-LTS before 22.04, any 32-bit |
| web - Chrome     | Latest 2 releases |                 96 or later                  |          95 or earlier           |
| web - Firefox    | Latest 2 releases |                 99 or later                  |          98 or earlier           |
| web - Safari     | Latest 2 releases |                 14 or later                  |          13 or earlier           |
| web - Edge       | Latest 2 releases |                 96 or later                  |          95 or earlier           |
{:.table.table-striped}

</div>
