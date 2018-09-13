# [Flutter][]'s website

[![Build Status SVG][]][Repo on Travis]

## Issues, bugs, and requests

We welcome contributions and feedback on our website!
Please file a request in our
[issue tracker](https://github.com/flutter/website/issues/new)
and we'll take a look.

For simple changes (such as to CSS and text), you probably don't need to build this site.
Often you can make changes using the GitHub UI.

If you want/need to build, read on.

## Before you build this site

### 1. Get the prerequisites

Install the following tools if you don't have them already.

- **[nvm][]**, the Node Version Manager.
- **[rvm][]**, the Ruby Version Manager.
- **[Flutter][Flutter install]**
- **[Dart SDK][Dart install]**

> IMPORTANT: Follow the installation instructions for each of the tools
carefully. In particular, configure your shell/environment so
that the tools are available in every terminal/command window you create.

### 2. Clone this repo _and_ its submodule

> NOTE: This repo has a git _submodule_, which affects how you clone it.

To **clone [this repo][]**, follow the instructions given in the
GitHub help on [Cloning a repository][], and _choose one_ of the following
submodule-cloning techniques:

- Clone this repo and its submodule _at the same_, use the
  `--recurse-submodules` option:<br>
  `git clone --recurse-submodules https://github.com/flutter/website.git`
- If you've already cloned this repo without its submodule, then run
  this command from the repo root:<br>
  `git submodule update --init --remote`

> IMPORTANT:
> Whenever you update your repo, update the submodule as well:<br>
> `git pull; git submodule update --init --remote`

### 3. Run installation scripts

> NOTE: It is safe to (re-)run all of the commands and scripts given below even
if you already have the required packages installed.

**Open a terminal/command window** and execute the following commands:

1. <code>cd <i>\<path-to-this-repo></i></code> &nbsp;&nbsp;# change to
   **root of this repo**
1. `source ./tool/env-set.sh` &nbsp;&nbsp;#
   initialize environment variables; install/use required Node & Ruby version
1. `./tool/before-install.sh` &nbsp;&nbsp;#
   install core set of required tools
1. `./tool/install.sh` &nbsp;&nbsp;#
   install everything else needed to build this site

> IMPORTANT:
> - Any time you create a **new terminal/command window** to work on
>   this repo, **repeat steps 1 and 2** above.
> - If you upgrade Dart then rerun all of the steps above.

## Developing

 1. Create a branch.

 1. Make your changes.

 1. Test your changes by serving the site locally. Run either **one** of these commands:

    - `tool/serve.sh`, _or_
    - `bundle exec jekyll serve --incremental --watch --livereload --port 4002`

 1. Prior to submitting, run link validation:<br>
    `tool/shared/check-links.sh`

## Deploy to a staging site

For edits made directly in the GitHub web UI, the changes will be deployed to a
staging site (such as `https://flutter-io-deploy-three.firebaseapp.com/inspector`)
by the Travis job.

For edits you make locally (using the 'developing' steps above), you can deploy them
to a personal staging site as follows (steps 1 and 2 need to be done only once):

1. In the [Firebase Console](https://console.firebase.google.com),
create your own Firebase project (e.g. 'mit-flutter-staging')

1. Tell Firebase about that project with the firebase
[`use` command](https://firebase.googleblog.com/2016/07/deploy-to-multiple-environments-with.html):
	```
	$ npx firebase use --add
	? Which project do you want to add? <select the project you created>
	? What alias do you want to use for this project? (e.g. staging) staging
	```

1. Tell Firebase that you want to deploy to staging:
	```
	$ npx firebase use staging
	Now using alias staging (<your project name>)
	```

1. Tell Firebase to deploy:
	```
	$ npx firebase use staging
	Now using alias staging (<your project name>)
	$ npx firebase deploy

	=== Deploying to '<your project name>'...

	i  deploying hosting
	i  hosting: preparing _site directory for upload...
	✔  hosting: 213 files uploaded successfully
	i  starting release process (may take several minutes)...

	✔  Deploy complete!
	```

## Writing for flutter.io

(Eventually, this section should be expanded to its own page.)

### Adding next/previous page links

If you have a document that spans multiple pages, you can add next and previous
page links to make navigating these pages easier. It involves adding some information
to the front matter of each page, and including some HTML.

```
---
layout: tutorial
title: Constraints

permalink: /tutorials/layout/constraints.html
prev-page: /tutorials/layout/properties.html
prev-page-title: "Container Properties"
next-page: /tutorials/layout/create.html
next-page-title: "Create a Layout"
---

{% include prev-next-nav.html %}

{:toc}

<!-- PAGE CONTENT -->

{% include prev-next-nav.html %}
```

Omit the "prev-page" info for the first page, and the "next-page" info for the
last page.

## Syntax highlighting

The flutter.io website uses [prism.js](http://prismjs.com/) for syntax
highlighting. This section covers how to use syntax highlighting, and
how to update our syntax highlighter for new languages.

### Supported languages

This website can syntax highlight the following languages:

* shell
* dart
* html
* css
* javascript
* java
* objectivec
* swift

### Using syntax highlighting

The easiest way to syntax highlight a block of code is to wrap
it with triple backticks followed by the language.

Here's an example:

	```dart
	class ExampleWidget extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return new Container();
      }
    }
	```

See the list of supported languages above for what to use
following the first triple backticks.

### Adding more languages for syntax highlighting

The flutter.io website uses a custom build of prism, which
includes only the languages the website requires. To improve
load times and user experience, we do not support every
language that prism supports.

To add a new language for syntax highlighting, you will need
to generate a new copy of the `prism.js` file.

Follow these steps to generate a new copy of `prism.js`:

* Open `js/prism.js`
* Copy the URL in the comment of the first line of the file
* Paste it into a browser window/tab
* Add the new language that you wish to syntax highlight
* DO NOT change the other plugins, languages, or settings
* Download the generated JavaScript, and use it to replace `js/prism.js`
* Download the generated CSS, and use it to replace `_sass/_prism.scss`

## Advanced stylization of code blocks

Do you want to highlight (make the background yellow)
code inside a code block? Do you want to strike-through
code inside a code block? We got that!

For syntax highlighting, plus yellow highlighting
and strike-through formatting, use the `prettify` tag
with additional custom inline markup.

If you want to highlight a specific bit of code, use the
`[[highlight]]highlight this text[[/highlight]]` syntax
with the `prettify` tag.

For example:

    {% prettify dart %}
    void main() {
      print([[highlight]]'Hello World'[[/highlight]]);
    }
    {% endprettify %}

If you want to strike-through a specific bit of code, use the
`[[strike]]highlight this text[[/strike]]` syntax
with the `prettify` tag.

For example:

    {% prettify dart %}
    void main() {
      print([[strike]]'Hello World'[[/strike]]);
    }
    {% endprettify %}

The `prettify` plugin will also unindent your code.

If you want to see how this functionality was added to this site, refer to
[this commit](https://github.com/flutter/website/commit/ea15f52fe47d3a7b6313ac58d07c66f3b29fe74d).

## Including a region of a file

You can include a specific range of lines from a file:

```ruby
{% include includelines filename=PATH start=INT count=INT %}
```

`PATH` must be inside of `_include`. If you are including source code,
place that code into `_include/code` to follow our convention.

## Code snippet validation

The code snippets in the markdown documentation are validated as part of the
build process. Anything within a '\`\`\`dart' code fence will be extracted into
its own file and checked for analysis issues. Some ways to tweak that:

- If a code snippet should not be analyzed, immediately proceed it with
  a `<!-- skip -->` comment
- To include code to be analyzed, but not displayed, add that in a comment
  immediately proceeding the snippet (e.g., `<!-- someCodeHere(); -->`)
- A snippet without any import statements will have an import
  (`'package:flutter/material.dart'`)
  automatically added to it
- We ignore special formatting tags like `[[highlight]]`.

[Flutter]: https://flutter.io

## Updating the Sample Catalog

The sample catalog's markdown files are generated by running [sample_page.dart](https://github.com/flutter/flutter/blob/master/examples/catalog/bin/sample_page.dart) from the Flutter github repo. Starting from the root of the Flutter repo:
```
cd examples/catalog
dart bin/sample_page.dart '<commit hashcode here>'
cp examples/catalog/.generated/*.md <your website repo>/catalog/samples
```

The generated markdown files will contain cloud storage links for sample app screenshots. Screenshots for each sample app are automatically generated for each Flutter repo commit. Choose a recent commit hashcode and confirm that the screenshots look OK.

If new sample apps have been added, update `_data/catalog/widget.json`. The entry for each widget class that's featured in a sample app should contain `"sample"` line like:
```
"sample": "ListView_index",
```

The `sample_page.dart` app will print a list of all of the `"sample"` properties that should appear in the `widget.json` file.

## Preventing broken links

Some form of broken links prevention is done automatically by `rake checklinks`
on every commit (through `tool/travis.sh`). But this won't see any Firebase
redirects (`rake checklinks` doesn't run the Firebase server) and it won't
check incoming links.

Before we can move the more complete
[automated `linkcheck` solution](https://github.com/dart-lang/site-webdev/blob/master/tool/check-links-using-fb.sh)
from dartlang.org, we recommend manually running the following.

* First time setup:

  ```
  pub global activate linkcheck
  npm install
  ```

* Start the localhost Firebase server:

  ```
  npx superstatic --port 4002
  ```

* Run the link checker:

  ```
  linkcheck :4002
  ```

  Even better, to check that old URLs are correctly redirected:

  ```
  linkcheck :4002 --input-file tool/sitemap.txt
  ```

[Build Status SVG]: https://travis-ci.org/flutter/website.svg?branch=dash
[Cloning a repository]: https://help.github.com/articles/cloning-a-repository
[Dart install]: https://www.dartlang.org/install
[Flutter install]: /get-started/install
[Firebase]: https://firebase.google.com/
[first-timers SVG]: https://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square
[first-timers]: https://www.firsttimersonly.com/
[Jekyll]: https://jekyllrb.com/
[nvm]: https://github.com/creationix/nvm#installation
[Repo on Travis]: https://travis-ci.org/flutter/website
[rvm]: https://rvm.io/rvm/install#installation
[this repo]: https://github.com/flutter/website
