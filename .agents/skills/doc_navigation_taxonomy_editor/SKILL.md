---
name: doc-navigation-taxonomy-editor
description: Sweeps and refactors website sidebar configuration (default.yml) to organize categories and check links.
---

# Sidebar Navigation Taxonomy Editor

## Overview

Use this skill to inspect and clean the documentation's side navigation config (typically `default.yml`), re-organize the layout into option groups, check for broken URLs, and remove review draft markers.

## Workflow

### 1. Remove Temporary Review Labels

- [ ] Scan the header nodes in the Yaml child configurations. Locate and remove words like:
  - `(new)`
  - `(old)`
  - `(restructured)`
  - `(draft)`
- [ ] Save changes while preserving the indentation spacing (YAML syntax is whitespace-specific).

### 2. Group Options and Platforms

- [ ] Group general integration parameters at the top of the category's children:
  1. *General options and table choice guides.*
  2. *General binary linkers FFI.*
  3. *General channels messaging Pigeon.*
- [ ] Group platform setup guides below a divider target:
  - Use `- divider` to visually separate general layout choices from target operating systems.
  - Nest iOS, macOS, Windows, Linux, Android, and Web files below.
- [ ] Ensure specific OS operations (e.g. build desktop stages) are housed inside their platform directories to prevent duplication.

### 3. Validate Link Integrity

- [ ] Check every permalink defined in the sidebar configurations. Verify that:
  - The destination `.md` file exist in the source paths.
  - The page title is consistent with the sidebar title.
- [ ] Verify that parent-child configurations compile without indentation syntax errors.
