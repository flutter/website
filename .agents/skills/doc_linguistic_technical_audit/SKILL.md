---
name: doc-linguistic-technical-audit
description: Scans technical documentation files for pronoun voice and code-gotcha explanations.
---

# Linguistic & Technical Audit

## Overview

Use this skill to audit markdown files to ensure they conform to stylistic voice guidelines and clearly explain code caveats (such as manual reference counting or class naming overrides) so readers do not get blocked.

## Workflow

### 1. Pronoun and Voice Sweep

- [ ] Search the modified files for institutional passive pronouns: "we", "us", "our", and "one".
- [ ] Rewrite sentences containing these pronouns to use the second person (**"you"**) or passive-free active instructions.
  - *Incorrect*: "Next, we will call compile to build the apk."
  - *Correct*: "Next, run the compile command to build the APK."
- [ ] Check sentence boundaries to ensure no descriptions end in incomplete lines or abrupt breaks.

### 2. Prerequisite Script Optimization

- [ ] Check setup block build instructions. Look for bloated compile steps (such as `flutter build apk` or `flutter build ipa`) when local dependencies fetching or lightweight options (like `flutter pub get`) are sufficient.
- [ ] Replace heavy build stages with faster caching triggers to save developer time.

### 3. API Gotcha Documentation

- [ ] If the documentation guides developers in using generated API bindings, verify that memory reference behaviors are covered:
  - Explain how native JNI or ObjC pointers are held.
  - Standardize reference instructions explaining how/when to release resources (e.g. calling `.release()` or utilizing pointers cleanup blocks).
- [ ] Check generated overloaded signatures (e.g. methods mapped with numeric suffixes like `methodName$1` or pointers overrides). Explain to the reader why the suffix exists and how to map it to the original overloaded method name.
