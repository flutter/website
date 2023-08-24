### Update your path

Independent of how you installed Flutter,
you need to add the Flutter SDK to your `PATH`.
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

To add Flutter to your `PATH` for _any_ terminal session, 
follow these steps:

1. Find your Flutter SDK installation path.
   
    ```terminal
    $ find / -type d -name "flutter/bin" 2>/dev/null
    ```
    
    Response should resemble:
   
    ```terminal
    /usr/<example>dev/flutter/bin
    ```
    
2. Append the following line to your `rc` shell file
   Linux reads the `rc` shell "resource" file each
   time it opens a terminal.

   Replace `<path_to_flutter_directory>` with your Flutter path
   
    ```terminal
    $ echo 'export PATH="$PATH:<path_to_flutter_directory>/flutter/bin"' >> $HOME/.bashrc
    ```
    
3. Reload the current shell profile.
   
    ```terminal
    source $HOME/.<rc file>
    ```
    
4. Verify that the `flutter/bin` directory exists in your `PATH`.
   
    ```terminal
    $ echo $PATH
    ```
    
    Response should resemble:
   
    ```terminal
    /usr/<example>/dev/flutter/bin:/usr/local/git/git-google/bin:/usr/local/git/current/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:
    ```
    
5. Verify that you can now use the `flutter` command.
   
    ```terminal
    $ which flutter
    ```

    Response should resemble:
   
    ```
	  /usr/<example>/dev/flutter/bin/flutter
	  ```

{% include docs/dart-tool.md %}
