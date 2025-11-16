---
title: Using Flutter in China
description: How to use, access, and learn about Flutter in China.
---

{% render "docs/china-notice-cn.md" %}

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

<Tabs key="china-setup-os">

<Tab name="Windows">

These steps require using PowerShell.

 1. Open a new window in PowerShell to prepare to run shell commands.

 1. Set `PUB_HOSTED_URL` to your mirror site.

    ```ps
    $ $env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
    ```

 1. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.

    ```ps
    $ $env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
    ```

 1. Download the Flutter archive from your preferred mirror site.

    For CFUG, visit their [Flutter SDK archive][],
    and download the SDK for your platform and architecture.

 1. Create a folder where you can install Flutter. Then change into it.
    Consider a path like `$env:USERPROFILE\dev`.

    ```ps
    $ New-Item -Path "$env:USERPROFILE\dev" -ItemType Directory; cd "$env:USERPROFILE\dev"
    ```
 1. Extract the SDK from the zip archive file.

    This example assumes you downloaded the Windows version of the Flutter SDK.
    You'll need to replace the path to the archive with the
    path to the archive file and version you downloaded.

    ```ps
    $ Expand-Archive .\flutter_windows_3.35.5-stable.zip
    ```

 1. Add Flutter to your `PATH` environment variable.

    ```ps
    $ $env:PATH = $pwd.PATH + "\flutter\bin",$env:PATH -join ";"
    ```

 1. Begin developing with Flutter.

    After following these steps,
    Flutter fetches packages and artifacts from `flutter-io.cn`
    in the current terminal window.

    To set these values permanently across terminals,
    follow the instructions on adding [Flutter to your PATH][windows-path],
    also adding the `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL` variables.

{:.steps}

[windows-path]: /install/add-to-path#windows

</Tab>

<Tab name="macOS">

 1. Open a new window in your terminal to prepare to run shell commands.

 1. Set `PUB_HOSTED_URL` to your mirror site.

    ```console
    $ export PUB_HOSTED_URL="https://pub.flutter-io.cn"
    ```

 1. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.

    ```console
    $ export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
    ```

 1. Download the Flutter archive from your preferred mirror site.

    For CFUG, visit their [Flutter SDK archive][],
    and download the SDK for your platform and architecture.

 1. Create a folder where you can install Flutter. Then change into it.
    Consider a path like `~/dev`.

    ```console
    $ mkdir ~/dev; cd ~/dev
    ```

 1. Extract the SDK from the zip archive file.

    This example assumes you downloaded the macOS version of the Flutter SDK.
    You'll need to replace the path to the archive with the
    path to the archive file and version you downloaded.

    ```console
    $ unzip flutter_macos_3.35.5-stable.zip
    ```

 1. Add Flutter to your `PATH` environment variable.

    ```console
    $ export PATH="$PWD/flutter/bin:$PATH"
    ```

 1. Begin developing with Flutter.

    After following these steps,
    Flutter fetches packages and artifacts from `flutter-io.cn`
    in the current terminal window.

    To set these values permanently across terminals,
    follow the instructions on adding [Flutter to your PATH][macos-path],
    also adding the `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL` variables.

{:.steps}

[macos-path]: /install/add-to-path#macos

</Tab>

<Tab name="Linux">

 1. Open a new window in your terminal to prepare to run shell commands.

 1. Set `PUB_HOSTED_URL` to your mirror site.

    ```console
    $ export PUB_HOSTED_URL="https://pub.flutter-io.cn"
    ```

 1. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.

    ```console
    $ export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
    ```

 1. Download the Flutter archive from your preferred mirror site.

    For CFUG, visit their [Flutter SDK archive][],
    and download the SDK for your platform and architecture.

 1. Create a folder where you can install Flutter. Then change into it.
    Consider a path like `~/dev`.

    ```console
    $ mkdir ~/dev; cd ~/dev
    ```

 1. Extract the SDK from the tar archive file.

    This example assumes you downloaded the Linux version of the Flutter SDK.
    You'll need to replace the path to the archive with the
    path to the archive file and version you downloaded.

    ```console
    $ tar -xf flutter_linux_3.35.5-stable.tar.xz
    ```

 1. Add Flutter to your `PATH` environment variable.

    ```console
    $ export PATH="$PWD/flutter/bin:$PATH"
    ```

 1. Begin developing with Flutter.

    After following these steps,
    Flutter fetches packages and artifacts from `flutter-io.cn`
    in the current terminal window.

    To set these values permanently across terminals,
    follow the instructions on adding [Flutter to your PATH][linux-path],
    also adding the `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL` variables.

{:.steps}

[linux-path]: /install/add-to-path#linux

</Tab>

</Tabs>

[Flutter SDK archive]: https://docs.flutter.cn/install/archive/

### Download Flutter archives based on a mirror site

To download Flutter from the [SDK archive][] from a mirror,
replace `storage.googleapis.com` with the URL of your trusted mirror.
Use your mirror site in the browser or in other applications
like IDM or Thunder.
This should improve download speed.

[SDK archive]: /install/archive

The following example shows how to change the URL for Flutter's download site
from Google's archive to CFUG's mirror.

<Tabs key="china-setup-os">

<Tab name="Windows">

To download the x64, Windows version of the Flutter SDK,
you would change the original URL from:

```plaintext
[!https://storage.googleapis.com!]/flutter_infra_release/releases/stable/windows/flutter_windows_3.35.5-stable.zip
```

to the mirror URL:

```plaintext
[!https://storage.flutter-io.cn!]/flutter_infra_release/releases/stable/windows/flutter_windows_3.35.5-stable.zip
```

</Tab>

<Tab name="macOS">

To download the arm64, macOS version of the Flutter SDK,
you would change the original URL from:

```plaintext
[!https://storage.googleapis.com!]/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.35.5-stable.zip
```

to the mirror URL:

```plaintext
[!https://storage.flutter-io.cn!]/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.35.5-stable.zip
```

</Tab>

<Tab name="Linux">

To download the Linux version of the Flutter SDK,
you would change the original URL from:

```plaintext
[!https://storage.googleapis.com!]/flutter_infra_release/releases/stable/linux/flutter_linux_3.35.5-stable.tar.xz
```

to the mirror URL:

```plaintext
[!https://storage.flutter-io.cn!]/flutter_infra_release/releases/stable/linux/flutter_linux_3.35.5-stable.tar.xz
```

</Tab>

</Tabs>

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

<Tabs key="china-setup-os">

<Tab name="Windows">

 1. Configure a proxy.
    To configure a proxy, check out the
    [Dart documentation on proxies][].

 1. Verify that your `PUB_HOSTED_URL` environment variable is either unset
    or empty.

    ```ps
    $ echo $env:PUB_HOSTED_URL
    ```

    If this command returns any value, unset it.

    ```ps
    $ Remove-Item $env:PUB_HOSTED_URL
    ```

</Tab>
<Tab name="macOS">

 1. Configure a proxy.
    To configure a proxy, check out the
    [Dart documentation on proxies][].

 1. Verify that your `PUB_HOSTED_URL` environment variable is
    either unset or empty.

    ```console
    $ echo $PUB_HOSTED_URL
    ```

    If this command returns any value, unset it.

    ```console
    $ unset $PUB_HOSTED_URL
    ```

</Tab>
<Tab name="Linux">

 1. Configure a proxy.
    To configure a proxy, check out the
    [Dart documentation on proxies][].

 1. Verify that your `PUB_HOSTED_URL` environment variable is
    either unset or empty.

    ```console
    $ echo $PUB_HOSTED_URL
    ```

    If this command returns any value, unset it.

    ```console
    $ unset $PUB_HOSTED_URL
    ```

</Tab>

</Tabs>

To learn more about publishing packages, check out the
[Dart documentation on publishing packages][].

[Dart documentation on proxies]: {{site.dart-site}}/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall
[Dart documentation on publishing packages]: {{site.dart-site}}/tools/pub/publishing

## Known, trusted community-run mirror sites

The Flutter team can't guarantee the long-term availability of any mirrors.
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
