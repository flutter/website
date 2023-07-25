## System requirements

To install and run Flutter,
your {{include.os}} environment must meet these requirements:

### Hardware requirements

<div class="table-wrapper" markdown="1">
|     Requirement              |                                    Minimum                               |      Optimal        |
|:-----------------------------|:------------------------------------------------------------------------:|:-------------------:|
| x86_64 CPU Cores             | 4                                                                        | 8                   |
| Memory in GB                 | 8                                                                        | 16                  |
| Display resolution in pixels | WXGA (1366 x 768)                                                        | FHD (1920 x 1080)   |
| Free disk space in GB        | {% include docs/install/reqs/windows/storage.md target=include.target %} |
{:.table.table-striped}
</div>

### Software requirements

To write and compile Flutter code for {{include.target}},
you must have the following version of Windows and the listed
software packages.

#### Operating system
{:.no_toc}

Flutter supports the 64-bit version of Microsoft Windows 10 or later.
These versions of Windows should include [Windows PowerShell 5.0][].

#### Development tools
{:.no_toc}

Download and install the Windows version of the following packages:

- [Git for Windows][] 2.4 or later to manage source code.
- [Visual Studio Code][] 1.75 or later to edit and debug Flutter code.
{% include docs/install/reqs/windows/software.md target=include.target %}

Flutter doesn't support any of these packages.
To troubleshoot installation issues, consult that product's documentation.

[Visual Studio Code]: https://code.visualstudio.com/docs/setup/windows
[Windows PowerShell 5.0]: https://docs.microsoft.com/powershell/scripting/install/installing-windows-powershell
[Git for Windows]: https://gitforwindows.org/
