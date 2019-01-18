### Update your path

You can update your PATH variable for the current session only at the command
line, as shown in [Get the Flutter SDK](#get-sdk). You'll probably want to
update this variable permanently, so you can run `flutter` commands in any terminal session.

The steps for modifying this variable permanently for all terminal sessions are machine-specific.
Typically you add a line to a file that is executed whenever you open
a new window. For example:

 1. Determine the directory where you placed the Flutter SDK. You will
    need this in Step 3.
 2. Open (or create) `$HOME/.bash_profile`. The file path and filename might be
    different on your machine.
 3. Add the following line and change `[PATH_TO_FLUTTER_GIT_DIRECTORY]` to be
    the path where you cloned Flutter's git repo:

    ```terminal
    $ export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
    ```

 4. Run `source $HOME/.bash_profile` to refresh the current window.
 5. Verify that the `flutter/bin` directory is now in your PATH by running:

    ```terminal
    $ echo $PATH
    ```

For more details, see [this StackExchange question](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path).
