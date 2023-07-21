## Get the Flutter SDK

{% include docs/china-notice.md %}

To get started with Flutter, follow these steps:

### Step 1: Download the Flutter SDK

1. Download the latest {{site.sdk.channel}} release of the Flutter SDK from
   [(here)](#){:.download-latest-link-{{os}}.btn.btn-primary}

   > Tip: For other release channels or older builds, visit the [SDK archive][].

2. Extract the zip file and place the `flutter` folder in the desired location.
   (e.g., `C:\src\flutter` on Windows).

{{site.alert.warning}}

Avoid installing Flutter in a path that includes special characters or spaces. 
Also, avoid directories like `C:\Program Files\` that require elevated 
privileges.

{{site.alert.end}}

### Step 2: Update your PATH

{% include_relative _help-link.md location='win-path' 
section='#unable-to-find-the-flutter-command' %}

Adding Flutter to your `PATH` makes running Flutter commands in the console 
easier. Here's how to do it:

#### For Windows Users:

1. In the Start search bar, type 'env' and select **Edit environment variables 
   for your account**.
2. Check for an entry called **Path** in the **User variables** section.
   - If it exists, click **Edit**. In the editor, click **New** and use the 
     file browser to navigate to the `flutter\bin` directory in your Flutter 
     SDK.
   - If it doesn't exist, click **New** in the **User variables** section. Name 
     the new variable `Path`, and use the file browser to select the 
     `flutter\bin` directory in your Flutter SDK.

#### For WSL2 Users:

Follow the instructions provided in the [WSL2 setup guide](\_wsl-setup.md).

> Note: You need to close and reopen console windows for these changes to take 
  effect.

{% include docs/dart-tool-win.md %}

### Step 3: Run `flutter doctor`

{% include_relative _help-link.md location='win-doctor' %}

Verify your setup by running the `flutter doctor` command in the console:

```bash
C:\src\flutter>flutter doctor
```

This command checks your environment and provides a status report of your 
Flutter installation. It also alerts you if additional setup tasks are required. 

{% include_relative _analytics.md %}

[Flutter repo]: {{site.repo.flutter}}
[SDK archive]: {{site.url}}/release/archive
[Set up an editor]: {{site.url}}/get-started/editor?tab=androidstudio
