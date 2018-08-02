# [Flutter-es][] en Español

El sitio web original [Flutter][].

[![Estatus de Version ](https://travis-ci.org/flutter-es/website.svg?branch=master)](https://travis-ci.org/flutter-es/website)

## Problemas, errores y peticiones

Agradecemos todas las contribuciones y retroalimentaciones en nuestro sitio web!
Por favor realiza una peticion en nuestro
[issue traker](https://github.com/flutter-es/website/issues/new)
y le daremos un vistazo.

## Desarollo

Instalar Jekyll y herramientas relacionadas siguiento estas 
[instrucciones](https://help.github.com/articles/using-jekyll-with-pages/)
de Github

Versión resumida a continuación:

1. Asegurate de tener [Ruby](https://www.ruby-lang.org/en/documentation/installation/) instalado; necesitas la versión 2.4.3 o superior:<br>
`ruby --version`

2. Asegurate de tener [Bundler](http://bundler.io/) instalado; si no se instala así:<br>
`gem install bundler`

3. Instala todas las dependencias:<br>
`bundle install`
    * En macOS, si encuentra errores mientras se contruyen las extensiones nativas de Ruby, vea [Instalación de Nokogiri](http://www.nokogiri.org/tutorials/installing_nokogiri.html#mac_os_x) para consejos sobre solución de problemas.

4. Crea un rama (branch).

5. Realice sus cambios
> IMPORTANTE todas las traducciones se realizarán dentro de la carpeta es_ES

6. Prueba tus cambios ejecutando el sitio localmente:<br>
`bundle exec jekyll serve` (o `jekyll serve -w --force_polling`)

7. Antes de enviarlo, ejecuta el enlace de validación:<br>
`rake checklinks`

## Desplegar a un staging site

Para ediciones realizadas de manera local (utilizando los pasos de arriba en 'desarrollo'), usted puede desplegarlos
a un sitio de staging personal de la forma siguiente (los paso 1 y 2 solo necesitan ser realizados en una ocasión):

1. En la [Consola Firebase](https://console.firebase.google.com),
crea tu propio projecto Firebase (ej. 'mi-flutter-staging')

2. Comunica a Firebase acerca del proyecto con firebase CLI
[commando `use` ](https://firebase.googleblog.com/2016/07/deploy-to-multiple-environments-with.html):
	```
	$ firebase use --add
	? Which project do you want to add? <select the project you created>
	? What alias do you want to use for this project? (e.g. staging) staging
	```

1. Comunica a Firebase que quieres desplegar a staging:
	```
	$ firebase use staging
	Now using alias staging (<nombre de tu proyecto>)
	```

1. Comunica a Firebase que despliegue:
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

### Agregando enlaces de pagina siguiente/anterior

Si se tiene un documento que abarca multiples páginas, usted puede agregar enlaces a páginas 
siguiente y anterior para hacer la navegación de estas páginas más sencilla. esto requiere agregar 
algo de información al frente de cada página, e incluir algo de HTML.

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

La manera más fácil de resaltar la sintaxis de un bloque de código es envolviéndolo
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

Consulte la lista de lenguajes admitidos anteriormente para saber qué usar después de las primeras comillas invertidas triples.

### Agregando más lenguajes al resaltado de sintaxis

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

## Estilo avanzado en un bloque de código 

Quieres resaltar (poner el fondo de color amarillo)
código dentro de un bloque de código? Quieres poner un texto tachado
dentro de un bloque de código? tenemos eso!

Para resaltar sintaxis, a demas resaltas en amarillo
y dar formato de tachado, utilice la etiqueta `prettify`
con personalización adicional en línea.

Si quisiera resaltar un pedazo de código específico, utilice
la sintaxis `[[highlight]]highlight this text[[/highlight]]` 
con la etiqueta `prettify`.

Por ejemplo:

    {% prettify dart %}
    void main() {
      print([[highlight]]'Hello World'[[/highlight]]);
    }
    {% endprettify %}

Si quisiera tachar un pedazo de código, utilice
la sintaxis `[[strike]]highlight this text[[/strike]]`
con la etiqueta `prettify`.

Por ejemplo:

    {% prettify dart %}
    void main() {
      print([[strike]]'Hello World'[[/strike]]);
    }
    {% endprettify %}

El complemento `prettify` también quitará el indentado de tu código.

Si quiere ver mas acerca de estas funcionalidades agregadas a este sitio, dirigase a
[este commit](https://github.com/flutter/website/commit/ea15f52fe47d3a7b6313ac58d07c66f3b29fe74d).

## Incluyendo region a un archivo

Usted puede incluir un rango específico de líneas desde un archivo:

```ruby
{% include includelines filename=PATH start=INT count=INT %}
```

`PATH` Debe estar dentro de `_include`. Si usted está incluyendo código fuente,
coloca tu código dentro `_include/code` para seguir nuestra convención.

## Validación de fragmento de código

Los fragmentos de código en la documentación es validado como parte de
proceso de contrucción. Cualquier cosas dentro de un '\`\`\`dart' puede extraerse dentro
de su propio archivo y verificar para analisis de problemas. Algunas formas de modificar esto:

- Si un fragmento de codigo no debe ser analizado, se procede inmediatamente con un comentario `<!-- skip -->`
- Para incluir código a ser analizado, pero no desplegado, agregue eso en su comentario
  inmediatamente proceda con el fragmento (ej., `<!-- someCodeHere(); -->`)
- Una fragmento sin ninguna declaración import automaticamente tendra un import
  (`'package:flutter/material.dart'`) agregado a el.
- Ignoramos el formato especial con las etiquetas con `[[highlight]]`.

[Flutter]: https://flutter.io
[Flutter-es]: https://flutter-es.firebaseapp.com/

## Actualizando el catalogo de ejemplo

Los archivos de muestra del catalogo de "markdown" son generados al correr [sample_page.dart](https://github.com/flutter/flutter/blob/master/examples/catalog/bin/sample_page.dart) para el repositorio de Flutter en github. Empezando desde la raíz del repositorio de Flutter:

```
cd examples/catalog
dart bin/sample_page.dart '<commit hashcode here>'
cp examples/catalog/.generated/*.md <your website repo>/catalog/samples
```

Los archivos "markdown" generados contendran los enlaces almacenados en la nube para capturas de pantalla en app de muestra. Las capturas de pantalla para cada app de muestra son generadas automaticamente para cada commit realizado en el repositorio de Flutter. Elige un commit con hashcode reciente y confirma que las capturas se ven bien.

Si nuevas apps de muestra han sido agregadas, actualiza `_data/catalog/widget.json`. La entrada para cada clase del widget que aparece en una aplicación de muestra debe contener una línea como `"sample"`:

```
"sample": "ListView_index",
```

La app `sample_page.dart` imprimirá una lista de todos las propiedades `"sample"` que deberían aparecer en el archivo `widget.json`.

## Previniendo enlaces rotos

Alguna forma de prevención de enlaces rotos se realiza automáticamente `rake checklinks`
en cada commit (a travez de `tool/travis.sh`). Pero esto no verá ningún redireccionamiento de Firebase (`rake checklinks` no ejecutan el servidor de Firebase) y no verificará los enlaces entrantes.

Antes de que podamos mover a una más completa
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
