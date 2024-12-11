---
title: Architecture recommendations and resources
short-title: Architecture recommendations
description: >
  Recommendations for building scalable Flutter applications.
prev:
  title: Architecture case study
  path: /app-architecture/case-study
next:
  title: Design patterns
  path: /app-architecture/design-patterns
---

This page presents architecture best practices, why they matter, and
whether we recommend them for your Flutter application.
You should treat these recommendations as recommendations,
and not steadfast rules, and you should
adapt them to your app's unique requirements.

The best practices on this page have a priority,
which reflects how strongly the Flutter team recommends it.

* **Strongly recommend:** You should always implement this recommendation if
  you're starting to build a new application. You should strongly consider
  refactoring an existing app to implement this practice unless doing so would
  fundamentally clash with your current approach.
* **Recommend**: This practice will likely improve your app.
* **Conditional**: This practice can improve your app in certain circumstances.
<br /><br />

{% for section in architecture_recommendations %}
<h2>{{section.category}}</h2>
<p>{{section.description}}</p>
<table class="table table-striped" style="border-bottom:1px #DADCE0 solid">
    <tr class="tr-main-head">
      <th style="width: 30%">Recommendation</th>
      <th style="width: 70%">Description</th>
    </tr>
    {% for rec in section.recommendations %}
    <tr>
      <td>
        <p>{{rec.recommendation}}</p>
        {% if rec.confidence == "strong" %}
            <div class="rrec-pill success">Strongly recommend</div>
        {% elsif rec.confidence == "recommend" %}
            <div class="rrec-pill info">Recommend</div>
        {% else %}
            <div class="rrec-pill">Conditional</div>
        {% endif %}
      </td>
      <td>
        {{rec.description}}
        <br />
        {{rec.confidence-description}}</td>
    </tr>    {% endfor %}
</table>
<br />
{% endfor %}

## Recommended resources

* Code and templates
  * [Compass app source code][] -
    Source code of a full-featured, robust Flutter application that
    implements many of these recommendations.
  * [Flutter skeleton][] -
    A Flutter application template that includes many of these recommendations.
  * [very_good_cli][] -
    A Flutter application template made by
    the Flutter experts Very Good Ventures.
    This template generates a similar app structure.
* Documentation
  * [Very Good Engineering architecture documentation][] -
    Very Good Engineering is a documentation site by VGV that has
    technical articles, demos, and open-sourced projects.
    It includes documentation on architecting Flutter applications.
  * [State Management with ChangeNotifier walkthrough][] -
    A gentle introduction into using the primitives in
    the Flutter SDK for your state management.
* Tooling
  * [Flutter developer tools][] -
    DevTools is a suite of performance and debugging tools for Dart and Flutter.
  * [flutter_lints][] -
    A package that contains the lints for
    Flutter apps recommended by the Flutter team.
    Use this package to encourage good coding practices across a team.


[Separation-of-concerns]: https://en.wikipedia.org/wiki/Separation_of_concerns
[architecture case study]: /app-architecture/guide
[our ChangeNotifier recommendation]: /get-started/fwe/state-management
[other popular options]: https://docs.flutter.dev/data-and-backend/state-mgmt/options
[freezed]: https://pub.dev/packages/freezed
[built_value]: https://pub.dev/packages/built_value
[Flutter Navigator API]: https://docs.flutter.dev/ui/navigation
[pub.dev]: https://pub.dev
[Compass app source code]: https://github.com/flutter/samples/tree/main/compass_app
[Flutter skeleton]: https://github.com/flutter/flutter/blob/master/packages/flutter_tools/templates/skeleton/README.md.tmpl
[very_good_cli]: https://cli.vgv.dev/
[Very Good Engineering architecture documentation]: https://engineering.verygood.ventures/architecture/
[State Management with ChangeNotifier walkthrough]: /get-started/fwe/state-management
[Flutter developer tools]: /tools/devtools
[flutter_lints]: https://pub.dev/packages/flutter_lints

## Feedback

As this section of the website is evolving,
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_4T0XuR9Ts29acw6?page="recommendations"
