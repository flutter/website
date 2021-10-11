[![Flutter logo]](https://flutter.dev)
# [Flutter][] website 

[![Build Status][]][Repo on GitHub Actions]

> **Note:** We've made significant changes to this
> repo to make it easier to use and maintain.
> If you've already cloned this repo, please do it again.
> The most significant differences include:
> * If you want to build the site,
>   a Docker container now makes build setup simpler.
>   For example, you no longer need to install nvm.
> * The default branch is now called `main`
>   (it was previously `master`).
> * Some files — in particular, image files —
>   have been moved.
> 
> Stay tuned for another significant update to
> the website repo later this year.
> 
> Thanks, as always, for your continued support!

## Table of contents
* [Issues, bugs, and requests](#issues-bugs-and-requests)
* [Before you submit a PR](#before-you-submit-a-pr)
* [Before you build this site](#before-you-build-this-site)
  - [1. Get the prerequisites](#1-get-the-prerequisites)
  - [2. Clone this repo _and_ its submodules](#2-clone-this-repo-and-its-submodules)
* [Setting up your local environment and serving changes](#setting-up-your-local-environment-and-serving-changes)
* [Creating and/or editing DartPad example code](#creating-andor-editing-dartpad-example-code)
  - [DartPad example code in GitHub gists](#dartpad-example-code-in-github-gists)
  - [DartPad example code in this repo](#dartpad-example-code-in-this-repo)
* [Deploying to a staging site](#deploying-to-a-staging-site)
* [Writing for flutter.dev](#writing-for-flutterdev)


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
  and avoid writing in first person. 
  You can start with the
  [style guide highlights](https://developers.google.com/style/highlights) 
  or the [word list](https://developers.google.com/style/word-list), 
  or use the search bar that's at the top of every style guide page. 

> We truly thank you for your willingness and helpfulness
> in keeping the website docs up to date!


## Before you build this site

For changes beyond simple text and CSS tweaks, 
we recommend building the site.

### 1. Get the prerequisites
Install the following tools, if you don't have them already:

- **bash**, the Bourne shell. 
  These instructions assume you're using `bash`, 
  and setup might not work if you use another shell.
- **GNU Make**. 
  On Windows the easiest way to install Make is `choco install make`. 
  Other options include using a [subsystem](https://docs.microsoft.com/en-us/windows/wsl/install-win10). 
- **Docker**. 
  We use Docker for local dev, tests, and building the site. 
  Install it from https://docs.docker.com/get-docker/.
- **Firebase CLI**, for hosting the site locally. 
  One way to get this is to run `npm install -g firebase-tools`. 
  For full setup details, 
  read the [Firebase CLI documentation](https://firebase.google.com/docs/cli).

### 2. Clone this repo _and_ its submodules

> **Note:** This repo has git _submodules_, 
> which affects how you clone it. 
> The GitHub documentation has general help on [forking][] and [cloning][] repos.

If you're outside of the Flutter organization, 
we recommend you **create a fork** of the repo under your own account, 
and then submit a PR from that fork. 

Once you have a fork (or you're a Flutter org member), 
_choose one_ of the following submodule-cloning techniques:

- Clone the repo and its submodule at the same
  using the `--recurse-submodules` option:
  ```bash
  $ git clone --recurse-submodules https://github.com/<username-or-flutter>/website.git
  ```

  OR
  
- If you've already cloned the repo without its submodule, 
  then run this command from the repo root:<br>
  ```bash
  $ git submodule update --init --recursive
  ```

> **Note:** At any time during development 
> you can use the `git submodule` command to refresh submodules:
> ```bash
> $ git pull; git submodule update --init --recursive
> ```

## Setting up your local environment and serving changes

1. _Optional:_ After cloning the repo and its submodules, 
   create a branch for your changes:
   ```bash
   $ git checkout -b <BRANCH_NAME>
   ```
   
1. If the Docker Desktop application isn't already running, start it.
   Look at its status icon: 
   if it has an exclamation point (`!`), then update Docker Desktop.

1. Run the initial setup command:
   ```bash
   $ make setup
   ```
   The site is build and ready to be served.
   The generated `_site` directory is visible locally.

1. Serve the site locally (via `docker-compose`):
   ```bash
   $ make up
   ```

1. View your changes in the browser by navigating to `http://localhost:4002`.
   > **Note:** Unless you're editing files under `site-shared`, 
   > you can safely ignore `ERROR: directory is already being watched` messages. 
   > For details, see [#1363](https://github.com/flutter/website/issues/1363).

1. Make your changes. 
   The files are updated, and your browser view should update to reflect 
   the changes. 
   You can either edit files locally or use an editor like `vim` 
   directly in a shell in the container. 
   To start a container shell, run `docker-compose exec site bash`.

1. Commit your changes to the branch and submit your PR.

1. When you've finished developing, shut down the Docker container:
   ```bash
   $ make down
   ```

> **Tip:** If you get stuck somewhere and need to start building fresh, 
> run the following `make mostlyclean` command and rebuild the site.
> ```bash
> $ make mostlyclean && make setup && make up
> ```
> If you still get stuck and unable to proceed then use 
> `make maintainer-clean` command. Make sure you run this command on 
> committed changes.
> ```bash
> $ make maintainer-clean && make setup && make up
> ```
>
> To find additional commands, read the [`Makefile`][]. 
> For example, if you need to debug the Docker infrastructure, 
> you can run `make debug`.

## Creating and/or editing DartPad example code

Most of the code used to create [DartPad][] examples is hosted on GitHub. 
However, this repo also contains some `*.dart` files
responsible for DartPad example code.


### DartPad example code in GitHub gists

A typical DartPad example takes the form of an `iframe`, 
for example, within a codelab's Markdown file:

```html
<iframe
  src="{{ site.custom.dartpad.embed-flutter-prefix }}?id=d7b09149ffee2f0535bb0c04d96987f5" 
  style="border:1px solid lightgrey;margin-top:10px;margin-bottom:25px"
  frameborder="no" height="500" width="100%">
</iframe>
```

This `iframe` depends on the following GitHub gist URL:
> https://gist.github.com/d7b09149ffee2f0535bb0c04d96987f5

For detailed instructions on how to use this approach to DartPad examples, 
see the [DartPad embedding guide][].


### DartPad example code in this repo 

Some DartPad example code remains in this repo:
- `src/_packages/dartpad_picker/web/dartpad_picker_main.dart`

This code must be manually compiled, 
which also regenerates the associated JavaScript file in `src/assets/js`:
```bash
$ cd `src/_packages/dartpad_picker
$ ./compile.sh
```


## Deploying to a staging site

You can deploy your local edits to a personal staging site as follows.

1. Create a Firebase project using [Firebase Console][]. For example, 
   `myInitials-flutter-website`.

1. Login into Firebase using your Google account by running 
   [`firebase login`][] Firebase CLI command:
   ```bash
   $ firebase login
   ```

1. Tell the Firebase CLI to use your project using the 
   [`firebase use`][] command:
   ```bash
   $ firebase use myInitials-flutter-website
   ```

1. Build the site via Docker with:
   ```bash
   $ make build
   ```
   The freshly created `_site` directory is ready to be deployed.

1. Deploy to the staging site:
   ```bash
   $ make deploy
   ```

Your personal version of the Flutter website is now deployed to Firebase. 
Copy the serving URL from the command output.


## Writing for flutter.dev

The [site-shared](https://github.com/dart-lang/site-shared) repo 
contains infrastructure shared by most of our Dart and Flutter websites. 
Some of this README is in the [doc](https://github.com/dart-lang/site-shared/tree/master/doc)
directory in the site-shared repo.

For more information on using and writing for this repo, refer to the following docs:

* [Infrastructure](https://github.com/dart-lang/site-shared/blob/master/doc/infrastructure.md)
* [Markdown](https://github.com/dart-lang/site-shared/blob/master/doc/markdown.md)
* [Examples](https://github.com/dart-lang/site-shared/blob/master/doc/examples.md)
* [Code excerpts](https://github.com/dart-lang/site-shared/blob/master/doc/code-excerpts.md)

Also check out the site-shared [wiki](https://github.com/dart-lang/site-shared/wiki):

* [Images](https://github.com/dart-lang/site-shared/wiki/Images)
* [Mobile friendly pages: tips & tricks](https://github.com/dart-lang/site-shared/wiki/Mobile-friendly-pages:-tips-&-tricks)
* [Writing for Dart and Flutter websites](https://github.com/dart-lang/site-shared/wiki/Writing-for-Dart-and-Flutter-websites)



[Flutter]: https://flutter.dev
[Build Status]: https://github.com/flutter/website/workflows/build/badge.svg
[cloning]: https://help.github.com/articles/cloning-a-repository
[DartPad]: https://dartpad.dev
[Firebase Console]: https://console.firebase.google.com
[`firebase login`]: https://firebase.google.com/docs/cli#sign-in-test-cli
[`firebase use`]: https://firebase.google.com/docs/cli#use_aliases
[forking]: https://docs.github.com/en/get-started/quickstart/fork-a-repo
[Flutter install]: https://flutter.dev/docs/get-started/install
[Flutter logo]: https://github.com/dart-lang/site-shared/blob/master/src/_assets/image/flutter/icon/64.png?raw=1
[Firebase]: https://firebase.google.com/
[Google Developer Documentation Style Guidelines]: https://developers.google.com/style
[DartPad embedding guide]: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide
[`Makefile`]: https://github.com/flutter/website/blob/main/Makefile
[Repo on GitHub Actions]: https://github.com/flutter/website/actions?query=workflow%3Abuild+branch%3Amaster
