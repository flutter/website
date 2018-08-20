---
layout: page
title: Inspector de widget de Flutter 

permalink: /inspector/
---

El Inspector de Widget de Flutter es una poderosa herramienta para visualizar y explorar el árbol de widgets en Flutter.


* TOC Placeholder
{:toc}

## Inspector de Widget de Flutter 

El framework Flutter usa widgets como el elemento principal de construcción para todo, desde controles (text, buttons, toggles, etc.) hasta layouts (centering, padding, rows, columns, etc.). El inspector es una poderosa herramienta de Flutter para visualizar y explorar los árboles de widgets. Puede ser útil para:

* Comprender los layouts existentes
* Diagnosticar problemas con layouts 

![IntelliJ Flutter Inspector Window](/images/intellij/visual-debugging.png)

Para iniciar haz clic en "Select widget" en la barra de herramientas del inspector de Flutter y después haz clic sobre el dispositivo, para seleccionar un widget. El widget seleccionado se resaltará en el dispositivo y en el árbol de widgets.

![Select Demo](/images/intellij/inspector_select_example.gif)

Luego puedes navegar por el árbol interactivo de widgets en el IDE para ver de cerca los widgets y los valores de sus atributos. Si estas tratando de depurar un problema de layout, en la capa del árbol de widgets los detalles pueden ser insuficientes. En ese caso haz clic sobre la pestaña Render Tree para ver el render tree correspondiente en el mismo lugar del árbol. Cuando depuras problemas, los atributos claves que buscas son `size` y `constraints`. Las restricciones fluyen por el árbol hacia abajo y los tamaños fluyen hacia arriba.

![Switch Trees](/images/intellij/switch_inspector_tree.gif)

Para una demostración más completa del Inspector, por favor vea el reciente [DartConf talk](https://www.youtube.com/watch?v=JIcmJNT9DNI).

## Comenzar con el Inspector

El Inspector está disponible actualmente en el [plugin de Flutter](/get-started/editor/) para Android Studio o IntelliJ IDEA.

## Feedback issues

Si tienes sugerencias, o encuentras problemas, por favor reporta estos en nuestro [tracker](https://github.com/flutter/flutter-intellij/issues/new?labels=inspector)!
