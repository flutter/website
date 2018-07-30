# [Flutter][]'s website

El sitio web para [Flutter][].

[![Estatus de Version ](https://travis-ci.org/flutter/website.svg?branch=master)](https://travis-ci.org/flutter/website)

## Problemas, errores y peticiones

Agradecemos todas las contribuciones y retroalimentaciones en nuestro sitio web!
Por favor realiza una peticion en nuestro
[rastreador de problemas](https://github.com/flutter/flutter/issues/new)
y le daremos un vistazo.

## Desarollo

Instalar Jekyll y herramientas relacionadas siguiento estas 
[instrucciones](https://help.github.com/articles/using-jekyll-with-pages/)
que Github proveé.

Sigue esta version tldr: (tldr = to long didn't read - Muy larga no lo lei)

1. Asegura tener [Ruby](https://www.ruby-lang.org/en/documentation/installation/) instalado; necesitas la version 2.4.3 o superior:<br>
`ruby --version`

1. Asegura tener [Bundler](http://bundler.io/) instalado; si no se instala asi:<br>
`gem install bundler`

1. Instala todas las dependencias:<br>
`bundle install`
    * En macOS, si usted encuentra errores mientras se contruyen las extensiones nativas de Ruby, vea [Instalación de Nokogiri](http://www.nokogiri.org/tutorials/installing_nokogiri.html#mac_os_x) por consejos sobre problemáticas.

1. Crea un rama (branch).

1. Realice sus cambios.

1. Prueba tus cambios ejecutando el sitio localmente:<br>
`bundle exec jekyll serve` (o `jekyll serve -w --force_polling`)

1. Antes de enviarlo, ejecuta el enlace de validación:<br>
`rake checklinks`

## Desplegar en el sitio de ensayo (staging site)

Para ediciones hechas directamente en el web UI de GitHub, los cambios seran desplegados 
al sitio de ensayo (como `https://flutter-io-deploy-three.firebaseapp.com/inspector`)
por el 'job' de Travis.

Para ediciones realizadas de manera local (utilizando los pasos de arriba en 'desarrollo'), usted puede desplegarlos
a un sitio de ensayo personal de la forma siguiente (paso 1 y 2 necesitan estar realizados solo en una ocasión):

1. En la [Consola Firebase](https://console.firebase.google.com),
crea tu propio projecto Firebase (ej. 'mit-flutter-staging')

1. Di a Firebase acerca del proyecto con firebase CLI
[commando `use` ](https://firebase.googleblog.com/2016/07/deploy-to-multiple-environments-with.html):
	```
	$ firebase use --add
	? Cual proyecto quieres agregar? <Selecciona el proyecto creado>
	? Cual es el alias que quieres usar para este proyecto? (ej. staging) staging
	```

1. Dile a Firebase que quieres desplegar a staging:
	```
	$ firebase use staging
	Now using alias staging (<nombre de tu proyecto>)
	```

1. Dile a Firebase que despliegue:
	```
	$ firebase use staging
	Now using alias staging (<nombre del proyecto>)
	$ firebase deploy

	=== Deploying to '<nombre de tu proyecto>'...

	i  deploying hosting
	i  hosting: preparing _site directory for upload...
	✔  hosting: 213 files uploaded successfully
	i  starting release process (may take several minutes)...

	✔  Deploy complete!
	```

## escribiendo para flutter.io

(Eventualmente, esta seccion debera crecer hs su propia pagina.)

### Agregando enlaces de pagina siguiente/anterior

Si se tiene un documento que abarca multiples paginas, usted puede agregar enlaces a paginas 
siguiente y anterior para hacer la navegacion de estas paginas mas sencilla. esto requiere agregar 
algo de informacion al frente de cada pagina, e incluir algo de HTML.

```
---
layout: tutorial
title: "Constraints"

permalink: /tutorials/layout/constraints.html
prev-page: /tutorials/layout/properties.html
prev-page-title: "Container Properties"
next-page: /tutorials/layout/create.html
next-page-title: "Create a Layout"
---

{% include prev-next-nav.html %}

{:toc}

<!-- PAGE CONTENT -->

{% include prev-next-nav.html %}
```

Omite la informacion "prev-page" para la primera pagina, y "next-page" 
para la ultima.

## Destacando sintaxis

El sitio de flutter.io utiliza [prism.js](http://prismjs.com/) para resaltar
sintaxis. Esta seccion cubre como utilizar el resaltado de sintaxis, y
como actualizar nuestro resaltado de sintaxis para lenguajes nuevos.

### Lenguajes soportados

Este sitio puede resaltar sintaxis de los siguiente lenguajes:

* shell
* dart
* html
* css
* javascript
* java
* objectivec
* swift

### Utilizando el resaltado de sintaxis

La manera mas facil de resaltas la sintaxis de un bloque de codigo es envolviendolo
en tres comillas invertidas seguidas por el lenguaje.

Aqui de ve un ejemplo:

	```dart
	class ExampleWidget extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return new Container();
      }
    }
	```

Vea la lista de lenguajes que se encuentra arriba para lo que se utiliza
seguidos de las tres comillas invertidas.

### Agregando mas lenguajes al resaltado de sintaxis

El sitio web de flutter.io utiliza un contructor de prism personalizado, el cual 
incluye solo los lenguajes que el sitio requiere. Para mejorar 
la carga y experiencia de usuario, nosotros no soportamos cada
lenguajes que prism soporta.

Para agregar un lenguaje nuevo al resaltado de lenguaje, usted necesitara
generar una copia de el archivo `prism.js`.

Siga los siguientes pasos para generar una nueva copia de `prism.js`:

* Abra `js/prism.js`
* Copie la URL comentada en la primera linea del archivo
* Pegala en el navegador.
* Agrega el nuevo lenguaje que deseas al resaltador de sintaxis.
* POR FAVOR NO cambie a otros complementos, lenguajes o configuraciones.
* Descargue el JavaScript generado, y reemplace `js/prism.js`
* Descargue el CSS generado, y reemplace `_sass/_prism.scss`

## Estilo avanzado en un bloque de codigo 

Quieres resaltar (poner el fondo de color amarillo)
codigo dentro de un bloque de codigo? Quieres poner un texto tachado
dentro de un bloque de codigo? tenemos eso!

Para resaltar sintaxis, a demas resaltas en amarillo
y dar formato de tachado, utilice la etiqueta `prettify`
con personalizacion adicional en linea.

Si quisiera resaltar un pedazo de codigo especifico, utilice
la sintaxis `[[highlight]]highlight this text[[/highlight]]` 
con la etiqueta `prettify`.

Por ejemplo:

    {% prettify dart %}
    void main() {
      print([[highlight]]'Hello World'[[/highlight]]);
    }
    {% endprettify %}

Si quisiera tachar un pedazo de codigo, utilice
la sintaxis `[[strike]]highlight this text[[/strike]]`
con la etiqueta `prettify`.

Por ejemplo:

    {% prettify dart %}
    void main() {
      print([[strike]]'Hello World'[[/strike]]);
    }
    {% endprettify %}

El complemento `prettify` tambien quitara el indentado de tu código.

Si quiere ver mas  acerca de estas funcionalidades agregadas a este sitio, refierace a
[este commit](https://github.com/flutter/website/commit/ea15f52fe47d3a7b6313ac58d07c66f3b29fe74d).

## Incluyendo region a un archivo

Usted puede incluir un rango específico de lineas desde un archivo:

```ruby
{% include includelines filename=PATH start=INT count=INT %}
```

`PATH` Debe estar dentro de `_include`. Si ustdes esta inclutendo código fuente,
coloca tu codigo dentro `_include/code` para seguir nuestra convensión.

## Validación de fragmento de código

Los fragmentos de código en la documentación es validado como parte de
proceso de contrucción. Cualquier cosas dentro de un '\`\`\`dart' puede extraerse dentro
de su propio archivo y verificar para analisis de problemas. Algunas formas de modificar esto:

- Si un fragmento de codigo no debe ser analizado, se procede inmedatamente con un comentario `<!-- skip -->`
- Para incluir código a ser analizado, pero no desplegado, agregue eso e sun comentario
  inmediatamente proceda con el fragmento (ej., `<!-- someCodeHere(); -->`)
- Una fragmento sin ninguna declaracion import automaticamente tendra un import
  (`'package:flutter/material.dart'`) agregado a el.
- Ignoramos el formato especial con las etiquetas con `[[highlight]]`.

[Flutter]: https://flutter.io

## Actualizando el catalogo de ejemplo

Los archivos de muestra del catalogo de "markdown" son generados al correr [sample_page.dart](https://github.com/flutter/flutter/blob/master/examples/catalog/bin/sample_page.dart) para el repositorio de Flutter en github. Empezando desde la raíz del repositorio de Flutter:

```
cd examples/catalog
dart bin/sample_page.dart '<commit hashcode here>'
cp examples/catalog/.generated/*.md <your website repo>/catalog/samples
```

Los archivos "markdown" generador contendran los enlaces almacenados en la nube para capturas de pantalla en app de muestra. Las capturas de pantalla para cada app de muestra son generadas automaticamente para cada commit realizado en el repositorio de Flutter. Elige un commit con hashcode reciente y confirma que las capturas se ven bien.

Si nuevas apps de muestra han sido agregadas, actualiza `_data/catalog/widget.json`. La entrada para cada clase del widget que aparece en una aplicacion de muestra debe contener una linea como `"sample"`:

```
"sample": "ListView_index",
```

La app `sample_page.dart` imprimirea una lista de todos las propiedades `"sample"` que deberian aparecer en el archivo `widget.json`.

## Previniendo enlaces fallados

Algunas de prevenier los enlaces (links) fallados es realizada automaticamenre por `rake checklinks`
en cada commit (a travez de `tool/travis.sh`). pero estos no seran vistor por ninguna redireción realizada
por Firebase (`rake checklinks` no ejecuta el servidor de Firebase) y este no podra
verificar enlaces de entrada.

Antes de que podamos mover a una mas completa
[solucion automatizada de `linkcheck`](https://github.com/dart-lang/site-webdev/blob/master/scripts/check-links-using-fb.sh)
de dartlang.org, recomendamos ejecutar manualmente lo siguiente.

* Configuracion de inicio:

  ```
  pub global activate linkcheck
  npm install -g superstatic
  ```

* Iniciar el servidor de Firebase local:

  ```
  superstatic --port 3474
  ```

* Ejecutar el verificador de enlaces:

  ```
  linkcheck :3474
  ```

  Aun mejor, verificar que las URLs viejas esta redireccionadas correctamente:

  ```
  linkcheck :3474 --input-file tool/sitemap.txt
  ```
