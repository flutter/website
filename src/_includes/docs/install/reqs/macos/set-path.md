{% assign terminal=include.terminal %}
{% assign target = include.target %}
{% assign dir = include.dir %}

### Add Flutter to your `PATH`
{:.no_toc}

To run Flutter commands in {{terminal}},
You need to add Flutter to the `PATH` environment variable.
This section covers the permanent addition of the path to the
Flutter to your `PATH` environment variable.
This guide presumes that you are using the latest default shell, `zsh`.
This section adds Flutter to the `PATH` using the `.zshenv` file.
Zsh uses this file only for environment variables and loads its
contents before any other configuration file.

1. Launch your preferred text editor.

1. If it exists, open the Zsh environmental variable file `~/.zshenv`
   in your text editor. If it doesn't, create `~/.zshenv`.

1. Copy the following text block.

   ```conf

   # Configure Flutter

   # Set the Flutter home directory to your Flutter install directory.
   export FLUTTER_HOME=$HOME/development/flutter

   # Check if Flutter is in your PATH, and, if not, add it. 
   if [[ $PATH != *"$FLUTTER_HOME"* ]]
   then
       export PATH=$FLUTTER_HOME/bin:$PATH
   fi
   ```

1. Paste it at the end of your `~/.zshenv` file.

1. Save your `~/.zshenv` file.

1. Load the changes to your current open terminal session.

    ```terminal
    $ source ~/.zshenv
    ```

   If you have more than one Terminal window open,
   repeat this step in each Terminal window.

[zsh-mac]: https://support.apple.com/en-us/102360
[brew]: https://brew.sh/
