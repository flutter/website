### Add Flutter to your `PATH` {:.no_toc}

To run Flutter commands in {{include.terminal}},
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
   <summary>Show <tt>{{shell.name}}</tt> command</summary>

   ```console
   $ {{shell.set-path}}
   ```

   {% if shell.name == 'shell' %}
   :::note
   If the above doesn't work, you might be using a non-login shell.
   In that case, add the same line to ~/.bashrc: `console $ echo
   'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.bashrc `.
   To ensure consistency across all shell types, source ~/.bashrc from
   ~/.bash_profile by adding the following to ~/.bash_profile: ` if [ -f
   ~/.bashrc ]; then source ~/.bashrc fi `.
   {% endif %}

   </details>

{% endfor %}

1. To apply this change, restart all open terminal sessions.
