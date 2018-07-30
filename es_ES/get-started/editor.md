---
layout: page
title: "Empezar: Configurar Editor"
permalink: /get-started/editor/
---

Usted puede contruir apps con flutter utilizando cualquier editor de texto combinandolo con nuestras
herramientas en linea de comando. De cualquier manera, recomendamos utilizar alguno de nuestros plugin para una
expeciencia aun mejor. Con nuestros plugins de edicion, usted obtendra terminacion de código, sintaxis resaltada, asistencia al editar widgets, apoyo para correr & debugear, y mas. 

Siga los siguientes pasos de abajo para agregar un plugin al editor para Androind Studio, IntelliJ 
o VS Code. Si quiere utilizar un editor difrente, eso esta bien, simplemente salte a 
[Siguiente paso: Crear y correr tu primer app](/get-started/test-drive/).

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
</ul>

<div id="tab-install-androidstudio" class="tabs__content current" markdown="1">

## Configuración Android Studio

*Android Studio:* Un experiencias completa e integráda del IDE para Flutter. 

### Instalar Android Studio

   * [Android Studio](https://developer.android.com/studio/index.html), version 3.0 o superior.

Otra opcion puede ser utilizar IntelliJ:

   * [IntelliJ IDEA Community](https://www.jetbrains.com/idea/download/), version 2017.1 o superior.
   * [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/download/), version 2017.1 o superior.

### Instalar los plugins de Flutter y Dart

Flutter es compatible por dos plugins:

   * El plugin de `Flutter` le da el poder del desarrollo a Flutter (correr,
     debugear, hot reload, etc.).
   * El plugin de `Dart` ofrece analisis de codigo (validacion de codigo como su tipo, terminacion de 
     codigo, etc.).

Para instalar:

   1. Inicie Android Studio.
   1. Abra preferecias de plugin (**Preferences>Plugins** en macOS,
      **File>Settings>Plugins** en Windows & Linux).
   1. Selecciona **Browse repositories…**,  elige el plug-in de Flutter y presione
      `install`.
   1. Presione `Yes` cuando aparezca para instalar el plugin de Dart.
   1. Presione `Restart` cuando aparezca.

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

## Configuracion de Visual Studio Code (VS Code)

*VS Code:* Un editor ligero con Flutter, asistencia al correr y depurar.

### Install VS Code

  * [VS Code](https://code.visualstudio.com/), La version estable mas resiente.

### Install the Flutter plugin

  1. Inicie VS Code
  1. Llame **View>Command Palette...**
  1. Teclee 'install', y seleccione la accion **'Extensions: Install Extension'**
  1. Introduzca `flutter` en el campo de busqueda, seleccione 'Flutter' en la lista, 
     y presione **Install**
  1. Seleccione 'OK' para recargar VS Code

## Valida tu configuracion con Flutter Doctor

  1. Llame a **View>Command Palette...**
  1. Teclee 'doctor', y selecciones la acción **'Flutter: Run Flutter Doctor'** 
  1. Revise la salida en el panel 'OUTPUT' para cualquier inconveniente.

</div>

</div>

## Siguiente paso

Hagamos una prueba con: crea un proyecto, correlo y 
experimenta 'hot reload'.


[Siguiente paso: Probar Flutter](/get-started/test-drive/)
