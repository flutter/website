---
title: Chat client sample
description: >
  Learn about the chat client sample included in the AI Toolkit.
prev:
  title: Custom LLM providers
  path: /ai-toolkit/custom-llm-providers
---

The AI Chat sample is meant to be a full-fledged chat app
built using the Flutter AI Toolkit and Vertex AI for Firebase.
In addition to all of the multi-shot, multi-media,
streaming features that it gets from the AI Toolkit,
the AI Chat sample shows how to store and manage
multiple chats at once in your own apps.
On desktop form-factors, the AI Chat sample looks like the following:

![Desktop app UI](/assets/images/docs/ai-toolkit/desktop-pluto-convo.png)


On mobile form-factors, it looks like this:

![Mobile app UI](/assets/images/docs/ai-toolkit/mobile-pluto-convo.png)

The chats are stored in an authenticated
Cloud Firestore database; any authenticated
user can have as many chats as they like.

In addition, for each new chat, while the user can
manually title it whatever they like,
the initial prompt and response is used to ask
the LLM what an appropriate title should be.
In fact, the titles of the chats in the
screenshots in this page were set automatically.

To build and run the sample,
follow the instructions in the [AI Chat README][].

{% comment %}
TODO: If Mit agrees, move this to an official Flutter repo
  Chris didn't want to do it so close to release
{% endcomment %}

[AI Chat README]: {{site.github}}/csells/flutter_ai_chat

