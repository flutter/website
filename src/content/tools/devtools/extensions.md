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

When you open the extension for the first time, you'll see a prompt to enable
the extension:

![Screenshot of extension enablement prompt](/assets/images/docs/tools/devtools/extension_enable_prompt.png)

You can modify the setting at any time from the DevTools Extensions dialog:

![Screenshot of DevTools Extensions dialog button](/assets/images/docs/tools/devtools/extension_dialog_button.png)

![Screenshot of extension enablement dialog](/assets/images/docs/tools/devtools/extension_dialog.png)

> Note: if the extension requires a running a connection to a running
application, you will not see the enablement prompt or enablement settings until
DevTools is connected to a running app.

Extension enablement states are stored in a `devtools_options.yaml`
file in the root of the user's project
(similar to `analysis_options.yaml`).

```yaml
description: This file stores settings for Dart & Flutter DevTools.
documentation: https://docs.flutter.dev/tools/devtools/extensions#configure-extension-enablement-states
extensions:
  - provider: true
  - shared_preferences: true
  - foo: false
```

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

<YouTubeEmbed id="gOrSc4s4RWY" title="Building DevTools extensions | Flutter Build Show"></YouTubeEmbed>

[article]: {{site.flutter-blog}}/dart-flutter-devtools-extensions-c8bc1aaf8e5f
