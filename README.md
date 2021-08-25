![Flutter logo][]
# [Flutter][] website 

[![Build Status][]][Repo on GitHub Actions]

NOTE: We have made significant changes to the flutter/website
repo to make it easier to use and maintain,
and the instructions in this file are changing.
If you have already cloned it, please clone it again.
The most significant differences include:
* The website now uses a Docker container, so
  you need to install Docker, if you haven't already.
  This means that much of the tooling previously
  required (like nvm) is no longer required.
* The default branch is renamed to `main`
  (it was previously `master`).
* Files (and most specifically image files)
  have been moved.

Stay tuned for another significant update to
the website repo later this year.

Thanks, as always, for your continued support!

## Table of contents
* [Issues, bugs, and requests](#issues-bugs-and-requests)
* [Before you submit a PR](#before-you-submit-a-pr)
* [Before you build this site](#before-you-build-this-site)
  - [1. Get the prerequisites](#1-get-the-prerequisites)
  - [2. Clone this repo _and_ its submodules](#2-clone-this-repo-and-its-submodules)
* [Set up your local environment and serve changes](#set-up-your-local-environment-and-serve-changes)
* [Creating and/or editing DartPad example code](#creating-andor-editing-dartpad-example-code)
  - [DartPad example code in GitHub gists](#dartpad-example-code-in-github-gists)
  - [DartPad example code in this repo - `src/_packages/dartpad_picker`](#dartpad-example-code-in-this-repo---src_packagesdartpad_picker)
* [Deploy to a staging site](#deploy-to-a-staging-site)
  - [Alternate deployment script](#alternate-deployment-script)
* [Deploying to the official site](#deploying-to-the-official-site)
* [Writing for flutter.dev](#writing-for-flutterdev)


## Issues, bugs, and requests
We welcome contributions and feedback on our website. Please file a request in our [issue tracker](https://github.com/flutter/website/issues/new) and we'll take a look.

If you have an issue with the API docs on [api.flutter.dev](https://api.flutter.dev), please file those issues on the [flutter/flutter](https://github.com/flutter/flutter/issues) repo, not on this (flutter/website) repo. The API docs are embedded in Flutter's source code, so the engineering team handles those.

> **NOTE** - For simple changes (such as to CSS and text), you probably don't need to build this site. Often, you can make changes using the GitHub UI. If you want/need to build, read on.


## Before you submit a PR
We love it when the community gets involved in improving our docs! But here are a few notes to keep in mind before you submit a PR:

- When triaging issues, we sometimes label an issue with the tag, "PRs welcome". But we welcome PRs on other issues as well&mdash;it doesn't have to be tagged with that label.
- Please realize that we follow (or try to follow) the [Google Developer Documentation Style Guidelines](https://developers.google.com/style). So please don't run our docs through Grammarly (or similar) and submit those changes as a PR. This guide is a reference doc and not meant to be read like a novel, but check out the [highlights](https://developers.google.com/style/highlights) page or use the search bar to find your subject of interest. Also, the [wordlist](https://developers.google.com/style/word-list) is very useful. (For example, don't use "i.e." or "e.g.", and avoid writing in first person.)

> We truly thank you for your willingness and helpfulness in keeping the website docs up to date!


## Before you build this site

### 1. Get the prerequisites
Install the following tools, if you don't have them already:

- **bash**, the Bourne shell. These instructions assume you're using `bash` and setup might not work if you use another shell.
- **GNU Make**. On Windows the easiest way to install Make is `choco install make`. Other options include using a [subsystem](https://docs.microsoft.com/en-us/windows/wsl/install-win10). 
- **Docker** is used for local dev, tests and building the site. It can be installed from [here](https://docs.docker.com/get-docker/).
- Lastly, install the **Firebase CLI** for local deployment by running `npm install -g firebase-tools`. Read the [docs](https://firebase.google.com/docs/cli) for full setup.


### 2. Clone this repo _and_ its submodules
> **NOTE** - This repo has git _submodules_, which affects how you clone it.

To **clone [flutter/website]()** (this repo), follow the instructions given in the GitHub help on [Cloning a repository][], then _choose one_ of the following submodule-cloning techniques:

- If you are outside of the Flutter organization, we recommend you create a fork of the repo under your own account, and then submit a PR from that fork. 

- Clone the repo and its submodule at the same using the `--recurse-submodules` option:
  ```bash
  $ git clone --recurse-submodules https://github.com/flutter/website.git
  ```

  OR
  
- If you've already cloned the repo without its submodule, then run this command from the repo root:<br>
  ```bash
  $ git submodule update --init --recursive
  ```

> **NOTE** - At any time during development you can use the `git submodule` command to refresh submodules:
> ```bash
> $ git pull; git submodule update --init --recursive
> ```

## Set up your local environment and serve changes
1. After cloning the repo and its submodules, first create a branch for your changes:
   ```bash
   $ checkout -b <BRANCH_NAME>
   ```
1. Then run the initial setup command:
   ```bash
   $ make setup
   ```
1. You can know run the site via `docker-compose` by running the convenience command:
   ```bash
   $ make up
   ```
   The site will initially be generated and then the development server will be running in the docker container. You will see the generated `_site` directory locally. Navigate to `http://localhost:4002` in your browser to connect the livereload feature and view the site.

   > *There are a number of commands available. When you are done developing, it is recommended to shut down the docker container via `make down`. If you need to enter the container for debug, run `make debug`, and so forth. Read through the `Makefile` for additional commands.* 

   > **NOTE** - Unless you're editing files under `site-shared`, you can safely ignore `ERROR: directory is already being watched` messages. For details, see [#1363](https://github.com/flutter/website/issues/1363).

1. Make your changes. You can develop locally and changes will be reflected in the container via the shared volume. You may also choose develop with `vim` or an editor of your choice directly in the container by running:
   ```bash
   $ docker-compose exec site bash
   ```
1. View your changes in the browser.
1. Commit your changes to the branch and submit your PR.

> **TIP** - Sometimes Jekyll gets confused and seems to be out-of-sync. This might happen, for example, when you pull from master and lots of files have moved. The Jekyll `--incremental` serve option can also sometimes produce this. To fix this run:
> ```bash
> $ make down && make clean && make up
> ```
> In some rare cases you may want to force all running containers down with:
> ```bash
> $ docker rm -f $(docker ps -aq)
> ````


## Creating and/or editing DartPad example code
Most of the code used to create DartPad examples is hosted on GitHub. However, this repo also contains some `*.dart` files responsible for DartPad example code.


### DartPad example code in GitHub gists
A typical DartPad example takes the form of an `iframe`, for example, within a codelab's markdown file:

```html
<iframe
  src="{{ site.custom.dartpad.embed-flutter-prefix }}?id=d7b09149ffee2f0535bb0c04d96987f5" 
  style="border:1px solid lightgrey;margin-top:10px;margin-bottom:25px"
  frameborder="no" height="500" width="100%">
</iframe>
```

This `iframe` depends on the following GitHub gist url:
> https://gist.github.com/d7b09149ffee2f0535bb0c04d96987f5

For detailed instructions on how to use this approach to DartPad examples, see the [DartPad embedding guide].


### DartPad example code in this repo 
Some DartPad example code remains in this repo:
- `src/_packages/dartpad_picker/web/dartpad_picker_main.dart`

This code must be manually compiled, which will also regenerate the associated Javascript file in `src/assets/js`:
```bash
$ cd `src/_packages/dartpad_picker
$ ./compile.sh
```


## Deploy to a staging site
You can deploy your local edits to a personal staging site as follows.

1. If you do not already have a Firebase project, navigate to the [Firebase Console](https://console.firebase.google.com) and create your own Firebase project (e.g. `my-foo`). You only need to do this step once.

1. In a separate `bash` shell, change to the repo directory and initialize Firebase:
    ```bash
    $ npx firebase init
    ```
1. Tell Firebase about your project with the [`firebase use` command](https://firebase.googleblog.com/2016/07/deploy-to-multiple-environments-with.html). You only need to do this step once:
    ```bash
    $ npx firebase use --add
    ? Which project do you want to add? <select the project you created>
    ? What alias do you want to use for this project? (e.g. staging) my-foo
    ```
1. Tell Firebase that you want to deploy to your staging:
    ```bash
    $ npx firebase use my-foo
    Now using alias staging (my-foo)
    ```
1. Build the site via Docker with:
   ```bash
   $ DISABLE_TESTS=1 make build
   ```
   You will see the `_site` directory has been refreshed locally. 

1. Finally, run the deploy command:
   ```bash
   $ make deploy
   ```

   Your personal version of the Flutter website is now deployed to Firebase. Copy the serving URL from the command output.


## Writing for flutter.dev
The [site-shared](https://github.com/dart-lang/site-shared) repo contains infrastructure shared by most of our Dart and Flutter websites. Some of this README is in the [doc](https://github.com/dart-lang/site-shared/tree/master/doc) directory in the site-shared repo.

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
[Cloning a repository]: https://help.github.com/articles/cloning-a-repository
[Flutter install]: https://flutter.dev/docs/get-started/install
[Flutter logo]: https://github.com/dart-lang/site-shared/blob/master/src/_assets/image/flutter/icon/64.png?raw=1
[Firebase]: https://firebase.google.com/
[first-timers SVG]: https://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square
[first-timers]: https://www.firsttimersonly.com/
[GNU diffutils]: https://www.gnu.org/software/diffutils
[DartPad embedding guide]: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide
[Jekyll]: https://jekyllrb.com/
[nvm]: https://github.com/nvm-sh/nvm/blob/master/README.md#installing-and-updating
[Repo on GitHub Actions]: https://github.com/flutter/website/actions?query=workflow%3Abuild+branch%3Amaster
[rvm]: https://rvm.io/rvm/install#installation
[this repo]: https://github.com/flutter/website
