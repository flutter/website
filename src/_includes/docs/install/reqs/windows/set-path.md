
### Update your Windows PATH variable {:.no_toc}

{% render docs/help-link.md, location:'win-path', section:'#unable-to-find-the-flutter-command' %}

To run Flutter commands in {{include.terminal}},
add Flutter to the `PATH` environment variable.
This section presumes that you installed the Flutter SDK in
`%USERPROFILE%\dev\flutter`.

{% render docs/install/reqs/windows/open-envvars.md %}

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
   command prompts and {{include.terminal}} instances.
