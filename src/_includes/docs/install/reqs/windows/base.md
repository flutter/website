## System requirements

To install and run Flutter,
your {{include.os}} environment must meet these requirements:

### Hardware requirements

Your {{include.os}} Flutter development environment must meet the following
minimal hardware requirements.

<div class="table-wrapper" markdown="1">
|     Requirement              |                                    Minimum                               |    Recommended      |
|:-----------------------------|:------------------------------------------------------------------------:|:-------------------:|
| x86_64 CPU Cores             | 4                                                                        | 8                   |
| Memory in GB                 | 8                                                                        | 16                  |
| Display resolution in pixels | WXGA (1366 x 768)                                                        | FHD (1920 x 1080)   |
| Free disk space in GB        | {% include docs/install/reqs/windows/storage.md target=include.target %}
</div>

### Software requirements

To write and compile Flutter code for {{include.target}},
you must have the following version of Windows and the listed
software packages.

#### Operating system
{:.no_toc}

Flutter supports {{site.devmin.windows}} or later.
These versions of Windows should include the required
[Windows PowerShell][] {{site.appmin.powershell}} or later.

#### Development tools
{:.no_toc}

Download and install the Windows version of the following packages:

- [Git for Windows][] {{site.appmin.github_win}} or later to manage source code.
- [Visual Studio Code][] {{site.appmin.vscode}} or later to write code.
{% include docs/install/reqs/windows/software.md target=include.target %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

To edit and debug Flutter code, install the [Flutter extension for VS Code][].
This extension simplifies installing the Flutter SDK using Visual Studio Code.

[Visual Studio Code]: https://code.visualstudio.com/docs/setup/windows
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Windows PowerShell]: https://docs.microsoft.com/powershell/scripting/install/installing-windows-powershell
[Git for Windows]: https://gitforwindows.org/
