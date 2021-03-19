### Update your path

You can update your PATH variable for the current session at
the command line, as shown in [Get the Flutter SDK][].
You'll probably want to update this variable permanently,
so you can run `flutter` commands in any terminal session.

The steps for modifying this variable permanently for
all terminal sessions are machine-specific.
Typically you add a line to a file that is executed
whenever you open a new window. For example:

 1. Determine the path of your clone of the Flutter SDK.
    You need this in Step 3.
 2. Open (or create) the `rc` file for your shell.
    Typing `echo $SHELL` in your Terminal tells you
    which shell you're using.
    If you're using Bash,
    edit `$HOME/.bash_profile` or `$HOME/.bashrc`.
    If you're using Z shell, edit `$HOME/.zshrc`.
    If you're using a different shell, the file path
    and filename will be different on your machine.
 3. Add the following line and change
    `[PATH_OF_FLUTTER_GIT_DIRECTORY]` to be
    the path of your clone of the Flutter git repo:

    ```terminal
    $ export PATH="$PATH:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"
    ```

 4. Run `source $HOME/.<rc file>`
    to refresh the current window,
    or open a new terminal window to
    automatically source the file.
 5. Verify that the `flutter/bin` directory
    is now in your PATH by running:

    ```terminal
    $ echo $PATH
    ```
    Verify that the `flutter` command is available by running:

    ```terminal
    $ which flutter
    ```

{% include dart-tool.md %}

[Get the Flutter SDK]: #get-sdk
