### Update your path

Independent of how you installed Flutter,
you need to add the Flutter SDK to your PATH.
You can add Flutter to your `PATH` either for the current session
or for all sessions going forward.

{% include docs/dart-tool.md %}

#### Update your path for the current session only

To update your `PATH` variable for the current session,
enter this command in your terminal:

```terminal
$ export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
```

In this command,
replace `[PATH_TO_FLUTTER_GIT_DIRECTORY]`
with the path to your Flutter SDK install.

#### Update your path for all future sessions

To add Flutter to your `PATH` for _any_ terminal session, follow these steps:

1. Find your Flutter SDK installation path.

  ```terminal
  $ find / -type d -name "flutter/bin" 2>/dev/null
  ```

  ```terminal
  /usr/<example>dev/flutter/bin
  ```

1. Append the following line to your `rc` shell file.
  Linux reads the `rc` shell "resource" file each
  time it opens a terminal.

  Replace `<path_to_flutter_directory>` with your Flutter path.

```terminal
export PATH="$PATH:`pwd`/flutter/bin"
```

4. Run `source $HOME/.<rc file>` to refresh the current window, or open a new terminal window to automatically source the file.
5. Verify that the `flutter/bin` directory is now in your PATH by running:

```terminal
$ echo $PATH
```

Verify that the `flutter` command is available by running:

```terminal
$ which flutter
```
{% include docs/dart-tool.md %}

### Update the path directly

In some cases, your distribution might not permanently acquire the path when using the previous directions. When this occurs, you can change the environment variables file directly. These instructions require administrator privileges:

1. Determine the path of your clone of the Flutter SDK.
2. Locate the `etc` directory at the root of the system, and open the `profile` file with root privileges.

```terminal
$ sudo nano /etc/profile
```

3. Update the PATH string with the location of your Flutter SDK directory.

```shell
if [ "`id -u`" -eq 0 ]; then
  PATH="..."
else
  PATH="/usr/local/bin:...:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"
fi
export PATH
```

4. End the current session or reboot your system.
5. Once you start a new session, verify that the `flutter` command is available by running:

```terminal
$ which flutter
```

For more details on setting the path in Bash, see [this StackExchange question][bash].
For information on setting the path in Z shell, see [this StackOverflow question][zsh].

[Get the Flutter SDK]: #get-sdk
[bash]: https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
[zsh]: {{site.so}}/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh
