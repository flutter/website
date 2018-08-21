## Configuración de Android 

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Nota:**
Flutter requiere de una completa instalación de Android Studio para proveer
las dependencias de la plataforma de Android. De cualquier manera, puede desarrollar sus
apps de Flutter en diferentes editores; hablaremos de ello en un paso siguiente.
</aside>


### Instalar Android Studio

1. Descarga e instala [Android Studio](https://developer.android.com/studio/index.html).

1. Inicia Android Studio, y sigue todo el 'Android Studio Setup Wizard'. Este
Instalará la versión más reciente de Android SDK, Android SDK Platform-Tools y 
Android SDK Build-Tools, Las cuales son requeridas por Flutter cuando se desarrolla para Android.

### Configurar tu dispositivo Android

Prepare la ejecución y pruebas de app de Flutter en un dispositivo de Android, necesitará
un dispositivo Android ejecutando Android 4.1 (API nivel 16) o superior.

1. Habilita **Opciones de desarrollador** y **Depurador por USB** en tu dispositivo. Instrucciones detalladas
 están disponibles en la [Documentación de Android](https://developer.android.com/studio/debug/dev-options.html).
1. Solo en Windows: Instala [Google USB Driver](https://developer.android.com/studio/run/win-usb)
1. Utilizando el cable USB, conecta tu móvil de la computadora, de requerirse en tu dispositivo, autoriza el acceso de la computadora a tu dispositivo.
1. En terminal, ejecuta el comando `flutter devices`  para verificar que Flutter ha reconocido 
tu dispositivo Android conectado.

Por defecto, Flutter utiliza la versión SDK de Android donde se encuentren las herramientas `adb`. Si
quieres que Flutter utilice alguna instalación diferente de el SDK de Android, deberás configurar
la variable de entorno `ANDROID_HOME` en el directorio de instalación.

### Configurar el emulador de Android

Prepare la ejecución y pruebas de app de Flutter en el emulador de Android, siguiendo estos pasos:

1. Habilite [VM acceleration](https://developer.android.com/studio/run/emulator-acceleration.html) en su equipo.
1. Abra **Android Studio>Tools>Android>AVD Manager** y seleccione
**Create Virtual Device**. (El submenú **Android** está presente solo
cuando se encuentra dentro de un proyecto de Android.)
1. Elija un dispositivo y seleccione **Next**.
1. Seleccione una o mas imágenes del sistema que quiera emular,
   y seleccione **Next**. Una imagen _x86_ o _x86\_64_ es recomendada.
1. Dentro de Emulated Performance, seleccione **Hardware - GLES 2.0** para habilitarlo
[aceleración de hardware](https://developer.android.com/studio/run/emulator-acceleration.html).
1. Verifique que la configuración de AVD es correcta, y seleccione **Finish**.

   Para mayor detalle de los pasos de arriba, vea [Administrando AVDs](https://developer.android.com/studio/run/managing-avds.html).
1. En el Administrador de Dispositivos Virtuales de Android (AVD) , de clic en la barra de herramienta **Run**.
   El emulador iniciara el arranque y mostrara el lienzo (canvas) por defecto para la versión del SO y dispositivo seleccionado.
