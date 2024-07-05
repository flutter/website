---
title: DevTools extensions
description: Learn how to use and build DevTools extensions.
---

## What are DevTools extensions?

[DevTools extensions][]
are developer tools provided by third-party packages that are
tightly integrated into the DevTools tooling suite.
Extensions are distributed as part of a pub package,
and they are dynamically loaded into DevTools when
a user is debugging their app.

[DevTools extensions]: {{site.pub-pkg}}/devtools_extensions

## Use a DevTools extension

If your app depends on a package that provides a
DevTools extension, the extension automatically
shows up in a new tab when you open DevTools.

### Configure extension enablement states

You need to manually enable the extension before it loads
for the first time. Make sure the extension is provided by
a source you trust before enabling it.

![Screenshot of extension enablement prompt](/assets/images/docs/tools/devtools/extension_enable_prompt.png)

Extension enablement states are stored in a `devtools_options.yaml`
file in the root of the user's project
(similar to `analysis_options.yaml`).
This file stores per-project
(or optionally, per user) settings for DevTools.

If this file is **checked into source control**,
the specified options are configured for the project.
This means that anyone who pulls a project's
source code and works on the project uses the same settings.

If this file is **omitted from source control**,
for example by adding `devtools_options.yaml`
as an entry in the `.gitignore` file, then the specified
options are configured separately for each user.
Since each user or contributor to the project
uses a local copy of the `devtools_options.yaml`
file in this case, the specified options might
differ between project contributors.

## Build a DevTools extension

For an in-depth guide on how to build a DevTools extension,
check out [Dart and Flutter DevTools extensions][article],
a free article on Medium.

To learn more about writing and using DevTools extensions,
check out the following video:

{% ytEmbed 'gOrSc4s4RWY', 'Building DevTools extensions | Flutter Build Show' %}

[article]: {{site.flutter-medium}}/dart-flutter-devtools-extensions-c8bc1aaf8e5f
