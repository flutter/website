{% assign terminal=include.terminal %}
{% assign target = include.target %}

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

1. To add Flutter to your `PATH` in your `.zshenv` file,
   run the following command.

    ```terminal
    $ cat <<EOF >> ~/.zshenv
    # Configure Flutter

    export FLUTTER_HOME=\$HOME/Projects/flutter
    if [[ \$PATH != *"\$FLUTTER_HOME"* ]]
    then
        export PATH=\$FLUTTER_HOME/bin:\$PATH
    fi
    EOF
    ```

1. To load the changes to your current open terminal sessions,
   run the following command.

    ```terminal
    $ source ~/.zshenv
    ```

[zsh-mac]: https://support.apple.com/en-us/102360
[brew]: https://brew.sh/
