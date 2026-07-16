---
title: "Dart & Flutter DevTools Extensions"
description: "A guide for building custom tooling in Dart & Flutter DevTools"
publishDate: 2023-11-15
author: kenzieschmoll
image: images/1JsdgKjxlVmm5EAFfXvQ2yA.webp
category: announcement
layout: blog
---

Have you ever wanted to build developer tooling for Dart and Flutter but didn’t know where to start? Or maybe you didn’t want to go through all the work of establishing a connection to a running Dart or Flutter application to access debugging data? Then, even if you did create a development tool, how would you deploy it or give users easy access to it? Well, we have some good news for you: now you can create developer tooling without all these hurdles.

With the new Dart & Flutter DevTools extensions framework, you can easily build developer tooling that is tightly integrated with the existing DevTools tooling suite. Extensions are built using Flutter web and leverage existing frameworks and utilities from DevTools to simplify the developer tool authoring experience.

<DashImage figure src="images/1JsdgKjxlVmm5EAFfXvQ2yA.webp" alt="Example DevTools extension for package:foo" caption="Example DevTools extension for package:foo" />


## How do DevTools extensions work?

Extensions are shipped as part of a pub package. You can add a DevTools extension to an existing pub package, or you can create a new package that provides a DevTools extension only. In both these scenarios, the end-user must list a dependency on the package providing the DevTools extension in order to see the extension in DevTools.

For example, imagine we have some `package:foo`, and this package provides a DevTools extension. When a user depends on `package:foo` in their app, they automatically get access to the DevTools extension provided by this package. When DevTools detects the `package:foo`extension is available, based on information from the user’s app or from their IDE, a new tab “Foo” will be added to DevTools that contains the developer tools provided by `package:foo`.

<DashImage figure src="images/1FFl2jeYpyn8DfjRI5xQ8mQ.webp" />


Some examples of packages that have added a DevTools extension to an existing package are [package:provider](https://pub.dev/packages/provider), [package:patrol](https://pub.dev/packages/patrol), and [package:drift](https://pub.dev/packages/drift).

## What types of tools are supported?

With the DevTools extensions framework you can build many types of tools, including:

* Companion tools for existing packages

* New tools that are shipped as their own package

* Tools that interact with a running application

* Tools that **do not** interact with a running application

* Tools that interact with project files opened in the IDE

* *Planned for the future: tools that interact with the Analysis server (upvote this [issue](https://github.com/flutter/devtools/issues/7658) if you want this feature sooner!)*

The DevTools Extensions framework comes with out-of-the-box features that make distributing your extension to users seamless:

* Users can use your tool from DevTools in the browser

* Users can use your tool embedded directly in their IDE

* Users can discover and open your tool from Dart & Flutter supported IDEs

Now let’s get started!

## Writing a DevTools extension: a step-by-step guide

### Before you get started

What you will need:

* Flutter SDK &gt;= `3.17.0–0.0.pre` & Dart SDK >= `3.2`.

* A [Pub](https://pub.dev/) package (existing or new) to add a DevTools extension to.
> To use the latest [devtools_extensions](https://pub.dev/packages/devtools_extensions) and [devtools_app_shared](https://pub.dev/packages/devtools_app_shared) packages, it is acceptable to develop your extension from the Flutter master or beta channel.

## Step 1: Set up your package hierarchy

### Standalone extensions

For a standalone extension (an extension that is not being shipped as part of an existing pub package), it is acceptable to include your extension source code in the same package that the extension is shipped with. This will simplify development, and since users of your package will add a dependency on your package as a `dev_dependency`, the size of your package will not affect the user's app size. Your package structure will look like this:

```plaintext
my_new_tool
  extension/
    devtools/
      build/
        ...  # pre-compiled output of the Flutter web app under lib/
      config.yaml
  lib/  # source code for your extension Flutter web app
    src/
      ...
```


Since the extension must be built as a Flutter web app, use `flutter create` to generate the package for your DevTools extension:

```bash
flutter create --template app --platforms web my_new_tool
```


Now, use the `my_new_tool` package to configure your extension in the next step.

### Companion extensions

For a companion extension (an extension that is shipped as part of an existing pub package), we recommend that you place your extension source code outside of your pub package. This will help keep your package size as small as possible, since you will want to avoid inflating the size of user apps that depend on your package. Here is the recommended package structure:

```plaintext
foo/  # formerly the repository root of your pub package
  packages/
    foo/  # your pub package
      extension/
        devtools/
          build/
            ...  # pre-compiled output of foo_devtools_extension/lib
          config.yaml
    foo_devtools_extension/
      lib/  # source code for your extension Flutter web app
```


## Step 2: Configure your extension

In the Dart package that will provide the DevTools extension to users, add a top-level `extension` directory:

```plaintext
foo/
  extension/
  lib/
  ...
```


Under the `extension` directory, create the following structure **exactly as shown**:

```plaintext
extension/
  devtools/
    build/
    config.yaml
```


The `config.yaml` file contains metadata that DevTools needs to load the extension:

```yaml
name: foo
version: 0.0.1
issueTracker: <link_to_your_issue_tracker.com>
materialIconCodePoint: '0xe0b1'
requiresConnection: true  # optional field - defaults to true
```


Copy the `config.yaml` file content above and paste it into the `config.yaml` file you just created in your package. **It is important that you use the exact file name and field names as shown, or else your extension may fail to load in DevTools.**

For each key, fill in the appropriate value for your package.

* `name`: the package name that this DevTools extension belongs to. The value of this field is used in the extension page title bar. **[required]**

* `version`: the version of your DevTools extension. This version number should evolve over time as you ship new features for your extension. The value of this field is used in the extension page title bar. **[required]**

* `issueTracker`: the URL for your issue tracker. When a user clicks the “Report an issue” link in the DevTools UI, they are directed to this URL. **[required]**

<DashImage figure src="images/1H0Q1Zv2L6_NUFUedI6mkQw.webp" alt="DevTools extension screen title bar" caption="DevTools extension screen title bar" />


* `materialIconCodePoint`: corresponds to the codepoint value of an icon from [material/icons.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/icons.dart). This icon is used for the extension’s tab in the top-level DevTools tab bar. **[required]**

<DashImage figure src="images/1bkNzahdp7eXUo7Xwh1U07Q.webp" alt="DevTools extension tab icon" caption="DevTools extension tab icon" />


* `requiresConnection`: whether the extension requires a connected Dart or Flutter app to use. This is an optional field that will default to `true` if unspecified. **[optional]**

For the most up-to-date documentation on the `config.yaml` spec, see [extension_config_spec.md](https://github.com/flutter/devtools/blob/master/packages/devtools_extensions/extension_config_spec.md).

Now it is time to build your extension.

## Step 3: Build your extension

1. Create the Flutter web app.

*Note: skip this step if you are building a standalone extension, since you already did this when you set up your package hierarchy.*

From the directory where you want your extension source code to live, run the following command, replacing `foo_devtools_extension` with `<your_package_name>_devtools_extension`:

```shell
flutter create --template app --platforms web foo_devtools_extension
```


2. Add the `package:devtools_extensions` dependency to your extension Flutter web app.

```shell
flutter pub add devtools_extensions
```


You will likely also want to add a dependency on [package:devtools_app_shared](https://pub.dev/packages/devtools_app_shared), which contains shared services, utilities, and UI components for you to use while building your extension. See [devtools_app_shared/example](https://github.com/flutter/devtools/tree/master/packages/devtools_app_shared/example) for sample usages.

```shell
flutter pub add devtools_app_shared
```


3. Add the `DevToolsExtension` widget at the root of your Fluter web app.

In `lib/main.dart`, add the following:

```dart
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DevToolsExtension());
}

class FooDevToolsExtension extends StatelessWidget {
  const FooDevToolsExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: Placeholder(), // Build your extension here
    );
  }
}
```


The `DevToolsExtension` widget automatically performs all extension initialization required to interact with DevTools. From anywhere in your extension web app, you can access the globals:

* `extensionManager`: a manager for interacting with DevTools or the extensions framework.

* `serviceManager`: a manager for interacting with the connected vm service, if present.

* `dtdManager`: a manager for interacting with the Dart Tooling Daemon, if present.

## Step 4: Debug your extension

When developing and maintaining your DevTools extension, you’ll want to run, debug, and test your extension Flutter web app. You have a couple of different options for this, outlined below.

### Option A: Use the Simulated DevTools Environment (recommended for development)

For debugging purposes, you will likely want to use the “simulated DevTools environment”. This is a simulated environment that allows you to build your extension without having to develop it as an embedded iFrame in DevTools. Running your extension this way will wrap your extension with an environment that simulates the DevTools-to-DevTools extension connection. It also gives you access to hot restart and a faster development cycle.

<DashImage figure src="images/1-3c-p57ai0Quc5rJOL9qEQ.webp" alt="Debugging an extension with the Simulated DevTools Environment" caption="Debugging an extension with the Simulated DevTools Environment" />


1. *Your DevTools extension.*

1. *The VM service URI for a test app that your DevTools extension will interact with. This app should depend on your extension’s parent package (package:foo in this example).*

1. *Buttons to perform actions that a user may trigger from DevTools.*

1. *Logs showing the messages that will be sent between your extension and DevTools.*

The simulated environment is enabled by the environment parameter `use_simulated_environment`. To run your extension web app with this flag enabled, add a configuration to your `launch.json` file in VS code:

```json
{
    // ...
    "configurations": [
        // ...
        {
            "name": "foo_devtools_extension + simulated environment",
            "cwd": "packages/foo_devtools_extension",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define=use_simulated_environment=true"
            ],
        },
        // ...
    ]
}
```


or launch your app from the command line with the added flag:

```shell
flutter run -d chrome - dart-define=use_simulated_environment=true
```


### Option B: Use a real DevTools environment

Once you develop your extension to a point where you are ready to test your changes in a real DevTools environment, you need to perform a series of setup steps:

1. Develop your extension to a point where you are ready to test your changes in a real DevTools environment. Build your flutter web app and copy the built assets from `your_extension_web_app/build/web` to your pub package's `extension/devtools/build` directory.

Use the `build_and_copy` command from `package:devtools_extensions` to help with this step.

```shell
cd your_extension_web_app;
flutter pub get;
dart run devtools_extensions build_and_copy --source=. --dest=path/to/your_pub_package/extension/devtools
```

> Note: if you are using the recommended package structure from above for adding an extension to an existing pub package, the value for *`— dest`* should be *`../your_pub_package/extension/devtools`*.

To ensure that your extension is setup properly for loading in DevTools, run the `validate` command from `package:devtools_extensions`. The `--package` argument should point to the root of the Dart package that this extension will be published with.

```shell
cd your_extension_web_app;
flutter pub get;
dart run devtools_extensions validate --package=path/to/your_pub_package
```


2. Prepare and a test environment with a dependency on your pub package that is providing the extension.

   In the Dart or Flutter project where you are adding a dependency on your package, add a [path](https://dart.dev/tools/pub/dependencies#path-packages) dependency that points to your local package source code (the package that contains the `extension/devtools/` directory with your extension's assets). Once you have done this, run `pub get` on the package.

   * **If your extension requires a running application**, then you’ll need to run the app that depends on your extension.

   * **If your extension does not require a running application**, then you will need to open the test Dart or Flutter project that depends on your package in a supported IDE (VS Code or IntelliJ / Android Studio).

3. Start DevTools in one of the following ways:

   * **If your extension requires a running application**, you can open DevTools either from the URI that was printed to command line when you ran the test app, or from the IDE where you ran your test app.

   * **If your extension does not require a running application**, you can open your Dart or Flutter project that depends on your package in a supported IDE (VS Code or IntelliJ / Android Studio). Open DevTools from the IDE to see your extension in the browser.

   * **If you need local or unreleased changes from DevTools**, you’ll need to build and run DevTools from source. See the DevTools [CONTRIBUTING.md](https://github.com/flutter/devtools/blob/7a53fd2ddf289ee1b76840b9bfd9a2cb7876f13b/packages/devtools_extensions) for a guide on how to do this. You’ll need to build DevTools with the server and the front end to test extensions — see [instructions](https://github.com/flutter/devtools/blob/master/CONTRIBUTING.md#development-devtools-server--devtools-flutter-web-app).

4. Once you have opened DevTools, you should see a tab in the DevTools app bar for your extension. The enabled or disabled state of your extension is managed by DevTools, which is exposed from an “Extensions” menu, available from the action buttons in the upper right corner of the screen.

<DashImage figure src="images/0s9-Y9X5dTyuk6Xj4.webp" alt="DevTools Extensions menu button" caption="DevTools Extensions menu button" />


<DashImage figure src="images/1DSi_p-2FO60qo5JUKXk-3Q.webp" alt="DevTools Extensions menu" caption="DevTools Extensions menu" />


## Step 5: Publish your package with a DevTools extension

In order for a package to provide a DevTools extension to its users, it must be published with the expected content in the `your_pub_package/extension/devtools/` directory (see the setup instructions above).

1. Ensure the `extension/devtools/config.yaml` file exists and is configured per the specifications above. You can run the `validate` command from `package:devtools_extensions` to verify.

```bash
cd your_extension_web_app;
flutter pub get;
dart run devtools_extensions validate --package=path/to/pkg_providing_your_extension_assets
```


2. Use the `build_and_copy` command provided by `package:devtools_extensions` to build your extension and copy the output to the `extension/devtools` directory:

```shell
cd your_extension_web_app;
flutter pub get;
dart run devtools_extensions build_and_copy --source=. --dest=path/to/your_pub_package/extension/devtools
```


Then publish your package on [pub.dev](https://pub.dev/): `flutter pub publish`. When running `pub publish`, you will see a warning if you do not have the `config.yaml` file and a non-empty `build` directory as required.

For additional guidance around publishing your package, see the `package:devtools_extensions` [publishing guide](https://pub.dev/packages/devtools_extensions#publish-your-package-with-a-devtools-extension).

## Conclusion

That’s it! Now, when a user depends on the latest version of your package, they will automatically get access to the tools you provide in your DevTools extension.

For issues and feature requests, please file an issue on the DevTools [issue tracker](https://github.com/flutter/devtools/issues).

For general support and access to the community of DevTools extension authors, check out the [#devtools-extension-authors](https://discord.com/channels/608014603317936148/1159561514072690739) Discord channel (you will first need to join the [Flutter Discord server](https://github.com/flutter/flutter/wiki/Chat)).
