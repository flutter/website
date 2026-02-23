[![Flutter logo]](https://docs.flutter.dev)

[Flutter logo]: https://github.com/dart-lang/site-shared/blob/main/src/_assets/image/flutter/icon/64.png?raw=1

# [Flutter][] documentation website

The [documentation site][Flutter] for the [Flutter framework][],
built with [Jaspr][] and hosted on [Firebase][].

[Flutter framework]: https://flutter.dev
[Jaspr]: https://jaspr.site
[Firebase]: https://firebase.google.com/

[Build Status]: https://github.com/flutter/website/workflows/build/badge.svg
[Flutter]: https://docs.flutter.dev/
[Repo on GitHub Actions]: https://github.com/flutter/website/actions?query=workflow%3Abuild+branch%3Amain

<a href="https://studio.firebase.google.com/import?url=https%3A%2F%2Fgithub.com%2Fflutter%2Fwebsite">
  <img
    height="32"
    alt="Open in Firebase Studio"
    src="https://cdn.firebasestudio.dev/btn/open_blue_32.svg">
</a>

## Issues, bugs, and requests

We welcome contributions and feedback on our website.
Please file a request in our
[issue tracker](https://github.com/flutter/website/issues/new/choose)
or create a [pull request](https://github.com/flutter/website/pulls).
For simple changes (such as tweaking some text),
it's easiest to make changes using the GitHub UI.

If you have an issue with the
API docs on [api.flutter.dev](https://api.flutter.dev),
please file them on
the [`flutter/flutter`](https://github.com/flutter/flutter/issues) repo,
not on this (`flutter/website`) repo.
The API docs are embedded in Flutter's source code,
so the engineering team handles them.


## Before you submit a PR

We love it when the community gets involved in improving our docs!
Here are a few things to keep in mind before you submit a PR:

- When triaging issues,
  we sometimes label an issue with the tag **PRs welcome**.
  However, we welcome PRs on other issues as well&mdash;
  it doesn't have to be tagged with that label.
- Please don't run our docs through Grammarly (or a similar tool)
  and submit those changes as a PR.
- We follow the [Google Developer Documentation Style Guidelines][]—
  for example, avoid "i.e." or "e.g.",
  avoid writing in the first person,
  and avoid the future tense.
  You can start with the
  [style guide highlights](https://developers.google.com/style/highlights)
  or the [word list](https://developers.google.com/style/word-list),
  or use the search bar at the top of every style guide page.

> We truly thank you for your willingness and helpfulness
> in keeping the website docs up to date!

[Google Developer Documentation Style Guidelines]: https://developers.google.com/style


## Contributing

To update this site, fork the repo, make your changes,
and generate a pull request.
For small, contained changes (such as style and typo fixes),
you probably don't need to build this site.
Often you can make changes using the GitHub UI.
If needed, we can stage the changes automatically in your pull request.

If your change involves code samples, adds/removes pages, or affects navigation,
please build and test your work before submitting.

If you want or need to build the site, follow the steps below.

## Build the site

For changes beyond simple text and CSS tweaks,
we recommend running the site locally to
enable an edit-refresh cycle.

### Get the prerequisites

To build and develop the site, you'll need to
install the latest stable release of Flutter, which includes Dart.

If you don't have Flutter or need to update, follow the
instructions at [Install Flutter][] or [Upgrading Flutter][].

If you already have Flutter installed, verify it's in your path
and is the latest stable version:

```console
flutter --version
```

[Install Flutter]: https://docs.flutter.dev/get-started
[Upgrading Flutter]: https://docs.flutter.dev/install/upgrade

### Clone this repo

If you're not a member of the Flutter organization,
we recommend you [create a fork][] of this repo under your own GitHub account
and then submit a pull request from that fork.

Once you have a fork (or you're a Flutter org member),
clone the repository with `git clone`:

```bash
git clone https://github.com/flutter/website.git
```

[create a fork]: https://docs.github.com/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo

## Set up your local environment and serve changes

Before you continue setting up the site infrastructure,
verify that the correct version of Flutter is set up and available by
following the instructions in [Get the prerequisites](#get-the-prerequisites).

1. _Optional:_ After cloning the repo,
   create a branch for your changes:

   ```console
   git checkout -b <BRANCH_NAME>
   ```

2. From the root directory of the repository,
   fetch the site's Dart dependencies.

   ```console
   dart pub get
   ```

3. From the root directory, run the `dash_site` tool to
   validate your setup and learn about the available commands.

   ```terminal
   dart run dash_site --help
   ```

4. From the root directory, serve the site locally.

   ```terminal
   dart run dash_site serve
   ```

   This command generates and serves the site on a
   local port that's printed to your terminal.

5. View your changes in the browser by navigating to <http://localhost:8080>.

   Note the port might be different if `8080` is taken.

6. Make your changes to the local repo.

   To view your changes in the browser,
   you'll need to refresh the page.
   The site should automatically rebuild on most changes, but if
   something doesn't update, exit the process and rerun the command.

7. Commit your changes to the branch and submit your PR.

   If your change is large, or you'd like to test it,
   consider [validating your changes](#validate-your-changes).

> [!TIP]
> To find additional commands that you can run,
> run `dart run dash_site --help` from the repository's root directory.

## Validate your changes

### Check documentation and example code

If you've made changes to the code in
the `/examples`, `/site`, or `/tool` directories,
commit your work, and then run the following command to
verify that it is up to date and matches site standards.

```terminal
dart run dash_site check-all
```

If this script reports any errors or warnings,
address them and rerun the command.
If you have questions, leave a comment on your issue or pull request,
and we'll do our best to help.
You can also chat with us on the `#hackers-devrel` channel
on the [Flutter contributors Discord][]!

[Flutter contributors Discord]: https://github.com/flutter/flutter/blob/main/docs/contributing/Chat.md

### Check links

If you've made changes to the content and want to check that all
internal links and Markdown link references are valid,
build the site locally and run the following commands.

1.  Build the site locally.

    ```bash
    dart run dash_site build
    ```

1.  Verify all Markdown link references are resolved.

    ```bash
    dart run dash_site check-link-references
    ```

1.  Verify that all internal links are valid.

    > [!NOTE]
    > This command relies on the `firebase` CLI tool being on your PATH.
    > If you haven't installed it or updated it in a while,
    > follow [Set up or update the Firebase CLI][firebase-install].

    ```bash
    dart run dash_site check-links
    ```

If either command reports any errors or warnings,
address them, rebuild the site, and rerun the command.

[firebase-install]: https://firebase.google.com/docs/cli#setup_update_cli

### Refresh code excerpts

A build that fails with the error
`Error: Some code excerpts need to be updated!`
means that one or more code excerpts in the site Markdown files
aren't identical to the code regions declared
in the corresponding `.dart` files.

The `.dart` files are the source of truth for code snippets,
and the preceding `<?code-excerpt>` instructions in Markdown files specify
how the snippets are copied from the `.dart` files.

To resolve this error and update the Markdown snippets to match,
from the root of the `website` directory,
run `dart run dash_site refresh-excerpts`.

To learn more about creating, editing, and using code excerpts,
check out the [excerpt updater package documentation][].

[excerpt updater package documentation]: https://github.com/dart-lang/site-shared/tree/main/pkgs/excerpter#readme
