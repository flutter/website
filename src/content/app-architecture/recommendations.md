---
title: Architecture recommendations and resources
short-title: Architecture recommendations
description: >
  Recommendations for building scalable Flutter applications.
# TODO(ewindmill): add prev in PR with "case study" 
---

This page presents architecture best practices, why they matter, 
and whether we recommend them for your Flutter application. 
You should treat these recommendations as recommendations, 
and not steadfast rules, and you should adapt them to your app's unique requirements.

The best practices on this page have a priority, 
which reflects how strongly the Flutter team recommends it.

* **Strongly recommend:** You should always implement this recommendation if
  you're starting to build a new application. You should strongly consider
  refactoring an existing app to implement this practice unless doing so would
  fundamentally clash with your current approach.
* **Recommend**: This practice will likely improve your app.
* **Conditional**: This practice can improve your app in certain circumstances.

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
            <br>
            {{rec.confidence-description}}</td>
        </tr> 
        {% endfor %}
    </table>
    <br>
{% endfor %}

[Separation-of-concerns]: https://en.wikipedia.org/wiki/Separation_of_concerns
[architecture case study]: /app-architecture/guide
[our ChangeNotifier recommendation]: https://docs.flutter.dev/get-started/fwe/state-management
[other popular options]: https://docs.flutter.dev/data-and-backend/state-mgmt/options
[freezed]: https://pub.dev/packages/freezed
[built_value]: https://pub.dev/packages/built_value
[Flutter Navigator API]: https://docs.flutter.dev/ui/navigation
[pub.dev]: https://pub.dev
