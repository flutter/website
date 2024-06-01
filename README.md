[![Flutter logo]](https://docs.flutter.dev)

[Flutter logo]: https://github.com/dart-lang/site-shared/blob/main/src/_assets/image/flutter/icon/64.png?raw=1

# [Flutter][] documentation website 

The [documentation site][Flutter] for the [Flutter framework][],
built with [Eleventy][] and hosted on [Firebase][].

[![Build Status][]][Repo on GitHub Actions]
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/flutter/website/badge)](https://deps.dev/project/github/flutter%2Fwebsite)

[Flutter framework]: https://flutter.dev
[Eleventy]: https://11ty.dev/
[Firebase]: https://firebase.google.com/

[Build Status]: https://github.com/flutter/website/workflows/build/badge.svg
[Flutter]: https://docs.flutter.dev/
[Repo on GitHub Actions]: https://github.com/flutter/website/actions?query=workflow%3Abuild+branch%3Amain

## Issues, bugs, and requests

We welcome contributions and feedback on our website. 
Please file a request in our
[issue tracker](https://github.com/flutter/website/issues/new/choose) 
or create a [pull request](https://github.com/flutter/website/pulls). 
For simple changes (such as tweaking some text), 
it's easiest to make changes using the GitHub UI.

If you have an issue with the 
API docs on [api.flutter.dev](https://api.flutter.dev), 
please file those issues on 
the [flutter/flutter](https://github.com/flutter/flutter/issues) repo, 
not on this (flutter/website) repo. 
The API docs are embedded in Flutter's source code, 
so the engineering team handles those.


## Before you submit a PR

We love it when the community gets involved in improving our docs! 
But here are a few notes to keep in mind before you submit a PR:

- When triaging issues, 
  we sometimes label an issue with the tag **PRs welcome**. 
  But we welcome PRs on other issues as well&mdash;
  it doesn't have to be tagged with that label.
- Please don't run our docs through Grammarly (or similar) 
  and submit those changes as a PR.
- We follow the [Google Developer Documentation Style Guidelines][] —
  for example, don't use "i.e." or "e.g.", 
  avoid writing in first person,
  and avoid writing in future tense.
  You can start with the
  [style guide highlights](https://developers.google.com/style/highlights) 
  or the [word list](https://developers.google.com/style/word-list), 
  or use the search bar that's at the top of every style guide page. 

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

> [!IMPORTANT]  
> If you are cloning this repository locally,
> follow the below instruction on cloning with its submodule.

If your change involves code samples, adds/removes pages, or affects navigation,
do consider building and test your work before submitting.

If you want or need to build the site, follow the steps below.

## Build the site

For changes beyond simple text and CSS tweaks,
we recommend running the site locally to
enable an edit-refresh cycle.

### Get the prerequisites

Install the following tools to build and develop the site:

#### Flutter

The latest stable release of Flutter, which includes Dart,
is required to build the site and run its tooling.
If you don't have Flutter or need to update, follow the
instructions at [Install Flutter][] or [Upgrading Flutter][].

If you already have Flutter installed, verify it's on your path
and already the latest stable version:

```console
flutter --version
```

[Install Flutter]: https://docs.flutter.dev/get-started
[Upgrading Flutter]: https://docs.flutter.dev/release/upgrade

#### Node.js

The **latest** stable LTS release of Node.js is required to build the site.
If you don't have Node.js or need to update, download your
computer's corresponding version and follow the instructions
from the [Node.js download archive][].
If you prefer, you can use a version manager such as [nvm][],
and run `nvm install` from the repository's root directory.

If you already have Node installed, verify it's available on your path
and already the latest stable version _(currently `20.12` or later)_:

```console
node --version
```

If your version is out of date,
follow the update instructions for how you originally installed it.

[Node.js download archive]: https://nodejs.org/en/download/
[nvm]: https://github.com/nvm-sh/nvm

### Clone this repo and its submodules

> [!NOTE]
> This repository has git _submodules_, which affects how you clone it.
> The GitHub documentation has general help on
> [forking][] and [cloning][] repos.

If you're not a member of the Flutter organization,
we recommend you **create a fork** of this repo under your own account,
and then submit a PR from that fork.

Once you have a fork (or you're a Flutter org member),
_choose one_ of the following submodule-cloning techniques:

1. Clone the repo and its submodule at the same time
   using the `--recurse-submodules` option:

   ```console
   git clone --recurse-submodules https://github.com/flutter/website.git
   ```

2. If you've already cloned the repo without its submodule,
   then run this command from the root of the repository:

   ```console
   git submodule update --init --recursive
   ```

> [!NOTE]
> At any time during development
> you can use the `git submodule` command to refresh submodules:
>
> ```console
> git pull && git submodule update --init --recursive
> ```

[cloning]: https://docs.github.com/repositories/creating-and-managing-repositories/cloning-a-repository
[forking]: https://docs.github.com/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo

## Set up your local environment and serve changes

Before you continue setting up the site infrastructure,
verify the correct versions of Flutter and Node.js are set up and available by
following the instructions in [Get the prerequisites](#get-the-prerequisites).

1. _Optional:_ After cloning the repo and its submodules,
   create a branch for your changes:

   ```console
   git checkout -b <BRANCH_NAME>
   ```

2. From the root directory of the repository,
   fetch the site's Dart dependencies.

   ```console
   dart pub get
   ```

3. Install `pnpm`, an alternative, efficient package manager for
   npm packages. If you already have `pnpm`, verify you have the
   latest stable version.

   ```console
   node --version
   ```

   If you do not already have `pnpm` installed, we recommend
   using [`corepack`][] to install and manage `pnpm` versions,
   since `corepack` is bundled with most installations of
   Node. If you installed `node` using Homebrew, you'll need
   to install corepack separately:

   ```console
   brew install corepack
   ```

   If you haven't used `corepack` before, you'll need to
   first enable it with `corepack enable`.
   Then, to install the correct `pnpm` version, from the
   root directory of the repository, run `corepack install`:

   ```console
   corepack enable;
   corepack install
   ```

   To install [`pnpm`][] without using `corepack`, you
   can use your preferred [installation method][pnpm-install].

4. Once you have `pnpm` installed and setup,
   fetch the site's npm dependencies using `pnpm install`.
   We highly recommend you use `pnpm`, but you can also use `npm`.

   ```console
   pnpm install
   ```
   
   Rerun `pnpm install` whenever you incorporate the
   latest changes to the `main` branch or if you
   experience dependency or import errors when building the site.

5. From the root directory, run the `dash_site` tool to
   validate your setup and learn about the available commands.

   ```console
   ./dash_site --help
   ```

6. From the root directory, serve the site locally.

   ```console
   ./dash_site serve
   ```

   This command generates and serves the site on a
   local port that's printed to your terminal.

7. View your changes in the browser by navigating to <http://localhost:4000>.

   Note the port might be different if `4000` is taken.

   If you want to check the raw, generated HTML output and structure,
   view the `_site` directory in a file explorer or an IDE.

8. Make your changes to the local repo.

   The site should automatically rebuild on most changes, but if
   something doesn't update, exit the process and rerun the command.
   Improvements to this functionality are planned.
   Please open a new issue to track the issue if this occurs.

9. Commit your changes to the branch and submit your PR.

   If your change is large, or you'd like to test it,
   consider [validating your changes](#validate-your-changes).

> [!TIP]
> To find additional commands that you can run,
> run `./dash_site --help` from the repository's root directory.

[`corepack`]: https://nodejs.org/api/corepack.html
[`pnpm`]: https://pnpm.io/
[pnpm-install]: https://pnpm.io/installation

## Validate your changes

### Check documentation and example code

If you've made changes to the code in the `/examples` or `/tool` directories,
commit your work, then run the following command to
verify it is up to date and matches the site standards.

```console
./dash_site check-all
```

If this script reports any errors or warnings,
then address those issues and rerun the command.
If you have any issues, leave a comment on your issue or pull request,
and we'll try our best to help you.
You can also chat with us on the `#hackers-devrel` channel
on the [Flutter contributors Discord][]!

[Flutter contributors Discord]: https://github.com/flutter/flutter/blob/master/docs/contributing/Chat.md

### Refresh code excerpts

A build that fails with the error
`Error: Some code excerpts needed to be updated!`
means that one or more code excerpts in the markdown file
aren't identical to the
code in the corresponding `.dart` file.

To resolve this error,
from the root of the `website` directory,
run `./dash_site refresh-excerpts`.

For more information see [Code excerpts][] .

[Code excerpts]: https://github.com/dart-lang/site-shared/blob/main/doc/code-excerpts.md

## [Optional] Deploy to a staging site

Submitted pull requests can be automatically staged
by a site maintainer.
If you'd like to stage the site yourself though,
you can build a full version and upload it to Firebase.

1. If you don't already have a Firebase project,

  - Navigate to the [Firebase Console](https://console.firebase.google.com)
    and create your own Firebase project (for example, `flutter-dev-staging`).

  - Head back to your local terminal and verify that you are logged in.

    ```console
    firebase login
    ```

  - Ensure that your project exists and activate that project:

    ```console
    firebase projects:list
    firebase use <your-project>
    ```

2. From the root directory of the repository, build the site:

   ```console
   ./dash_site build
   ```

   This will build the site and copy it to your local `_site` directory.
   If that directory previously existed, it will be replaced.

3. Deploy to your activated Firebase project's default hosting site:

   ```console
   firebase deploy --only hosting
   ```

4. Navigate to your PR on GitHub and include the link of the staged version.
   Do consider adding a reference to the commit you staged,
   so that reviewers know if any further changes have been made.
