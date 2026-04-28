On iOS 14 and later, enable the Dart multicast DNS service in the
**Debug** version of your iOS app.
This adds [debugging functionalities such as hot-reload and DevTools][]
using `flutter attach`.

:::warning
Never enable this service in the **Release** version of your app.
The Apple App Store might reject your app.
:::

To set local network privacy permissions only in the Debug version of your app,
create a separate `Info.plist` per build configuration.
SwiftUI projects start without an `Info.plist` file.
If you need to create a property list,
you can do so through Xcode or text editor.
The following instructions assume the default **Debug** and **Release**.
Adjust the names as needed depending on your app's build configurations.

1. Create a new property list.

   1. Open your project in Xcode.

   1. In the **Project Navigator**, click on the project name.

   1. From the **Targets** list in the Editor pane, click on your app.

   1. Click the **Info** tab.

   1. Expand **Custom iOS Target Properties**.

   1. Right-click on the list and select **Add Row**.

   1. From the dropdown menu, select **Bonjour Services**.
      This creates a new property list in the project directory
      called `Info`. This displays as `Info.plist` in the Finder.

1. Rename the `Info.plist` to `Info-Debug.plist`

   1. Click on **Info** file in the project list at the left.

   1. In the **Identity and Type** panel at the right,
      change the **Name** from `Info.plist` to `Info-Debug.plist`.

1. Create a Release property list.

   1. In the **Project Navigator**, click on `Info-Debug.plist`.

   1. Select **File** > **Duplicate...**.
      You can also press <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd>.

   1. In the dialog box, set the **Save As:** field to
      `Info-Release.plist` and click **Save**.

1. Add the necessary properties to the **Debug** property list.

   1. In the **Project Navigator**, click on `Info-Debug.plist`.

   1. Add the String value `_dartVmService._tcp`
      to the **Bonjour Services** array.

   1. _(Optional)_ To set your desired customized permission dialog text,
      add the key **Privacy - Local Network Usage Description**.

      <DashImage image="development/add-to-app/ios/project-setup/debug-plist.png" caption="The `Info-Debug` property list with the **Bonjour Services** and **Privacy - Local Network Usage Description** keys added" />

1. Set the target to use different property lists for different build modes.

   1. In the **Project Navigator**, click on your project.

   1. Click the **Build Settings** tab.

   1. Click **All** and **Combined** sub-tabs.

   1. In the Search box, type `plist`.
      This limits the settings to those that include property lists.

   1. Scroll through the list until you see **Packaging**.

   1. Click on the **Info.plist File** setting.

   1. Change the **Info.plist File** value
      from `path/to/Info.plist` to `path/to/Info-$(CONFIGURATION).plist`.

      <DashImage image="development/add-to-app/ios/project-setup/set-plist-build-setting.png" caption="Updating the `Info.plist` build setting to use build mode-specific property lists" />

      This resolves to the path **Info-Debug.plist** in **Debug** and
      **Info-Release.plist** in **Release**.

      <DashImage image="development/add-to-app/ios/project-setup/plist-build-setting.png" caption="The updated **Info.plist File** build setting displaying the configuration variations" />

1. Remove the **Release** property list from the **Build Phases**.

   1. In the **Project Navigator**, click on your project.

   1. Click the **Build Phases** tab.

   1. Expand **Copy Bundle Resources**.

   1. If this list includes `Info-Release.plist`,
      click on it and then click the **-** (minus sign) under it
      to remove the property list from the resources list.

      <DashImage image="development/add-to-app/ios/project-setup/copy-bundle.png" caption="The **Copy Bundle** build phase displaying the **Info-Release.plist** setting. Remove this setting." />

1. The first Flutter screen your Debug app loads prompts
   for local network permission.

   Click **OK**.

   _(Optional)_ To grant permission before the app loads, enable
   **Settings > Privacy > Local Network > Your App**.

[debugging functionalities such as hot-reload and DevTools]: /add-to-app/debugging