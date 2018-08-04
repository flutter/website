---
layout: page
title: Accessibility

permalink: /accessibility/
---

Flutter se compromete a apoyar a los desarrolladores que quieran hacer sus aplicaciones más
accesibles: utilizable por la mayor cantidad de gente posible, incluidos aquellos con
discapacidades tales como ceguera o impedimento motor.

* Placeholder for TOC
{:toc}

# Soporte de accesibilidad de Flutter

Flutter admite tres componentes para el soporte de accesibilidad:

* **[Fuentes grandes](#large-fonts)**: Renderizar widgets de texto con tamaños de fuente especificados por el usuario
* **[Lectores de pantalla](#screen-reader)**: Comunicar comentarios verbales sobre el contenido de la interfaz de usuario
* **[Suficiente contraste](#sufficient-contrast)**: Hacer widgets con colores que tengan suficiente contraste

## Inspección del soporte de Accesibilidad

Los detalles de estos se discuten a continuación. Además de las pruebas para estos temas específicos, recomendamos el uso de escáneres de accesibilidad automatizados:

  * Para Android:
    1. Instale el [Escáner de accesibilidad][accessibility-scanner] para Android
    1. Habilite el Escáner de Accesibilidad desde Android Settings > Accessibility >
       Accessibility Scanner > On
    1. Acceda al botón de icono 'casilla de verificación' del Analizador de accesibilidad para iniciar un escaneo
  * Para iOS:
    1. Abra la carpeta `iOS` de su aplicación Flutter en Xcode
    1. Seleccione un simulador como objetivo y haga clic en el botón Run
    1. En Xcode, seleccione Xcode > Open Developer Tools > Accessibility Inspector
    1. En el Inspector de Accesibilidad, seleccione Inspection > Enable Point to
       Inspect, y luego seleccione los diversos elementos de la interfaz de usuario en la aplicación Flutter para inspeccionar sus atributos de accesibilidad
    1. En el Inspector de Accesibilidad, seleccione Audit en la barra de herramientas, y luego
       seleccione Run Audio para obtener un reporte de problemas potenciales.

[accessibility-scanner]: https://play.google.com/store/apps/details?id=com.google.android.apps.accessibility.auditor&hl=en

## Fuentes grandes {#large-fonts}

Tanto Android como iOS contienen configuraciones de sistema para configurar los tamaños de fuente deseados utilizados por las aplicaciones. Los widgets de texto de Flutter respetan esta configuración del sistema operativo cuando se determinan los tamaños de fuente.

### Tips para desarroladores

Los tamaños de fuente son calculados automáticamente por Flutter según la configuración del sistema operativo. Sin embargo, como desarrollador, debe asegurarse de que todos los diseños tengan espacio suficiente para mostrar todos sus contenidos cuando aumente el tamaño de las fuentes. Por ejemplo, puede probar todas las partes de su aplicación en un dispositivo de pantalla pequeña configurado para usar la configuración de fuente más grande.

### Ejemplo

Las siguientes dos capturas de pantalla muestran la plantilla estándar de la aplicación Flutter representada 1) con la configuración de fuente predeterminada de iOS, y 2) con la configuración de fuente más grande seleccionada en la configuración de accesibilidad de iOS.

![Captura de pantalla que muestra una aplicación de Flutter con un tamaño de fuente regular](/images/a18n/a18n-fonts-regular.png)
![Captura de pantalla que muestra una aplicación de Flutter que utiliza el tamaño de fuente más grande disponible](/images/a18n/a18n-fonts-large.png)

## Lectores de pantalla {#screen-reader}

Lectores de pantalla ([TalkBack][talkback], [VoiceOver][voiceover]) permite a los usuarios con discapacidad visual recibir comentarios por voz sobre el contenido de la pantalla.

### Tips para desarrolladores

Active VoiceOver o TalkBack en tu dispositivo y navega por tu aplicación. Si se encuentra con algún problema, use el [widget Semantics][semanticswidget] para personalizar la experiencia de accesibilidad de su aplicación.

[talkback]: https://support.google.com/accessibility/android/answer/6283677?hl=en
[voiceover]: https://www.apple.com/lae/accessibility/iphone/vision/
[semanticswidget]: https://docs.flutter.io/flutter/widgets/Semantics-class.html

## Suficiente contraste {#sufficient-contrast}

El suficiente contraste de color hace que el texto y las imágenes sean más fáciles de leer. Además de beneficiar a los usuarios con diversas discapacidades visuales, el suficiente contraste de color ayuda a todos los usuarios cuando visualizan una interfaz en dispositivos en condiciones de iluminación extrema, como cuando están expuestos a la luz solar directa o en una pantalla con bajo brillo.

La [W3C recomienda](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html):

* Al menos 4.5:1 para texto pequeño (por debajo de 18 puntos regulares o 14 puntos en negrita)
* Al menos 3.0:1 para texto grande (18 puntos y más arriba de lo normal o 14 puntos y más arriba en negrita)

### Tips para desarrolladores

Asegúrese de que las imágenes que incluya tengan suficiente contraste.

Al especificar colores en widgets, asegúrese de que se use suficiente contraste entre
selecciones de color en primer plano y fondo.
