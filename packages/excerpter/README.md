# Markdown code-block excerpt updater

Tooling to update code excerpts in Markdown documentation
from regions declared in source files elsewhere.

> [!WARNING]  
> This package is still a work-in-progress and not completely functional.

## Install

This package is not currently published on pub,
so you must use it as a [git][git-dep] or [path][path-dep] dependency.

[git-dep]: https://dart.dev/tools/pub/dependencies#git-packages
[path-dep]: https://dart.dev/tools/pub/dependencies#path-packages

## Defining excerpt regions

The package pulls content from Dart files that are
optionally split up with code regions.

To include lines within a code region,
add a Dart line comment before the first line in the region with
`#docregion <name>` where `<name>` is your desired name for the region.
Then after the final line of the region,
add a Dart line comment with `#enddocregion <name>` with the same name.
You can open and close a docregion multiple times within a file.

Region names must be a non-empty sequence of alphanumeric characters,
optionally containing dashes (`-`).

A single docregion comment can open or close multiple regions
with a comma-delimited list.

### Annotated example

The following Dart snippet is an example of using
docregion comments in a few different ways.

```dart
// #docregion imports
import 'dart:async';
// #enddocregion imports

// #docregion main, main-stub
void main() async {
  // #enddocregion main-stub
  print('Compute π using the Monte Carlo method.');
  await for (final estimate in computePi().take(500)) {
    print('π ≅ $estimate');
  }
  // #docregion main-stub
}
// #enddocregion main, main-stub

/// Generates a stream of increasingly accurate estimates of π.
Stream<double> computePi({int batch = 100000}) async* {
  // ...
}
```

The regions defined in this Dart snippet are:
`imports`, `main`, `main-stub`, and the unnamed region for the entire file.

Some of the regions defined in the example above include:

- `imports` region:

  ```dart
  import 'dart:async';
  ```

- `main-stub` region:

  ```dart
  void main() async {
    // ···
  }
  ```

The `main-stub` region is discontinuous as it has a break in it.
When this package is run to update excerpts, each break is
replaced by a language-specific comment filled with a plaster marker (`...`).

For details concerning the processing of plasters, see the
[code_excerpt_updater][] documentation.

## Injecting excerpts

To inject content from docregions or entire files into Markdown files,
you use a special syntax to inject into a code block
or configure the injecting logic.

In both cases, the syntax starts with `\<?code-excerpt` and ends with `?>`.

### Inject instruction

Use an inject instruction to inject a docregion from a source file
into the current Markdown file, with optional arguments
to configure the injection.

Inject instructions must precede a Markdown code block
that is denoted with the language in the target file.

````md
<?code-excerpt "path/main.dart (optional-region-name)" arg0="value0" ...?>
```dart
void main() {}
```
````

The first unnamed argument, surrounded in double quotes,
is the path to source file to pull regions from,
relative to the base source path set by the CLI.
A specific region from the file can be specified in parentheses,
otherwise the entire file is extracted.

The following table outlines the parameters supported by injection instructions.
Note that specified arguments, such as transformations, are applied
in the order they appear in the instruction.

| Parameter   | Argument               | Description                                                                   |
|-------------|------------------------|-------------------------------------------------------------------------------|
| `indent-by` | `int`                  | The amount to indent each line by.                                            |
| `plaster`   | `String`               | The plaster template to use, or `none` to disable.                            |
| `skip`      | `int`                  | The amount of lines to skip at the beginning if positive, or end if negative. |
| `take`      | `int`                  | The amount of lines to take at the beginning if positive, or end if negative. |
| `remove`    | `String\|RegExp`       | Remove the lines containing the specified pattern.                            |
| `retain`    | `String\|RegExp`       | Keep the lines containing the specified pattern.                              |
| `from`      | `String\|RegExp`       | Keep the lines after and including the first one with the specified pattern.  |
| `to`        | `String\|RegExp`       | Keep the lines before and including the first one with the specified pattern. |
| `replace`   | [Replacement syntax][] | Replace text with the specified pattern to the specified string.              |

[Replacement syntax]: #replacement-syntax

For parameters that accept a `RegExp`,
they follow the Dart VM's supported syntax,
and must be wrapped in forward slashes, such as `/<regexp>/`.
If you're passing a normal string, the forward slashes are unnecessary.

### Replacement syntax

The `replace` argument accepts one or more semicolon separated
regular expression and replacement expression pairs.
The replacement expressions can be simple strings or
include backreferences to numbered capture groups from the
regular expression using, `$&`, `$1`, `$2`, and so on.

The following replace expression replaces text like `Hello world`
with `[!Hello!] world`:

```md
replace="/(Hello)( world)/[!$1!]$2/g;"
```

Compared to other transforms, replace transforms are
applied on the entire excerpt rather than per line.

### Set instruction

Use a set instruction to configure one of the following for
subsequent injection instructions:

- The base directory that source files for docregions are found in.
- The template to be used for plaster lines.
- Replace expressions that will run for every inject instruction.

Only one set instruction argument can be used at a time,
and only one of each can exist in the file.
Subsequent set instructions of the same type override the previous ones.

#### Modify the source file base path

To set the base directory that source files for docregions are found in
to a subdirectory of the CLI provided one, use the `path-base` argument:

```md
<?code-excerpt path-base="subdirPath"?>
```

#### Modify the plaster template

To change the template used for plaster lines, use the `plaster` argument:

```md
<?code-excerpt plaster="// Fill in to complete."?>
```

If you want to use the default plaster content specified by the CLI,
you can use `$defaultPlaster` within the template:

```md
<?code-excerpt plaster="///// $defaultPlaster"?>
```

#### Add a global transform

To add a transform expression that is applied to all subsequent excerpts
use the `replace` argument and the same [replacement syntax][] as above.

```md
<?code-excerpt replace="/Hello/Hola/g;"?>
```

[replacement syntax]: #replacement-syntax

#### Reset set instructions

To reset any of the instructions,
use the same arguments set to an empty string (`""`);

## Updating excerpts

To update the excerpts specified by injection instructions
within your Markdown files, you can either use the package
as a library through the `Updater` class, or the CLI.

```bash
dart run excerpter [OPTIONS] <file_or_directory>
```

| Option              | Description                                                                                                                     |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------|
| `--dry-run `        | If the updater should only report if excerpts need to be updated.                                                               |
| `--fail-on-update`  | Report a non-zero exit code if an excerpt is or needs to be updated.                                                            |
| `--exclude`         | Regular expressions of paths to exclude when processing a directory recursively. Dot files and directories are always excluded. |
| `--base-source`     | The path to the directory containing the source files that excerpt regions should be retrieved from.                            |
| `--plaster-content` | The default plaster content, such as "..." or "···".                                                                            |
| `--replace`         | A replacement to run on every excerpt. Refer to the [replacement syntax](#replacement-syntax) for more details.                 |

## Learn more

To learn more about the tool, check out
the various usages across the [dart.dev][] and [docs.flutter.dev][]
website repositories.

[dart.dev]: https://github.com/dart-lang/site-www
[docs.flutter.dev]: https://github.com/flutter/website
