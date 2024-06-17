### Link and Embed frameworks in Xcode {:#method-b .no_toc}

#### Approach {:#method-b-approach}

In this second method, edit your existing Xcode project,
generate the necessary frameworks, and embed them in your app.
Flutter generates iOS frameworks for Flutter itself,
for your compiled Dart code, and for each of your Flutter plugins.
Embed these frameworks and update your existing application's build settings.

#### Requirements {:#method-b-reqs}

No additional software or hardware requirements are needed for this method.
Use this method in the following use cases:

* Members of your team can't install the Flutter SDK and CocoaPods
* You don't want to use CocoaPods as a dependency manager in existing iOS apps

#### Limitations {:#method-b-limits}

{% render docs/add-to-app/ios-project/limits-common-deps.md %}

#### Example project structure {:#method-b-structure}

{% render docs/add-to-app/ios-project/embed-framework-directory-tree.md %}

#### Procedures

How you link, embed, or both the generated frameworks
into your existing app in Xcode depends on the type of framework.

* Link and embed dynamic frameworks.
* Link static frameworks. [Never embed them][static-framework].

{% render docs/add-to-app/ios-project/link-and-embed.md %}

[static-framework]: https://developer.apple.com/library/archive/technotes/tn2435/_index.html
