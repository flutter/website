:::note
The following steps assume you're
using the [default shell][zsh-mac] on macOS, Zsh.

If you use another shell besides Zsh,
check out [this tutorial on setting your PATH][other-path].
:::

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Open or create the Zsh environment variable file</h3>

    If it exists, open the [Zsh environment variable file][zsh-files]
    `~/.zprofile` in your preferred text editor.
    If it doesn't exist, create the `~/.zprofile` file.

 1. <h3>Add the Flutter SDK bin to your path</h3>

    At the end of your `~/.zprofile` file,
    use the built-in `export` command to update the `PATH` variable
    to include the `bin` directory of your Flutter installation.

    Replace `<path-to-sdk>` with the path to your Flutter SDK installation.

    ```bash
    export PATH="<path-to-sdk>/bin:$PATH"
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd add the following to the file:

    ```bash
    export PATH="$HOME/develop/flutter/bin:$PATH"
    ```

 1. <h3>Save your changes</h3>

    Save, then close, the `~/.zprofile` file you edited.

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

[zsh-mac]: https://support.apple.com/en-us/102360
[zsh-files]: https://zsh.sourceforge.io/Intro/intro_3.html
[other-path]: https://www.cyberciti.biz/faq/unix-linux-adding-path/
[troubleshoot]: /install/troubleshoot
