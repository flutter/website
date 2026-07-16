---
title: "Must try: Use Firebase to host your Flutter app on the web"
description: "So you have a Flutter app, and you want to show it to the world? Look no further! This tutorial will show you how to host your Flutter app…"
publishDate: 2019-11-11
author: clocksmith
image: images/1eL-dHo08RwyLYOl17DNTog.webp
category: tutorial
layout: blog
---

## Use Firebase to host your Flutter app on the web

<DashImage figure src="images/1eL-dHo08RwyLYOl17DNTog.webp" />


So you have a Flutter app, and you want to show it to the world? Look no further! This tutorial shows how to host your Flutter app on the web through a Firebase-hosted URL in just 4 easy steps (2 steps if you already have firebase-tools installed and an existing Firebase project). It is assumed that you have Flutter installed and are able to run your Flutter app locally. If you are new to Flutter, first check out the [getting started guide](https://flutter.dev/docs/get-started/install).

## Prerequisite

If your project was created before flutter web was enabled, your project needs a copy of the web folder with an `index.html` file. If there is not a web folder in your root directory, run the following command to make one:

```bash
$ flutter create .
```


If you create a project after enabling the web, it automatically creates the `web/index.html` file for you. Good, now on to the Firebase Hosting setup.

☝️Note: Step 1 and 2 can be skipped if you already have a Firebase project and firebase-tools installed.

## Step 1: Create the Firebase project

🏃‍♀ Skip this step if you already have a Firebase project to use.

☝️Note: A new project can also be created on the command line from within step 2, but this tutorial creates it in the Firebase console.

In a browser, go to the [Firebase console](https://console.firebase.google.com/).

<DashImage figure src="images/0J0ZaW4hZbSlEXjK9.webp" />


Click **Add project** and give your project a name:

<DashImage figure src="images/00i_W2vNozOa87N_B.webp" />


☝️Note: The actual project name might generate some extra characters at the end for uniqueness.

Click **Continue.** For simplicity, don’t enable Google Analytics for this project, so turn off the switch and click **Create project**. If you want to use Google Analytics, leave the switch on, and there will be one extra step of choosing or creating a Google Analytics project.

<DashImage figure src="images/0qUlFDIP4H0C4_urO.webp" />


Watch for a few seconds as the project is created, until you see that it is ready and click **Continue.**

<DashImage figure src="images/0fL_0E_cbbMff5IIr.webp" />


That’s it for step 1!

## Step 2: Install the firebase-tools CLI

🏃‍♀Skip this step if you already have firebase-tools installed.

If you do not have `npm`, you must install that first.

☝️Note: If you are not sure whether `npm` is installed on your machine, run `$ npm -v` , and see if it lists a version number. If it does, then you already have `npm`. If it says “command not found”, you need to install it.

[Installing npm on windows](https://www.guru99.com/download-install-node-js.html).

[Installing npm on linux](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm).

[Installing npm on mac](https://treehouse.github.io/installation-guides/mac/node-mac.html).

Or download it directly from [Node.js](https://nodejs.org).

Once `npm` is installed, run the following command to install the `firebase-tools`:

```bash
$ npm install -g firebase-tools
```


`firebase-tools` is now installed!

## Step 3: Initialize Firebase hosting for your Flutter project

Open a terminal and navigate to the root directory for your Flutter app and run this command to login:

```bash
$ firebase login
```


☝️Note: If you are already logged in and want to re-login as different account, first logout with:

```bash
$ firebase logout
```


Follow the command prompt and the link in your browser. Accept the permissions by clicking **Ok**. When you return to your terminal you should see that you are now logged in:

<DashImage figure src="images/0JZ_gkqDtOFpGnTtJ.jpg" />


Next, run this command from the root directory of your Flutter app to initialize your Firebase project:

```bash
$ firebase init
```


<DashImage figure src="images/0F4TQYa2f-9bAaW3X.webp" />


Use the arrow keys to navigate the cursor to **Hosting** and hit the spacebar to select it, then press enter. Now you will see this screen:

<DashImage figure src="images/0KnlTgdXeNMDAMpna.webp" />


Select **Use an existing project** by pressing Enter. Use the arrow keys to select the project you made in step 1.

Next, enter `build/web` as the public directory and press enter, then enter **y** (for yes) to select the single page app option:

<DashImage figure src="images/0mYMsKK4g65KGh71f.webp" />


☝️Note: After this step, 2 new files are created (`.firebaserc` and `firebase.json`) in your root directory. Check and make sure they are there. If not, check for errors in the `firebase init` step and retry.

## Step 4: Build and deploy!

Build your app for web:

```bash
$ flutter build web
```


This builds the necessary files in `<root-directory>/build/web`.

Note: If you see a warning: “Experimental feature web is not supported on stable branches”, make sure you are on at least the dev channel and have web enabled. For example:

```plaintext
$ flutter channel
  beta
* dev
  master
  stable
$ ~ $ flutter devices
2 connected devices:

Chrome     • chrome     • web-javascript • Google Chrome 78.0.3904.87
Web Server • web-server • web-javascript • Flutter Tools
```


Finally, run:

```bash
$ firebase deploy
```


The hosting files are uploaded and hosted at your Firebase URL. You can follow the link in your terminal to your Flutter web project!
