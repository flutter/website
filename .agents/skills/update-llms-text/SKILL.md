---
name: update-llms-text
description: Update and maintain the llms.txt file. Use when the user wants to add sections, add links, correct information, or review the llms.txt file.
disable-model-invocation: true
argument-hint: "[action or description of changes]"
---

# Update llms.txt

Update `sites/docs/src/content/llms.txt`, a curated resource list that
helps LLMs understand the Flutter framework.

Always start by reading the existing `sites/docs/src/content/llms.txt` to
understand the current structure and content before making changes.

## Actions

Based on the user-provided action, perform one of the following tasks:

### Add a section

When asked to add a new section:

1.  If not provided, ask for the section title and links.
2.  Place the new section in a logical location relative to existing sections.

### Add links

When asked to add new links to an existing section:

1.  If not provided, ask for the target section and links to add.
2.  For each link provided:

    1.  Load and analyze its source file to identify its title and
        determine an appropriate description.
    2.  Append the link to the specified section,
        matching the existing Markdown-based format:

        ```md
        - [Title](URL): Description.
        ```

### Correct information

When asked to correct information:

1.  If not provided, Ask for the incorrect information and the correction.
2.  Update the file with the corrected information.

### Review the file

When asked to review the file:

1.  Read the entire file.
2.  Check for duplicate entries, broken links, inconsistent formatting,
    spelling and grammar errors, and general opportunities for improvement.
3.  Report findings and suggestions to the user, but
    don't make changes without approval.

## Formatting rules

- Each link follows the format: `- [Title](URL): Description.`
- Sections are separated by a blank line.
- Keep descriptions concise and informative.
