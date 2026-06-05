---
name: doc-migration-setup
description: Establishes a context profile and migration checklist before editing files.
---

# Document Migration Setup

## Overview

Use this skill to correctly pull together base files, comments, and outline drafts when preparing to rewrite or migrate a documentation section (e.g. moving from Method Channels to Native Interop).

## Workflow

### 1. Collect Context Base Files

- [ ] Ask the user for the URL of the base Pull Request or Git branch to fetch.
- [ ] Ask the user for the text document outlines or notes detailing the new feature's design.
- [ ] Ask the user for the reviewer comments spreadsheet, tracking sheet, or text files holding previous developer threads.

### 2. Run Gap & File Status Analysis

- [ ] Inspect the repository directory structures. Compare the old folder structure with the user's intent:
  - List files to be **Modified**.
  - List files to be **Created** (new page paths).
  - List files to be **Deleted** (deprecated pages).
- [ ] Build a **File Status Matrix** mapping change scopes to target paths.

### 3. Create the Execution Log & Checklist

- [ ] Write an `implementation_plan.md` artifact grouping tasks by Phase (e.g. Phase 1: Landing Page, Phase 2: Android Interop, Phase 3: iOS framework).
- [ ] Write a `task.md` file listing granular checklist check-boxes tracking subtasks.
- [ ] Outline a preliminary **Verification Plan** detailing how results will be checked (e.g., compile steps, anchor validation).
