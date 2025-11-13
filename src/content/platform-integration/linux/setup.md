---
title: Set up Linux development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for Linux desktop.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for the Linux desktop platform.

:::note
If you haven't set up Flutter already,
visit and follow the [Get started with Flutter][] guide first.

If you've already installed Flutter,
ensure that it's [up to date][].
:::

[Get started with Flutter]: /get-started
[up to date]: /install/upgrade

## Set up tooling {: #set-up-tooling}

To run and debug desktop Flutter apps on Linux,
download and install the prerequisite packages.

Using your preferred package manager or mechanism,
install the latest versions of the following packages:

- `clang`
- `cmake`
- `ninja-build`
- `pkg-config`
- `libgtk-3-dev`
- `libstdc++-12-dev`

On Debian-based distros with `apt-get`, such as Ubuntu,
install these packages using the following commands:

```console
$ sudo apt-get update -y && sudo apt-get upgrade -y
$ sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev libstdc++-12-dev
```

## Validate your setup {: #validate-setup}

 1. <h3>Check for toolchain issues</h3>

    To check for any issues with your Linux development setup,
    run the `flutter doctor` command in your preferred terminal:

    ```console
    $ flutter doctor -v
    ```

    If you see any errors or tasks to complete
    under the **Linux toolchain** section,
    complete and resolve them, then
    run `flutter doctor -v` again to verify any changes.

 1. <h3>Check for Linux devices</h3>

    To ensure Flutter can find and connect to your Linux device correctly,
    run `flutter devices` in your preferred terminal:

    ```console
    $ flutter devices
    ```

    If you set everything up correctly,
    there should be at least one entry with the platform marked as **linux**.

 1. <h3>Troubleshoot setup issues</h3>

    If you need help resolving any setup issues,
    check out [Install and setup troubleshooting][].

    If you still have issues or questions,
    reach out on one of the Flutter [community][] channels.

{: .steps}

[Install and setup troubleshooting]: /install/troubleshoot
[community]: {{site.main-url}}/community

## Start developing for Linux {: #start-developing}

Congratulations!
Now that you've set up Linux desktop development for Flutter,
you can continue your Flutter learning journey while testing on Linux
or begin expanding integration with Linux.

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
      <span class="card-title">Build for Linux</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/platform-integration/linux/building">Build a Linux app</a>
        </li>
        <li>
          <a class="text-button" href="/deployment/linux">Release a Linux app</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/platform-channels">Write Linux-specific code</a>
        </li>
        <li>
          <a class="text-button" href="https://pub.dev/packages?q=platform%3Alinux+is%3Aplugin">Flutter plugins for Linux</a>
        </li>
        <li>
          <a class="text-button" href="https://github.com/ubuntu-flutter-community/yaru_tutorial">Design Ubuntu-themed apps</a>
        </li>
      </ul>
    </div>
  </div>
</div>
