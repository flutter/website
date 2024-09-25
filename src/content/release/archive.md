---
title: Flutter SDK archive
short-title: Archive
description: "All current Flutter SDK releases: stable, beta, and main."
toc: false
---

The {{site.sdk.channel | capitalize }} channel contains the
most stable Flutter builds.
To learn more, check out [Flutter's channels][].

{% render docs/china-notice.md %}

To learn what's new in the major Flutter releases,
check out the [release notes][] page.


:::note Note on provenance
[provenance](https://slsa.dev/provenance)
describes how software artifacts are built, including
what the download contains and who created it.
To view provenance in a more readable format
and where nothing is downloaded, run the following
command using the provenance file URL from a release (you might need to 
download [jq](https://stedolan.github.io/jq/) to easily parse the JSON).

```console
curl [provenance URL] | jq -r .payload | base64 -d | jq
```
:::


{% tabs "os-archive-tabs" %}
{% tab "Windows" %}

{% include docs/release/archive-release_os.md os="Windows" %}

{% endtab %}
{% tab "macOS" %}

{% include docs/release/archive-release_os.md os="macOS" %}

{% endtab %}
{% tab "Linux" %}

{% include docs/release/archive-release_os.md os="Linux" %}

{% endtab %}
{% endtabs %}

<a id="master-channel" aria-hidden="true"></a>

## Main channel

Installation bundles are not available for the `main` channel
(which was previously known as the `master` channel).
However, you can get the SDK directly from
[GitHub repo][] by cloning the main channel,
and then triggering a download of the SDK dependencies:

```console
$ git clone -b main https://github.com/flutter/flutter.git
$ ./flutter/bin/flutter --version
```

For additional details on how our installation bundles are structured,
see [Installation bundles][].

[Flutter's channels]: {{site.repo.flutter}}/blob/main/docs/releases/Flutter-build-release-channels.md
[release notes]: /release/release-notes
[GitHub repo]: {{site.repo.flutter}}
[Installation bundles]: {{site.repo.flutter}}/blob/main/docs/infra/Flutter-Installation-Bundles.md
