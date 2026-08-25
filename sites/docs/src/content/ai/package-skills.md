---
title: Package skills
description: >-
  Learn how to bundle and consume agent skills in Dart and Flutter packages.
---

Package skills allow library authors to distribute AI instructions alongside
their code on [pub.dev](https://pub.dev). When developers add your package to
their project, their AI coding assistant can discover and use your package's
official skills.

## For app developers: Consuming package skills

When you add a package that includes skills, your coding assistant can access
expert guidance tailored specifically to that library's APIs, patterns, and
code generation workflows.

### Discover and install skills from dependencies

To scan your project dependencies and install available package skills, run:

```bash
dart run skills@ get
```

The `skills` CLI scans your dependencies for bundled `skills/` directories,
presents the skills discovered, and lets you choose which skills to install.
Subsequent runs are incremental—displaying only new, updated, or removed
skills.

To automatically install all discovered skills without interactive prompts, use
the `--all` flag:

```bash
dart run skills@ get --all
```

### Install external skills

You can also install standalone skills from external Git repositories using the
`add` command:

```bash
dart run skills@ add https://github.com/my-org/custom-ai-skills.git
```

---

## For package authors: Publishing skills

Package authors can publish skills directly in their `pub.dev` package
releases to teach AI assistants how to use their libraries correctly.

### Add skills to your package repository

1. Create a `skills/` directory in the root of your package repository.
2. Inside `skills/`, create a subdirectory prefixed with your package name (for
   example, `skills/my_package_network/`).
3. Add a `SKILL.md` file containing YAML frontmatter (`name`, `description`)
   and step-by-step markdown instructions.
4. Verify that the `skills/` directory is not excluded in your `.pubignore`
   file.
5. Publish your package to `pub.dev`.

### Example `SKILL.md` structure

```markdown
---
name: my_package-error-handling
description: >-
  Use when making network requests with my_package to ensure safe patterns.
---

# Error Handling Guidelines

## Best practices
* Always wrap network operations in a try/catch block.
* Catch `NetworkException` specifically to handle retries and diagnostics.
* Provide fallback UI state in the event of a timeout.

## Example
1. Call `MyClient.fetchData()`.
2. Catch `NetworkException` and log `e.context`.
3. Return a fallback UI model.
```

---

## Next steps

* To explore the underlying specification, check out
  [agentskills.io](https://agentskills.io/).
* To file issues or give feedback on Dart skills tooling, visit the
  [dart-lang/ai repository](https://github.com/dart-lang/ai).
