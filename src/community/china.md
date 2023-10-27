---
title: Using Flutter in China
description: Where to find a version of the Flutter site that is localized to Simplified Chinese.
toc: true
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

To install or use Flutter in China,
use a trustworthy Flutter mirror site.
This requires setting two environment variables on your machine.

_All examples that follow presume that you are using the CFUG mirror._

To set your machine to use a mirror site on macOS or Linux:

1. Create and change into the directory where you plan
   to store your local Flutter clone.

1. Set your pub URL to your mirror site.

   ```terminal
   $ export PUB_HOSTED_URL=https://pub.flutter-io.cn
   ```

1. Set your Flutter storage URL to your mirror site.

   ```terminal
   $ export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
   ```

1. Clone the Flutter repo from your mirror site.

   ```terminal
   $ git clone -b dev {{site.repo.flutter}}.git
   ```

1. Add Flutter to your `PATH` environment variable.

   ```terminal
   $ export PATH="$PWD/flutter/bin:$PATH"
   ```

1. Run Flutter Doctor to verify your installation.

   ```terminal
   $ flutter doctor
   ```

1. Return to the [setting up Flutter]({{site.url}}/get-started/editor)
   guide and continue from that procedure.

From this example, `flutter pub get` fetches packages from `flutter-io.cn`.
in any terminal where you set `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL`.

Any environment variables set using `export` in this procedure
only apply to the current terminal window.
To set these values on a permanent basis,
add those three `export` commands to the bottom of the `*rc` or `*_profile`
file that your preferred shell uses.

### Download other versions of Flutter

To install a different version of Flutter found in the
[archive]({{site.url}}/release/archive),
replace `storage.googleapis.com` with that of your trusted mirror.
This should improve download speed.

For example:

* Original URL:<br>
  [`https://storage.googleapis.com/{{path}}`](https://storage.googleapis.com/{{path}})

* Mirrored URL:<br>
  [`https://storage.flutter-io.cn/{{path}}`](https://storage.flutter-io.cn/{{path}})

## Configure your machine to publish your package

If you receive errors when attempting to publish your package,
try one of the following solutions:

  {% comment %}
  From https://github.com/flutter/website/pull/9338#discussion_r1328077020
  {% endcomment %}

1. Clear your `PUB_HOSTED_URL` environment variable.

   ```terminal
   $ unset PUB_HOSTED_URL
   ```

   Remember to reset this environment variable after you publish.

   ```terminal
   export PUB_HOSTED_URL=https://pub.flutter-io.cn
   ```

1. Configure a proxy.
   To configure a proxy, check out the [Dart documentation on proxies][].

  {% comment %}
  From https://github.com/flutter/website/issues/2556#issuecomment-481566476
  {% endcomment %}

1. Enable your VPN without adding a `credentials.json` file.

1. Disable your proxy and add a `credentials.json` file.

[Dart documentation on proxies]: {{site.dart-site}}/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall

## Details on mirror sites

### Support for mirror sites

The Flutter team cannot guarantee long-term availability of any mirrors.
You can use other mirrors if they become available.

### New mirror sites in China

If you're interested in setting up your own mirror in China,
contact [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)
for assistance.

### Known, trusted community-run mirror sites

#### China Flutter User Group

[China Flutter User Group][] maintains the `flutter-io.cn` mirror.
It includes Flutter and packages.

If you're running into issues that only occur when
using the `flutter-io.cn` mirror, report the issue to their
[issue tracker (镜像问题)]({{site.github}}/cfug/flutter.cn/issues/new/choose).

To set your machine to use this mirror, use these commands:

```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

#### Shanghai Jiao Tong University *nix User Group

[Shanghai Jiao Tong University *nix User Group][]
maintains the `mirror.sjtu.edu.cn` mirror.
It includes Flutter and packages.

If you're running into issues that only occur when
using the `mirror.sjtu.edu.cn` mirror, report the issue to their
[issue tracker (议题)](https://git.sjtu.edu.cn/sjtug/flutter-sdk/-/issues).

To set your machine to use this mirror, use these commands:

```bash
export FLUTTER_STORAGE_BASE_URL=https://mirror.sjtu.edu.cn
export PUB_HOSTED_URL=https://mirror.sjtu.edu.cn/flutter-infra
```

[China Flutter User Group]: https://github.com/cfug
[Shanghai Jiao Tong University *nix User Group]: https://github.com/sjtug
