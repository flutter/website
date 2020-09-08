---
title: Using the Code Size Tool
description: Learn how to use the DevTools code size tool.
---

## What is it?

The code size tool allows you to visualize, analyze, and diff code / app size
data.

## How to use it

If DevTools is already connected to a running application, navigate to the
"Code Size" tab.

![Screenshot of code size tab]({% asset tools/devtools/code_size_tab.png @path %})

If DevTools is not connected to a running application, you can
access the tool from the landing page that appears once you have launched
DevTools.

![Screenshot of code size access on landing page]({% asset tools/devtools/code_size_access_landing_page.png @path %})

## Analysis Tab

![Screenshot of code size analysis]({% asset tools/devtools/code_size_analysis.png @path %}){:width="100%"}

### Loading a code size file

When you open the Analysis tab, you'll see instructions to load a code size
file. Drag and drop a code size file in, and click "Analyze Size".

![Screenshot of code size analysis loading screen]({% asset tools/devtools/code_size_load_analysis.png @path %}){:width="100%"}

See [Generating size files][] below for information on generating size files.

### Treemap map and table
The treemap and table show the hierarchical data for your app's size.

For questions about using the treemap, see [How to use the treemap][] below.

### Dominator Tree and Call Graph

This section of the page shows code size attribution data. This data is visible
in the form of a dominator tree as well as a call graph.

#### Using the dominator tree

![Screenshot of code size dominator tree]({% asset tools/devtools/code_size_dominator_tree.png @path %}){:width="100%"}

A dominator tree is a tree where each node's children are those nodes it
immediately dominates. A node `d` dominates a node `n` if every entry point to
`n` must go through `d`.

To put it in context of app size analysis, imagine `package:a` imports both
`package:b` and `package:c`, and both `package:b` and `package:c` import
`package:d`.

```
package:a
|__ package:b
|   |__ package:d
|__ package:c
    |__ package:d
```

In this example, `package:a` dominates `package:d`, so the dominator tree for
this data would look like:

```
package:a
|__ package:b
|__ package:c
|__ package:d
```

This information is helpful for understanding why certain pieces of code are
present into your compiled application. For example, if you are analyzing your
app size and find an unexpected package included in your compiled app, you can
use the dominator tree to trace the package to its root source.

#### Using the call graph

![Screenshot of code size call graph]({% asset tools/devtools/code_size_call_graph.png @path %}){:width="100%"}

A call graph, unlike the dominator tree, shows the many-to-many relationships
that exist between nodes of code size data. We'll again use this example:

```
package:a
|__ package:b
|   |__ package:d
|__ package:c
    |__ package:d
```

The call graph for this data would link `package:d` to its direct callers,
`package:b` and `package:c`, instead of its "dominator", `package:a`.

```
package:a --> package:b -->
                              package:d
package:a --> package:c -->
```

## Diff Tab

![Screenshot of code size diff]({% asset tools/devtools/code_size_diff.png @path %}){:width="100%"}

### Loading code size files

When you open the Diff tab, you'll see instructions to load "old" and "new" code
size files. These files should be generated from two different versions of the
same app, for example, the bits before and after a PR. Drag and drop these files
in to their respective locations, and click "Analyze Diff".

![Screenshot of code size diff loading screen]({% asset tools/devtools/code_size_load_diff.png @path %}){:width="100%"}

See [Generating size files][] below for information on generating these files.

### Treemap and table

In the diff view, the treemap and tree table show only data that differs between
the two imported size files.

For questions about using the treemap, see [How to use the treemap][] below.

## How to use the treemap

A treemap is a visualization for hierarchical data. The space is broken up into
rectangles, where each rectangle is sized and ordered by some quantitative
variable (in this case, size in bytes). Inside of each rectangle (call one A),
there are additional rectangles that exist one level deeper in the data
hierarchy (children of A).

To drill into a cell in the treemap, select the cell. This will re-root the tree
to the selected cell.

To navigate back, or up a level, use the breadcrumb navigator at the top of the
treemap.

![Screenshot of treemap breadcrumb navigator]({% asset tools/devtools/treemap_breadcrumbs.png @path %}){:width="100%"}

## Generating size files

### Flutter code size analysis files

A prerequisite to using the code size tool is generating the proper data to
analyze. To analyze the size of your entire app, including analysis for Native
and Dart code, generate a code size analysis file using the `--analyze-size`
flag:

```
flutter build <your target platform> --analyze-size
```

This will build your application, print a size summary to the command line, and
print a line telling you where to find the size analysis file.

```
flutter build apk --analyze-size --target-platform=android-arm64
...
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
app-release.apk (total compressed)                               6 MB
...
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
A summary of your APK analysis can be found at: build/apk-code-size-analysis_01.json
```

In this example, the file found at `build/apk-code-size-analysis_01.json` is the
file we will import into the DevTools Code Size Tools to analyze further.

### Dart AOT snapshot files

If you are not interested in total app size, but rather are only interested in
Dart code size, the tool also supports importing Dart AOT v8 snapshots. You can
generate these files via

```
flutter build aot --release --extra-gen-snapshot-options=--write-v8-snapshot-profile-to=profile.json
```

The file generated by this command is a graph representation of the snapshot.
It attributes bytes written into a snapshot to a node in the heap graph. This
format covers both data and code sections of the snapshot.

{{site.alert.note}}
    The data in the v8 snapshot file is a subset of the data in the Flutter code
    size analysis files detailed above, so we recommend that you use the Flutter
    code size analysis files for all Flutter code size debugging.
{{site.alert.end}}

[How to use the treemap]: #how-to-use-the-treemap
[Generating size files]: #generating-size-files
