#### Configure your iOS simulator
{:.no_toc}

To prepare to run and test your Flutter app on the iOS simulator,
follow this procedure.

1. If using Xcode 15 or greater, download and install the iOS Simulator
   by running the following command:

    ```terminal
    $ xcodebuild -downloadPlatform iOS
    ```

    If you want to use a different method of downloading and installing the
    iOS Simulator, check out
    [Apple's documentation on installing Simulators][] for more options.

1. To start the Simulator, run the following command:

    ```terminal
    $ open -a Simulator
    ```

1. Set your Simulator to use a 64-bit device.
   This covers the iPhone 5s or later.

   * From **Xcode**, choose a simulator device type. Go to
     **Product** <span aria-label="and then">></span>
     **Destination** <span aria-label="and then">></span>
     Choose your target device.

   * From the **Simulator** app, go to
     **File** <span aria-label="and then">></span>
     **Open Simulator** <span aria-label="and then">></span>
     Choose your target iOS device.

   * To check the device version in the Simulator,
     open the **Settings** app <span aria-label="and then">></span>
     **General** <span aria-label="and then">></span>
     **About**.

1. The simulated high-screen density iOS devices might overflow your screen.
   If that appears true on your Mac, change the presented size in the
   **Simulator** app.

    |  **Display Size** |                          **Menu command**                          |      **Keyboard shortcut**     |
    |:-----------------:|:------------------------------------------------------------------:|:------------------------------:|
    | Small             | **Window** <span aria-label="and then">></span> **Physical Size**  | <kbd>Cmd</kbd> +  <kbd>1</kbd> |
    | Moderate          | **Window** <span aria-label="and then">></span> **Point Accurate** | <kbd>Cmd</kbd> +  <kbd>2</kbd> |
    | HD accurate       | **Window** <span aria-label="and then">></span> **Pixel Accurate** | <kbd>Cmd</kbd> +  <kbd>3</kbd> |
    | Fit to screen     | **Window** <span aria-label="and then">></span> **Fit Screen**     | <kbd>Cmd</kbd> +  <kbd>4</kbd> |
    {:.table.table-striped}

[Apple's documentation on installing Simulators]: {{site.apple-dev}}/documentation/xcode/installing-additional-simulator-runtimes
