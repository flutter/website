
<details>
<summary><strong>To verify your shell configuration, expand this section</strong></summary>

Like most UNIX-like operating system, macOS can support multiple shells,
like `bash`, `zsh`, and `sh`.
As of the October 2019 release of macOS Catalina (macOS 10.15),
Zsh or `zsh` is the default shell for macOS.

#### Check and set `zsh` as default

1. To verify `zsh` was set as the default macOS shell,
   run the [Directory Services command line utility][dscl].

    ```console
    $ dscl . -read ~/ UserShell
    ```

    The command should print the following as its response.

    ```console
    UserShell: /bin/zsh
    ```

    You can skip the remaining steps.

1. If you need to install `zsh`,
   follow the procedure in [this Wiki][install-zsh].

1. If you need to change your default shell to `zsh`,
   run the `chsh` command.

    ```console
    $ chsh -s `which zsh`
    ```

To learn more about macOS and `zsh`, check out
[Use zsh as the default shell on your Mac][zsh-mac]
in the macOS documentation.

</details>

[install-zsh]: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
[dscl]: https://ss64.com/mac/dscl.html
