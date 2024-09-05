
{% assign id =  include.os | downcase -%}

1. Configure a proxy.
   To configure a proxy, check out the
   [Dart documentation on proxies]({{site.dart-site}}/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall).

  {% comment %}
  From <https://github.com/flutter/website/issues/2556#issuecomment-481566476>
  {% endcomment %}

1. Verify that your `PUB_HOSTED_URL` environment variable is either unset
   or empty.

   {% if id == 'windows' -%}

   ```console
   {{prompt}} echo $env:PUB_HOSTED_URL
   ```

   If this command returns any value, unset it.

   ```console
   {{prompt}} Remove-Item $env:PUB_HOSTED_URL
   ```

   {% else -%}

   ```console
   {{prompt}} echo $PUB_HOSTED_URL
   ```

   If this command returns any value, unset it.

   ```console
   {{prompt}} unset $PUB_HOSTED_URL
   ```

   {% endif %}
