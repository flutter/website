## Linux Setup

### Additional Linux Requirements
In addition to the Flutter SDK, these additional tools are required for desktop development on Linux:

- [Clang](https://clang.llvm.org/)
- [CMake](https://cmake.org/)
- [GTK development headers](https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html)
- [Ninja build](https://ninja-build.org/)
- [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
- [liblzma-dev](https://packages.debian.org/sid/liblzma-dev) (This might be necessary in some cases)

These can be installed by executing the following command:

```terminal
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

### Understanding Linux Commands

Understanding the commands used can help avoid potential issues and allow for a smoother installation process. Here's a brief overview of what each term in the above command means:

| Term/command | Definition/Usage |
| ------------ | ---------------- |
| `sudo` | Gives the command administrative permissions. |
| `apt`, `apt-get` | Call the APT package manager. |
| `install` | Tells the package manager to install a package. |
| `clang` | Refers to the Clang compiler. |
| `cmake` | Refers to the CMake build system. |
| `ninja-build` | Refers to the Ninja build system. |
| `pkg-config` | Refers to the pkg-config helper tool. |
| `libgtk-3-dev` | Refers to the GTK development headers. |
| `liblzma-dev` | Refers to the liblzma development headers. |
| `update` | Tells APT to refresh the package lists. |
| `snap` | Calls the snap package manager. |
| `--classic` | Is a confinement level for snap that gives the package access to system resources. |
| `cd` | Changes the current directory. |
| `tar` | Calls the program that handles tar files. |
| `x` | Tells tar to extract a file. |
| `f` | Tells tar to use the filename that follows. |
| `echo` | Prints to the console. |
| `PATH` | Is a variable holding the system path. |
| `export` | Sets environment variables. |
| `pwd` | Prints the working directory. |
| `wget` | Is a command line utility for downloading files from the internet. |
| `dpkg` | Calls the Debian package manager. |
| `-i` | Tells dpkg to install a package. |
| `-f` | Stands for --fix-broken in APT. It attempts to correct a system with broken dependencies in place. |
