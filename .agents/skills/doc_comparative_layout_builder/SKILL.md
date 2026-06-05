---
name: doc-comparative-layout-builder
description: Identifies duplicate workflow explanations and builds comparative tables using Jekyll styles.
---

# Comparative Layout Builder

## Overview

Use this skill to refactor technical documents to present cross-platform options in side-by-side matrices instead of disjointed sections, and style them correctly using the repository's native styling tags.

## Workflow

### 1. Identify Redundant Sections

- [ ] Scan tutorials comparing different lanes of code (e.g. Method Channels vs. generated bindings) to identify parallel sections (like "Overview JNIgen" next to "Overview Channels").
- [ ] Collapse distinct overviews into a single consolidated **"Overview: Bindings vs. Channels"** section.

### 2. Format a Core Choice Table

- [ ] Construct a comparative table detailing:
  - **Integration Option**: The names of the methods.
  - **When to Use**: Clear situations favoring the approach.
  - **Tradeoffs / When Not to Use**: Limitations, compile speed, or complexity factors.
- [ ] Add a short summary explaining how options are **non-exclusive** and can be combined inside complex codebases (e.g. FFI for C, Pigeon for API bridges).

### 3. Apply Style Decorations

- [ ] Verify that every markdown table is directly followed by the Jekyll/Kramdown class helper line:
  ```markdown
  {:.table .table-striped}
  ```
- [ ] Spin up the local preview compiler server to verify that the table renders with correct borders, padding, and striping layout.
