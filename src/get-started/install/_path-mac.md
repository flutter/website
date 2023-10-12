### Update your path

You can update your PATH variable for the current session at
the command line, as shown in step 3 of [Get the Flutter SDK][].
To update this variable permanently so you can run
`flutter` commands in _any_ terminal session,
use the following instructions.

The steps for modifying the `PATH` variable
_all_ subsequent terminal sessions are machine-specific.
Typically, you add a line to a shell script file that
executes whenever you open a new window. For example:

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

[Get the Flutter SDK]: #get-sdk
