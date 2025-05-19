
### Remove Flutter from your macOS PATH {:.no_toc}

To remove Flutter commands from your terminal,
remove Flutter to the `PATH` environment variable.
This guide presumes your [Mac runs the latest default shell][zsh-mac], `zsh`.
Zsh uses the `.zshenv` file for [environment variables][envvar].

1. Launch your preferred text editor.

1. Open the Zsh environmental variable file `~/.zshenv`

1. Remove the following line at the end of your `~/.zshenv` file.

   ```bash
   export PATH=$HOME/development/flutter/bin:$PATH
   ```

1. Save your `~/.zshenv` file.

1. To apply this change, restart all open terminal sessions.

If you use another shell,
check out [this tutorial on removing a directory from your PATH][other-path].

[zsh-mac]: https://support.apple.com/en-us/102360
[envvar]: https://zsh.sourceforge.io/Intro/intro_3.html
[other-path]: https://phoenixnap.com/kb/linux-add-to-path
