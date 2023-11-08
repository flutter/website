---
title: Using Flutter in China
description: Where to find a version of the Flutter site that is localized to Simplified Chinese.
toc: true
os-list: [Windows, macOS, Linux, ChromeOS]
---

{% assign flutter-sdk = 'flutter_opsys_v3.13.0-stable.' %}
{% capture sdk-path -%}flutter_infra_release/releases/stable/opsys/{{flutter-sdk}}{%- endcapture %}

To speed the download and installation of Flutter in China,
consider using a [mirror site][].

{{site.alert.important}}
  Use mirror sites _only_ if you _trust_ the provider.
  The Flutter team can't verify their reliability or security.
{{site.alert.end}}

[mirror site]: https://en.wikipedia.org/wiki/Mirror_site

## Use a Flutter mirror site

The [China Flutter User Group][] (CFUG) maintains a Simplified Chinese
Flutter website [https://flutter.cn](https://flutter.cn) and a mirror.
Other mirrors can be found at the [end of this guide](#known-trusted-community-run-mirror-sites).

### Configure your machine to use a mirror site

To install or use Flutter in China, use a trustworthy Flutter mirror site.
This requires setting two environment variables on your machine.

_All examples that follow presume that you are using the CFUG mirror._

To set your machine to use a mirror site:

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="china-os-tabs" role="tablist">
{% for os in page.os-list %}
{% assign id = os | downcase -%}
  <li class="nav-item">
    <a class="nav-link {%- if id == 'windows' %} active {% endif %}" id="{{id}}-tab" href="#{{id}}" role="tab" aria-controls="{{id}} {{id}}-dl {{id}}-pub" aria-selected="true">{{os}}</a>
  </li>
{% endfor -%}
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
{% for os in page.os-list %}
{% include_relative _os-settings.md ref-os=os sdk=flutter-sdk %}
{% endfor -%}
</div>

### Download Flutter archives based on a mirrored URL

To download Flutter archives from a mirrored URL,
replace `storage.googleapis.com` with the URL of your trusted mirror.
This should improve download speed.
You can use the mirror URL in other applications to download software.

To change a Google storage site to a CFUG storage site, replace the example
original URL with the example mirror URL.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="china-os-dl-tabs" role="tablist">
{% for os in page.os-list %}
{% assign id = os | downcase -%}
  <li class="nav-item">
    <a class="nav-link {%- if id == 'windows' %} active {% endif %}" id="{{id}}-dl-tab" href="#{{id}}-dl" role="tab" aria-controls="{{id}} {{id}}-dl {{id}}-pub" aria-selected="true">{{os}}</a>
  </li>
{% endfor -%}
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
{% for os in page.os-list %}
{% include_relative _download-urls.md ref-os=os filepath=sdk-path %}
{% endfor -%}
</div>

{{site.alert.note}}
  Not every mirror supports downloading artifacts using their direct URL.
{{site.alert.end}}

## Configure your machine to publish your package

To publish your packages to `pub.dev`,
you need to be able to access both Google Auth and the `pub.dev` site.

{% comment %}
From https://github.com/flutter/website/pull/9338#discussion_r1328077020
{% endcomment %}

To enable access to `pub.dev`:

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="china-os-pub-tabs" role="tablist">
{% for os in page.os-list %}
{% assign id = os | downcase -%}
  <li class="nav-item">
    <a class="nav-link {%- if id == 'windows' %} active {% endif %}" id="{{id}}-pub-tab" href="#{{id}}-pub" role="tab" aria-controls="{{id}} {{id}}-pub" aria-selected="true">{{os}}</a>
  </li>
{% endfor -%}
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
{% include_relative _pub-settings.md os="Windows" filepath=path %}
{% include_relative _pub-settings.md os="macOS" filepath=path %}
{% include_relative _pub-settings.md os="Linux" filepath=path %}
{% include_relative _pub-settings.md os="ChromeOS" filepath=path %}
</div>

To learn more about publishing packages, check out
[Dart documentation on publishing packages][].

[Dart documentation on proxies]: {{site.dart-site}}/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall

[Dart documentation on publishing packages]: {{site.dart-site}}/tools/pub/publishing

## Known, trusted community-run mirror sites

The Flutter team cannot guarantee long-term availability of any mirrors.
You can use other mirrors if they become available.

{% for mirror in site.data.mirrors %}

<hr>

### {{mirror.group}}

[{{mirror.group}}][] maintains the `{{mirror.mirror}}` mirror.
It includes the Flutter SDK and pub packages.

#### Configure your machine to use this mirror
{:.no_toc}

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```terminal
export PUB_HOSTED_URL={{mirror.urls.pubhosted}};
export FLUTTER_STORAGE_BASE_URL={{mirror.urls.flutterstorage}}
```

On Windows:

```terminal
$env:PUB_HOSTED_URL="{{mirror.urls.pubhosted}}";
$env:FLUTTER_STORAGE_BASE_URL="{{mirror.urls.flutterstorage}}"
```

#### Get support for this mirror
{:.no_toc}

If you're running into issues that only occur when
using the `{{mirror.mirror}}` mirror, report the issue to their
[issue tracker]({{mirror.urls.issues}}).

{% endfor %}

{% for mirror in site.data.mirrors %}
[{{mirror.group}}]: {{mirror.urls.group}}
{% endfor %}

## Offer to host a new mirror site

If you're interested in setting up your own mirror,
contact [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
for assistance.
