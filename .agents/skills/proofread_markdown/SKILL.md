---
name: proofread_markdown
description: Proofreads markdown files that were changed in a workspace
---

# Proofread markdown files

Hi there! You can use this skill to proofread markdown files. This particular
project has documentation style rules that are slightly different than what you
are used to, so please use the steps in this workflow to update any markdown
files that have changed.

## 1. Check line length

Leadership does not want markdown files to have lines that exceed 80 characters.
The reason is that it makes it easier to read for humans, and this is easier for
agents, when a screenshot of a markdown file is needed.

1. Run the `wrap_lines.dart` script on the file to automate line wrapping:

   ```bash
   dart /Users/afitch/flutter_web/website/.agents/skills/proofread_markdown/scripts/wrap_lines.dart <file_path>
   ```

2. Verify that the file was wrapped correctly (preserving headings and
   code blocks).


## 2. Convert headings with title case to sentence case

If you see a heading (any level) that use title case like this:

```
## Do A Thing
```

Change it to look like this

```
## Do a thing
```

## 3. Use active voice in headings

Let's use active voice in headings. So if you see a heading that looks like
this:

```
## Project Configuration
```

Change it to active voice that looks like this:

```
## Configure the project
```

## 4. Put a blank line after headings

Make sure there is always a blank line after a heading. So if you see a
heading that looks like this:

```
## Configure the project
Do a thing, blah blah blah.
```

Change it to look like this:

```
## Configure the project

Do a thing, blah blah blah.
```

## 5. Use less words in sections with steps

If a section has steps in it, be brief. Keep it short, simple, and accurate.

Change steps to be direct like this:

```
 ### Search for a Topic

 1.  Navigate to the **Search** tab (Magnifying Glass icon).
 2.  Select **View topics** from the dropdown (default).
 3.  Enter your query in the "Query" text box (e.g., "Flutter widgets").
 4.  Press **Enter**.
 5.  View results in the main content area.
```
