---
title: Using Flutter in China
description: Where to find a version of the Flutter site that is localized to Simplified Chinese.
toc: true
os-list: [Windows, macOS, Linux, ChromeOS]
---

{% assign path = 'flutter_infra_release/releases/stable/windows/flutter_windows_3.3.0-stable.zip' -%}

To speed the download and installation of Flutter in China,
consider using a mirror site.

{{site.alert.important}}
  Use mirror sites only if you _trust_ the provider.
  The Flutter team cannot verify their reliability or security.
{{site.alert.end}}

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
    <a class="nav-link {%- if id == 'windows' %} active {% endif %}" id="{{id}}-tab" href="#{{id}}" role="tab" aria-controls="{{id}}" aria-selected="true">{{os}}</a>
  </li>
{% endfor -%}
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
{% include_relative _os-settings.md os="Windows" %}
{% include_relative _os-settings.md os="macOS" %}
{% include_relative _os-settings.md os="Linux" %}
{% include_relative _os-settings.md os="ChromeOS" %}
</div>

### Download Flutter archives based on a mirrored URL

To download Flutter archives from a mirrored URL,
replace `storage.googleapis.com` with the URL of your trusted mirror.
This should improve download speed and the replaced URL
can be used to download other software.

{{site.alert.note}}
  Not every mirror supports downloading artifacts using a replaced URL.
{{site.alert.end}}

For example:

* Original URL:<br>
  [`https://storage.googleapis.com/{{path}}`](https://storage.googleapis.com/{{path}})

* Mirrored URL:<br>
  [`https://storage.flutter-io.cn/{{path}}`](https://storage.flutter-io.cn/{{path}})

## Configure your machine to publish your package

To publish your packages to pub.dev,
you need to be able to access both Google Auth and the pub.dev site.

  {% comment %}
  From https://github.com/flutter/website/pull/9338#discussion_r1328077020
  {% endcomment %}

To publish packages to pub.dev:

1. Configure a proxy.
   To configure a proxy, check out the [Dart documentation on proxies][].

  {% comment %}
  From https://github.com/flutter/website/issues/2556#issuecomment-481566476
  {% endcomment %}

1. Verify that your `PUB_HOSTED_URL` environment variable is either unset
   or empty.

   On macOS, Linux, or ChromeOS, run this command:

   ```bash
   echo $PUB_HOSTED_URL
   ```

   If this command returns any value, unset it.

   ```bash
   unset $PUB_HOSTED_URL
   ```

   On Windows, run this command:

   ```powershell
   echo $env:PUB_HOSTED_URL
   ```

   If this command returns any value, unset it.

   ```powershell
   Remove-Item $env:PUB_HOSTED_URL
   ```

To learn more about publishing packages, check out
[Dart documentation on publishing packages][].

[Dart documentation on proxies]: {{site.dart-site}}/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall

[Dart documentation on publishing packages]: {{site.dart-site}}/tools/pub/publishing

## Details on mirror sites

### Support for mirror sites

The Flutter team cannot guarantee long-term availability of any mirrors.
You can use other mirrors if they become available.

### Host new mirror sites

If you're interested in setting up your own mirror,
contact [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
for assistance.

### Known, trusted community-run mirror sites

#### China Flutter User Group

[China Flutter User Group][] maintains the `flutter-io.cn` mirror.
It includes Flutter and packages.

If you're running into issues that only occur when
using the `flutter-io.cn` mirror, report the issue to their
[issue tracker (镜像问题)]({{site.github}}/cfug/flutter.cn/issues/new/choose).

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

On Windows:

```powershell
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

#### Shanghai Jiao Tong University *nix User Group

[Shanghai Jiao Tong University *nix User Group][]
maintains the `mirror.sjtu.edu.cn` mirror.
It includes Flutter and packages.

If you're running into issues that only occur when
using the `mirror.sjtu.edu.cn` mirror, report the issue to their
[issue tracker (议题)](https://github.com/sjtug/mirror-requests).

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```bash
export FLUTTER_STORAGE_BASE_URL=https://mirror.sjtu.edu.cn
export PUB_HOSTED_URL=https://mirror.sjtu.edu.cn/flutter-infra
```

On Windows:

```powershell
$env:PUB_HOSTED_URL="https://mirror.sjtu.edu.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://mirror.sjtu.edu.cn/flutter-infra"
```

[China Flutter User Group]: https://github.com/cfug
[Shanghai Jiao Tong University *nix User Group]: https://github.com/sjtug
