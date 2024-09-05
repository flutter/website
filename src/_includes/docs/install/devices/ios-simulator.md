#### Configure your iOS simulator

To prepare to run and test your Flutter app on the iOS simulator,
follow this procedure.

1. To install the iOS Simulator, run the following command.

    ```console
    {{prompt1}} xcodebuild -downloadPlatform iOS
    ```

1. To start the Simulator, run the following command:

    ```console
    $ open -a Simulator
    ```

1. Set your Simulator to use a 64-bit device.
   This covers the iPhone 5s or later.

   * From **Xcode**, choose a simulator device type.

     1. Go to **Window** <span aria-label="and then">></span>
        **Devices and Simulators**.

        You can also press <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>2</kbd>.

     2. Once the **Devices and Simulators** dialog opens,
        click **Simulators**.

     3. Choose a **Simulator** from the left-hand list or press **+** to
        create a new simulator.

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

    | **Display Size**  |                          **Menu command**                          |     **Keyboard shortcut**     |
    |:-----------------:|:------------------------------------------------------------------:|:-----------------------------:|
    | Small             | **Window** <span aria-label="and then">></span> **Physical Size**  | <kbd>Cmd</kbd> + <kbd>1</kbd> |
    | Moderate          | **Window** <span aria-label="and then">></span> **Point Accurate** | <kbd>Cmd</kbd> + <kbd>2</kbd> |
    | HD accurate       | **Window** <span aria-label="and then">></span> **Pixel Accurate** | <kbd>Cmd</kbd> + <kbd>3</kbd> |
    | Fit to screen     | **Window** <span aria-label="and then">></span> **Fit Screen**     | <kbd>Cmd</kbd> + <kbd>4</kbd> |
    
    {:.table .table-striped}

