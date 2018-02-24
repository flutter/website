## Get the Flutter SDK

To get Flutter, use `git` to clone the repository and then add the `flutter` tool to your path.
Running `flutter doctor` shows any remaining dependencies you may need to install.

### Clone the repo

If this is the first time you're installing Flutter on this machine, clone the
repository:

{% commandline %}
git clone -b dev https://github.com/flutter/flutter.git
{% endcommandline %}

To update an existing version of Flutter, see [Upgrading Flutter](/upgrading/)

### Update your path

To run the `flutter` command in any terminal session, you need to add it to your PATH environment variable:

* Go to "Control Panel > User Accounts > User Accounts > Change my environment variables"
* Under "User variables" check if there is an entry called "Path":
    * If the entry does exist, append the full path to `flutter\bin` using `;` as a separator from existing values.
    * If the entry does not exist, create a new user variable named `Path` with the full path to `flutter\bin` as its value.

Close and re-open any terminal window (e.g. command prompt or PowerShell) to apply this change.

### Run flutter doctor

Open a new Command Prompt or PowerShell window and run the following command to
see if there  are any dependencies you need to install to complete the setup:

{% commandline %}
flutter doctor
{% endcommandline %}

Run this command in either a Command Prompt or PowerShell window. Currently, Flutter does
not support third-party shells like Git Bash.
{: .alert-warning}

This command checks your environment and displays a report to the terminal window.
The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately.
Check the output carefully for other software you may need to install or further 
tasks to perform .

For example:

```
✗ Minimum supported Android SDK version is 25 but this system has 23. Please upgrade.
```

The first time you run the `flutter` command, it downloads its own dependencies and compiles
itself. Subsequent runs should be much faster.

The following sections describe how to perform these tasks and finish the setup process.
You'll see in `flutter doctor` output that if you choose to use an IDE, plugins
are available for IntelliJ IDEA, Android Studio, and VS Code. See [Editor Setup](/get-started/editor-configuration/)
for the steps to install the Flutter and Dart plugins.

Once you have installed any missing dependencies, run the `flutter doctor` command again to
verify that you’ve set everything up correctly.

The `flutter` tool uses Google Analytics to anonymously report feature usage statistics
and basic crash reports. This data is used to help improve Flutter tools over time.
Analytics is not sent on the very first run or for any runs involving `flutter config`,
so you can opt out of analytics before any data is sent. To disable reporting, 
type `flutter config --no-analytics` and to display the current setting, type 
`flutter config`. See Google's privacy policy:[www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).
{: .alert-warning}
