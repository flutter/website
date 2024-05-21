
### Add Flutter to your `PATH` {:.no_toc}

To run Flutter commands in {{include.terminal}},
add Flutter to the `PATH` environment variable.
This guide presumes your [Mac runs the latest default shell][zsh-mac], `zsh`.
Zsh uses the `.zshenv` file for [environment variables][envvar].

1. Launch your preferred text editor.

1. If it exists, open the Zsh environmental variable file `~/.zshenv`
   in your text editor. If it doesn't, create `~/.zshenv`.

1. Copy the following line and paste it at the end of your `~/.zshenv` file.

   ```bash
   export PATH=$HOME/development/flutter/bin:$PATH
   ```

1. Save your `~/.zshenv` file.

1. To apply this change, restart all open terminal sessions.

If you use another shell,
check out [this tutorial on setting your PATH][other-path].

[zsh-mac]: https://support.apple.com/en-us/102360
[envvar]: https://zsh.sourceforge.io/Intro/intro_3.html
[other-path]: https://www.cyberciti.biz/faq/unix-linux-adding-path/
