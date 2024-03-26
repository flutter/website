{% assign terminal=include.terminal %}

### Remove Flutter from your Windows Path variable {:.no_toc}

To remove Flutter commands from {{terminal}},
remove Flutter from the `PATH` environment variable.

{% include docs/install/reqs/windows/open-envvars.md %}

1. Under **User variables for (username)** section,
   look for the **Path** entry.

   {:type="a"}
   1. Double-click on it.

      The **Edit Environment Variable** dialog displays.

   1. Click the **%USERPROFILE%\dev\flutter\bin** entry.

   1. Click **Delete**.

   1. Click **OK** three times.

1. To enable these changes,
   close and reopen any existing command prompts and {{terminal}} instances.
