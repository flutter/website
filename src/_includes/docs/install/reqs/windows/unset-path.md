
### Remove Flutter from your Windows Path variable {:.no_toc}

To remove Flutter commands from PowerShell,
remove Flutter to the `PATH` environment variable.

1. Press <kbd>Windows</kbd> + <kbd>Pause</kbd>.

   If your keyboard lacks a <kbd>Pause</kbd> key,
   try <kbd>Windows</kbd> + <kbd>Fn</kbd> + <kbd>B</kbd>.

   The **System > About** dialog displays.

1. Click **Advanced System Settings**
   <span aria-label="and then">></span> **Advanced**
   <span aria-label="and then">></span> **Environment Variables...**

   The **Environment Variables** dialog displays.

1. Under **User variables for (username)** section,
   look for the **Path** entry.

   {:type="a"}
   1. Double-click on it.

      The **Edit Environment Variable** dialog displays.

   1. Click the **%USERPROFILE%\dev\flutter\bin** entry.

   1. Click **Delete**.

   1. Click **OK** three times.

1. To enable these changes,
   close and reopen any existing
   command prompts and PowerShell instances.
