---
layout: page
title: Taps, drags, y otros gestos en Flutter

permalink: /gestures/
---

* TOC Placeholder
{:toc}

# Introducción

Este documento explica como escuchar y responder a _gestos_ en Flutter. Los ejemplos de gestos incluye taps, drags y ajustar tamaño.

El sistema de gestos en flutter tienen dos capas separadas.
La primera capa tiene eventos de puntero en bruto, que describen la ubicación y el movimiento de punteros (e.g., taps, ratones, styli) en la pantalla. La segunda capa tiene _gestos_, que describen acciones semánticas que consisten en uno o más movimientos de puntero.


# Punteros

Los punteros representan datos en bruto de la interacción del usuario con la pantalla del dispositivo. Existen cuatro tipos de eventos de punteros:

- [`PointerDownEvent`](https://docs.flutter.io/flutter/gestures/PointerDownEvent-class.html)
El puntero ha contactado con una ubicación determinada de la pantalla. 
- [`PointerMoveEvent`](https://docs.flutter.io/flutter/gestures/PointerMoveEvent-class.html)
El puntero se ha movido de una ubicación de la pantalla a otra.
- [`PointerUpEvent`](https://docs.flutter.io/flutter/gestures/PointerUpEvent-class.html)
  El puntero ha dejado  de hacer contacto con la pantalla.
- [`PointerCancelEvent`](https://docs.flutter.io/flutter/gestures/PointerCancelEvent-class.html)
  La acción de ese puntero ya no está dirigida hacia esta aplicación.

En el pointer down, el framework hace una _prueba de éxito_ en tu aplicación para determinar que widgets existen en esa ubicación donde el puntero entró en contacto con la pantalla.

El evento pointer down (y los eventos posteriores para ese puntero) se envían luego al widget más interno encontrado por la prueba de éxito.

A partir de ahí, los eventos emergen en el árbol y son enviados a todos los widgets en el camino desde el widget más interno a la raíz del árbol. No hay ningún mecanismo para cancelar o detener los eventos de punteros de ser enviados más allá.

Para escuchar eventos de puntero directamente desde la capa de widgets, use un [`Listener`](https://docs.flutter.io/flutter/widgets/Listener-class.html)
widget. Sin embargo, en general, considere usar gestos en su lugar (como se discute a continuación).

# Gestos

Los gestos representan acciones semánticas (e.g., tap, drag, y scale) que se reconocen a partir de múltiples eventos de puntero individuales, potencialmente incluso varios punteros individuales. Los gestos pueden enviar varios eventos, correspondientes al ciclo de vida del gesto (e.g., drag start, drag update, y drag end):

- Tap
  - `onTapDown` Un puntero que podría causar un tap, ha entrado en contacto con la pantalla en una ubicación particular.
  - `onTapUp` Un puntero que activará un tap dejó de contactar la pantalla en una ubicación particular.
  - `onTap` Se ha producido un tap.
  - `onTapCancel` El puntero que activó previamente el  `onTapDown` no terminará causando un tap.
- Doble tap
  - `onDoubleTap` El usuario ha pinchado la pantalla en la misma ubicación dos veces en una sucesión rápida.
- Long press
  - `onLongPress` Un puntero ha permanecido en contacto con la pantalla en el mismo lugar durante un largo período de tiempo.
- Drag vertical 
  - `onVerticalDragStart` Un puntero ha hecho contactado con la pantalla y podría empezar a moverse verticalmente.
  - `onVerticalDragUpdate` Un puntero que está en contacto con la pantalla y en movimiento vertical se ha movido en la dirección vertical.
  - `onVerticalDragEnd` Un puntero que estaba previamente en contacto con la pantalla y en movimiento vertical ya no está en contacto con la pantalla y se movía a una velocidad específica cuando dejó de tocar la pantalla.
- Drag horizontal
  - `onHorizontalDragStart` Un puntero ha entrado en contacto con la pantalla y puede comenzar a moverse horizontalmente.
  - `onHorizontalDragUpdate` Un puntero que está en contacto con la pantalla y se mueve horizontalmente se ha movido en la dirección horizontal.
  - `onHorizontalDragEnd` Un puntero que estaba previamente en contacto con la pantalla y que se movía horizontalmente ya no está en contacto con la pantalla y se estaba moviendo a una velocidad específica cuando dejó de contactar la pantalla.

Para escuchar los gestos de la capa de widgets, utilice un
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) widget.

Si está utilizando componentes material, muchos de esos widgets ya responden a los taps o gestos. Por ejemplo,
[IconButton](https://docs.flutter.io/flutter/material/IconButton-class.html) y [FlatButton](https://docs.flutter.io/flutter/material/FlatButton-class.html)
responden a la presión (taps), y
[`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html)
responde a golpes para disparar el desplazamiento.
Si no está utilizando los widgets, pero desea que el efecto  "Ink Splash " en un tap, puede utilizar
[`InkWell`](https://docs.flutter.io/flutter/material/InkWell-class.html).

## Desambiguación de gesto

En una ubicación determinada en la pantalla, puede haber múltiples detectores de gestos. Todos estos detectores de gestos escuchan la secuencia de eventos de puntero a medida que pasan e intentan reconocer gestos específicos. El
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html)
widget decide qué gestos tratar de reconocer basado en cuáles de sus callbacks no son nulos.

Cuando hay más de un reconocedor de gestos para un puntero dado en la pantalla, el framework desambigua qué gesto pretende el usuario haciendo que cada reconocedor se una a la _arena de gestos_. La arena de gestos determina qué gesto gana usando las siguientes reglas:

- En cualquier momento, un reconocedor puede declarar la derrota y salir de la arena. Si sólo queda un reconocedor en la arena, ese reconocedor es el ganador.

- En cualquier momento, un reconocedor puede declarar la victoria, lo que hace que gane y todos los reconocedores restantes pierdan.

Por ejemplo, cuando se desambigua el arrastre horizontal y vertical, ambos reconocedores entran en la arena cuando reciben el evento pointer down. Los reconocedores observan los eventos de movimiento del puntero. Si el usuario mueve el puntero más de un cierto número de píxeles lógicos horizontalmente, el reconocedor horizontal declarará la victoria y el gesto se interpretará como un arrastre horizontal. De forma similar, si el usuario mueve más de un cierto número de píxeles lógicos verticalmente, el reconocedor vertical declarará la victoria.

La arena de gestos es beneficiosa cuando solo hay un reconocedor de arrastre horizontal (o vertical). En ese caso, habrá solo un reconocedor en la arena y la resistencia horizontal será reconocida inmediatamente,lo que significa que el primer píxel del movimiento horizontal se puede tratar como un arrastre y el usuario no tendrá que esperar una desambiguación adicional del gesto.
