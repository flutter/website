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
Check out [Flutter’s channels][] for details.

For details about what's new in the major Flutter releases,
check out the [release notes][] page.


{{site.alert.secondary}}
  **A note on provenance**: [provenance](https://slsa.dev/provenance)
  describes how software artifacts are built, including
  what the download contains and who created it.
  To view provenance in a more readable format
  and where nothing is downloaded, run the following
  command using the provenance file URL from a release (you might need to 
  download [jq](https://stedolan.github.io/jq/) to easily parse the JSON).

  ```terminal
  curl [provenance URL] | jq -r .payload | base64 -d | jq
  ```
{{site.alert.end}}

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
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
{% include_relative _release_os.md os="Windows" %}
{% include_relative _release_os.md os="macOS" %}
{% include_relative _release_os.md os="Linux" %}
</div>

## Master channel

Installation bundles are not available for master.
However, you can get the SDK directly from
[GitHub repo][] by cloning the master channel,
and then triggering a download of the SDK dependencies:

```terminal
$ git clone -b master https://github.com/flutter/flutter.git
$ ./flutter/bin/flutter --version
```

For additional details on how our installation bundles are structured,
see [Installation bundles][].

[Flutter’s channels]: {{site.repo.flutter}}/wiki/Flutter-build-release-channels
[release notes]: {{site.url}}/release/release-notes
[GitHub repo]: {{site.repo.flutter}}
[Installation bundles]: {{site.repo.flutter}}/wiki/Flutter-Installation-Bundles
