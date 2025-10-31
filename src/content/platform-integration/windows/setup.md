---
title: Set up Windows development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for Windows.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for the Windows desktop platform.

:::note
If you haven't set up Flutter already,
visit and follow the [Get started with Flutter][] guide first.

If you've already installed Flutter,
ensure that it's [up to date][].
:::

[Get started with Flutter]: /get-started
[up to date]: /install/upgrade

## Set up tooling {: #set-up-tooling}

With [Visual Studio][vs], you can run Flutter apps on Windows as well as
compile and debug native C and C++ code.

Note that **Visual Studio** is an IDE separate from **Visual Studio _Code_**
and only supported on Windows.

1. <h3>Install Visual Studio</h3>

   If you haven't done so already,
   follow the Microsoft guide to
   [install and set up Visual Studio][vs].

   If you've already installed Visual Studio,
   [update it to the latest version][vs-update].

1. <h3>Set up Visual Studio workloads</h3>

   When the Visual Studio installer prompts you to choose workloads,
   select and install the **Desktop development with C++** workload.

   If you already installed Visual Studio,
   follow the Microsoft guide to
   [Modify Visual Studio workloads][vs-modify].

   :::tip
   If installing with the command line,
   the ID of the **Desktop development with C++** workload is
   `Microsoft.VisualStudio.Workload.NativeDesktop`.
   :::

{: .steps}

[vs]: https://visualstudio.microsoft.com/
[vs-install]: https://learn.microsoft.com/en-us/visualstudio/install/install-visual-studio
[vs-update]: https://learn.microsoft.com/en-us/visualstudio/install/update-visual-studio
[vs-modify]: https://learn.microsoft.com/en-us/visualstudio/install/modify-visual-studio

## Validate your setup {: #validate-setup}

1. <h3>Check for toolchain issues</h3>

   To check for any issues with your Windows development setup,
   run the `flutter doctor` command in your preferred terminal:

   ```console
   $ flutter doctor -v
   ```

   If you see any errors or tasks to complete under the
   **Windows version** and **Visual Studio - develop Windows apps** sections,
   complete and resolve them, then
   run `flutter doctor -v` again to verify any changes.

1. <h3>Check for Windows devices</h3>

   To ensure Flutter can find and connect to your Windows device correctly,
   run `flutter devices` in your preferred terminal:

   ```console
   $ flutter devices
   ```

   If you've set everything up correctly,
   there should be at least one entry with the platform marked as **windows**.

1. <h3>Troubleshoot setup issues</h3>

   If you need help resolving any setup issues,
   check out [installation and setup troubleshooting][troubleshoot].
   Depending on your issue,
   also check out Microsoft's guide on
   [Visual Studio troubleshooting][vs-troubleshoot].

   If you still have issues or questions,
   reach out on one of the Flutter [community][] channels.

{: .steps}

[troubleshoot]: /install/troubleshoot
[vs-troubleshoot]: https://learn.microsoft.com/en-us/troubleshoot/developer/visualstudio/installation/troubleshoot-installation-issues
[community]: {{site.main-url}}/community

## Start developing for Windows {: #start-developing}

Congratulations!
Now that you've set up Windows desktop development for Flutter,
you can continue your Flutter learning journey while testing on Windows
or begin expanding integration with Windows.

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
      <span class="card-title">Build for Windows</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/platform-integration/windows/building">Build a Windows app</a>
        </li>
        <li>
          <a class="text-button" href="/deployment/windows">Deploy to windows</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/platform-channels">Write Windows-specific code</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/windows/building#customizing-the-windows-host-application">Customize the app window</a>
        </li>
        <li>
          <a class="text-button" href="https://pub.dev/packages/win32">Access Win32 APIs with Dart</a>
        </li>
      </ul>
    </div>
  </div>
</div>
