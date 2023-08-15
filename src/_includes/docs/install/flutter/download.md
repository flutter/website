### Download then install Flutter
{:.no_toc}

{% assign os = include.os %}

1. Download the following installation bundle to get the latest
   {{site.sdk.channel}} release of the Flutter SDK:

   [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

   For other release channels, and older builds,
   check out the [SDK archive][].

1. Extract the zip file.

1. Move the contained `flutter` directory
   to where you want to store the Flutter SDK.

   {{site.alert.warning}}
   Do not install Flutter to a directory or path that meets
   one or both of the following conditions:

   - The path contains special characters or spaces.
   - The path requires elevated privileges.

   As an example, `C:\Program Files\` fails both conditions.
   You could use `%USERPROFILE%\flutter` or `D:\dev\flutter`.
   {{site.alert.end}}

[SDK archive]: {{site.url}}/release/archive

### Update your Windows PATH variable
{:.no_toc}

{% include docs/help-link.md location='win-path' section='#unable-to-find-the-flutter-command' %}

To run Flutter commands in PowerShell,
add Flutter to the `PATH` environment variable.

1. In the **Start** search bar, type `env``.

1. Select **Edit environment variables for your account**.

1. Under **User variables** check for the **Path** entry.

   * If the entry exists, prepend the full path to `flutter\bin`
     followed with a semicolon (`;`) to separate the new value from
     existing values.

   * If the entry doesn't exist,
     create a new user variable named **Path**.

     Set its value to the full path to `flutter\bin`.

1. For these changes to take effect,
   close and reopen any existing command prompts and PowerShell instances.
