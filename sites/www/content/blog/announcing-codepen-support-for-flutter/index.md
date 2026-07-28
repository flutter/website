---
title: "Announcing CodePen support for Flutter"
description: >-
  Today we're excited to announce that
  CodePen is adding support for Flutter
publishDate: 2020-04-15
author: zoeyfan
image: images/06wPqdCz_TzB2gAXr.webp
category: announcement
layout: blog
---

<DashImage figure src="images/06wPqdCz_TzB2gAXr.webp" />

Today we’re excited to announce that [CodePen](https://codepen.io), the leading social development environment for millions of front-end developers and designers, is adding [support for Flutter](https://codepen.io/flutter)! For web developers CodePen has long been a great place for sharing design explorations, new techniques, and ideas. Now with the introduction of Flutter, CodePen enables a new audience to learn, share and promote their creativity.

In the words of Alex Vazquez, one of the co-founders of CodePen:
> “CodePen has been a big fan of Flutter and the Dart programming language for years. We’re pretty pumped that Flutter now supports mobile *and* the web. The Flutter community is growing fast, which is why we’re excited to support Flutter with its own custom CodePen editor! Flutter is officially a first-class member of the CodePen community. We can’t wait to see what you build with Flutter on CodePen.”

Since the inception of Flutter, we’ve designed it as a canvas for creative expression. It has been encouraging to see growing recognition of its design capabilities, from the partnerships we announced with Adobe and SuperNova at our design-orientated [Flutter Interact event](https://g.co/FlutterInteract), to the naming of [Flutter as one of the most important design ideas of the decade](https://www.fastcompany.com/90442092/the-14-most-important-design-ideas-of-the-decade-according-to-the-experts) by Fast Company. With the new addition of a CodePen-based Flutter environment, creative professionals can now leverage CodePen to discover artistic Flutter inspirations, build up impressive Flutter portfolios, and showcase amazing Flutter ideas to the world!

CodePen’s Flutter editor is built on top of the same backend service, [dart-services](https://github.com/dart-lang/dart-services), that currently powers [DartPad](https://www.dartpad.dev) (the web-based editor created by the Flutter and Dart teams that has been recently updated to support Flutter). When we built DartPad, we designed it to be an educational tool to help developers learn Flutter and Dart, and share code snippets with each other. We specifically decided to open-source [dart-services](https://github.com/dart-lang/dart-services) so that sites like CodePen could tailor it to new scenarios and audiences.

DartPad is an excellent tool for quickly testing an idea in code, or for sharing your snippet with other developers, and it’s useful for reproducing (and filing) bugs. You can do this in CodePen, too, but CodePen has the advantage of an active design community where you can share, comment, promote, try out design ideas, and get input from other designers. CodePen’s Flutter editor is more like your “right brain” that you use to prototype ideas for creative expression and design inspiration, while DartPad is more like your “left brain” when you need to quickly test an idea or code up a technical concept.

<DashImage figure src="images/1uEJNcnBPZRxMr1EK0aqBRw.webp" alt="*[“Light effect” animation](https://codepen.io/zoeyfan/pen/mdeebvy) by [Mariano Zorrilla](https://gist.github.com/mkiisoft)*" caption="*[“Light effect” animation](https://codepen.io/zoeyfan/pen/mdeebvy) by [Mariano Zorrilla](https://gist.github.com/mkiisoft)*" />

## Flutter editor on CodePen

Let’s take a quick tour of the Flutter editor on CodePen. You can create a new Flutter pen (CodePen’s term for “code snippet”) either from [scratch](https://codepen.io/pen/editor/flutter) or from an existing [template](https://codepen.io/topic/flutter/templates). Many thanks to our esteemed Flutter community members ([@aednlaxer](https://github.com/aednlaxer), [@ayushnishad](https://github.com/ayushnishad), [@diegoveloper](https://github.com/diegoveloper/), [@divyanshub024](https://github.com/divyanshub024), [@egorbelibov](https://github.com/egorbelibov/), [@gskinnerTeam](https://github.com/gskinnerTeam), [@mkiisoft](https://gist.github.com/mkiisoft), [@orestesgaolin](https://github.com/orestesgaolin/), [@SlaxXxX](https://github.com/SlaxXxX), and others) for contributing some cool samples to the template list.

Let’s start with the [“GooeyEdge” template](https://codepen.io/zoeyfan/pen/ExVaXGK). As you can see, the Flutter code is on the left side, and Flutter’s web output is on the right side. You can play with this interactive design by dragging the edge of the visual using your mouse.

<DashImage figure src="images/111R_BtjzdSuPel44qDByKA.gif" alt="*[“Gooey edge” animation](https://codepen.io/zoeyfan/pen/ExVaXGK) by [Grant Skinner](https://github.com/gskinnerTeam)*" caption="*[“Gooey edge” animation](https://codepen.io/zoeyfan/pen/ExVaXGK) by [Grant Skinner](https://github.com/gskinnerTeam)*" />

You can also make changes to the Flutter code, and see them take effect accordingly. For example, if we change the color of the page control indicator from “white” to “blue” (line 326), you can see the color gets updated within a few seconds! CodePen automatically recompiles your code each time you make a change. Just update a line, wait a few seconds, and the new output appears.

<DashImage figure src="images/1YdadfEdp4pALMekmxaPWFA.webp" alt="Page control indicator changed into blue" caption="Page control indicator changed into blue" />

Now let’s see what happens if I introduce a syntax error. Say I accidentally delete a semicolon at the end of line 1. I’ll immediately see a red bar warning of the syntax error. This allows you to easily spot and correct mistakes.

<DashImage figure src="images/0bPcKdz1gG_1UxR6D.webp" alt="Warning message when introducing a syntax error" caption="Warning message when introducing a syntax error" />

## Social features

What we particularly love about CodePen is the social and community features it offers. Once you create a new pen or discover Flutter “pens” created by the community, you can save, favorite, add to a collection, share on social media, or even fork to create your own version!

<DashImage figure src="images/0zfGvzw1Zb8SwDcpv.webp" />

<DashImage figure src="images/0ulpFtxXC_93Qp59b.webp" />

## Give it a try!

We hope this new Flutter playground on [CodePen](https://codepen.io/flutter) empowers you to build and showcase your cool Flutter animations, ideas, vignettes, and more. Please share your designs with us on Twitter using **#FlutterPen**. We can’t wait to see what you build! If you missed last week’s announcement about [free training](https://medium.com/flutter/learn-flutter-for-free-c9bc3b898c4d), you might want to check that out. And keep an eye out: we’ll have more news very soon.
