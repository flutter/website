---
title: DevTools release notes
description: Learn about the latest changes in Dart and Flutter DevTools.
showToc: false
---

This page summarizes the changes in official stable releases of DevTools.
To view a complete list of changes, check out the
[DevTools git log]({{site.repo.organization}}/devtools/commits/master).

The Dart and Flutter SDKs include DevTools.
To check your current version of DevTools,
run the following on your command line:

```console
$ dart devtools --version
```

### Release notes

{% comment %}
When adding the release notes for a new DevTools release,
make sure to add the version number as an entry to the list
found at `/src/_data/devtools_releases.yml`.
{% endcomment -%}

{% assign releases = devtools_releases.releases %}

{% for release in releases -%}
* [{{release}} release notes](/tools/devtools/release-notes/release-notes-{{release}})
{% endfor -%}
