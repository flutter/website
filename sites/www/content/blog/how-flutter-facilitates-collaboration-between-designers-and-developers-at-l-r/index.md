---
title: "How Flutter facilitates collaboration between designers and developers at L+R"
description: "You might be familiar with Global Citizen (GC), an organization dedicated to ending world poverty and helping the planet. When GC wanted to…"
publishDate: 2024-02-19
author: ivan
image: images/0dv6mhmjDb4HP59LA.webp
category: spotlight
layout: blog
---

You might be familiar with [Global Citizen](https://www.globalcitizen.org/en/) (GC), an organization dedicated to ending world poverty and helping the planet. When GC wanted to rewrite a mobile app to help with this effort, they reached out to our studio, [L+R](https://levinriegner.com/home), to collaborate on designing, building, and launching the app simultaneously on Android and iOS.

Flutter’s flexibility, pre-built widget catalog, and robust animation capabilities allowed the L+R team to implement a design-led development process. When using Flutter, our developers have a blank canvas to bring custom designs to life. For L+R, this means our design teams can unleash their creativity to create user-centric apps that look and feel great.

Here are a few screenshots from the Global Citizen app:

<DashImage figure src="images/0wuezwMGAnC91NBTJ.webp" />


<DashImage figure src="images/0dv6mhmjDb4HP59LA.webp" />


<DashImage figure src="images/0KD5yX1QHIghjtf78.webp" />


**The design process**

When starting a new client project, the designers first create a design system in Figma. This consists of brand guidelines — like color palettes and typography — and small reusable components.

When starting on the Global Citizen app rewrite, the design team expanded upon the existing guidelines to provide a fresh look with higher-contrast elements. Not only does this help to direct the user’s attention but it also improves accessibility.

<DashImage figure src="images/0DwbyxOv8yHSp1aFb.webp" />


UI elements are created as *components* in Figma. Each component may have different *variants* depending on component type or state. For example, the following diagram shows several button variants:

<DashImage figure src="images/0JXYimUKJxblL6LYA.webp" />


When developing new components, the design team referenced the Material and iOS design kits in Figma for inspiration. This helps with translating the design to code as these Figma components closely correspond to widgets available in the Material and Cupertino libraries.

Throughout the design process, the team composed the small, reusable components to form larger feature-specific components that were then combined into entire pages. This empowered Global Citizen’s product team to expand the app with new functionality while remaining true and consistent with the original vision.

**Project template**

At L+R, our team has been working with Flutter since its first public release. To make building Flutter apps fast and easy for our team, we’ve created an [open-source repository](https://github.com/levin-riegner/flutter-template) that serves as a project template and provides the cornerstone for all Flutter apps that we build.

This barebones project contains a set of widgets that can be customized and used in our client’s applications. For example, the buttons represented in the Figma design file (shown above) can be built using the `_BaseButton` class from the project template. This class accepts different colors, text styles, and padding to best match the design system set for that project.

<DashImage figure src="images/0ApRsUADr-G3HYMzY.webp" />


,

To make it easy to style these components based on the brand guidelines, we use the `ThemeData` class. Developers take the color schemes and text styles from Figma and map them to the corresponding theme properties.

<DashImage figure src="images/0DOvyVLAckVSQqoax.webp" />


Our team leveraged the existing properties in `ThemeData` as much as possible, and then used the `ThemeExtension` functionality to complete the remaining configurations.

**Flutter’s widget library**

As mentioned above, the project template contains a set of reusable widgets. When developing these, we try to use pre-existing widgets from the Material and Cupertino libraries as much as possible. In the Global Citizen app, about half of the components descend from Material or Cupertino widgets.

For example, the `TextField` and `TextFormField` widgets from Material contained all the necessary customizations and functionality needed to match the designs. The `TextButton` from Material was also used to implement the `_BaseButton` widget. In this case, we took advantage of `TextButton`’s existing highlight functionality, but we wrapped it into a new widget with extended functionality to better suit our needs.

<DashImage figure src="images/0BrVLb8vUnOxCenlR.webp" />


Having these out-of-the-box UI components that can easily be styled makes it easier to build and maintain our widgets. However, sometimes our designers create custom components that can’t be recreated using Flutter’s Material or Cupertino widgets. In these cases, the development team creates our own custom widgets from low-level Flutter widgets.

One example from the Global Citizen app was progress indicators. For this app, our designers created a custom progress indicator as shown in the following GIF. The existing Material and Cupertino progress indicators didn’t work for this design. However, it was easy for our developers to create an entirely new widget using only containers, rows, and columns with intrinsic animations.

<DashImage figure src="images/0FSZ6UZM2gdxag6tr.webp" />


<DashImage figure src="images/0ecO_ptzWhoeP60fp.webp" />


Community libraries were also incredibly useful for more complex and flexible components. For example we used a community- built [`flushbar`](https://pub.dev/packages/another_flushbar) to display alert notifications inside the Global Citizen app.

<DashImage figure src="images/0vMiJl709u8ABpUE3.webp" />


**Hot reload**

When translating the Figma design to Flutter code, it’s important for designers and developers to collaborate. Designers often have feedback that results in small tweaks to styles, layouts, or animations. Hot reload made this collaboration much more efficient.

With hot reload, developers can tweak the code while screen-sharing with the design team (either during the UX phase, UI concept phase, front-end implementation stage, or even the design-QA stage). While screen sharing, the designer can instantly see the results of changes. This makes debugging and iteration much faster.

**Smooth animations**

One thing that helps an app feel polished is adding thoughtful animations. Flutter’s animation framework is flexible and powerful, however it can be difficult for designers to understand. One thing that helped our team was to reference beautiful animations in open source apps. Specifically, we looked at the codebase for the [Wonderous ap](http://wonderous.app)p. We’ve since leveraged the open-source library, [`flutter_animate`](https://pub.dev/packages/flutter_animate), that powers Wonderous to add simple yet enriching animations to key functionalities.

The video in the following link highlights part of the “Take Action” flow, where the user navigates through a series of informative screens to learn more about the issue.

Check out the [action_learn_animations](https://drive.google.com/file/d/1OmILf7hZZHbnWbaC6BN-EopYDmQtEOmp/view) video.

Using flutter_animate, we were able to do the following:

* Animate the step indicator as the user moves forward

* Add a slight fade transition between pages

* Transform the **Play Video** button into a success checkmark after viewing the video

Overall, Flutter allows a flexible approach to design and development. Flutter’s pre-built widgets make it easier to create reusable UI components that can be styled to match a customer’s branding. The Flutter community plays an important role in how the technology matures, offering high quality libraries and expanding the available resources. Key Flutter features like hot reload supports better collaboration between designers and developers. All of these put together result in an app that is both beautiful and functional!

For more information about the app, check out [The New Global Citizen App: Daily Activism & Measurable Impact in Your Pocket](https://www.globalcitizen.org/en/content/new-global-citizen-app-impact-activism-every-day/). You can also [download the Global Citizen app](https://www.globalcitizen.org/en/app/download/) to your mobile device.

[L+R](https://levinriegner.com/home) is an international strategy, design, and mobile technology studio. We offer many services like UX design, mobile development and strategy consulting.