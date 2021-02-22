---
title: Build and release a Linux app to the Snap Store
description: How to prepare for and release a Linux app to the Snap store.
short-title: Linux
---

During a typical development cycle,
you test an app using `flutter run` at the command line,
or by using the **Run** and **Debug**
options in your IDE. By default,
Flutter builds a _debug_ version of your app.

When you're ready to prepare a _release_ version of your app,
for example to [publish to the Snap Store][snap],
this page can help.

{{site.alert.warning}}
  **Work in progress!**
  This page covers desktop support for Linux,
  which is available as an alpha-quality feature in the Flutter dev channel.
  There are still notable feature gaps,
  including accessibility support.
  We strongly recommend that you examine the
  [Desktop shells][] page in the [Flutter wiki][]
  to understand known limitations and ongoing work.
{{site.alert.end}}


## Prerequisites

To build and publish to the Snap Store, you need the
following components:

* [Ubuntu][] OS, 18.04 LTS (or higher)
* [Snapcraft][] command line tool
* [Multipass virtualization manager][] or
  [LXD container manager][]

## Set up the build environment

Use the following instructions to set up your build environment.

### Install snapcraft

At the command line, run the following:

```terminal
$ sudo snap install snapcraft --classic
```

### Install Multipass

Also at the command line, run the following:

```terminal
$ sudo snap install multipass --classic
```

To work correctly, Multipass requires access to the CPU
virtualization extensions. If the extensions are not
available for your CPU architecture, not enabled in BIOS,
or not accessible (for instance if you are running a
virtual machine without nested virtualization),
you won't be able to use Multipass.

If you see the following error, you should use LXD:

```terminal
launch failed: CPU does not support KVM extensions
```

### Install LXD

To install LXD, use the following command:

```terminal
$ sudo snap install lxd
```

LXD can be used as an alternative backend during the
snap build process. Once installed, LXD needs to be
configured for use. The default answers are suitable
for most use cases.

```terminal
$ sudo lxd init
Would you like to use LXD clustering? (yes/no) [default=no]:
Do you want to configure a new storage pool? (yes/no) [default=yes]:
Name of the new storage pool [default=default]:
Name of the storage backend to use (btrfs, dir, lvm, zfs, ceph) [default=zfs]:
Create a new ZFS pool? (yes/no) [default=yes]:
Would you like to use an existing empty disk or partition? (yes/no) [default=no]:
Size in GB of the new loop device (1GB minimum) [default=5GB]:
Would you like to connect to a MAAS server? (yes/no) [default=no]:
Would you like to create a new local network bridge? (yes/no) [default=yes]:
What should the new bridge be called? [default=lxdbr0]:
What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
Would you like LXD to be available over the network? (yes/no) [default=no]:
Would you like stale cached images to be updated automatically? (yes/no) [default=yes]
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]:
```

On the first run, LXD may not be able to connect to its socket:

```terminal
An error occurred when trying to communicate with the 'LXD'
provider: cannot connect to the LXD socket
('/var/snap/lxd/common/lxd/unix.socket').
```

This means you need to add your user name to the LXD
(lxd) group, so log out of your session and then log back in:

```terminal
$ sudo usermod -a -G lxd <your username>
```

## Overview of snapcraft

The `snapcraft` tool builds snaps based on the instructions
listed in a `snapcraft.yaml` file.
To get a basic understanding of snapcraft and its
core concepts, take a look at the [Snap documentation][]
and the [Introduction to snapcraft][].
Additional links and information are listed at the
bottom of this page.

## Flutter snapcraft.yaml example

Place the YAML file in your Flutter
project under `<project root>/snap/snapcraft.yaml`.
(And remember that YAML files are sensitive to white space!)
For example:

```yaml
name: super-cool-app
version: 0.1.0
summary: Super Cool App
description: Super Cool App that does everything!

confinement: strict
base: core18
grade: stable

slots:
  dbus-super-cool-app: # adjust accordingly to your app name
    interface: dbus
    bus: session
    name: org.bar.super_cool_app # adjust accordingly to your app name and
    
apps:
  super-cool-app:
    command: super_cool_app
    extensions: [flutter-master] # Where "master" defines which Flutter channel to use for the build
    plugs:
    - network
    slots:
      - dbus-super-cool-app
parts:
  super-cool-app:
    source: .
    plugin: flutter
    flutter-target: lib/main.dart # The main entry-point file of the application
```

The following sections explain the various pieces of the YAML file.

### Metadata

This section of the `snapcraft.yaml` file defines and
describes the application. The snap version is
derived (adopted) from the build section.

```yaml
name: super-cool-app
version: 0.1.0
summary: Super Cool App
description: Super Cool App that does everything!
```

### Grade, confinement, and base

This section defines how the snap is built.

```yaml
confinement: strict
base: core18
grade: stable
```

**Grade**
: Specifies the quality of the snap; this is relevant for
  the publication step later.

**Confinement**
: Specifies what level of system resource access the snap
  will have once installed on the end-user system.
  Strict confinement limits the application access to
  specific resources (defined by plugs in the `app` section).

**Base**
: Snaps are designed to be self-contained applications,
  and therefore, they require their own private core root
  filesystem known as `base`. The `base` keyword specifies
  the version used to provide the minimal set of common libraries,
  and mounted as the root filesystem for the application at runtime.

### Apps

This section defines the application(s) that exist inside the snap.
There can be one or more applications per snap. This example
has a single application&mdash;super_cool_app. 

```yaml
apps:
  super-cool-app:
    command: super_cool_app
    extensions: [flutter-master]
```

**Command**
: Points to the binary, relative to the snap’s root,
  and runs when the snap is invoked.

**Extensions**
: A list of one or more extensions. Snapcraft extensions
  are reusable components that can expose sets of libraries
  and tools to a snap at build and runtime,
  without the developer needing to have specific knowledge
  of included frameworks. The `flutter-master` extension exposes
  the GTK 3 libraries to the Flutter snap. This ensures a
  smaller footprint and better integration with the system.

  The `flutter-master` extension sets your flutter channel
  to `master`.  If you would like to build your app with the `dev`
  channel simply use the `flutter-dev` extension.

**Plugs**
: A list of one or more plugs for system interfaces.
  These are required to provide necessary functionality
  when snaps are strictly confined. This Flutter snap needs
  access to the network.

**DBus interface**
: The [DBus interface][] provides a way for snaps to 
  communicate over DBus. The snap providing the DBus 
  service declares a slot with the well-known DBus name 
  and which bus it uses. Snaps wanting to communicate 
  with the providing snap’s service declare a plug for 
  the providing snap. Note that a snap declaration is 
  needed for your snap to be delivered via the snap store 
  and claim this well-known DBus name (simply upload the 
  snap to the store and request a manual review and 
  a reviewer will take a look).

  When a providing snap is installed, snapd will 
  generate security policy that will allow it to 
  listen on the well-known DBus name on the specified 
  bus. If the system bus is specified, snapd will also 
  generate DBus bus policy that allows ‘root’ to own 
  the name and any user to communicate with the 
  service. Non-snap processes are allowed to 
  communicate with the providing snap following 
  traditional permissions checks. Other (consuming) 
  snaps may only communicate with the providing 
  snap by connecting the snaps’ interface.
  
```
dbus-super-cool-app: # adjust accordingly to your app name
  interface: dbus
  bus: session
  name: dev.site.super_cool_app 
```

### Parts

This section defines the sources required to
assemble the snap.

Parts can be downloaded and built automatically using plugins.
Similar to extensions, snapcraft can use various plugins
(like Python, C, Java, Ruby, etc) to assist in the
building process. Snapcraft also has some special plugins.

**nil** plugin
: Performs no action and the actual build process is
  handled using a manual override.

**flutter** plugin
: Provides the necessary Flutter SDK tools so you can
  use it without having to manually download and set up
  the build tools.

```yaml
parts:
  super-cool-app:
    source: .
    plugin: flutter
    flutter-target: lib/main.dart # The main entry-point file of the application
```


## Desktop file and icon


Desktop entry files are used to add an application 
to the desktop menu. These files specify the name and 
icon of your application, the categories it belongs to,
related search keywords and more. These files have the 
extension .desktop and follow the XDG Desktop Entry 
Specification version 1.1.
  
### Flutter super-cool-app.desktop example

Place the .desktop file in your Flutter project 
under `<project root>/snap/gui/super-cool-app.desktop`.

**Notice**: icon and .desktop file name must be the 
same as your app name in yaml file!

For example:

```desktop
  [Desktop Entry]
  Name=Super Cool App
  Comment=Super Cool App that does everything
  Exec=super-cool-app 
  Icon=${SNAP}/meta/gui/super-cool-app.png # replace name to your app name
  Terminal=false
  Type=Application
  Categories=Education; #adjust accordingly your snap category
```

Place your icon with .png extension in your Flutter 
project under `<project root>/snap/gui/super-cool-app.png`.


## Build the snap

Once the `snapcraft.yaml` file is complete,
run `snapcraft` as follows from the root directory
of the project.

To use the Multipass VM backend:

```terminal
$ snapcraft
``` 

To use the LXD container backend:

```terminal
$ snapcraft --use-lxd
```

## Publish

Once the snap is built, you'll have a `<name>.snap` file
in your root project directory. You can now publish the snap.
The process consists of the following:

1. Create a developer account at [snapcraft.io][], if you
   haven't already done so.
1. Register the app's name. Registration can be done
   either using the Snap Store Web UI portal, or from the
   command line, as follows:
   ```terminal
   $ snapcraft login
   $ snapcraft register
   ```
1. Release the app. After reading the next section
   to learn about selecting a Snap Store channel,
   push the snap to the store:
   ```terminal
   $ snapcraft upload --release=<channel> <file>.snap
   ```

### Snap Store channels

The Snap Store uses channels to differentiate among
different versions of snaps.

The `snapcraft upload` command uploads the snap file to
the store. However, before you run this command,
you need to learn about the different release channels.
Each channel consists of three components:

**Track**
: All snaps must have a default track called latest.
  This is the implied track unless specified otherwise.

**Risk**
: Defines the readiness of the application.
  The risk levels used in the snap store are:
  `stable`, `candidate`, `beta`, and `edge`.

**Branch**
: Allows creation of short-lived snap
  sequences to test bug-fixes.

### Snap Store automatic review

The Snap Store runs several automated checks against
your snap. There may also be a manual review,
depending on how the snap was built, and if there are
any specific security concerns. If the checks pass
without errors, the snap becomes available in the store.

## Additional resources

You can learn more from the following links on the
[snapcraft.io][] site:

* [Channels][]
* [Environment variables][]
* [Interface management][]
* [Parts environment variables][]
* [Releasing to the Snap Store][]
* [Snapcraft extensions][]
* [Supported plugins][]



[Desktop shells]: {{site.repo.flutter}}/wiki/Desktop-shells
[Environment variables]: https://snapcraft.io/docs/environment-variables
[Flutter wiki]: {{site.repo.flutter}}/wiki/
[Interface management]: https://snapcraft.io/docs/interface-management
[DBus interface]: https://snapcraft.io/docs/dbus-interface
[Introduction to snapcraft]: https://snapcraft.io/blog/introduction-to-snapcraft
[LXD container manager]: https://linuxcontainers.org/lxd/downloads/
[Multipass virtualization manager]: https://multipass.run/
[Parts environment variables]: https://snapcraft.io/docs/parts-environment-variables
[Releasing to the Snap Store]: https://snapcraft.io/docs/releasing-to-the-snap-store
[Channels]: https://docs.snapcraft.io/channels
[snap]: https://snapcraft.io/store
[Snap documentation]: https://snapcraft.io/docs
[Snapcraft]: https://snapcraft.io/snapcraft
[snapcraft.io]: https://snapcraft.io/
[Snapcraft extensions]: https://snapcraft.io/docs/snapcraft-extensions
[Supported plugins]: https://snapcraft.io/docs/supported-plugins
[Ubuntu]: https://ubuntu.com/download/desktop
