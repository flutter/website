---
title: Set up app links for Android
description: How set up universal links for an iOS application built with Flutter
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="codelabs/deeplink_cookbook"?>

Deep linking is a mechanism for launching an app with a URI.
This URI contains scheme, host, and path,
and opens the app to a specific screen.

:::note
Did you know that Flutter DevTools provides a
deep link validation tool for Android?
An iOS version of the tool is in the works.
Learn more and see a demo at [Validate deep links][].
:::

[Validate deep links]: /tools/devtools/deep-links

A _app link_ is a type of deep link that uses
`http` or `https` and is exclusive to Android devices.

Setting up app links requires one to own a web domain.
Otherwise, consider using [Firebase Hosting][]
or [GitHub Pages][] as a temporary solution.

## 1. Customize a Flutter application

Write a Flutter app that can handle an incoming URL.
This example uses the [go_router][] package to handle the routing.
The Flutter team maintains the `go_router` package.
It provides a simple API to handle complex routing scenarios.

1. To create a new application, type `flutter create <app-name>`:

    ```shell
    $ flutter create deeplink_cookbook
    ```

2. To include `go_router` package in your app,
   add a dependency for `go_router` to the project:

    To add the `go_router` package as a dependency,
    run `flutter pub add`:

    ```console
    $ flutter pub add go_router
    ```

3. To handle the routing,
   create a `GoRouter` object in the `main.dart` file:

    <?code-excerpt "lib/main.dart"?>
    ```dartpad title="Flutter GoRouter hands-on example in DartPad" run="true"
    import 'package:flutter/material.dart';
    import 'package:go_router/go_router.dart';
    
    void main() => runApp(MaterialApp.router(routerConfig: router));
    
    /// This handles '/' and '/details'.
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => Scaffold(
            appBar: AppBar(title: const Text('Home Screen')),
          ),
          routes: [
            GoRoute(
              path: 'details',
              builder: (_, __) => Scaffold(
                appBar: AppBar(title: const Text('Details Screen')),
              ),
            ),
          ],
        ),
      ],
    );
    ```

## 2. Modify AndroidManifest.xml

1. Open the Flutter project with VS Code or Android Studio. 
2. Navigate to `android/app/src/main/AndroidManifest.xml` file.
3. Add the following metadata tag and intent filter inside the
   `<activity>` tag with `.MainActivity`.

    Replace `example.com` with your own web domain.

    ```xml
    <meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="http" android:host="example.com" />
        <data android:scheme="https" />
    </intent-filter>
    ```
   
   :::note
   The metadata tag flutter_deeplinking_enabled opts
   into Flutter's default deeplink handler.
   If you are using the third-party plugins,
   such as [uni_links][], setting this metadata tag will
   break these plugins. Omit this metadata tag
   if you prefer to use third-party plugins.
   :::

## 3. Hosting assetlinks.json file

Host an `assetlinks.json` file in using a web server
with a domain that you own. This file tells the
mobile browser which Android application to open instead
of the browser. To create the file,
get the package name of the Flutter app you created in
the previous step and the sha256 fingerprint of the
signing key you will be using to build the APK.

### Package name

Locate the package name in `AndroidManifest.xml`,
the `package` property under `<manifest>` tag.
Package names are usually in the format of `com.example.*`.

### sha256 fingerprint

The process might differ depending on how the apk is signed.

#### Using google play app signing

You can find the sha256 fingerprint directly from play
developer console. Open your app in the play console,
under **Release> Setup > App Integrity> App Signing tab**:

<img src="/assets/images/docs/cookbook/set-up-app-links-pdc-signing-key.png" alt="Screenshot of sha256 fingerprint in play developer console" width="50%" />

#### Using local keystore

If you are storing the key locally,
you can generate sha256 using the following command:

```console
keytool -list -v -keystore <path-to-keystore>
```

### assetlinks.json

The hosted file should look similar to this:

```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.example.deeplink_cookbook",
    "sha256_cert_fingerprints":
    ["FF:2A:CF:7B:DD:CC:F1:03:3E:E8:B2:27:7C:A2:E3:3C:DE:13:DB:AC:8E:EB:3A:B9:72:A1:0E:26:8A:F5:EC:AF"]
  }
}]
```

1. Set the `package_name` value to your Android application ID.

2. Set sha256_cert_fingerprints to the value you got
   from the previous step.

3. Host the file at a URL that resembles the following:
   `<webdomain>/.well-known/assetlinks.json`

4. Verify that your browser can access this file.

## Testing

You can use a real device or the Emulator to test an app link,
but first make sure you have executed `flutter run` at least once on
the devices. This ensures that the Flutter application is installed.

<img src="/assets/images/docs/cookbook/set-up-app-links-emulator-installed.png" alt="Emulator screenshot" width="50%" />

To test **only** the app setup, use the adb command:

```console
adb shell 'am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://<web-domain>/details"' \
    <package name>
```

:::note
This doesn't test whether the web files are
hosted correctly,
the command launches the app even
if web files are not presented.
:::

To test **both** web and app setup, you must click a link
directly through web browser or another app.
One way is to create a Google Doc, add the link, and tap on it.

If everything is set up correctly, the Flutter application
launches and displays the details screen:

<img src="/assets/images/docs/cookbook/set-up-app-links-emulator-deeplinked.png" alt="Deeplinked Emulator screenshot" width="50%" />

## Appendix

Source code: [deeplink_cookbook][]

[deeplink_cookbook]: {{site.github}}/flutter/codelabs/tree/main/deeplink_cookbook
[Firebase Hosting]: {{site.firebase}}/docs/hosting
[go_router]: {{site.pub}}/packages/go_router
[GitHub Pages]: https://pages.github.com
[uni_links]: {{site.pub}}/packages/uni_links
[Signing the app]: /deployment/android#signing-the-app
