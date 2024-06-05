---
title: Flutter SDK archive
short-title: Archive
description: "All current Flutter SDK releases: stable, beta, and master."
toc: false
---

<style>
.scrollable-table {
  overflow-y: scroll;
  max-height: 20rem;
}
</style>

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

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="os-archive-tabs" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="windows-tab" href="#windows" role="tab" aria-controls="windows" aria-selected="true">Windows</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="macos-tab" href="#macos" role="tab" aria-controls="macos" aria-selected="false">macOS</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="linux-tab" href="#linux" role="tab" aria-controls="linux" aria-selected="false">Linux</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div id="sdk-archives" class="tab-content">

{% include docs/release/archive-release_os.md os="Windows" %}

{% include docs/release/archive-release_os.md os="macOS" %}

{% include docs/release/archive-release_os.md os="Linux" %}

</div>

## Master channel

Installation bundles are not available for master.
However, you can get the SDK directly from
[GitHub repo][] by cloning the master channel,
and then triggering a download of the SDK dependencies:

```console
$ git clone -b master https://github.com/flutter/flutter.git
$ ./flutter/bin/flutter --version
```

For additional details on how our installation bundles are structured,
see [Installation bundles][].

[Flutter's channels]: {{site.repo.flutter}}/blob/master/docs/releases/Flutter-build-release-channels.md
[release notes]: /release/release-notes
[GitHub repo]: {{site.repo.flutter}}
[Installation bundles]: {{site.repo.flutter}}/blob/master/docs/infra/Flutter-Installation-Bundles.md
