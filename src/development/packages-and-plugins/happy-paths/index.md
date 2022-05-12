---
title: Happy paths project
description: The Happy paths page lists areas of technology where we recommend specific Flutter packages and plugins that add functionality to your app.
---

![Header image for Happy Paths](/assets/images/docs/happy-paths/HappyPaths_HeaderImage_Cropped.png){:width="30%"}

Once you’ve learned Flutter basics and are ready to move on to developing more 
advanced apps, how do you make that leap? The [pub.dev][] website 
lists thousands of packages and plugins for Dart and Flutter.

So how do you choose?  
  
Perhaps you suffer from [analysis paralysis][].

[analysis paralysis]: https://www.investopedia.com/terms/a/analysisparalysis.asp#:~:text=Analysis%20paralysis%20is%20an%20inability,an%20inability%20to%20pick%20one
[pub.dev]: {{site.pub}}
  
The Happy paths project is here to help.
We’ve created Happy paths recommendations to help 
you make informed decisions on how to add various types of functionality 
to your app. There are _many_ packages that can help you achieve your goals, 
but we wanted to provide some guidance for newer Flutter developers as you ramp 
up to building larger and more complex apps. Keep in mind that these are not 
the _only_ paths that you can choose, but are solutions that we can recommend.  
  
In future, we plan to add more happy path recommendations
for different areas of functionality. If there’s a specific
happy path recommendation that you would like to see, 
please [file an issue][] to let us know.  
   
[file an issue]: {{site.github}}/flutter/website/issues/new/choose


{% for card in site.data.happy_paths_cards -%}
  {% capture index0Modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}
  {% capture indexModulo3 %}{{ forloop.index | modulo:3 }}{% endcapture %}
  {% if index0Modulo3 == '0' %}
  <div class="card-deck mb-4">
  {% endif %}
    <a class="card" href="{{card.url}}">
      <div class="card-body">
        <div class="happy-paths-image-holder">
          <img src="{{card.image}}" alt="Happy Path logo">
        </div>
        <header class="card-title">{{card.name}}</header>
        <p class="card-text">{{card.description}}</p>
      </div>
    </a>
  {% if indexModulo3 == '0' %}
  </div>
  {% endif %}
{% endfor -%}

