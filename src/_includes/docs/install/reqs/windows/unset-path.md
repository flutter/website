{% assign terminal=include.terminal %}

### Remove Flutter from your Windows PATH variable
{:.no_toc}

To remove Flutter commands from {{terminal}},
remove Flutter to the `PATH` environment variable.

1. Press <kbd>Windows</kbd> + <kbd>S</kbd>.

1. Type `environment`.

1. When **Edit the system environment variables** displays
   as the **Best match**, click **Open** under
   **Edit the system environment variables**.

1. Click **About**.

1. Click **Advanced System Settings**.

1. Click **Environment Variables...**

   The **Environment Variables** dialog displays.

1. Under **User variables for \<user\>** check for the **Path** entry.

   {:type="a"}
   1. If the entry exists, click **Delete**.

   1. Click **OK**.

1. To enable these changes,
   close and reopen any existing command prompts and {{terminal}} instances.
