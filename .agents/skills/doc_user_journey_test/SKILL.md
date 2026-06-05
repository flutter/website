---
name: doc-user-journey-test
description: Executes user persona runs (CUJs) and writes walkthrough validation logs.
---

# User Journey Validation (CUJ)

## Overview

Use this skill to audit newly crafted or refactored documentation from the perspective of specific developer profiles, verify links, and summarize results in walking indexes.

## Workflow

### 1. Define CUJ Personas

- [ ] Identify 2–3 target developer profiles who will consume the documentation. Examples:
  - **Persona A (The Flutter Native Beginner)**: Familiar with Flutter but has never written Kotlin/Swift or set up platform-specific paths.
  - **Persona B (The Plugin Architect)**: Needs to bind complex external C++ libraries or third-party Maven/CocoaPods components.
- [ ] List the questions each persona is asking when landing on the page.

### 2. Run the Reading Journey

- [ ] "Read" each draft file chronologically pretending to be the target persona. Fulfill the code steps step-by-step.
- [ ] Flag and repair:
  - Missing commands or prerequisites (e.g. telling a user to configure a file without showing them where it goes).
  - Vague naming declarations.
  - Unexplained technical terminology (e.g. JNI reference count management, FFI timer callbacks).

### 3. Create the Walkthrough Log

- [ ] Write a `walkthrough.md` file listing all modifications and new documents.
- [ ] Detail the visual changes, table adjustments, and compile fixes.
- [ ] Add explicit instructions on how developers can spin up the local development servlets to visually check the updates.
