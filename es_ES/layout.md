---
layout: page
title: Tratando con las restricciones de cajas en Flutter

permalink: /layout/
---

Usted puede ser redirigido a esta página si el maframework detecta un problema que involucre restricciones de cajas.


* Placeholder for TOC
{:toc}

## Introducción

En Flutter, los widgets son renderizados por sus objetos [`RenderBox`](https://docs.flutter.io/flutter/rendering/RenderBox-class.html) subyacentes. Los cuadros generadores obtienen restricciones por parte de sus padres y se clasifican dentro de esas restricciones. 
Las restricciones consisten en valores mínimos y maximos para el ancho y alto; los tamaños consisten en un ancho y alto específicos.

En general, hay tres tipos de cajas, en términos de cómo manejar
sus restricciones:

- Aquellos que tratan de ser los más grandes posible.
  Por ejemplo, las cajas usadas por [`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html) y [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html).
- Aquellos que tratan de tener el mismo tamaño que su hijo.
  Por ejemplo, las cajas usadas por [`Transform`](https://docs.flutter.io/flutter/widgets/Transform-class.html) y [`Opacity`](https://docs.flutter.io/flutter/widgets/Opacity-class.html).
- Aquellos que tratan de tener un tamaña en particular.
  Por ejemplo, las cajas usadas por [`Image`](https://docs.flutter.io/flutter/dart-ui/Image-class.html) y [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html).

Algunos widgets, por ejemplo [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html), varian de tipo en tipo basados en sus argumentos de construcción. En el caso de [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html), este por defecto trata de ser tan grande como sea posible, pero si tu colocas un valor en `width`, para esa instancia, trata de honrar ese valor y tomar un tamaño particular.

Otras, por ejemplo [`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html) y [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html) (cajas flexibles) varían basándose en las restricciones que se les otorgue, como se describe a continuación en la sección "Flex".

Las restricciones a veces son "estrictas", lo que significa que no dejan espacio para que la caja en el renderizado decida un tamaño
(e.g. si el mínimo y máximo  de ancho son el mismo, se dice que tienen un ancho estricto). El widget de ejemplo principal de esta `App`, es restringido por la clase
[`RenderView`](https://docs.flutter.io/flutter/rendering/RenderView-class.html): la caja usada por el niño devuelto por la función principal de la aplicación [`build`](https://docs.flutter.io/flutter/widgets/State/build.html) le da una restricción que lo fuerza a llenar exactamente el área del contenido de la aplicación  (comúnmente toda la aplicación). Muchas de las cajas en Flutter, especialmente aquellas que tienen un único hijo, van pasar sus restricciones a sus hijos. Eso significa que si anida un grupo de cajas dentro de otra en la raíz del árbol de renderizado de tu aplicación, todas encajarán exactamente entre sí, forzadas por las restricciones estrictas.

Algunas cajas _pierden_ las restricciones, significa que el valor máximo es mantenido pero que el mínimo es removido. Por ejemplo, [`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html).

Restricciones Ilimitadas
------------------------

En ciertas situaciones, las restricciones dadas por la caja pueden ser _ilimitadas_, o infinitas. Estos significa que ya sea el máximo de ancho o el máximo de alto es colocado a `double.INFINITY`.


A box that tries to be as big as possible won't function usefully when
given an unbounded constraint, and in checked mode, such a combination
will throw an exception that points to this file.

The most common cases where a render box finds itself with unbounded
constraints are within flex boxes ([`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html)
and [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html)), 
and **within scrollable regions** 
([`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html) 
and other [`ScrollView`](https://docs.flutter.io/flutter/widgets/ScrollView-class.html) subclasses).

In particular, [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html)
tries to expand to fit the space available
in its cross-direction (i.e. if it's a vertically-scrolling block, it
will try to be as wide as its parent). If you nest a vertically
scrolling [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html)
inside a horizontally scrolling [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html),
the inner one will try to be as wide as possible, which is infinitely
wide, since the outer one is scrollable in that direction.

Flexibles
---------

Flex boxes themselves ([`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html) 
and [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html)) 
behave differently based on
whether they are in a bounded constraints or unbounded constraints in
their given direction.

In bounded constraints, they try to be as big as possible in that
direction.

In unbounded constraints, they try to fit their children in that
direction. In this case, you cannot set `flex` on the children to
anything other than 0 (the default). In the widget library, this
means that you cannot use [`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html)
when the flex box is inside
another flex box or inside a scrollable. If you do, you'll get an
exception message pointing you at this document.

In the _cross_ direction, i.e. in their width for [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html) (vertical flex) and in their height for [`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html) (horizontal flex), they must never
be unbounded, otherwise they would not be able to reasonably align
their children.
