# Shared agent skills for the Dart and Flutter websites

[Agent skills][] that help AI tools write and review content
for `dart.dev`, `docs.flutter.dev`, and `flutter.dev`.

This package is the single source of truth for these skills.
Each website repository installs a copy of them
into its `.agents/skills/` directory with [`package:skills`][].

[Agent skills]: https://agentskills.io/
[`package:skills`]: https://pub.dev/packages/skills

## Available skills

The package provides the following skills:

- `site-skills-write-technical-docs`:
  write or review developer-facing prose.
- `site-skills-format-markdown`:
  write or edit Markdown and site-specific Markdown extensions.
- `site-skills-write-dart`:
  write, review, or refactor Dart code.
- `site-skills-write-flutter`:
  write, review, or refactor Flutter code.

`package:skills` only installs skills whose names begin with
the name of the package that provides them,
so each skill name begins with `site-skills-`.

## Edit a skill

To change a shared skill, follow these steps:

1. Edit the files in this package's `skills/` directory.
   Don't edit the installed copies in `.agents/skills/`,
   because the next installation overwrites them.

1. Keep the guidance applicable to each website.
   If a rule only applies to some sites, name the sites it applies to.
   Add guidance that's specific to one repository to
   that repository's `AGENTS.md` file or to a skill in that repository.

1. From the root of this repository,
   update the installed copies and commit the result:

   ```console
   dart run skills@ get --package site_skills --all
   ```

## Install the skills in another repository

This package isn't published on pub.dev,
so you must use it as a [git dependency][git-dep].

To install the skills in another repository, follow these steps:

1. Add the package as a development dependency
   that's pinned to a commit of this repository:

   ```yaml
   dev_dependencies:
     site_skills:
       git:
         url: https://github.com/flutter/website
         path: packages/site_skills
         ref: <commit hash>
   ```

1. Install the skills that the repository needs.
   For example, to install every skill except `site-skills-write-flutter`:

   ```console
   dart run skills@ get --package site_skills \
     --skill site-skills-write-technical-docs \
     --skill site-skills-format-markdown \
     --skill site-skills-write-dart
   ```

1. Commit the installed skills in `.agents/skills/` and
   the `.config/dart_skills/skills_config.json` file.

To pick up later changes to the skills,
update the `ref` value and run the installation command again.

[git-dep]: https://dart.dev/tools/pub/dependencies#git-packages
