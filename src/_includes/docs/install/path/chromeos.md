:::note
The following steps assume
you've already [turned on Linux support][chromeos-linux] and that
you're using Bash or the default shell on ChromeOS.

If you're using a different shell besides the default or Bash, follow the
[add to path instructions for Linux][linux-path]{: target="_blank"} instead.
:::

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Add the Flutter SDK bin to your path</h3>

    To add the `bin` directory of your Flutter installation to your `PATH`:

    1. Copy the following command.
    1. Replace `<path-to-sdk>` with the path to your Flutter SDK install.
    1. Run the edited command in your preferred terminal.

    ```console
    $ echo 'export PATH="<path-to-sdk>:$PATH"' >> ~/.bash_profile
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.bash_profile
    ```

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open Zsh sessions in your terminal apps and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open a Zsh session in your preferred terminal,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

[chromeos-linux]: https://support.google.com/chromebook/answer/9145439
[linux-path]: /install/add-to-path#linux
[troubleshoot]: /install/troubleshoot
