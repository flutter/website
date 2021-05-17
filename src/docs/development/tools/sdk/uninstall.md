---
title: Uninstall Flutter
short-title: Uninstall
description: Steps to remove Flutter SDK.
toc: false
---

Before uninstalling Flutter, you have a few things to consider:

- Do you want to uninstall only Flutter, or also Dart? Dart is contained within the Flutter SDK, so it might be easiest to uninstall Flutter and then do a fresh Dart install.
- Do you also want to uninstall Android Studio? Xcode? CocoaPods? If so, refer to the docs for those tools.

{% comment %} Nav tabs {% endcomment -%}

<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="windows-tab" href="#windows" role="tab" aria-controls="windows" aria-selected="true">Windows</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="mac-linux-tab" href="#maclinux" role="tab" aria-controls="maclinux" aria-selected="false">Mac and Linux</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}

<div class="tab-content">

<div class="tab-pane active" id="windows" role="tabpanel" aria-labelledby="windows-tab" markdown="1">

## Uninstall Flutter on Windows

To uninstall Flutter and all of its contents,

- Navigate to the folder where the Flutter SDK is located
- Right click on the SDK folder and click delete.

{{site.alert.note}}
  If you experience any errors at this stage, such as,
  “Unable to complete action as the folder is in use”,
  do the following:
  * Open the task manager by pressing CTRL + ALT + DEL keys together.
  * Search for the running `dart.exe` process,
   select and click **end process** to quit the Dart VM.
  * Repeat the above steps to remove the Flutter SDK.
{{site.alert.end}}

### Removing .pub_cache

Package dependencies are stored in a [global cache directory][].
This directory can be large. To see exactly how large, in Windows Explorer,
select the file, and select **Properties** from the XXX menu.

[global cache directory]: {{site.dart-site}}/tools/pub/cmd/pub-cache

To remove the cache directory, do the following:

- Navigate to `%LOCALAPPDATA%\Pub\Cache` and delete the folder.

{{site.alert.note}}
  If the .pub_cache location was changed using the `PUB_CACHE`
  environment variable, navigate to that location and then right click
  and delete the folder.
{{site.alert.end}}

- If you’re unaware of the location and want to get the path,
  Open Command Prompt and run

```bash
echo %PUB_CACHE%.
```

- Navigate to the location specified and perform the above steps.

### Update your path

- In the search bar, type ‘env’ and select **Edit Environment Variables**.

- Select the Path variable, and remove the path containing `flutter/bin`.

**You’ve successfully removed Flutter and Dart from your machine**.

### We'll miss you

We’re sad to see you go, and we hope to see you back soon!
</div>
<div class="tab-pane active" id="maclinux" role="tabpanel" aria-labelledby="maclinux" markdown="1">

## Uninstall Flutter on Mac and Linux

To uninstall the Flutter and all of its contents,

- Navigate to the location either from the terminal or by using Finder on Mac, and the default file manager on Ubuntu.
- Delete the folder to remove the Flutter and Dart sdks.
- You may need to ensure that you have root privileges, or run `sudo rm -rf` in the folder path.

### Removing .pub_cache

Package dependencies are stored in a global cache on your development machine so that pub does not have to re-download the packages.

By default on Mac and Linux, the .pub_cache is stored in your home directory

To remove .pub_cache:

- Navigate to the Users/username/ directory either from the terminal or by using Finder on Mac, and the default file explorer on Linux.
- Delete the .pub_cache folder.

{{site.alert.note}}
If you don’t have permissions, run sudo `rm -rf .pub_cache` to remove it.
{{site.alert.end}}

{{site.alert.note}}
If the .pub_cache location was changed using the PUB_CACHE environment variable, navigate to that location and then right click and delete the folder.
{{site.alert.end}}

- If you’re unaware of the location and want to get the path,
  Open Command Prompt and run

```bash
echo $PUB_CACHE
```

### Uninstall using Snap Store,

If Flutter was installed using the snap store on Linux, remove it by running

```bash
sudo snap remove flutter
```

### Update your path,

Depending on the shell you use, open the configuration script file using your preferred text editor or terminal editor. For example:

- By default, on Linux,

```bash
 vi $HOME/.bashrc
```

On Mac,

```zsh
  vi $HOME/.zshrc
```

- In the PATH variable, remove the text from the beginning of the Flutter path up to, and including, the trailing colon.
- Save and exit.

**You’ve successfully removed Flutter and Dart from your machine**.

### We'll miss you

We’re sad to see you go, and we hope to see you back soon!
</div>
