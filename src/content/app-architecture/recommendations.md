---
title: Architecture recommendations and resources
short-title: Architecture recommendations
description: >
  Recommendations for building scalable Flutter applications.
# TODO(ewindmill): add prev in PR with "case study" 
---

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
          <td>{{rec.description}}<br>{{rec.confidence-description}}</td>
        </tr> 
        {% endfor %}
    </table>
    <br>
{% endfor %}


[architecture case study]: /app-architecture/guide
[our ChangeNotifier recommendation]: https://docs.flutter.dev/get-started/fwe/state-management
[other popular options]: https://docs.flutter.dev/data-and-backend/state-mgmt/options
[freezed]: https://pub.dev/packages/freezed
[built_value]: https://pub.dev/packages/built_value
[Flutter Navigator API]: https://docs.flutter.dev/ui/navigation
[pub.dev]: https://pub.dev