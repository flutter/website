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
    For example, Linux uses the Bash shell by default,
    so edit `$HOME/.bashrc`.
    If you are using a different shell, the file path
    and filename will be different on your machine.
 3. Add the following line, changing the
    `[PATH_OF_FLUTTER_GIT_DIRECTORY]` to
    the path of your copy of the Flutter SDK:

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

{% include docs/dart-tool.md %}

### Update the path directly

In some cases, your distribution might not permanently acquire
the path when using the previous directions. When this occurs,
you can change the environment variables file directly.
These instructions require administrator privileges:

   1. Determine the path of your clone of the Flutter SDK.

   2. Locate the `etc` directory at the root of the system,
      and open the `profile` file with root privileges.

        ```terminal
        $ sudo nano /etc/profile
        ```
   3. Update the PATH string with the location of your
      Flutter SDK directory.

      ```shell
      if [ "`id -u`" -eq 0 ]; then
         PATH="..."
      else
         PATH="/usr/local/bin:...:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"
      fi
      export PATH
      ```

   4. End the current session or reboot your system.
   5. Once you start a new session, verify that the
      `flutter` command is available by running:

      ```terminal
      $ which flutter
      ```

For more details on setting the path in Bash,
see [this StackExchange question][bash].
For information on setting the path in Z shell,
see [this StackOverflow question][zsh].


[Get the Flutter SDK]: #get-sdk
[bash]: https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
[zsh]: {{site.so}}/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh
