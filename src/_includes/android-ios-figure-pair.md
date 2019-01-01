{% comment %}
Sadly, Jekyll doesn't seem to supported nested includes, so the following won't work:

  {% include app-figure.md image="{{include.image}}" platform="Android" %}
  {% include app-figure.md image="{{include.image}}" platform="iOS" %}

{% endcomment -%}

<figure class="site-figure">
  <div class="site-figure-container">
      {% asset 'get-started/android/{{include.image}}'
          alt='{{include.alt}} on Android'
          class='{{include.class}}' %}
      <figcaption class="figure-caption">Android</figcaption>
  </div>
  <div class="site-figure-container">
      {% asset 'get-started/ios/{{include.image}}'
          alt='{{include.alt}} on iOS'
          class='{{include.class}}' %}
      <figcaption class="figure-caption">iOS</figcaption>
  </div>
</figure>
