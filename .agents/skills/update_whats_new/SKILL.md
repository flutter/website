---
name: update-whats-new
description: Update the whats-new page and archive old entries with changes to the website since the previous release.
---

# Update what's new page

Use this skill when a new Flutter release has occurred and you need to update `sites/docs/src/content/release/whats-new.md` to describe the changes to the documentation site since the previous release.

## Steps

1.  **Identify the previous release date & version**

    Read `sites/docs/src/content/release/whats-new.md` and locate the topmost release section.
    Find the version and the release date for that release.
    This is your starting point.

2.  **Archive the oldest release (if necessary)**

    To keep the "What's new" page focused on recent updates, it should typically hold only the last 3 to 4 releases. 
    If adding a new release exceeds this limit, move the oldest release section from `sites/docs/src/content/release/whats-new.md` to `sites/docs/src/content/release/archive-whats-new.md`.
    
    * Open `archive-whats-new.md` and insert the moved section at the top of the stable releases list (just below the introduction, separated by `---`).
    * Ensure all reference link definitions for that archived release are also moved to the bottom of the archived section.

3.  **Retrieve recent Git commits**

    Retrieve the git commits made to the documentation content directory since the previous release date identified in Step 1.
    For example:
    ```bash
    git log --after="<previous_release_date>" --oneline -- sites/docs/src/content/
    ```

4.  **Analyze commits for meaningful changes**

    Review the content of each commit since that date.
    Identify changes that are significant to developers or users.
    Look for:
    * New pages or guides (e.g. AI guides, dependency management).
    * Large or significant page updates.
    * Deprecated pages or major migrations.
    * New cookbook recipes or tutorials.

    > [!IMPORTANT]
    > ONLY include entries that are meaningful and user-facing to someone reading our documentation.
    >
    > **Do NOT include:**
    > * Non-user-facing infrastructure changes.
    > * Internal refactoring or maintenance simplifications.
    > * Trivial tweaks (e.g. typos, link fixes, release notes index updates).
    > * Commits from Dart/Flutter team members (e.g. Parker, Daco) unless they authored a major new guide.
    >
    > **DO include specific, high-impact changes, for example:**
    > * Added a new guide for [installing plugins in IDEs](/tools/widget-previewer).
    > * Reworked the [Android Kotlin migration guide](/release/breaking-changes/kotlin-version).
    > * Added support for [Swift Package Manager Add-to-App](/platform-integration/ios/app-extensions).

5.  **Create a new release section**

    In `sites/docs/src/content/release/whats-new.md`, create a new section at the top of the file (just below the introduction) for the new release.
    Follow the formatting and structure of past releases on the page:
    * A heading with the release date and version, like `## 12 August 2026: Release 3.47`.
    * A concise announcement paragraph linking ONLY to the release blog post (e.g., `Flutter 3.47 is live! For details, check out the [Flutter 3.47 blog post][3.47-blog-post].`). Do not link breaking changes or release notes in this paragraph.
    * If a release video is available, embed it using the `<YouTubeEmbed>` component:
      ```html
      <div class="video-wrapper">
      <span class="video-intro">Check out the latest in Dart and Flutter</span>
      <YouTubeEmbed id="VIDEO_ID" title="What's New in Dart and Flutter 3.47" fullWidth></YouTubeEmbed>
      </div>
      ```
    * A list heading: `**Docs updated or added since the <Previous Version> release**`.

6.  **Add entries for meaningful changes**

    For each meaningful change identified in Step 4:
    * Add a bullet point under the new release section.
    * Write a concise explanation of the change.
    * **Formatting Rule:** Do NOT use bold topic prefixes followed by colons (e.g. do NOT write `* **Widget Previews:** Flutter [Widget Previews]...`). Instead, write clean, natural sentences with the links integrated inline, matching the style of past entries (e.g. `The Flutter [Widget Previews][widget-previewer] tool has graduated to stable...`).
    * Add a link to the relevant section or new page using markdown reference links.
    * If a community contributor was involved, thank them by including their GitHub handle in parentheses, for example: `(Thank you, [username][].)`. Only thank community contributors, not Flutter team members.

7.  **Add and format link definitions**

    Add the link definitions (reference links) to the bottom of the new release section, matching the style used throughout the document.
    For example:
    ```markdown
    [3.47-blog-post]: /blog/whats-new-in-flutter-3-47
    [username]: https://github.com/username
    ```

8.  **Request review**

    Notify the developer that the `whats-new.md` page has been updated and ask them to verify the changes.
