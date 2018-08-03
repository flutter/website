---
layout: page
title: "Empezar: Configurar Editor"
permalink: /get-started/editor/
---

Usted puede construir apps con Flutter utilizando cualquier editor de texto combinando con nuestras
herramientas en línea de comando. De cualquier manera, recomendamos utilizar alguno de nuestros plugin para una
mejor experiencia. Con nuestros plugins de edición, usted podrá auto completar código, sintaxis resaltada, asistencia al editar widgets, apoyo para ejecutar & depurar, y más. 

Siga los siguientes pasos para agregar un complemento al editor para Androind Studio, IntelliJ 
o VS Code. Si quiere utilizar un editor diferente, está bien, simplemente salte al 
[siguiente paso: crear y ejecutar tu primer app](/get-started/test-drive/).

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
</ul>

<div id="tab-install-androidstudio" class="tabs__content current" markdown="1">

## Configuración Android Studio

*Android Studio:* Un experiencia completa e integrada del IDE para Flutter. 

### Instalar Android Studio

   * [Android Studio](https://developer.android.com/studio/index.html), version 3.0 o superior.

Otra opción puede ser utilizar IntelliJ:

   * [IntelliJ IDEA Community](https://www.jetbrains.com/idea/download/), version 2017.1 o superior.
   * [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/download/), version 2017.1 o superior.

### Instalar los complementos de Flutter y Dart

Flutter es compatible por dos plugins:

   * El complemento de `Flutter` le da el poder de desarrollo a Flutter (ejecutar,
     depurar, hot reload, etc.).
   * El complemento de `Dart` ofrece análisis de código (validación de código como su tipo, auto completar
     código, etc.).

Para instalar:

   1. Inicie Android Studio.
   1. Abra preferecias de complementos (**Preferences>Plugins** en macOS,
      **File>Settings>Plugins** en Windows & Linux).
   1. Seleccione **Browse repositories…**,  elige el complemento de Flutter y presione
      `install`.
   1. Presione `Yes` cuando aparezca para instalar el complemento de Dart.
   1. Presione `Restart` cuando aparezca.

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

## Configuración de Visual Studio Code (VS Code)

*VS Code:* Un editor ligero con Flutter, asistencia al ejecutar y depurar.

### Instalar VS Code

  * [VS Code](https://code.visualstudio.com/), La versión estable mas reciente.

### Instalar el complemento de Flutter 

  1. Inicie VS Code
  1. Llame **View>Command Palette...**
  1. Teclee 'install', y seleccione la acción **'Extensions: Install Extension'**
  1. Introduzca `flutter` en el campo de busqueda, seleccione 'Flutter' en la lista, 
     y presione **Install**
  1. Seleccione 'OK' para recargar VS Code

## Valida tu configuración con Flutter Doctor

  1. Llame a **View>Command Palette...**
  1. Teclee 'doctor', y seleccione la acción **'Flutter: Run Flutter Doctor'** 
  1. Revise la salida en el panel 'OUTPUT' para cualquier inconveniente.

</div>

</div>

## Siguiente paso

Hagamos una prueba: crea un proyecto, ejecútalo y 
experimenta 'hot reload'.


[Siguiente paso: Prueba Flutter](/get-started/test-drive/)
