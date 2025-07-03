
### Download then install Flutter {:.no_toc}

{% assign osl = include.os | downcase | replace: "chromeos","linux" %}
{% case include.os %}
{% when 'Windows' -%}
   {% assign unzip='Expand-Archive .\\' %}
   {% assign path='C:\\user\\{username}\\dev' %}
   {% assign flutter-path='C:\\user\\{username}\\dev\\flutter' %}
   {% assign prompt='PS C:\\>' %}
   {% assign prompt2=path | append: '>' %}
   {% assign diroptions='`%USERPROFILE%` (`C:\\Users\\{username}`) or `%LOCALAPPDATA%` (`C:\\Users\\{username}\\AppData\\Local`)' %}
   {% assign dirinstall='`%USERPROFILE%\\dev\\`' %}
   {% assign dirdl='%USERPROFILE%\\Downloads' %}
   {% assign ps-dir-dl='$env:USERPROFILE\\Downloads\\' %}
   {% assign ps-dir-target='$env:USERPROFILE\\dev\\' %}
   {% capture uz -%}
     {{prompt}} Expand-Archive `
         –Path {{ps-dir-dl}}flutter_sdk_v1.0.0.zip `
         -Destination {{ps-dir-target}}
   {%- endcapture %}
{% when "macOS" -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='unzip' %}
   {% assign path='~/development/' %}
   {% assign flutter-path='~/development/flutter' %}
   {% assign prompt='\$' %}
   {% assign dirdl='~/Downloads/' %}
   {% capture uz -%}
      {{prompt}} {{unzip}} {{dirdl}}flutter_sdk_v1.0.0.zip \
          -d {{path}}
   {%- endcapture %}
{% else -%}
   {% assign diroptions='`~/development/`' %}
   {% assign dirinstall='`~/development/`' %}
   {% assign unzip='tar' %}
   {% assign path='~/development/' %}
   {% assign flutter-path='~/development/flutter' %}
   {% assign prompt='\$' %}
   {% assign dirdl='~/Downloads/' %}
   {% capture uz -%}
     {{prompt}} {{unzip}} -xf {{dirdl}}flutter_sdk_v1.0.0.zip -C {{path}}
   {%- endcapture %}
{% endcase -%}

To install Flutter,
download the Flutter SDK bundle from its archive,
move the bundle to where you want it stored,
then extract the SDK.

1. Download the following installation bundle to get the latest
   {{site.sdk.channel}} release of the Flutter SDK.

   {% if include.os=='macOS' %}

   | Intel Processor                                                  | Apple Silicon                                                                         |
   |------------------------------------------------------------------|---------------------------------------------------------------------------------------|
   | [(loading...)](#){:.download-latest-link-{{osl}} .filled-button} | [(loading...)](#){:.download-latest-link-{{osl}}-arm64 .apple-silicon .filled-button} |

   {% else %}

   [(loading...)](#){:.download-latest-link-{{osl}} .filled-button}

   {% endif -%}

   For other release channels, and older builds, check out the [SDK archive][].

   The Flutter SDK should download to the {{include.os}}
   default download directory: `{{dirdl}}`.
   {% if include.os=='Windows' %}
   If you changed the location of the Downloads directory,
   replace this path with that path.
   To find your Downloads directory location,
   check out this [Microsoft Community post][move-dl].
   {% endif %}

1. Create a folder where you can install Flutter.

   Consider creating a directory at {{diroptions}}.
   {% if include.os == "Windows" -%}

   :::warning
   Don't install Flutter to a directory or path that meets
   one or both of the following conditions:

   * The path contains special characters or spaces.
   * The path requires elevated privileges.

   As an example, `C:\Program Files` meets both conditions.
   :::

   {% endif %}

1. Extract the file into the directory you want to store the Flutter SDK.

   ```console
   {{uz}}
   ```

   When finished, the Flutter SDK should be in the `{{flutter-path}}` directory.

[SDK archive]: /install/archive
[move-dl]: https://answers.microsoft.com/en-us/windows/forum/all/move-download-folder-to-other-drive-in-windows-10/67d58118-4ccd-473e-a3da-4e79fdb4c878

{% case include.os %}
{% when 'Windows' %}

### Update your Windows PATH variable {:.no_toc}

{% render docs/help-link.md, location:'win-path', section:'#unable-to-find-the-flutter-command' %}

To run Flutter commands in PowerShell,
add Flutter to the `PATH` environment variable.
This section presumes that you installed the Flutter SDK in
`%USERPROFILE%\dev\flutter`.

1. Press <kbd>Windows</kbd> + <kbd>Pause</kbd>.

   If your keyboard lacks a <kbd>Pause</kbd> key,
   try <kbd>Windows</kbd> + <kbd>Fn</kbd> + <kbd>B</kbd>.

   The **System > About** dialog displays.

1. Click **Advanced System Settings**
   <span aria-label="and then">></span> **Advanced**
   <span aria-label="and then">></span> **Environment Variables...**

   The **Environment Variables** dialog displays.

1. In the **User variables for (username)** section,
   look for the **Path** entry.

   {:type="a"}
   1. If the entry exists, double-click on it.

      The **Edit Environment Variable** dialog displays.

      {:type="i"}

      1. Double-click in an empty row.

      1. Type `%USERPROFILE%\dev\flutter\bin`.

      1. Click the **%USERPROFILE%\dev\flutter\bin** entry.

      1. Click **Move Up** until the Flutter entry sits at the top of the list.

      1. Click **OK** three times.

   1. If the entry doesn't exist, click **New...**.

      The **Edit Environment Variable** dialog displays.

      {:type="i"}
      1. In the **Variable Name** box, type `Path`.

      1. In the **Variable Value** box,
         type `%USERPROFILE%\dev\flutter\bin`

      1. Click **OK** three times.

1. To enable these changes,
   close and reopen any existing
   command prompts and PowerShell instances.

{% when 'macOS' %}

### Add Flutter to your `PATH` {:.no_toc}

To run Flutter commands in the terminal,
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

{% else %}

### Add Flutter to your `PATH` {:.no_toc}

To run Flutter commands in a shell,
add Flutter to the `PATH` environment variable.

1. Check which shell starts when you open a new console window.
   This would be your _default shell_.

   ```console
   $ echo $SHELL
   ```

   This differs from another command that tells you which shell runs
   in your current console.

   ```console
   $ echo $0
   ```

1. To add Flutter to your `PATH`, expand the entry for your default shell, then
   choose the command.

{% for shell in shells %}

   <details {% if shell.name == 'bash' %}open{% endif %}>
   <summary>Show <code>{{shell.name}}</code> command</summary>

   ```console
   $ {{shell.set-path}}
   ```

   {% if shell.name == 'shell' %}
   :::note
   If the above doesn't work, you might be using a non-login shell.
   In that case, add the same line to ~/.bashrc: `console $ echo
   'export PATH="~/development/flutter/bin:$PATH"' >> ~/.bashrc `.
   To ensure consistency across all shell types, source ~/.bashrc from
   ~/.bash_profile by adding the following to ~/.bash_profile: ` if [ -f
   ~/.bashrc ]; then source ~/.bashrc fi `.
   {% endif %}

   </details>

{% endfor %}

1. To apply this change, restart all open terminal sessions.

{% endcase %}
