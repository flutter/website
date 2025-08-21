---
title: Set up web development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for the web platform.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for the web platform.

:::note
If you haven't set up Flutter already,
visit and follow the [Get started with Flutter][] guide first.

If you've already installed Flutter,
ensure that it's [up to date][].
:::

[Get started with Flutter]: /get-started
[up to date]: /install/upgrade

## Install a web browser {: #install}

To run and debug your Flutter app on the web,
[download and install Google Chrome][chrome-install]
or [install and use Microsoft Edge][edge-install].

<details>
<summary>Expand for instructions for other browsers</summary>

If you want to debug your app in other web browsers,
you can use the `flutter run -d web-server` command,
and manually navigate to the specified URL in your preferred browser.

Note that debugging support in the `web-server` mode is limited.

</details>


[chrome-install]: https://www.google.com/chrome/
[edge-install]: https://www.microsoft.com/edge

## Validate your setup {: #validate-setup}

To ensure that you installed the browser successfully,
and that Flutter can find it,
run `flutter devices` in your preferred terminal.

You should at least see one connected device labeled
**Chrome (web)** or **Edge (web)**, similar to the following:

```console highlightLines=4
$ flutter devices

Found 1 connected devices:
  Chrome (web)    • chrome • web-javascript • Google Chrome
```

If the command isn't found, or you don't see Chrome listed,
check out [Set up troubleshooting][troubleshoot].

[troubleshoot]: /install/troubleshoot

## Start developing for the web {: #start-developing}

Now that you've set up web development for Flutter,
you can continue your Flutter learning journey while testing on the web
or begin expanding integration with the web.

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
      <img src="/assets/images/decorative/flutter-on-phone.svg" height="160" aria-hidden="true" alt="A representation of Flutter on multiple devices.">
    </div>
    <div class="card-header">
      <span class="card-title">Build for the web</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/platform-integration/web/building">Build a web app with Flutter</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/web/initialization">Customize app initialization</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/web/wasm">Compile to Wasm</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/web/web-content-in-flutter">Integrate web content</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/web/embedding-flutter-web">Embed in another web app</a>
        </li>
      </ul>
    </div>
  </div>
</div>
