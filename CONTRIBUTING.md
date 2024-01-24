# Flutter website contributor's guide

If you would like to contribute to the Flutter website,
we’re happy to have your help! Anyone can contribute,
regardless of your writing experience or how you view yourself as a writer,
developer, or grammar stickler.

## Contributors

Before submitting a PR,
[search for an issue][search-issue] that covers your concern.
If one exists, add `Fixes #<found-issue>` to your new PR.
If you don't find one and your change is significant,
consider [creating an issue][create-issue].
The issue should describe the problem, how you would plan to fix it,
and should be assigned to yourself.

When you create a new page or perform a major rewrite of an existing page,
consider drafting it first in Google Docs to simplify collaboration.
Once your Google doc has been created,
add a link to it from your new GitHub issue.

### Draft changes

1. [Create a branch][create-branch] for your change.
   Consider naming it `fix-<issue_number>` to help others find the related issue.
   The new branch should be based on the `main` branch or a feature
   or version branch.

   To branch and set upstream at the same time, use this command:

   ```terminal
   git checkout -b <fix-issue> upstream main
   ```

1. Try to limit content changes to those that address the request made in the
   associated issue or doc plan. Use your best judgment.

   1. Avoid adjusting indents, line breaks, formatting, and the like
      unrelated to your PR as part of the PR whenever possible.
      To separate work unrelated to the PR, use a new commit,
      a [separate issue][create-issue], a [separate PR](#submit-pr),
      or some combination.

   1. Explain the reason for the additional changes in the PR summary,
      if necessary. For guidance on what to include in a PR summary,
      check out [this section in the Blockly docs][blockly-pr-note]
      or this [PullRequest.com blog post][good-pr-blog-post].

1. Make sure all copy and content meets the standards in the
   [Google Developer Documentation Style Guide][style-guide].
   Focus on the [**Voice and tone**][gs-tone]
   and the [**Highlights**][gs-highlights]
   pages. They provide the best starting points.

1. Using `git`, [commit changes](https://git-scm.com/docs/git-commit) often.
   It simplifies reverting a specific change.
   Reviewers can choose to review changes made since their last review and
   shorten review cycles.

1. When you complete your draft,
   [push the change to GitHub][push-change].

### Submit a PR and request a review {#submit-pr}

1. [Create a pull request][create-pr]
   and verify that you have the right target branch.
   Most PRs are merged into the `main` branch.
   If you need to target an upcoming release or new feature,
   your PR might be merged to a dedicated branch with a different name.

1. Write the PR summary using the following guidelines:

   1. Describe the change.
      Include a brief description of what's changing in the pull request.
      Do this even if you link to a relevant issue.

   1. Link to any related issues. If the PR should fix a particular issue,
      include a line that states `Fixes #<issue number>`.
      (Including this phrase links the PR to the issue.
      When you close the PR, GitHub closes the issue).
      If your PR fixes multiple issues,
      include this phrase in whole for each issue.

   1. Point to specific changes. If your PR is large,
      consider pointing the reviewer to the specific files or lines
      you'd like the reviewer to check.

1. If your PR isn't ready for review,
   [set it to Draft][set-draft] and, if possible,
   [apply the **st.WIP** label][apply-wip-label].

1. Click **Create pull request**. This starts the review process.

### Respond to reviewer feedback

1. Read and address comments from the reviewer.
   Acknowledge all comments with at least a [reaction emoji][reaction-emoji].
   If the changes are technically or grammatically correct, make them.
   Reply to comments that you want to discuss.
   Remember that all comments are public. Keep your replies civil and relevant.

1. When your PR is ready for another round of feedback,
   re-request a review or write a comment with `PTAL @[reviewer]`.
   (PTAL means _please take another look_.)

1. Once your PR is approved, a reviewer [merges it][merges-pr].

## Reviewers

### General guidelines for reviews

* Technical review comes before content, or "copy", review.
* Lean toward velocity. Aim for _improvement_ over absolute _perfection_.
* Check the whole page. Sometimes new content contradicts unchanged
  content elsewhere on the same page.
* Prefer giving an overall note when there's a repeated problem,
  rather than commenting on every instance.
* Try to **approve** with suggestions wherever possible.
  Use **request changes** only when the change can harm an end user's
  work.
* Close PRs that violate [Flutter's Code of Conduct][code-of-conduct].

### Perform a technical review

In general, follow these practices.

* Critique the _technical aspects_ of the PR.
  If technical content could be made less complex or more detailed,
  advise the writer that this is the case in your review.
  Still _approve the PR_ but only if your changes are included.
* Provide suggested changes with corrected copy to make your changes clear.

To conduct a consistent technical review in the Flutter website:

1. [Review a PR][review-pr] when it meets the following conditions:

   1. The writer [requested your review][request-review] of the PR.

   1. The writer applied the [**review.tech**][review-tech-label]
      label to the PR, if possible.

   1. The writer didn't set the PR to [Draft mode][set-draft].
      You can provide feedback to a draft issue,
      but you should understand that the author's still working on the draft.

1. Validate technical accuracy.

   1. Check any step-by-step procedures and code examples.

   1. If code examples have been added or changed,
      verify that new code is included in CI and that tests are passing.

   1. Verify that the code remains consistent with the
      [Flutter Tree Hygiene guide][flutter-tree]
      and the [Flutter code style guide][flutter-style].

1. When [adding comments][add-comments],
   state explicitly if you're making a suggestion or
   pointing out something that needs to change.

1. When completing a review,
   favor [approving the PR][approve-pr] rather than requesting changes,
   whenever possible.

   1. If all of your comments were suggestions rather than issues,
      approve the PR and trust the submitter to read and consider them
      before merging.
      Click **Approve** and change the label from
      [**review.tech**][review-tech-label] to
      [**review.copy**][review-copy-label].

   1. If the PR needs concrete changes before you can approve,
      note the reason why,
      click **Comment** and change the label from
      [**review.tech**][review-tech-label] to
      [**review.await-update**][review-await-label].

### Perform a content review

In general, follow these practices.

* Favor trusting the writer.
  If they stand by the changes and the copy issues are minimal,
  _approve the PR_.
* Provide suggested changes with corrected copy to make your change clear.

To conduct a consistent copy review in the Flutter website:

1. [Review a PR][request-pr] when it meets the following conditions:

   1. The writer [requested your review][request-review] of the PR.

   1. The writer applied the [**review.copy**][review-copy-label]
      label to the PR.

   1. The writer didn't set the PR to [Draft mode][set-draft].
      You can provide feedback to a draft issue,
      but you should understand that the author's still working on the draft.

1. Check that text and code examples are consistent with one another.

1. When adding comments,
   be clear if you're making a suggestion or pointing out something that
   definitely needs to change.

1. Stay consistent with the
   [Google developer documentation style guide][style-guide] (GDDSG).

1. When completing a review,
   prefer approving a PR rather than requesting changes, whenever possible.

   1. If all of your comments were suggestions rather than issues,
      just approve and trust the submitter to read and consider them before merging.
      Click **Approve** and change the label
      from [**review.copy**][review-copy-label] to **st.RFM.%**.

   1. If there are concrete changes needed before you can approve,
      note the reason why, click **Comment** and change the label
      from **review.copy** to **review.await-update**.

## Resources for contributors and reviewers

* Semantic Line Breaks: https://sembr.org
* Google Developer Documentation Style Guide: https://developers.google.com/style
* Chicago Manual of Style: https://www.chicagomanualofstyle.org

[approve-pr](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/approving-a-pull-request-with-required-reviews)
[add-comments](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request#adding-comments-to-a-pull-request)
[search-issue](https://www.freecodecamp.org/news/github-search-tips/)
[create-issue](https://github.com/flutter/website/issues/new/choose)
[create-branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository)
[style-guide](https://developers.google.com/style).
[gs-tone](https://developers.google.com/style/tone)
[gs-highlights](https://developers.google.com/style/highlights)
[push-change](https://docs.github.com/en/get-started/using-git/pushing-commits-to-a-remote-repository).
[set-draft](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/changing-the-stage-of-a-pull-request)
[apply-wip-label](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels#applying-a-label).
[create-pr](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
[reaction-emoji](https://github.blog/2016-03-10-add-reactions-to-pull-requests-issues-and-comments/)
[merges-pr](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request)
[code-of-conduct](https://github.com/flutter/flutter/blob/master/CODE_OF_CONDUCT.md)
[review-pr](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/reviewing-proposed-changes-in-a-pull-request)
[request-review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review)
[review-tech-label](https://github.com/flutter/website/labels/review.tech)
[review-copy-label](https://github.com/flutter/website/labels/review.copy)
[review-await-label](https://github.com/flutter/website/labels/review.await-update)
[flutter-tree](https://github.com/flutter/flutter/wiki/Tree-hygiene)
[flutter-style](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
[good-pr-blog-post](https://www.pullrequest.com/blog/writing-a-great-pull-request-description/)
[blockly-pr-note](https://developers.google.com/blockly/guides/contribute/get-started/write_a_good_pr#communicate-2)
