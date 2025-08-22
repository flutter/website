---
title: Flutter SDK archive
short-title: Archive
description: "All current Flutter SDK releases: stable, beta, and main."
toc: true
---

{% render docs/china-notice.md %}

## Overview

The Flutter SDK archive is a collection of all previous versions of the
Flutter SDK. This archive is useful for developers who need to use an older
version of Flutter for compatibility reasons or to investigate bugs.

The archive includes Flutter SDKs for Windows, macOS, and Linux on the
following [channels][]:

*   **{{site.sdk.channel | capitalize }} channel**: This channel contains the
    most stable Flutter builds. Roughly every third beta version is promoted
    to the stable version. The stable channel is the recommended channel for
    new users and for production app releases.

*   **Beta channel**: This channel is the most recent version of Flutter that is
    available, but it is not yet stable. The beta branch is usually released
    on the first Wednesday of the month. A fix will typically end up in the
    beta channel about two weeks after it lands in the main channel. 
    Releases are distributed as [installation bundles][].

*   **Main channel**: This channel has the newest features, but it hasn't been fully
    tested and might have some bugs. We don't recommend using it unless you're
    contributing to Flutter itself.

The following information is available for each Flutter release in the
SDK archive:

*   **Flutter version**: The version number of the Flutter SDK
    (for example, 3.0.0, 2.10.5). This follows semantic versioning, indicating
    the significance of changes between releases.
*   **Architecture**: The processor architecture the SDK is built for
    (for example, x64, arm64). This specifies the type of processor the SDK is
    compatible with.
*   **Ref**: The git commit hash that uniquely identifies the specific codebase
    used for that release.
*   **Release Date**: The date when that particular Flutter version was
    officially released.
*   **Dart version**: The corresponding version of the Dart SDK included in the
    Flutter SDK release.
*   **Provenance**: Provides details about the build process and origin of the
    SDK, potentially including information about security attestations or
    build systems used. Results are returned as JSON.

## Stable channel

{% tabs "os-archive-tabs" %}

{% tab "Windows" %}

{% render docs/release/archive-release.md, os: "Windows", channel: "stable" %}

{% endtab %}

{% tab "macOS" %}

{% render docs/release/archive-release.md, os: "macOS", channel: "stable" %}

{% endtab %}

{% tab "Linux" %}

{% render docs/release/archive-release.md, os: "Linux", channel: "stable" %}

{% endtab %}

{% endtabs %}


## Beta channel

{% tabs "os-archive-tabs" %}

{% tab "Windows" %}

{% render docs/release/archive-release.md, os: "Windows", channel: "beta" %}

{% endtab %}

{% tab "macOS" %}

{% render docs/release/archive-release.md, os: "macOS", channel: "beta" %}

{% endtab %}

{% tab "Linux" %}

{% render docs/release/archive-release.md, os: "Linux", channel: "beta" %}

{% endtab %}

{% endtabs %}


<a id="master-channel" aria-hidden="true"></a>

## Main channel

[Installation bundles][] are not available for the `main` channel
(which was previously known as the `master` channel).
However, you can get the SDK directly from
[GitHub repo][] by cloning the main channel,
and then triggering a download of the SDK dependencies:

```console
$ git clone -b main https://github.com/flutter/flutter.git
$ ./flutter/bin/flutter --version
```

## More information

To learn what's new in the major Flutter builds, check out the
[release notes][] page.

For details on how our installation bundles are structured,
see [Installation bundles][].

[channels]: {{site.repo.flutter}}/blob/main/docs/releases/Flutter-build-release-channels.md
[release notes]: /release/release-notes
[GitHub repo]: {{site.repo.flutter}}
[Installation bundles]: {{site.repo.flutter}}/blob/main/docs/infra/Flutter-Installation-Bundles.md
