{% assign terminal=include.terminal %}

### Update your Windows PATH variable
{:.no_toc}

{% include docs/help-link.md location='win-path' section='#unable-to-find-the-flutter-command' %}

To run Flutter commands in {{terminal}},
add Flutter to the `PATH` environment variable.

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
   1. If the entry exists, click **Edit...**.

   1. If the entry doesn't exist, click **New...**.

   1. Click **New**.

   1. Type `<install-directory>\flutter\bin`.

   1. Click the **\<install-directory\>\flutter\bin** entry.

   1. Click **Move Up** until the Flutter entry sits at the top of the list.

   1. Click **OK**.

1. To enable these changes,
   close and reopen any existing command prompts and {{terminal}} instances.
