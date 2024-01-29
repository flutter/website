---
title: DevTools release notes
description: Learn about the latest changes in Dart and Flutter DevTools.
toc: false
---

This page summarizes the changes in official stable releases of DevTools.
To view a complete list of changes, check out the
[DevTools git log]({{site.repo.organization}}/devtools/commits/master).

The Dart and Flutter SDKs include DevTools.
To check your current version of DevTools,
run the following on your command line:

```terminal
$ dart devtools --version
```

### Release notes

{% assign releases = site.data.devtools_releases.releases %}

{% for release in releases -%}
* [{{release}} release notes]({{site.url}}/tools/devtools/release-notes/release-notes-{{release}})
{% endfor -%}
