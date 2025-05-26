
 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Navigate to the environment variables settings</h3>

    1. Press <kbd>Windows</kbd> + <kbd>Pause</kbd>.

       If your keyboard lacks a <kbd>Pause</kbd> key,
       try <kbd>Windows</kbd> + <kbd>Fn</kbd> + <kbd>B</kbd>.

       The **System > About** dialog opens.

    1. Click **Advanced System Settings**
       <span aria-label="and then">></span> **Advanced**
       <span aria-label="and then">></span> **Environment Variables...**.

       The **Environment Variables** dialog opens.

 1. <h3>Add the Flutter SDK bin to your path</h3>

    1. In the **User variables for (username)** section
       of the **Environment Variables** dialog,
       look for the **Path** entry.

    1. If the **Path** entry exists, double-click it.

       The **Edit Environment Variable** dialog should open.

       1. Double-click inside an empty row.

       1. Type the path to the `bin` directory of your Flutter installation.

          For example, if you downloaded Flutter into a
          `develop\flutter` folder inside your user directory,
          you'd type the following:

          ```plaintext
          %USERPROFILE%\develop\flutter\bin
          ```

       1. Click the Flutter entry you added to select it.

       1. Click **Move Up** until the Flutter entry sits at the top of the list.

       1. To confirm your changes, click **OK** three times.

       {: type="a"}

    1. If the entry doesn't exist, click **New...**.

       The **Edit Environment Variable** dialog should open.

       1. In the **Variable Name** box, type `Path`.

       1. In the **Variable Value** box,
          type the path to the `bin` directory of your Flutter installation.

          For example, if you downloaded Flutter into a
          `develop\flutter` folder inside your user directory,
          you'd type the following:

          ```plaintext
          %USERPROFILE%\develop\flutter\bin
          ```

       1. To confirm your changes, click **OK** three times.

       {: type="a"}

 1. <h3>Apply your changes</h3>

    To apply this change and get access to the `flutter` tool,
    close and reopen all open command prompts,
    sessions in your terminal apps, and IDEs.

 1. <h3>Validate your setup</h3>

    To ensure you successfully added the SDK to your `PATH`,
    open command prompt or your preferred terminal app,
    then try running the `flutter` and `dart` tools.

    ```console
    $ flutter --version
    $ dart --version
    ```

    If either command isn't found,
    check out [Flutter installation troubleshooting][troubleshoot].

{: .steps}

[troubleshoot]: /install/troubleshoot
