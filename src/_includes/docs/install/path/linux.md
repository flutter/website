 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Determine your default shell</h3>

    If you don't know what shell you use,
    check which shell starts when you open a new console window.

    ```console
    $ echo $SHELL
    ```

 1. <h3>Add the Flutter SDK bin to your path</h3>

    To add the `bin` directory of your Flutter installation to your `PATH`:

    1. Expand the instructions for your default shell.
    1. Copy the provided command.
    1. Replace `<path-to-sdk>` with the path to your Flutter SDK install.
    1. Run the edited command in your preferred terminal with that shell.

    <hr>

    <details>
    <summary>Expand for <code>bash</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>:$PATH"' >> ~/.bash_profile
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.bash_profile
    ```

    </details>

    <details>
    <summary>Expand for <code>zsh</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.zshenv
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.zshenv
    ```

    </details>

    <details>
    <summary>Expand for <code>fish</code> instructions</summary>

    ```console
    $ fish_add_path -g -p <path-to-sdk>/bin
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ fish_add_path -g -p ~/develop/flutter/bin
    ```

    </details>

    <details>
    <summary>Expand for <code>csh</code> instructions</summary>

    ```console
    $ echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.cshrc
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'setenv PATH "$HOME/develop/flutter/bin:$PATH"' >> ~/.cshrc
    ```

    </details>

    <details>
    <summary>Expand for <code>tcsh</code> instructions</summary>

    ```console
    $ echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.tcshrc
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'setenv PATH "$HOME/develop/flutter/bin:$PATH"' >> ~/.tcshrc
    ```

    </details>

    <details>
    <summary>Expand for <code>ksh</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.profile
    ```

    </details>

    <details>
    <summary>Expand for <code>sh</code> instructions</summary>

    ```console
    $ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile
    ```

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd run the following:

    ```console
    $ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.profile
    ```

    </details>

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open shell sessions in your terminal apps and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open your preferred terminal with your default shell,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

[troubleshoot]: /install/troubleshoot
