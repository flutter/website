### Actualiza tu path

Se puede actualizar la variable de PATH para la sesión actual solo para la linea de comandos, 
como se muestra en [Obtener Flutter SDK](./#get-sdk). Probablemente necesitarás 
actualizar esta variable permanentemente, de esta manera poder ejecutar el comando `flutter`
en cualquier sesión de terminal.

Los pasos para modificar esta variables permanentemente para todas las sesiones de terminal para el equipo.
Típicamente se agrega una linea al archivo que se ejecuta cada que abres
una nueva ventana, por ejemplo:

1. Determine el directorio donde se encuentra el SDK de Flutter. Necesitaras esto
   en el paso 3.
2. Abre (o crea) `$HOME/.bash_profile`. la dirección del archivo puede estar
   en un lugar diferente en tu equipo.
3. Agrega la siguiente linea y cambia `[PATH_TO_FLUTTER_GIT_DIRECTORY]` para ser
   el directorio donde esta clonado el repositorio de Flutter:

{% commandline %}
export PATH=[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin:$PATH
{% endcommandline %}

4. Ejecuta `source $HOME/.bash_profile` para refrescar la ventana actual. 

5. Verifica que el directorio de `flutter/bin` esta en tu PATH ejecutando el siguiente comando:

{% commandline %}
echo $PATH
{% endcommandline %}

Para mas detalles, ver [Estas preguntas en StackExchange](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path).
