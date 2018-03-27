## Get the Flutter SDK

To get Flutter, use `git` to clone the repository and then add the `flutter` tool to your path.
Running `flutter doctor` shows any remaining dependencies you may need to install.

### Clone the repo

If this is the first time you're installing Flutter on this machine, clone the
repository:

{% commandline %}
git clone -b beta https://github.com/flutter/flutter.git
{% endcommandline %}

To update an existing version of Flutter, see [Upgrading Flutter](/upgrading/)

### Update your path

To run the `flutter` command in any terminal session, you need to add it to your PATH environment variable:

* Go to "Control Panel > User Accounts > User Accounts > Change my environment variables"
* Under "User variables" check if there is an entry called "Path":
    * If the entry does exist, append the full path to `flutter\bin` using `;` as a separator from existing values.
    * If the entry does not exist, create a new user variable named `Path` with the full path to `flutter\bin` as its value.

Reboot Windows to fully apply this change.
