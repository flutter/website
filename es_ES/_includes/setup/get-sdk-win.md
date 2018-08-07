## Obtener el SDK de Flutter

1. Descarga el siguiente paquete de instalación para obtener la versión beta mas reciente de 
Flutter SDK (para otros lanzamientos, y paquetes viejos, véase la pagina [archivo 
SDK](/sdk-archive/)):
    * [(cargando...)](#){:.download-latest-link-windows}
1. Extraiga el archivo zip y coloque el contenido de `flutter` en la locación
   deseada de instalación para el Flutter SDK (ej. `C:\src\flutter`; no instale
   flutter en un directorio como `C:\Program Files\` que requiere permisos de administrador).
1. Localice el archivo `flutter_console.bat` dentro del directorio de `flutter`. Inicíelo con doble clic.

Ahora está todo listo para ejecutar los comando de Flutter en la consola de Flutter!

Para actualizar una versión existente de Flutter, vea [Actualizando Flutter](/upgrading/).

### Actualizando tu "path"

Si desea ejecutar los comandos de Flutter en un ventana de comandos regular de Windows, siga
estos pasos y agregue Flutter a las variables de ambiente en el PATH:

* Entra a "Panel de Control > Cuentas de usuario > Cuentas de usuario > Cambiar mis variables de entorno"
* Debajo de "Variables de usuario" verifica si existe una entrada llamada "Path":
    * Si el directorio de Flutter no existe, agrega el directorio completo `flutter\bin` usando `;`
      como separador de los valores existentes.
    * Si la entrada `Path` no existe, crea una nueva variable llamada `Path` con el 
      directorio completo a `flutter\bin` como su valor.

Reinicia Windows para aplicar los cambios completamente.

### Ejecutar Flutter doctor

En la consola de Flutter, ejecuta el siguiente comando para
ver si existe alguna dependencia que necesite instalar para completar la configuración:

{% commandline %}
flutter doctor
{% endcommandline %}

Este comando verifica tu entorno y muestra un reporte en la terminal de windows.
El SDK de Dart esta empaquetado con Flutter, no es necesario instalar Dart por separado.
Verifica la salida con cuidado para otros programas que pudieras necesitar o para 
desempeñar otras tareas mas adelante (mostradas en texto en **negrita**).

Por Ejemplo:
<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

La siguiente sección describe como desempeñar estas tareas y finalizar el proceso de configuración.

Una vez que tenga instalado cualquiera de las dependencias faltantes, ejecute el comando `flutter doctor`
de nuevo para verificar que todo se ha configurado correctamente.

Las herramientas de Flutter usan Google Analytics para, anónimamente, reportar estadística de 
características de uso y reportes básicos de fallas. Estos datos son utilizados para ayudar 
a mejorar las herramientas de flutter con el tiempo.
Analytics no enviá cada ejecución o cualquier ejecución dentro del `flutter config`,
por lo que puede optar por no participar en los análisis antes de enviar los datos. 
Para deshabilitar los reportes, teclee `flutter config --no-analytics` y para desplegar la
configuración actual, teclee `flutter config`. 
Vea la política de privacidad de Google: [www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).
{: .alert-warning}
