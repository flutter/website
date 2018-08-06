---
layout: page
title: Documentación de Flutter
permalink: /docs/
---

<ul class="cards">
{% for card in site.data.docs_cards %}
	<li class="cards__item">
	    <div class="card">
		    <h3 class="catalog-category-title"><a class="action-link" href="{{card.url}}">{{card.name}}</a></h3>
		    <p>{{card.description}}</p>
		    <div class="card-action">
		        <a class="action-link" href="{{card.url}}">VISITAR</a>
		    </div>
		</div>
	</li>
{% endfor %}
</ul>

&nbsp;


## Nuevo en Flutter?

Una vez que has pasado por [Empezar](/get-started/install/),
incluido [Escribe tu primera App con Flutter,](/get-started/codelab/)
aquí tienes algunos pasos para seguir.

* [Flutter para Desarrolladores Android](/flutter-for-android/)<br>
  Revisa estas notas si tienes experiencia en Android.

* [Patrones HTML/CSS](/web-analogs/)<br>
  Revisa estas analogías entre HTML y Flutter si tienes experiencia en web.

* [Construye Layouts en Flutter](/tutorials/layout/)<br>
  Aprende cómo crear layouts en Flutter, donde todo es un widget.

* [Añade Interactividad a tu aplicación Flutter](/tutorials/interactive/)<br>
  Aprende cómo añadir un stateful widget a tu app.

* [Un Tour por el Framework de Widgets de Flutter](/widgets-intro/)<br>
  Aprende más sobre el estilo reactivo del framework de Flutter.

&nbsp;


## Quieres mejorar tus habilidades?

Cuando domines lo básico, prueba estas páginas.

* [Cookbook](/cookbook/)<br>
  Una (creciente) colección de recetas que abordan los casos de uso comunes con Flutter.

* [Catálogo de Apps de Ejemplo](/catalog/samples/)<br>
  Aplicaciones simples que demuestran cómo implementar funcionalidades y widgets.

* [Añadir Assets e Imágenes en Flutter](/assets-and-images/)<br>
  Cómo añadir recursos a una aplicación en Flutter.

* [Animaciones en Flutter](/animations/)<br>
  Cómo crear animaciones standard, hero, o staggered, por nombrar algunos estilos de animación que soporta Flutter.

* [Rutas y Navegación](/cookbook/navigation/navigation-basics/)<br>
  Cómo crear y navegar a una nueva pantalla (llamada
  _route_ en Flutter).

* [Internacionalización](/tutorials/internationalization/)<br>
  Sé global! Cómo internacionalizar tu aplicación Flutter.

* [Dart Eficaz](https://www.dartlang.org/guides/language/effective-dart)<br>
  Guías sobre cómo escribir mejor código con Dart.

&nbsp;


## Temas especializados

Sumérgete en los temas que te interesen.

* [Flutter Widget Inspector](/inspector/)<br>
  Cómo usar el inspector de widgets, una poderosa herramienta que te permite
  explorar el árbol de widgets, deshabilitar el banner "DEBUG"
  , mostrar la capa sobrepuesta de rendimiento, y mucho más.

* [Fuentes Propias](/cookbook/design/fonts/)<br>
  Cómo añadir fuentes a tu aplicación.

* [Text Input](/cookbook/forms/text-input/)<br>
  Cómo configurar un text input básico.

* [Depurar aplicaciones Flutter](/debugging/)<br>
  Herramientas y consejos para depurar tu app.


&nbsp;


Esta no es una lista completa. Por favor usa el menú de navegación izquierdo,
o el buscador para encontrar otros temas.
