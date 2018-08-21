## Configuración de iOS 

### Instalar Xcode

Para desarrollar apps con Flutter en iOS, necesitaras una Mac con Xcode 9.0 o más reciente:

1. Instalar Xcode 9.0 o más reciente (vía [descarga web](https://developer.apple.com/xcode/) o
[Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835)).
1. Configurar la línea de comandos de Xcode para usar el recién versión recién instalada de Xcode 
ejecutando `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` desde 
la linea de comandos.

   Esta es el directorio correcto la mayoría de casos, cuando quiera hacer uso de la versión más reciente de Xcode.
   Si necesita usar una versión diferente, especifique esa dirección en su lugar.

1. Asegúrese de firmar el acuerdo de licencia de Xcode abriendo por primera vez y confirmando o
ejecutando `sudo xcodebuild -license` desde la linea de comando.

Con Xcode, serás capaz de ejecutar apps de Flutter en un dispositivo o un simulador.

### Configurar el simulador iOS

Para preparar la ejecución y probar tu app de Flutter en el simulador de iOS, siga estos pasos:

1. En su Mac, encuentre el simulador via Spotlight o utilizando el siguiente comando:

{% commandline %}
open -a Simulator
{% endcommandline %}

2. Asegura que el simulador utilizado este utilizando un dispositivo de 64 bits (iPhone 5s o superior)  verificando la configuración en el menú del simulador **Hardware > Device**.
3. Dependiendo de el tamaño de la pantalla de la máquina de desarrollo, se simulará la calidad en la pantalla de tu dispositivo iOS el cual podría desbordar la pantalla, configura la escala del dispositivo en el menú **Window > Scale** en el simulador.
4. Inicia tu app ejecutando `flutter run`.


### Desplegar en dispositivos iOS

Para desplegar tu app de Flutter en un dispositivo físico de iOS, necesitarás algunas herramientas extras y una cuenta de Apple. También necesitarás configurar el dispositivo físico para despegarlo en Xcode.


1. Instalar [homebrew](http://brew.sh/).
1. Abrir la terminar y ejecutar estos comandos para instalar las herramientas para desplegar las apps de Flutter en dispositivos iOS

{% commandline %}
brew update
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods
pod setup
{% endcommandline %}

   Si cualquiera de estos comandos falla con error, ejecuta `brew doctor` y sigue las instrucciones
   para resolver el problema.

1. Continua con el flujo de registro en Xcode para provisionar tu proyecto:
    1. Abre el espacio de trabajo por defecto en tu proyecto ejecutando `open ios/Runner.xcworkspace`  en una ventana de terminal del directorio donde está el proyecto de Flutter.
    1. En Xcode, selecciona el proyecto `Runner` en  el panel de navegación del lado izquierdo.
    1. En la página de configuración de `Runner`, asegurate que tu equipo de desarrollo esta seleccionado debajo de **General > Signing > Team**. Cuando seleccionas un equipo, Xcode crea y descarga un Certificado de Desarrollo, registra tu dispositivo a tu cuenta, y crea y descarga un perfil provisional (de necesitarse).
        * Para empezar tu primer proyecto de desarrollo en iOS, necesitarás registrarte en Xcode con tu ID de Apple.<br>
        ![Agregar cuenta en Xcode](/images/setup/xcode-account.png)<br>
        Hay soporte en desarrollo y pruebas para cualquier ID de apple. Enrolarte en el programa de desarrolladores de Apple es necesario para distribuir tu app en el App Store. Ver la [diferencias entre los tipos de membresías de Apple](https://developer.apple.com/support/compare-memberships).
        * La primera ocasiones que utilices un dispositivo físico para desarrollo iOS, necesitarás autorizar ambas tu Mac y tu certificado de desarrollo en el dispositivo. Selecciona `Trust` en la ventana que te muestra la primera vez que es conectado tu dispositivo iOs a tu Mac.<br>
        ![Autorizar Mac](/images/setup/trust-computer.png)<br>
        Ahora, ve a la configuración de la app en el dispositivo iOS, selecciona **General > Device Management**  y autoriza el Certificado.
        * Si tu registro automático falla en Xcode, verifica que el valor del proyecto sea único **General > Identity > Bundle Identifier**.<br>
        ![Compruebe el ID del paquete de la app](/images/setup/xcode-unique-bundle-id.png)
1. Inicia tu app ejecutando el comando `flutter run`.
