---
title: "Playful typography with Flutter"
description: >-
  Exploring variable fonts and shaders
publishDate: 2023-01-20
author: hellobrianjames
image: images/0x9XqN84kLr7s86vK.webp
category: story
layout: blog
---

## Intro

I’m Brian, a newcomer to the Flutter-verse, and I’ve been a UX engineer on Google’s Flutter team for about six months now. As a UX engineer, I combine my background as a graphic designer with coding skills to help the team build Flutter itself, and to show off what Flutter can do. This blog post shares one of my first experiments with Flutter as a hybrid designer–developer: a simple typography-themed puzzle app. It combined my creative background in design with technical explorations around a couple of Flutter APIs you might not have tried yet: [FontVariation](https://api.flutter.dev/flutter/dart-ui/FontVariation-class.html) and [AnimationController](https://api.flutter.dev/flutter/animation/AnimationController-class.html). I had a lot of fun creating this app, and through it I saw first-hand how great Flutter is for designers who code, or developers with an eye for design.

<DashImage figure src="images/0x9XqN84kLr7s86vK.webp" alt="*A palette of customized Flutter text widgets, using variable fonts and shaders.*" caption="*A palette of customized Flutter text widgets, using variable fonts and shaders.*" />

## Typography

Graphic designers love geeking out on “typography,” which is just a fancy word for the styling of text. This includes things like choosing fonts, sizing, layout, spacing, and so on. With all of these settings to work with, letters can become a kind of art form in themselves! Being a designer by training, I knew whatever I created for this exploratory project would somehow involve digging into typography with Flutter. In the past few years, [variable fonts](https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts) have emerged as an intriguing way for designers to have unprecedented control over text styling. It’s an area I’ve been meaning to explore more, and with Flutter’s support for variable fonts, it seemed like the perfect opportunity.

You’re probably already familiar with fonts in general, which determine what each character in a block of text looks like. Normal fonts usually give us a few settings that we can choose from, for instance weight: bold, normal, or light. Variable fonts take that customization to the next level. In the case of weight, for instance, we might be able to pick any numerical setting between 100 (extremely light) and 1000 (extremely bold). And we aren’t limited only to weight; font creators can allow users to set all kinds of things, like the width of the letters, or depth of the descenders (how far lowercase letters like ‘p’ and ‘y’ drop down), and much more. Each of these different settings is called an “axis,” like the axes of a graph.

<DashImage figure src="images/0pO_MkjR1GrLhb8va.webp" alt="*The letter ‘g’ in the variable font Roboto Flex, with variations along the width axis (left to right) and weight axis (top to bottom). These are just two of its many axes in effect!*" caption="*The letter ‘g’ in the variable font Roboto Flex, with variations along the width axis (left to right) and weight axis (top to bottom). These are just two of its many axes in effect!*" />

Flutter offers a straightforward way to adjust these settings in the `TextStyle` widget, by using the `fontVariations` field. For example, the following code snippet would create a text style in the Roboto Flex variable font, at a size of 18, with variable axis settings for the weight (`wght`) and width (`wdth`):

```dart
TextStyle(
  fontFamily: 'RobotoFlex',
  fontSize: 18,
  fontVariations:[
    FontVariation('wght', 374),
    FontVariation('wdth', 118)
  ],
)
```

For more information on variable fonts, check out the [variable fonts resources](https://fonts.google.com/knowledge/topics/variable_fonts) on the Google Fonts site.

Setting the variations was easy enough, but then I wanted to animate from one variation setting to another, and between combinations of settings. Fortunately, Flutter and Dart made it easy to take two existing underlying features ([`FontVariation`](https://api.flutter.dev/flutter/dart-ui/FontVariation-class.html) and [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html)), and glue them together to make my own new custom motion typography effect.

For my demo, I made a `WonkyChar` widget and a `WonkyAnimPalette` helper class, which gave me a simple way to choose any letters to show on screen, control the text size, and feed in a mix of settings related to variable font axes. The `WonkyChar` widget also contained a standard Flutter `AnimationController` object, which I used to animate the settings. In this example, the letter ‘M’ will show at a size of 200, and animate its weight (boldness) from very thin to very bold, in a four-second animation:

```dart
WonkyChar(
  text: 'M',
  size: 200,
  animationDurationMillis: 4000,
  animationSettings: [
    WonkyAnimPalette.weight(
      from: 100,
      to: 900,
    ),
  ],
),
```

## Custom shaders

The effect of the variable fonts, especially with animation, was great, but I wanted to push my visual creativity even further and see what I could do with the letter shapes. Incidentally, I had heard that Flutter just added support for custom fragment shaders. Shaders are programs that run on the computer’s Graphics Processing Unit (GPU), allowing developers to create all kinds of visuals while maintaining high frame rates. Flutter supports writing shaders in GLSL, one of the most well-known and well-documented shader languages, with many tutorials and examples available in books, websites, YouTube videos, and massive open online courses (MOOCs). I’m definitely not an expert in shaders or graphics programming, but I’ve tinkered with them before, so this was another great opportunity to explore Flutter’s features while building my own skills.
> **Note**: Shaders are a fairly advanced coding topic, and the details about plugging them into your Flutter app are beyond the scope of this blog post. If you’d like to try writing some shaders yourself, check out [Writing and using fragment shaders](https://docs.flutter.dev/development/ui/advanced/shaders) in the Flutter docs. It’s a really fascinating approach to coding!

Initially, just to show one possibility, I wrote a simple GLSL shader to act like a filter on one of my `WonkyChar` widgets (described above), to create the following effect:

<DashImage figure src="images/0-N5jTlkJHFmEeb0e.webp" alt="*WonkyChar widget before and after applying the shader.*" caption="*WonkyChar widget before and after applying the shader.*" />

## Project description

These raw components — typography, variable font support, and shaders — were an interesting start, but they needed to actually come together in a coherent project. As a self-assignment to learn more about coding in Flutter and the Flutter community, I made a simple tile-based puzzle game, Type Jam, inspired by the [2022 Flutter Puzzle Hack](https://flutterhack.devpost.com/) competition. Brainstorming around these ideas in context of the puzzle hack prompt, I came up with the following concept: You, the player, have to help a beleaguered font company put a glitchy font file back together by solving a series of tile-based puzzles.

Each screen of the app features a puzzle consisting of scrambled pieces of a glitchy letter, surrounded by whole letters animating according to a variable font axis, like weight or width. The glitchy effect on the puzzle tiles is created by a different shader on each page, causing the tile pieces to look wavy, or fractured, etc. And, in a switch from the usual tile puzzle mechanics, I decided to have players solve puzzles by rotating tiles rather than sliding them, so that the entire letter could be viewed upon completion, with no empty slots. Looking back, this might have made the puzzles a little too easy, but maybe I can come up with more challenges for version 2.0!

<DashImage figure src="images/090hPGzJLj7qBZp7t.webp" alt="*Variable fonts plus shader effects (on the tiles pieces) applied in the puzzle game app. Letters on this screen animate on the “optical size” axis.*" caption="*Variable fonts plus shader effects (on the tiles pieces) applied in the puzzle game app. Letters on this screen animate on the “optical size” axis.*" />

If you’d like to see how it all came together, check out the [`varfont_shader_puzzle`](https://github.com/flutter/samples/tree/main/experimental/varfont_shader_puzzle) example for the Type Jam app in the [flutter/samples repo](https://github.com/flutter/samples), in the “experimental” folder. As I mentioned before, I’m still pretty new to Flutter, and I have just a basic working knowledge of shaders, so I’m looking forward to improving it going forward! For now, please think of it as a quick demo, rather than as a template.

## Conclusion

As a design-focused UX engineer, it was incredibly satisfying to combine my design and technical interests to create playful typography, and allow others to play with the letters, too. Plus, I saw for myself Flutter’s potential as a creative tool that can go beyond the typical patterns for app design. I had a great time making this project, and hope it inspires other designer–coders to try out their weird and fun ideas, and bring their designs to life as real apps!
