## Obtener el SDK de Flutter {#get-sdk}

1. Descarga el siguiente paquete de instalación para obtener la versión beta más reciente de 
Flutter SDK (para otros lanzamientos, y paquetes viejos, véase la pagina [archivo 
SDK](/sdk-archive/) page.):
{% if page.url contains "linux" %}
    * [(cargando...)](#){:.download-latest-link-linux}
{% else %}
    * [(cargando...)](#){:.download-latest-link-macos}
{% endif %}<br><br>
1. Extraer el archivo en la locación deseada, ej.:
    {% commandline %}
    cd ~/development
{% if page.url contains "linux" %}
    tar xf ~/Downloads/<span class="download-latest-link-filename-linux">flutter_linux_xxx.tar.xz</span>
{% else %}
    unzip ~/Downloads/<span class="download-latest-link-filename-macos">flutter_macos_xxx.zip</span>
{% endif %}
    {% endcommandline %}

1. Agrega la herramienta `flutter` a tu "path":
    {% commandline %}
    export PATH=`pwd`/flutter/bin:$PATH
    {% endcommandline %}

El comando de arriba configurara el PATH en la variable temporal, para la ventana actual de terminal. para
agregar de manera permanente Flutter a tu "path", vea [Actualiza el path](#update-your-path).

Ahora esta todo listo para ejecutar los comando de Flutter en la consola de Flutter!

Para actualizar una versión existente de Flutter, vea [Actualizando Flutter](/upgrading/).

### Ejecutar Flutter doctor

Ejecuta el siguiente comando para verificar si existe alguna dependencia que se necesite para
completar la configuración:

{% commandline %}
flutter doctor
{% endcommandline %}

Este comando verifica tu ambiente y muestra un reporte en la terminal de windows.
El SDK de Dart esta empaquetado con Flutter, no es necesario instalar Dart por separado.
Verifica la salida con cuidad para otros programas que pudieras necesitar o para 
desempeñar otras tareas mas adelante (mostradas en texto en **negrita**).

Por ejemplo:
<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

La siguiente sección describe cómo desempeñar estas tareas y finalizar el proceso de configuración.

Una vez que tenga instalado cualquiera de las dependencias faltantes, ejecute el comando `flutter doctor`
de nuevo para verificar que todo se ha configurado correctamente.

Las herramientas de Flutter usan Google Analytics para anónimamente reportar estadística de 
características de uso y reportes básicos de fallas. Estos datos son utilizados para ayudar 
a mejorar las herramientas de flutter con el tiempo.
Analytics no envía cada ejecución o cualquier ejecución dentro del `flutter config`,
por lo que puede optar por no participar en los análisis antes de enviar los datos. 
Para deshabilitar los reportes, teclee `flutter config --no-analytics` y para desplegar la
configuración actual, teclee `flutter config`. 
Vea la política de privacidad de Google: [www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).
{: .alert-warning}
