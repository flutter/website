---
title: Set up macOS development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for macOS devices.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for the macOS desktop platform.

:::note
If you haven't set up Flutter already,
visit and follow the [Get started with Flutter][] guide first.

If you've already installed Flutter,
ensure that it's [up to date][].
:::

[Get started with Flutter]: /get-started
[up to date]: /install/upgrade

## Set up tooling {: #set-up-tooling}

With Xcode, you can run Flutter apps on macOS as well as
compile and debug native Swift and Objective-C code.

 1. <h3>Install Xcode</h3>

    If you haven't done so already,
    [install and set up the latest version of Xcode][xcode].

    If you've already installed Xcode,
    update it to the latest version using the
    same installation method you used originally.

 1. <h3>Set up Xcode command-line tools</h3>

    To configure the Xcode command-line tools to use
    the version of Xcode you installed,
    run the following command in your preferred terminal:

    ```console
    $ sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```

    If you downloaded Xcode elsewhere or need to use a different version,
    replace `/Applications/Xcode.app` with the path to there instead.

 1. <h3>Agree to the Xcode licenses</h3>

    After you've set up Xcode and configured its command-line tools,
    agree to the Xcode licenses.

    1. Open your preferred terminal.

    1. Run the following command to review and sign the Xcode licenses.

       ```console
       $ sudo xcodebuild -license
       ```

    1. Read and agree to all necessary licenses.

       Before agreeing to the terms of each license,
       read each with care.

       Once you've accepted all the necessary licenses successfully,
       the command should output how to review the licenses.

 1. <h3>Install CocoaPods</h3>

    To support [Flutter plugins][] that use native macOS code,
    install the latest version of [CocoaPods][].

    Install CocoaPods following the
    [CocoaPods installation guide][].

    If you've already installed CocoaPods,
    update it following the [CocoaPods update guide][].

{: .steps}

[xcode]: https://developer.apple.com/xcode/
[Flutter plugins]: /packages-and-plugins/developing-packages#types
[CocoaPods]: https://cocoapods.org/
[CocoaPods installation guide]: https://guides.cocoapods.org/using/getting-started.html#installation
[CocoaPods update guide]: https://guides.cocoapods.org/using/getting-started.html#updating-cocoapods

## Validate your setup {: #validate-setup}

 1. <h3>Check for toolchain issues</h3>

    To check for any issues with your macOS development setup,
    run the `flutter doctor` command in your preferred terminal:

    ```console
    $ flutter doctor -v
    ```

    If you see any errors or tasks to complete
    under the **Xcode** section,
    complete and resolve them, then
    run `flutter doctor -v` again to verify any changes.

 1. <h3>Check for macOS devices</h3>

    To ensure Flutter can find and connect to your macOS device correctly,
    run `flutter devices` in your preferred terminal:

    ```console
    $ flutter devices
    ```

    If you set everything up correctly,
    there should be at least one entry with the platform marked as **macos**.

 1. <h3>Troubleshoot setup issues</h3>

    If you need help resolving any setup issues,
    check out [Install and setup troubleshooting][].

    If you still have issues or questions,
    reach out on one of the Flutter [community][] channels.

{: .steps}

[Install and setup troubleshooting]: /install/troubleshoot
[community]: {{site.main-url}}/community

## Start developing for macOS {: #start-developing}

Congratulations!
Now that you've set up macOS desktop development for Flutter,
you can continue your Flutter learning journey while testing on macOS
or begin expanding integration with macOS.

<div class="card-grid link-cards">
  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/pointing-the-way.png" height="160" aria-hidden="true" alt="Dash helping you explore Flutter learning resources.">
    </div>
    <div class="card-header">
      <span class="card-title">Continue learning Flutter</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/get-started/codelab">Write your first app</a>
        </li>
        <li>
          <a class="text-button" href="/get-started/fundamentals">Learn the fundamentals</a>
        </li>
        <li>
          <a class="text-button" href="https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Explore Flutter widgets</a>
        </li>
        <li>
          <a class="text-button" href="/reference/learning-resources">Check out samples</a>
        </li>
        <li>
          <a class="text-button" href="/resources/bootstrap-into-dart">Learn about Dart</a>
        </li>
      </ul>
    </div>
  </div>
  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/flutter-on-desktop.svg" height="160" aria-hidden="true" alt="An outline of Flutter desktop support.">
    </div>
    <div class="card-header">
      <span class="card-title">Build for macOS</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/deployment/macos">Build and deploy to macOS</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/macos/c-interop">Bind to native macOS code</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/macos/platform-views">Embed native macOS views</a>
        </li>
        <li>
          <a class="text-button" href="/deployment/flavors-ios">Set up app flavors</a>
        </li>
        <li>
          <a class="text-button" href="/packages-and-plugins/swift-package-manager/for-app-developers">Use Swift Package Manager</a>
        </li>
      </ul>
    </div>
  </div>
</div>
