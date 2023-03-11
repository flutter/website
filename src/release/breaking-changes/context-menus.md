---
title: A new way to customize context menus
description: Several hard-coded parameters for customizing context menus have now been replaced by a generic widget builder.
---

{% comment %}
  PLEASE READ THESE GENERAL INSTRUCTIONS:
  * All lines of text should be 80 chars OR LESS.
    The writers strongly prefer semantic line breaks:
    https://github.com/dart-lang/site-shared/blob/main/doc/writing-for-dart-and-flutter-websites.md#semantic-line-breaks
  * DON'T SUBMIT a PR weeks and weeks in advance.
    Doing this causes it to get stanky in the website
    repo and usually develops conflicts in the index file.
    Ideally, submit a PR once you have confirmed
    info on the version number where the breaking
    change landed.
  * One of the most important things to fill out 
    in this template is the *Timeline* section.
    I won't approve/merge the PR until the "landed in"
    release info is provided. For example:
    `Landed in version: 1.21.0-5.0.pre<br>`.
    Do NOT list the PR in this section. Also, don't
    fill in the "stable" release info unless it's
    already in a published stable release.
    After a stable release, I go through and confirm
    that updates have made it to stable and I then
    update the breaking change and the index file.
  * The text in this page should be backwards looking,
    so write about previous behavior in past tense,
    not future tense. People are reading this months
    from now when the change is likely in the stable
    release, not today. Don't say "in a month" or
    talk about your plan to do something next week.
    Assume you've done it, and that they're looking
    back to figure out how to migrate their code.
  * Use sentence case for headings and titles.
    (`## Migration guide`, NOT `Migration Guide`)
  * DON'T use the abbreviation `i.e.` or `e.g.`.
    Use "for example" or "such as", and similar.
  * For links, use the macros where possible.
    See the examples at the end of this template,
    but don't use "github.com" or "api.flutter.dev" or
    "pub.dev" in your URLs. Use the {{site.github}},
    {{site.api}}, or {{site.pub}} macros.
  * AVOID "will" when possible, in other words,
    stay in the present tense. For example:
    Bad: "When encountering an xxx value,
          the code will throw an exception."
    Good: "When encountering an xxx value,
           the code throws an exception."
    Good use of "will": "In release 2.0, the xxx API
          will be deprecated."
  * Finally, delete the comment tags and text from the
    final PR.
{% endcomment %}

## Summary

Context menus, or text selection toolbars, are the menus that show up when long
pressing or right clicking on text in Flutter, and they show options like Cut,
Copy, Paste, and Select all. Previously, it was only possible to narrowly
customize them using ToolbarOptions and TextSelectionControls. Now, they have
been made composable using widgets, just like everything else in Flutter, and
the specific configuration parameters have been deprecated.

## Context

Previously, it was possible to disable buttons from the context menus using
TextSelectionControls, but any customization beyond that required copying and
editing hundreds of lines of custom classes in the framework. Now, all of this
has been replaced by a simple builder function, contextMenuBuilder, which allows
any Flutter widget to be used as a context menu.

## Description of change
Context menus are now built via the contextMenuBuilder parameter, which has been
added to all text-editing and text-selection widgets. If one is not provided,
then Flutter just sets it to a default that builds the correct context menu for
the given platform. All of these default widgets are exposed to users for
re-use. Customizing context menus now consists of using contextMenuBuilder to
return whatever widget you want, possibly including reusing the built-in context
menu widgets.

Here's an example that shows how to add a "Send email" button to the default
context menus whenever an email address is selected. The full code can be found
[here](https://github.com/flutter/samples/blob/main/experimental/context_menus/lib/email_button_page.dart).

```dart
TextField(
  contextMenuBuilder: (context, editableTextState) {
    final TextEditingValue value = editableTextState.textEditingValue;
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;
    if (isValidEmail(value.selection.textInside(value.text))) {
      buttonItems.insert(
          0,
          ContextMenuButtonItem(
            label: 'Send email',
            onPressed: () {
              ContextMenuController.removeAny();
              Navigator.of(context).push(_showDialog(context));
            },
          ));
    }
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: buttonItems,
    );
  },
)
```

A large number of examples of different custom context menus are available [in
the samples repo](https://github.com/flutter/samples/tree/main/experimental/context_menus).

All related deprecated features were flagged with the deprecation warning "Use
`contextMenuBuilder` instead."

## Migration guide

In general, any previous changes to context menus that have been deprecated now
require the use of the contextMenuBuilder parameter on the relevant text-editing
or text-selection widget (
[on TextField](https://master-api.flutter.dev/flutter/material/TextField/contextMenuBuilder.html),
for example). Return a built-in context menu widget like
[AdaptiveTextSelectionToolbar](https://master-api.flutter.dev/flutter/material/AdaptiveTextSelectionToolbar-class.html)
to use Flutter's built-in context menus, or return your own widget for something
totally custom.

To transition to contextMenuBuilder, the following parameters and classes have
been deprecated.

### [ToolbarOptions](https://master-api.flutter.dev/flutter/widgets/ToolbarOptions-class.html)
This class was previously used to explicitly enable or disable certain buttons
in a context menu. Now, you can achieve the same effect by adjusting the
buttonItems passed into AdaptiveTextSelectionToolbar.

For example, you could ensure that the Cut button never appears, but the other
buttons do appear as usual:

```dart
TextField(
  contextMenuBuilder: (context, editableTextState) {
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;
    buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
      return buttonItem.type == ContextMenuButtonType.cut;
    });
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: buttonItems,
    );
  },
)
```

Or, you could ensure that the Cut button appears exclusively and always:

```dart
TextField(
  contextMenuBuilder: (context, editableTextState) {
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: <ContextMenuButtonItem>[
        ContextMenuButtonItem(
          onPressed: () {
            editableTextState.cutSelection(SelectionChangedCause.toolbar);
          },
          type: ContextMenuButtonType.cut,
        ),
      ],
    );
  },
)
```

### [TextSelectionControls.canCut](https://master-api.flutter.dev/flutter/widgets/TextSelectionControls/canCut.html) and other button booleans
This previously had the same effect of enabling and disabling certain buttons as
ToolbarOptions.cut, etc. had. See the previous section on ToolbarOptions for how
to achieve a similar effect with contextMenuBuilder.

### [TextSelectionControls.handleCut](https://master-api.flutter.dev/flutter/widgets/TextSelectionControls/handleCut.html) and other button callbacks
This allowed the modification of the callback called when the buttons were
pressed.

// TODO(justinmc): An example of modifying the cut action here.

### [buildToolbar](https://master-api.flutter.dev/flutter/widgets/TextSelectionControls/buildToolbar.html)

// TODO(justinmc): An example of building a custom toolbar here.


// TODO(justinmc): Also include code before migration above. Also, mention that you don't need to extend/replace crazy classes anymore. Just use contextMenuBuilder.
Code before migration:

```dart
// Example of code before the change.
```

Code after migration:

```dart
// Example of code after the change.
```

## Timeline

{% comment %}
  The version # of the SDK where this change was
  introduced.  If there is a deprecation window,
  the version # to which we guarantee to maintain
  the old API. Use the following template:

  If a breaking change has been reverted in a
  subsequent release, move that item to the
  "Reverted" section of the index.md file.
  Also add the "Reverted in version" line,
  shown as optional below. Otherwise, delete
  that line.
{% endcomment %}

Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

{% comment %}
  These links are commented out because they
  cause the GitHubActions (GHA) linkcheck to fail.
  Remove the comment tags once you fill this in with
  real links. Only use the "master-api" include if
  you link to "master-api.flutter.dev".

{% include docs/master-api.md %}

API documentation:

* [`ClassName`][]

Relevant issues:

* [Issue xxxx][]
* [Issue yyyy][]

Relevant PRs:

* [PR title #1][]
* [PR title #2][]
{% endcomment %}

{% comment %}
  Add the links to the end of the file in alphabetical order.
  The following links are commented out because they make
  the GitHubActions (GHA) link checker believe they are broken links,
  but please remove the comment tags before you commit!

  If you are sharing new API that hasn't landed in
  the stable channel yet, use the master channel link.
  To link to docs on the master channel,
  include the following note and make sure that
  the URL includes the master link (as shown below).

  Here's an example of defining a stable (site.api) link
  and a master channel (master-api) link.

<!-- Stable channel link: -->
[`ClassName`]: {{site.api}}/flutter/[link_to_relevant_page].html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`ClassName`]: {{site.master-api}}/flutter/[link_to_relevant_page].html

[Issue xxxx]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[Issue yyyy]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[PR title #1]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
[PR title #2]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
{% endcomment %}
