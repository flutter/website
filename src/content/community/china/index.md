---
title: Using Flutter in China
description: How to use, access, and learn about Flutter in China.
toc: true
os-list: [Windows, macOS, Linux, ChromeOS]
---

{% assign flutter-sdk = 'flutter_opsys_v3.13.0-stable.' %}
{% capture sdk-path -%}flutter_infra_release/releases/stable/opsys/{{flutter-sdk}}{%- endcapture %}

{% render docs/china-notice-cn.md %}

To speed the download and installation of Flutter in China,
consider using a [mirror site][] or _mirror_.

:::important
Use mirror sites _only_ if you _trust_ the provider.
The Flutter team can't verify their reliability or security.
:::

[mirror site]: https://en.wikipedia.org/wiki/Mirror_site

## Use a Flutter mirror site

The [China Flutter User Group][] (CFUG) maintains a Simplified Chinese
Flutter website [https://flutter.cn](https://flutter.cn) and a mirror.
Other mirrors can be found at the [end of this guide](#known-trusted-community-run-mirror-sites).

### Configure your machine to use a mirror site

To install or use Flutter in China, use a trustworthy Flutter mirror.
This requires setting two environment variables on your machine.

_All examples that follow presume that you are using the CFUG mirror._

To set your machine to use a mirror site:

{% tabs "china-setup-os" %}

{% for os in os-list %}
{% tab os %}

{% include docs/community/china/os-settings.md ref-os=os sdk=flutter-sdk %}

{% endtab %}
{% endfor -%}

{% endtabs %}

### Download Flutter archives based on a mirror site

To download Flutter from the [SDK archive][] from a mirror,
replace `storage.googleapis.com` with the URL of your trusted mirror.
Use your mirror site in the browser or in other applications
like IDM or Thunder.
This should improve download speed.

[SDK archive]: /release/archive

The following example shows how to change the URL for Flutter's download site
from Google's archive to CFUG's mirror.

{% tabs "china-setup-os" %}

{% for os in os-list %}
{% tab os %}

{% include docs/community/china/download-urls.md ref-os=os filepath=sdk-path %}

{% endtab %}
{% endfor -%}

{% endtabs %}

:::note
Not every mirror supports downloading artifacts using their direct URL.
:::

## Configure your machine to publish your package

To publish your packages to `pub.dev`,
you need to be able to access both Google Auth and the `pub.dev` site.

{% comment %}
From <https://github.com/flutter/website/pull/9338#discussion_r1328077020>
{% endcomment %}

To enable access to `pub.dev`:

{% tabs "china-setup-os" %}

{% for os in os-list %}
{% tab os %}

{% include docs/community/china/pub-settings.md os=os filepath=path %}

{% endtab %}
{% endfor -%}

{% endtabs %}

To learn more about publishing packages, check out the
[Dart documentation on publishing packages][].

[Dart documentation on publishing packages]: {{site.dart-site}}/tools/pub/publishing

## Known, trusted community-run mirror sites

The Flutter team can't guarantee long-term availability of any mirrors.
You can use other mirrors if they become available.

{% for mirror in mirrors %}

<hr>

### {{mirror.group}}

[{{mirror.group}}][] maintains the `{{mirror.mirror}}` mirror.
It includes the Flutter SDK and pub packages.

#### Configure your machine to use this mirror

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```console
export PUB_HOSTED_URL={{mirror.urls.pubhosted}};
export FLUTTER_STORAGE_BASE_URL={{mirror.urls.flutterstorage}}
```

On Windows:

```console
$env:PUB_HOSTED_URL="{{mirror.urls.pubhosted}}";
$env:FLUTTER_STORAGE_BASE_URL="{{mirror.urls.flutterstorage}}"
```

#### Get support for this mirror

If you're running into issues that only occur when
using the `{{mirror.mirror}}` mirror, report the issue to their
[issue tracker]({{mirror.urls.issues}}).

{% endfor %}

{% for mirror in mirrors %}
[{{mirror.group}}]: {{mirror.urls.group}}
{% endfor %}

## Offer to host a new mirror site

If you're interested in setting up your own mirror,
contact [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
for assistance.

