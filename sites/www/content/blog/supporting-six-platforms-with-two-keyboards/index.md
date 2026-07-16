---
title: "Supporting six platforms with two keyboards"
description: "Developing Flutter applications for Android, iOS, the web, Windows, macOS, and Linux without losing your sanity"
publishDate: 2022-12-06
author: domesticmouse
image: images/1RQs5hWCyE30nkyfsVqDb0A.jpeg
category: engineering
layout: blog
---

<DashImage figure src="images/1RQs5hWCyE30nkyfsVqDb0A.jpeg" />

The joy of Flutter is the ease of developing applications for six platforms. The pain is verifying your application on six platforms.

I’m writing a codelab that uses Dart’s Foreign Function Interface (FFI) to integrate C code from iOS, Android, macOS, Linux, and Windows. This story describes how I can develop for all the platforms that Flutter supports without covering my desk in devices.

Accept that you need more than one machine. As you plan to build your application on at least a subset of the six platforms, consider that this isn’t nearly as bad as it sounds.

I can develop apps on six platforms with two machines: one macOS laptop and one Windows 11 desktop. Additionally, I have two keyboards, one mouse, and one magic touch pad.

Here’s why you need the two platforms.

Start with the obvious: you need a macOS machine to develop for macOS and iOS. Apple says so. Develop for Windows on Windows. It’s what Flutter for Windows supports out of the box, so that’s the paved path. Flutter supports web and Android development on either or both of macOS and Win11. For reasons of keyboard familiarity (I’ve been on macOS for over a decade), I use macOS.

Windows Subsystem for Linux version 2, or WSL2, on Windows 11 prevented my needing three full keyboards. When you have the Microsoft Windows Subsystem for Linux Product Manager presenting a keynote on WSL2 at Ubuntu Summit to a room full of Linux devotees, you start to understand how much the world has changed over the last twenty years.

The Linux support in WSL2 extends beyond running graphical Linux applications. Visual Studio Code provides stellar support for WSL2-hosted development. WSL2 runs a headless version of VSCode inside its Linux environment and controls it from a Windows VSCode instance. This keeps Windows and Linux development on one machine with all of the same key shortcuts even if the file system layout differs.

This said, don’t try to run both your Flutter Windows and Linux development out of the one shared file area. Yes, WSL2 allows you to see the Windows file system from Linux and the Linux file system from Windows. Dart, though, won’t know which binaries to use. Another minor issue would be that the line endings in your source files will get confused as well. Transfer code between Linux and Windows using Git configured with [appropriate line ending mappings](https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings). Your sanity will thank you.

If you want to develop Flutter on all the platforms Flutter supports, do yourself a favor and grab both a macOS machine and a Windows 11 machine. Your compile times will thank you.
