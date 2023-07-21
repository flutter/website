[Announcing Flutter for Windows]: {{site.flutter-medium}}/announcing-flutter-for-windows-6979d0d01fed
## Windows Desktop Setup

{% include_relative _help-link.md location='win-desktop' %}

To develop desktop applications with Flutter on Windows, you'll need to perform 
the following steps:

### Step 1: Install the Flutter SDK

Follow the instructions in our [Getting Started Guide](\_getting-started.md) to 
install the Flutter SDK on your system.

### Step 2: Install Additional Windows Requirements

In addition to the Flutter SDK, you'll need to install the following:

* [Visual Studio 2022][]
  
  - or -
    
* [Visual Studio Build Tools 2022][]

When installing Visual Studio or the Build Tools, make sure you include the 
"Desktop development with C++" workload. This is necessary for building Windows 
applications and should include all of its default components. 

{% include_relative _vs-workload-notice.md %}

For more information on building Windows applications with Flutter, refer to 
[Building Windows apps][].

### Optional: Set Up WSL

If you prefer working in a Linux-like environment, you can set up the Windows 
Subsystem for Linux (WSL). However, keep in mind that while WSL can be used to 
run Flutter command-line tools, it doesn't support GUI applications out of the box. 
For more information, see our guide on setting up [Flutter in WSL](\_wsl-setup.md).

[Building Windows apps]: {{site.url}}/platform-integration/windows/building
[Visual Studio 2022]: https://visualstudio.microsoft.com/downloads/
[Visual Studio Build Tools 2022]: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
