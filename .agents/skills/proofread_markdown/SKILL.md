---
name: proofread-markdown
description: Proofreads Markdown files against Google guidelines.
---

# Proofreading Markdown

## Overview

Help us transform technical text into clear, concise,
and machine-readable Markdown. We follow the
Google Developer Documentation Style Guide.

## Workflow

### 1. Check line length

- [ ] Wrap lines semantically and keep them generally under 80 characters using
      [scripts/wrap_lines.dart](scripts/wrap_lines.dart)
- [ ] Verify that the file was wrapped correctly, preserving headings and
      code blocks

### 2. Fix voice and tone

- [ ] Use active voice.
- [ ] Use present tense.
- [ ] Use second person ("you"). No "we".

### 3. Check word choice

- [ ] Replace forbidden terms: "e.g.", "i.e.", "etc.", "should", "would",
      "could".
- [ ] Use Oxford comma and American spelling.

### 4. Check style of headings

- [ ] Use Sentence case for headings.
      - If you change a heading, add an id after the heading like this:
        "## Configure the project {: #project-configuration }"
- [ ] Put a blank line after all headings.

### 5. Check style of lists

- [ ] Numbered lists MUST use `1.` for every item to allow easy reordering.
- [ ] How-to sections must have active voice in headings.
      - No: "## Project Configuration"
      - Yes: "## Configure the project"
      
### 6. Use less words in sections with steps

- [ ] Ask the user if they would like the steps to be more concise. 
      If yes, update the steps to be brief. Keep it short, simple, and
      accurate.
