---
title: Supported deployment platforms
shortTitle: Supported platforms
description: The platforms that Flutter supports by platform version.
showBreadcrumbs: false
---

As of Flutter {{site.currentFlutterVersion}},
Flutter supports deploying apps on the following combinations of
hardware architectures and operating system versions.
These combinations are called _platforms_.

Flutter categorizes platforms as follows:

* **Supported**: The platforms and versions that the Flutter team supports.
* **CI-tested**: The Flutter team tests these platforms on every commit.
* **Unsupported**: The Flutter team doesn't test or support these platforms.

Based on these categories,
Flutter supports deploying to the following platforms.

{% assign opsys = platforms %}

| Target platform | Target architectures | Supported versions | CI-tested versions |  Unsupported versions |
|---|:---:|:---:|:---:|:---:|
{%- for platform in opsys %}
  | {{platform.platform}} | {{platform.target-arch}} | {{platform.supported}} | {{platform.ci-tested}} | {{platform.unsupported}} |
{%- endfor %}

{:.table .table-striped}
