{% assign os = 'wsl' -%}

## Windows Subsystem for Linux (WSL2) Setup

[Windows Subsystem for Linux](https://aka.ms/wsl) (WSL) allows you to run a GNU/Linux environment directly on Windows without the overhead of a virtual machine. This guide will use Ubuntu as an example, but you can choose any Linux distribution of your preference.

## System requirements

To install and run Flutter on Windows Subsystem for Linux (WSL2) with Ubuntu distribution, your development environment must meet these minimum requirements:

- **Operating Systems**: Windows 10 (version 2004 and higher, Build 19041 and higher) or later (64-bit), x86-64 based, with WSL2 enabled and Ubuntu distribution installed.
- **Disk Space**: 1.64 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these tools being available in your environment.
  - [Visual Studio Code][] with [Remote - WSL][] extension installed.
  - Git 2.x, which can be installed via `sudo apt-get install git`.

### Installing Flutter

#### Installing using Microsoft Store

This method is the simplest way to add WSL2 and Ubuntu to your Windows. It provides automatic updates which are managed by the Windows Store. To install, follow the steps:

1. Install [WSL2](https://apps.microsoft.com/store/detail/windows-subsystem-for-linux/9P9TQF7MRM4R) from Microsoft Store.
2. Install a Linux distribution. We recommend using [Ubuntu](https://apps.microsoft.com/store/detail/ubuntu/9PDXGNCFSCZV) from the Microsoft Store.
3. Install [Visual Studio Code][] from its official website.
4. Add the [Remote - WSL extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) from the VS Code Marketplace. This extension allows VS Code to interact with the Linux subsystem.

#### Installing using Command Line

For advanced users, who want more control over the installation process, use these steps:

1. Open PowerShell as Administrator and run the following command to install WSL and Ubuntu:

    ```powershell
    wsl --install
    ```

   Then, restart your machine.

2. Set WSL2 as your default version:

    ```powershell
    wsl --set-default-version 2
    ```

3. If you want to install a different Linux distribution, run the following command, replacing `<Distribution Name>` with the name of the distribution:

    ```powershell
    wsl --install -d <Distribution Name>
    ```

4. Install [Visual Studio Code](https://code.visualstudio.com/Download) in Windows and add [Remote - WSL extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) to it.

## Setting up the Linux environment

After setting up WSL2 and VS Code, it's time to install Flutter, Android Studio, and Google Chrome in the Linux environment. These tools will run directly in WSL2, giving you a complete Linux development environment in Windows.


1. Open Visual Studio Code and connect to WSL Ubuntu by using the Remote-WSL extension. This opens the Ubuntu Bash terminal instead of the Windows CMD terminal.

2. Update your Linux distribution by running the following commands:

    ```terminal
    sudo apt-get update && sudo apt-get upgrade
    ```

3. If the `snap` command is not available, install Snap Package Manager by running the following command:

    ```terminal
    sudo apt install snapd
    ```

4. Install Flutter by running the following command:

    ```terminal
    sudo snap install flutter --classic
    ```

5. Install Android Studio by running the following command:

    ```terminal
    sudo snap install android-studio --classic
    ```

6. Download Google Chrome:

    ```terminal
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    ```

7. Install Google Chrome:

    ```terminal
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt --fix-broken install
    ```

{{site.alert.note}}

For more detailed Linux installation instructions, please refer to the [Linux setup page][].

{{site.alert.end}}

### Verify your setup

After installing these tools, it's important to verify that everything is working correctly. The `flutter doctor` command can check your environment and report any issues with your setup.

Run `flutter doctor`:

   ```bash
   flutter doctor
   ```

With this setup, you can now use Visual Studio Code for your Flutter projects in a full Linux environment.

### Common Linux commands

For those who may be new to the Linux command line, here's a table of common Linux commands that you might find useful during your development work.

| Command | Description                                                                      |
| ------- | -------------------------------------------------------------------------------- |
| `cd`    | Change directory                                                                 |
| `ls`    | List directory contents                                                          |
| `pwd`   | Print working directory                                                          |
| `mkdir` | Create a directory                                                               |
| `rm`    | Remove a file or directory                                                       |
| `touch` | Create an empty file                                                             |
| `cat`   | Display file’s contents to the standard output device (usually your monitor)     |
| `cp`    | Copy files and directories                                                       |
| `mv`    | Move or rename files and directories                                             |
| `less`  | View file contents                                                               |


[WSL2]: https://aka.ms/wsl2
[Microsoft Store]: https://aka.ms/wslstore
[Linux setup page]: {{site.url}}/platform-integration/linux/setup
[Visual Studio Code]: https://code.visualstudio.com/download
[Remote - WSL]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl
