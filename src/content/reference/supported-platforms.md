---
title: Supported deployment platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

As of Flutter {{site.appnow.flutter}},
Flutter supports deploying apps the following combinations of
hardware architectures and operating system versions.
These combinations are called _platforms_.

Flutter supports platforms in three tiers:

* **Supported**: The Flutter team tests these platforms on every commit.
* **Best effort**: The Flutter team intends to support these platforms
  through coding practices. The team tests these platforms on an ad-hoc basis.
* **Unsupported**: The Flutter team doesn't test or support these platforms.

Based on these tiers, Flutter supports deploying to the following platforms.

{% assign opsys = platforms %}

| Target Platform | Hardware architectures | Supported versions | Best effort versions | Unsupported versions |
|---|:---:|:---:|:---:|:---:|
{%- for platform in opsys %}
  | {{platform.platform}} | {{platform.chipsets}} | {{platform.supported}} | {{platform.besteffort}} | {{platform.unsupported}} |
{%- endfor %}

{:.table .table-striped}
