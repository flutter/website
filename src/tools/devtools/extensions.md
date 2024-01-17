---
title: DevTools extensions
description: Learn how to use and build DevTools extensions.
---

## What are DevTools extensions?

DevTools extensions are developer tools provided by third-party packages that
are tightly integrated into the DevTools tooling suite. Extensions are
distributed as part of a pub package, and they are dynamically loaded into DevTools when a user is debugging their app.

## Using a DevTools extension

If your app depends on a package that provides a DevTools extension, the
extension will automatically show up in a new tab when you open DevTools. You
will need to manually enable the extension before it loads for the first time.
Make sure the extension is provided by a source you trust before enabling it.

![Screenshot of extension enablement prompt]({{site.url}}/assets/images/docs/tools/devtools/extension_enable_prompt.png)

### devtools_options.yaml

Extension enablement states are stored in a `devtools_options.yaml` file in the
root of the user's project (similar to `analysis_options.yaml`). This file
stores per-project (or optionally, per user) settings for DevTools.

If this file is **checked into source control**, the specified options will be
configured for the project. This means that anyone who pulls a project's
source code and works on the project will use the same settings.

If this file is **omitted from source control**, for example by adding
`devtools_options.yaml` as an entry in the `.gitignore` file, then the specified
options will be configured separately for each user. Since each user or
contributor to the project will use a local copy of the `devtools_options.yaml`
file in this case, the specified options may differ between project contributors.

## Building a DevTools extension

For an in-depth guide on how to build a DevTools extension, please read this
[article](https://medium.com/flutter/dart-flutter-devtools-extensions-c8bc1aaf8e5f).