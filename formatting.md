---
layout: page
title: Formatting Flutter code
sidebar: home_sidebar
permalink: /formatting/
---

Flutter source code style guidelines, and support for automatic formatting.

* TOC Placeholder
{:toc}

## Flutter formatting guidelines

Flutter framework code and sample code uses a consistent style as detailed in
our [style
guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo).

Flutter application developers are welcome to follow this style as well, but
this is by not required. Flutter will work regardless of what style is used
when writing applications.

## Automatically formatting code

While your code may follow any preferred style -- in our experience -- teams of
developers may find it more productive to:

1. have a single, shared style, and

1. to enforce this style through automatic formatting.

The alternative is often tiring formatting debates during code reviews, where
time may be better spent on code behavior rather than code style. (*Note*:
Automatically formatting code may in some hard cases lead to different results
that what you would personally expect. For background details, see our [blog
post](
http://journal.stuffwithstuff.com/2015/09/08/the-hardest-program-ive-ever-written/).)

### Automatically formatting code in IntelliJ

Automatic formatting of code is supported in IntelliJ if you have the
`dart`-plugin (see [IntelliJ setup](/setup/#flutter-intellij-ide-plugins)).

To automatically format the code in the current source code window, right-click
and select `Reformat with Dart style`. You can a keyboard shortcut to this in
Keymap section of IntelliJ Preferences.

### Automatically formatting code in the CLI

You can also automatically format code in the CLI (command line interface) using
the `flutter format` command:

```
Usage: flutter format <one or more paths>
-h, --help    Print this usage information.
```

### Using 'trailing commas'

Flutter code often involves building fairly deep tree-shaped data structures,
for example in a `build`-method. The automatic code formatting described above
is shared with other Dart code, and per default may lead to sub-optimal
formatting of these deep structures.

To get good automatic formatting, we recommend you adopt the optional *trailing
commas*. The rule for adding a trailing comma is simple: Always add a trailing
comma at the end of a parameter list in functions, methods, and constructors
where you care about keeping the formatting you crafted. This will help the
automatic formatter to insert an appropriate amount of line breaks for
Flutter-style code.

Here is an example of automatically formatted code *with* trailing commas:

![Automatically formatted code with trailing commas](/images/intellij/trailing-comma-with.png)

And the same code automatically formatted code *without* trailing commas:

![Automatically formatted code without trailing commas](/images/intellij/trailing-comma-without.png)
