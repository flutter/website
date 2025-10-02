---
title: Use the Debug console
description: Learn how to use the DevTools console.
---

The DevTools Debug console allows you to watch an
application's standard output (`stdout`),
evaluate expressions for a paused or running
app in debug mode, and analyze inbound and outbound
references for objects.

:::note
This page is up to date for DevTools 2.23.0.
:::

The Debug console is available from the [Inspector][],
[Debugger][], and [Memory][] views.

[Inspector]: /tools/devtools/inspector
[Debugger]:  /tools/devtools/debugger
[Memory]:    /tools/devtools/memory

## Watch application output

The console shows the application's standard output (`stdout`):

![Screenshot of stdout in Console view](/assets/images/docs/tools/devtools/console-stdout.png)

## Explore inspected widgets

If you click a widget on the **Inspector** screen,
the variable for this widget displays in the **Console**:

![Screenshot of inspected widget in Console view](/assets/images/docs/tools/devtools/console-inspect-widget.png){:width="100%"}

## Evaluate expressions

In the console, you can evaluate expressions for a paused
or running application, assuming that you are running
your app in debug mode:

![Screenshot showing evaluating an expression in the console](/assets/images/docs/tools/devtools/console-evaluate-expressions.png)

To assign an evaluated object to a variable,
use `$0`, `$1` (through `$5`) in the form of `var x = $0`:

![Screenshot showing how to evaluate variables](/assets/images/docs/tools/devtools/console-evaluate-variables.png){:width="100%"}

## Browse heap snapshot

To drop a variable to the console from a heap snapshot,
do the following:

1. Navigate to **Devtools > Memory > Diff Snapshots**.
1. Record a memory heap snapshot.
1. Click on the context menu `[⋮]` to view the number of
   **Instances** for the desired **Class**.
1. Select whether you want to store a single instance as
   a console variable, or whether you want to store _all_
   currently alive instances in the app.

![Screenshot showing how to browse the heap snapshots](/assets/images/docs/tools/devtools/browse-heap-snapshot.png){:width="100%"}

The Console screen displays both live and static
inbound and outbound references, as well as field values:

![Screenshot showing inbound and outbound references in Console](/assets/images/docs/tools/devtools/console-references.png){:width="100%"}
