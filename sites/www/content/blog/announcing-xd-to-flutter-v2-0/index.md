---
title: "Announcing XD to Flutter v2.0!"
description: "Giving designers a fast path to production Flutter code"
publishDate: 2021-04-29
author: gskinner
image: images/1OoVDCYfw18QB91Fpe5jDAg.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1OoVDCYfw18QB91Fpe5jDAg.webp" />


Flutter is Google’s open-source UI toolkit for building beautiful apps for mobile, desktop, web, and embedded devices from a single codebase. Over the last couple of years, it has become the leading choice for developers who want to build apps for multiple platforms; but designers need a visual tool for prototyping and creating Flutter UI, rather than handcrafting Dart source code. Enter [*XD to Flutter*](https://github.com/AdobeXD/xd-to-flutter-plugin)!

It’s been almost a year since the first preview release of the plugin, and we’ve continued to refine and improve it with a handful of minor updates, a major v1.0 launch last summer, and now a v2.0 release to match with the launch of Flutter 2!

## Wait, what is XD to Flutter?

The name probably gives it away, but the XD to Flutter plugin is a powerful, easy-to-use tool to export your stunning [Adobe XD](https://www.adobe.com/products/xd.html) designs into clean, functional code for Flutter. You can copy code for specific visual elements from your design, export reusable widgets, or even entire views.

<YoutubeEmbed id="raG7NjM0p0k" title="Adobe XD to Flutter" fullwidth="true"/>


That means that, with the XD to Flutter plugin, you can get your designs running on virtually any device with the click of a button. It’s not going to code your whole app for you, but it’ll give you a head start.

XD to Flutter is built by [gskinner](https://gskinner.com/) in partnership with Adobe, and is published as a plugin for Adobe XD itself, so you can use it with any existing Adobe XD design you’re building.

## Awesome! So what’s new?

The initial release of XD to Flutter had great support for outputting all the different visual elements in a design — vector graphics, images, rich text, background blurs, blend modes, shadows, and similar — but the result could be static and inflexible.

While it was handy for grabbing an icon or text style, we wanted it to do more! XD empowers designers to create dynamic UIs, with tools like responsive layout, scrollable areas, stacks, and grids; we want the plugin to support every one of those capabilities, and with v2.0 we’ve made a lot of progress.

### Responsive Resize

XD to Flutter supports the responsive layout features of XD, which lets you “pin” elements within their enclosing parent and precisely control how they resize.

<DashImage figure src="images/1Ep_TKKdQqNDhNGtYjXSmzQ.webp" alt="Responsive design in Adobe XD" caption="Responsive design in Adobe XD" />


<DashImage figure src="images/1A6Kateq9HjSt3XADTQzaow.webp" alt="Responsive resize in Flutter" caption="Responsive resize in Flutter" />


This is achieved in Flutter by using a custom `Pinned` layout widget in the open-source [adobe_xd](https://pub.dev/packages/adobe_xd) package that developers can leverage directly in their projects.

<DashImage figure src="images/1F_lxL7fE3-MkjobRiJLqpA.webp" alt="Pinned widget code example" caption="Pinned widget code example" />


### Stacks & Scroll Groups

“Stacks” and Scroll Groups provide new ways to lay out content on-screen dynamically in Adobe XD. Stacks in XD let you arrange a bunch of different elements in a horizontal or vertical list, with varying spacing between them; they are more similar to a `Flex` widget in Flutter than their namesake `Stack` widget.

Scroll Groups predictably let you define an area to scroll a larger group of content vertically or horizontally, right inside your design.

XD to Flutter v2.0 supports both of these features, converting them into common Flutter widgets (`Column`, `Row`, and `SingleChildScrollView`). You can even put a stack into a scroll group to easily create a scrolling list of items.

<DashImage figure src="images/1avGeBrHwEcAyptu0aKyc4w.webp" alt="Stacks & Scroll Groups in XD (left) and Flutter (right)" caption="Stacks & Scroll Groups in XD (left) and Flutter (right)" />


### Padding & Background Elements

Another new feature is background elements, which let you designate a visual element as the background for a group. This can be paired with padding to space the background’s edges from the content.

The Flutter export uses a `Stack` widget to layer the background element behind the content, which is placed into a `Padding` widget.

<DashImage figure src="images/1-nUSSGKplXOzmySlrEUwXg.webp" alt="Padding & Background in XD (left) and Flutter (right)" caption="Padding & Background in XD (left) and Flutter (right)" />


### Flutter 2 & null safety

The layout features described above enable much more responsive UI, complimenting Flutter 2’s increased support for form factors like desktop and web.

Flutter 2 also introduces sound null safety — a language feature that helps developers catch nullability issues before they cause problems in apps. XD to Flutter v2.0 includes a new setting to “Export Null Safe Code”, ensuring that the generated code is future-ready.

<DashImage figure src="images/14Gdqc7x5Vk85t47tQIocmw.webp" alt="“Export Null Safe Code” setting and output" caption="“Export Null Safe Code” setting and output" />


### Sounds great! How do I get started?

Whether you’re using it to copy the code for a tricky gradient, or to export fully responsive, parameterized, interactive widgets, it’s simple to join the thousands of creative professionals that are already using the XD to Flutter plugin.

You can install it by selecting “Browse Plugins…” from Adobe XD’s “Plugin” menu and searching for “Flutter” (strangely, searching for “XD to Flutter” doesn’t work), or just visit [adobe.com/go/xd_to_flutter](https://adobe.com/go/xd_to_flutter).

<DashImage figure src="images/1aSDHtLA_ZQyiyXX3y9j2Ng.webp" />


Once you have it installed, open the XD to Flutter panel from the plugins panel, and tap the “Need help?” link to check out the [plugin documentation](https://github.com/AdobeXD/xd-to-flutter-plugin/blob/master/README.md).

Flutter 2 is an exciting step forward for the framework, with a focus on building beautiful apps that run virtually anywhere. At [gskinner](https://gskinner.com/), we’re thrilled to be working with Adobe and Google to ensure that XD to Flutter continues to make the process of faithfully translating a delightful design to a working product even easier.

Stay tuned for more exciting updates to the plugin soon!