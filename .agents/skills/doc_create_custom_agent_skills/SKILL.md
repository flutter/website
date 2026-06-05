---
name: doc-create-custom-agent-skills
description: Analyzes past chat logs and summaries to formulate new technical writing agent skills.
---

# Create Custom Agent Skills (Meta-Skill)

## Overview

Use this skill to extract recurring workflow patterns from a completed or in-progress conversation and package them into formal, reusable `.agents/skills/` playbooks.

## Workflow

### 1. Review Conversation Transcript

- [ ] Scan the chat logs and summaries in the workspace.
- [ ] Identify repetitive or highly structured tasks that were performed, such as:
  - Repetitive text auditing (pronouns, formatting, code gotchas).
  - Component or layout conversions (collapsing items into comparisons, tables).
  - Configuration files edits (sidebars, paths, links validation).
  - Validation steps (CUJ auditing, compile testing).

### 2. Group into Skill Scopes

- [ ] Deconstruct each recurring task into a dedicated, single-purpose skill scope. Avoid creating overloaded skills that try to solve multiple distinct objectives at once.
- [ ] For each identified skill scope, define:
  - **`name`**: Kept short, lowercase, and hyphenated (e.g. `doc-migration-setup`).
  - **`description`**: A single bullet-like summary details what the skill delivers.

### 3. Write the Skill Blueprint

- [ ] Create a new directory under `.agents/skills/[skill_type]/` matching the name.
- [ ] Write a `SKILL.md` containing the frontmatter block at the top:
  ```markdown
  ---
  name: [skill-name]
  description: [Short explanation of what the skill does.]
  ---
  ```
- [ ] Add the following markdown layout inside `SKILL.md`:
  - `# Skill Title`
  - `## Overview`: A paragraph describing the target persona and benefits.
  - `## Workflow`: A checklist of actionable, itemized instructions that lead the agent from input collection to final validation.

### 4. Create the Playbook Pull Request

- [ ] Add the folders to Git.
- [ ] Commit and push the branch to your fork to open the Pull Request.
