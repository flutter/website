---
layout: page
title: Preparando para release una app Android

permalink: /android-release/
---

Durante el ciclo de desarrollo típico, probarás una aplicación usando `flutter run` en la
línea de comando, los botones Run y Debug de la barra de herramientas en IntelliJ, o ambos. Por defecto, Flutter crea una versión *debug* de su aplicación.

Cuando estés listo para preparar una versión *release* para Android, por ejemplo para
[publicarla a Google Play Store][play], sigue los pasos.

* TOC Placeholder
{:toc}

## Revisa el App Manifest

Revisa el fichero por defecto [App Manifest][manifest] `AndroidManifest.xml` localizado
en el directorio `<app dir>/android/app/src/main/` y verifica si los valores son correctos,
especialmente:

* `application`: Edita la etiqueta [`application`][applicationtag] para reflejar el nombre
final de la aplicación.

* `uses-permission`: Elimina el [permiso][permissiontag] `android.permission.INTERNET`
si el código de tu aplicación no necesita acceso a Internet. 
La plantilla estándar incluye esta etiqueta para permitir la comunicación entre
herramientas de Flutter y una aplicación en ejecución.

## Revisa la configuración de compilación

Revisa el archivo por defecto de [Gradle build][gradlebuild] `build.gradle`
localizado en el directorio `<app dir>/android/app/` y verifica si los valores están correctos, especialmente:

* `defaultConfig`:

  * `applicationId`: Especifique el (Id de Aplicación)[appid] final y único.

  * `versionCode` & `versionName`: Especifica el número de versión de la aplicación interna, y
  la cadena de número de versión. Consulta la guía de información de versión en
  la [documentación de versiones][versions] para más detalle.

  * `minSdkVersion` & `targetSdkVersion`: Especifica el nivel mínimo de API y el nivel de API en que está diseñada la aplicación para ser ejecutada. Consulte la sección de contenido de la API en la [documentación de versiones][versions] para más detalle.

## Añadiendo un icono para el Launcher

Cuando una nueva aplicación Flutter es creada, este tiene un Launcher Icon por defecto. Para personalizar este icono debería 
ver el paquete [Iconos de inicio de Flutter](https://pub.dartlang.org/packages/flutter_launcher_icons).

Alternativamente, si deseas hacerlo manualmente, aquí está como:

1. Revisa las pautas de [Iconos del Launcher de Android][launchericons] para el diseño del ícono.

1. En el directorio `<app dir>/android/app/src/main/res/` , coloca tus archivos de iconos en la carpeta señalada
usando los [Calificadores de Configuración][configurationqualifiers].
Las carpetas predeterminadas `mipmap-` demuestran la convención de nomenclatura correcta.

1. En `AndroidManifest.xml`, actualiza el atributo `android:icon` de la etiqueta [`application`][applicationtag] a los
iconos de referencia del paso anterior (por ejemplo, `<application android:icon="@mipmap/ic_launcher" ...`).

1. Para verificar que los iconos han sido reemplazados, ejecuta tu app usando `flutter run` e inspecciona el icono de la app en el 
Launcher.

## Firmando la app

### Creando un Keystore
Si tienes una Keystore anterior, salta al siguiente paso. Si no, crea una ejecutando lo siguiente en
la línea de comandos:
`keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`

*Nota*: Mantenga este archivo privado; no lo incluya en un repositorio de control de versiones público.

*Nota*: `keytool` puede no estar en su ruta. Este es parte del JDK de Java, el cual es instalado como parte
de Android Studio. Para la ruta en concreto, ejecuta `flutter doctor -v` y verás la ruta impresa después
de 'Java binary at:', y luego usa esa ruta completa reemplazando `java` con `keytool`.

### Referencia el keystore desde la app

Crea un archivo llamado `<app dir>/android/key.properties` que contenga una referencia a tu keystore:

```
storePassword=<contraseña del paso anterior>
keyPassword=<contraseña del paso anterior>
keyAlias=key
storeFile=<localización del archivo, por ejemplo /Users/<user name>/key.jks>
```

*Nota*: Mantenga este archivo privado; no lo incluya en un repositorio de control de versiones público.

### Configurar la firma en Gradle

Configura la firma de tu app editando el archivo `<app dir>/android/app/build.gradle`.

1. Reemplaza:
```
   android {
```
   con la información de la keystore desde tu archivo de propiedades:
```
   def keystorePropertiesFile = rootProject.file("key.properties")
   def keystoreProperties = new Properties()
   keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

   android {
```

1. Reemplaza:
```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now, so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```
   con:
```
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile file(keystoreProperties['storeFile'])
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```

Los release build de tu aplicación ahora se firmarán automáticamente.


## Habilitando Proguard

Por defecto, Flutter no ofusca o minimiza el Android host.
Si pretendes usar librerías de Java de terceras partes,
querrás reducir el tamaño del APK o proteger ese código de ingeniería inversa.

Para información sobre ofuscación de código Dart, ver [Obfuscating Dart Code](https://github.com/flutter/flutter/wiki/Obfuscating-Dart-Code)
En la [wiki de Flutter](https://github.com/flutter/flutter/wiki/).

### Paso 1 - Configurar Proguard

Crea el archivo `/android/app/proguard-rules.pro` y añade las reglas listadas a continuación.

```
#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
```

La configuración anterior solo protege las bibliotecas del motor de Flutter. Cualquier biblioteca adicional (por ejemplo, Firebase) requiere que se agreguen sus propias reglas.

### Paso 2 - Habilita obfuscación y/o minificación

Abre el archivo `/android/app/build.gradle` y localiza la definición `buildTypes`.
Dentro de la configuración `release` establece las etiquetas `minifiyEnabled` y `useProguard`
a true. Tienes también que apuntar ProGuard al archivo que has creado en el paso 1.

```
android {

    ...

    buildTypes {

        release {

            signingConfig signingConfigs.debug

            minifyEnabled true
            useProguard true

            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'

        }
    }
}
```

Nota: La ofuscación y la minificación pueden ampliar considerablemente el tiempo de compilación de la aplicación de Android.

## Construyendo una release APK

Esta sección describe cómo crear una versión APK. Si completaste los pasos de firma en la sección anterior, se firmará la release APK.

Usando la línea de comandos:

1. `cd <app dir>` (reemplace `<app dir>` con su directorio de la aplicación).
1. Ejecuta `flutter build apk` (`flutter build` por defecto a `--release`).

La release APK para su aplicación se creó en `<app dir>/build/app/outputs/apk/app-release.apk`.

## Instalación de una release APK en un dispositivo

Sigue estos pasos para instalar el APK creado en el paso anterior en un dispositivo Android conectado.

Usando la línea de comando:

1. Conecta su dispositivo Android a su computadora con un cable USB.
1. `cd <app dir>` donde `<app dir>` es el directorio de tu aplicación.
1. Ejecuta `flutter install` .

## Publicación de una APK en Google Play Store

Para obtener instrucciones detalladas sobre la publicación de la versión release de una aplicación en Google Play Store, consulta la [documentación de publicación de Google Play][play].

[manifest]: http://developer.android.com/guide/topics/manifest/manifest-intro.html
[manifesttag]: https://developer.android.com/guide/topics/manifest/manifest-element.html
[appid]: https://developer.android.com/studio/build/application-id.html
[permissiontag]: https://developer.android.com/guide/topics/manifest/uses-permission-element.html
[applicationtag]: https://developer.android.com/guide/topics/manifest/application-element.html
[versions]: https://developer.android.com/studio/publish/versioning.html
[launchericons]: https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html
[configurationqualifiers]: https://developer.android.com/guide/practices/screens_support.html#qualifiers
[play]: https://developer.android.com/distribute/googleplay/start.html
[gradlebuild]: https://developer.android.com/studio/build/#module-level
