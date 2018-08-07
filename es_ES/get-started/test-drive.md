---
layout: page
title: "Empezar: Prueba Inicial"
permalink: /get-started/test-drive/
---

Esta página describe como hacer tu prueba inicial en Flutter: crear una nueva app de Flutter 
con nuestras plantillas, ejecutarla, y aprender cómo hacer cambios con "Hot Reload".

Flutter es un juego de herramientas flexible, por favor empieza por seleccionar tu herramienta
de desarrollo favorita para escribir, crear y ejecutar tus apps de Flutter.

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
    <li class="tab-link" data-tab="tab-install-terminal">Terminal + editor</li>
</ul>

<div id="tab-install-androidstudio" class="tabs__content current" markdown="1">

*Android Studio:* Un experiencia completa e integrada del IDE para Flutter. 

## Crear una app nueva {#create-app}

   1. Seleccionar **File > New Flutter Project**
   1. Seleccionar **Flutter application** como tipo de proyecto, y presionar siguiente
   1. Introducir nombre de proyecto (ej. `myapp`), y presionar siguiente
   1. Clic en **Finish**
   1. Espera mientras Android Studio instala el SDK, y crear el proyecto.

Los comandos de arriba crean un directorio para el proyecto llamado `myapp`
el cual contiene una app demo sencilla
que utiliza [Material Components](https://material.io/guidelines/).

Dentro del directorio del proyecto, el código de tu app, esta en `lib/main.dart`.

## Ejecutar app

   1. Localiza la barra de herramientas principal de Android Studio:<br>
      ![Main IntelliJ toolbar](/images/intellij/main-toolbar.png)
   1. En el **target selector**, selecciona un dispositivo android para ejecutar la app.
      Si ninguno esta en la lista como disponible, selecciona **Tools> Android > AVD Manager** y
      crea uno ahí mismo. Para mas detalle, vea [Administrando
      AVDs](https://developer.android.com/studio/run/managing-avds.html).
   1. Clic en el **Run icon** en la barra de herramientas, seleccionar **Run >
      Run** del menú.
   1. Si todo funciona, deberás de ver iniciar tu app en el dispositivo o 
      simulador:<br>
      ![App iniciada en Android](/images/flutter-starter-app-android.png)

## Probando hot reload

Flutter ofrece un ciclo de desarrollo rápido con _hot reaload_, la habilidad de recargar 
el código en una app ejecutando en vivo sin reiniciar o perder el estado de la app. simplemente
hace un cambio a tu código fuente, diciéndole a tu IDE o herramienta de linea de comandos que
quieres recargar, y ver los cambio en tu simulador, emulador, o dispositivo.

  1. Cambia el texto<br>`'You have pushed the button this many times:'`
     a<br>`'You have clicked the button this many times:'`
  1. No presione el botón de 'Stop'; permita que su app continué ejecutándose.
  1. Para ver tus cambios presione **Save All**, o clic
     **Hot Reload** (el botón con el icono del relámpago).

Deberás ver como el texto actualizado en la app ejecutándose casi inmediatamente.

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

*VS Code:* Un editor ligero con Flutter, asistencia al correr y depurar.

## Crear una nueva app

  1. Iniciar VS Code
  1. llamar **View > Command Palette**
  1. Teclea "flutter", y selecciona la acción **Flutter: New Project**
  1. Introducir el nombre del proyecto (como `myapp`), y presiona **Enter**
  1. Crear o seleccionar el directorio padre para el nuevo folder del proyecto
  1. Espera la creación del proyecto y completar la generación de el archivo `main.dart` y que
     aparezca.

Los comando de arriba crean un directorio para el proyecto llamado `myapp`
el cual contiene una app demo sencilla
que utiliza [Material Components](https://material.io/guidelines/).

Dentro del directorio del proyecto, el código de tu app esta en `lib/main.dart`.

## Ejecutar app

 1. Localizar la barra de estado de VS Code(la barra azul en la parte de abajo de la ventana)
 1. Seleccionar el dispositivo de el área de **Device Selector**.
    Para detalles, vea [Cambio rápido entre dispositivos de Flutter][].
    - Si no se encuentra ningún dispositivo disponible y prefieres usar un simulador,
      clic **No Devices** y lance un simulador.
    - Para configurar un dispositivo real, siga las instrucciones para el dispositivo en específico para [empezar: instalar](/get-started/install) en el SO que utilice.
 1. llamar a **Debug > Start Debugging** o presionar <kbd>F5</kbd>
 1. Espere que el app sea lanzada &mdash; el progreso se imprimirá en la vista de
    **Debug Console**
 1. Si todo funciona, después de que la app sea construida, podrá ver
    la app iniciada en su dispositivo:<br>
    ![App Iniciada en Android](/images/flutter-starter-app-android.png)

[Cambio rápido entre dispositivos de Flutter]: https://dartcode.org/docs/quickly-switching-between-flutter-devices

## Probando el hot reload

Flutter ofrece un ciclo de desarrollo rápido con _hot reload_, la habilidad de recargar 
el código en una app ejecutando en vivo sin reiniciar o perder el estado de la app. simplemente
hace un cambio a tu código fuente, diciéndole a tu IDE o herramienta de linea de comandos que
quieres recargar, y ver los cambio en tu simulador, emulador, o dispositivo.

  1. Cambia el texto<br>`'You have pushed the button this many times:'`
     a<br>`'You have clicked the button this many times:'`
  1. No presione el botón de 'Stop'; permita que su app continué ejecutándose.
  1. Para ver tus cambios presione **Save All**, o clic
     **Hot Reload** (el botón con el icono del relámpago).

Deberás ver como el texto actualizado en la app ejecutándose casi inmediatamente.

</div>

<div id="tab-install-terminal" class="tabs__content" markdown="1">

*Terminal + editor:* Su editor de elección combinado con herramienta de terminal de Flutter
para ejecutar y construir.

## Crear una nueva app

   1. Use el comando `flutter create` para crear un nuevo proyecto:
   {% commandline %}
   flutter create myapp
   cd myapp
   {% endcommandline %}

El comando de arriba crea el directorio del proyecto de Flutter llamado `myapp` el cual
contiene una app demo sencilla que utiliza
[Material Components](https://material.io/guidelines/).

Dentro del directorio del proyecto, el código de tu app esta en `lib/main.dart`.

## Ejecutar app

   * Verifica que un dispositivo Android se este ejecutando. Si no se muestra ninguno, vea
     [configuración](/get-started/install/).
   {% commandline %}
   flutter devices
   {% endcommandline %}
   * Ejecuta la app con el comando `flutter run`:
   {% commandline %}
   flutter run
   {% endcommandline %}
   * Si todo funciona, después de que la app sea construida, deberás ver tu app iniciada en el dispositivo o simulador:<br>
      ![App Iniciada en Android](/images/flutter-starter-app-android.png)

## Probando el hot reload

Flutter ofrece un ciclo de desarrollo rápido con _hot reload_, la habilidad de recargar 
el código en una app ejecutando en vivo sin reiniciar o perder el estado de la app. simplemente
hace un cambio a tu código fuente, diciéndole a tu IDE o herramienta de línea de comandos que
quieres recargar, y ver los cambio en tu simulador, emulador, o dispositivo.

  1. Cambia el texto<br>`'You have pushed the button this many times:'`
     a<br>`'You have clicked the button this many times:'`
  1. No presione el botón de 'Stop'; permita que su app continué ejecutándose.
  1. Para ver tus cambios presione **Save All**, o clic
     **Hot Reload** (el botón con el icono del relámpago).


</div>

</div>

## Siguiente paso

Aprendamos algunos conceptos del núcleo de Flutter, creando una pequeña app

[Siguiente paso: Escribir tu primera app](/get-started/codelab/)
