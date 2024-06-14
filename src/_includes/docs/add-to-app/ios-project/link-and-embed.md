Flutter plugins might produce [static or dynamic frameworks][].
Link static frameworks, [_never_ embed them][static-framework].

If you embed a static framework into your iOS app,
you can't publish that app to the App Store.
Publishing fails with a
`Found an unexpected Mach-O header code` archive error.

##### Link all frameworks

To link the necessary frameworks, follow this procedure.

1. Choose the frameworks to link.

   1. In the **Project Navigator**, click on your project.

   1. Click the **Build Phases** tab.

   1. Expand **Link Binary With Libraries**.

      {% render docs/captioned-image.liquid,
      image:"development/add-to-app/ios/project-setup/linked-libraries.png",
      caption:"Expand the **Link Binary With Libraries** build phase in Xcode" %}

   1. Click **+** (plus sign).

   1. Click **Add Other...** then **Add Files...**.

   1. From the **Choose frameworks and libraries to add:** dialog box,
      navigate to the `/path/to/MyApp/Flutter/Release/` directory.

   1. Command-click the frameworks in that directory then click **Open**.

      {% render docs/captioned-image.liquid,
      image:"development/add-to-app/ios/project-setup/choose-libraries.png",
      caption:"Choose frameworks to link from the **Choose frameworks and
      libraries to add:** dialog box in Xcode" %}

1. Update the paths to the libraries to account for build modes.

   1. Launch the Finder.

   1. Navigate to the `/path/to/MyApp/` directory.

   1. Right-click on `MyApp.xcodeproj` and select **Show Package
      Contents**.

   1. Open `project.pbxproj` with Xcode. The file opens in Xcode's text
      editor. This also locks **Project Navigator** until you close the text editor.

      {% render docs/captioned-image.liquid,
      image:"development/add-to-app/ios/project-setup/project-pbxproj.png",
      caption:"The `project-pbxproj` file open in the Xcode text editor" %}

   1. Find the lines that resemble the following text in the
      `/* Begin PBXFileReference section */`.

      ```text
      312885572C1A441C009F74FF /* Flutter.xcframework */ = {
        isa = PBXFileReference;
        expectedSignature = "AppleDeveloperProgram:S8QB4VV633:FLUTTER.IO LLC";
        lastKnownFileType = wrapper.xcframework;
        name = Flutter.xcframework;
        path = Flutter/[!Release!]/Flutter.xcframework;
        sourceTree = "<group>";
      };
      312885582C1A441C009F74FF /* App.xcframework */ = {
        isa = PBXFileReference;
        lastKnownFileType = wrapper.xcframework;
        name = App.xcframework;
        path = Flutter/[!Release!]/App.xcframework;
        sourceTree = "<group>";
      };
      ```

   1. Change the `Release` text highlighted in the prior step
      and change it to `$(CONFIGURATION)`. Also wrap the path in
      quotation marks.

      ```text
      312885572C1A441C009F74FF /* Flutter.xcframework */ = {
        isa = PBXFileReference;
        expectedSignature = "AppleDeveloperProgram:S8QB4VV633:FLUTTER.IO LLC";
        lastKnownFileType = wrapper.xcframework;
        name = Flutter.xcframework;
        path = [!"!]Flutter/[!$(CONFIGURATION)!]/Flutter.xcframework[!"!];
        sourceTree = "<group>";
      };
      312885582C1A441C009F74FF /* App.xcframework */ = {
        isa = PBXFileReference;
        lastKnownFileType = wrapper.xcframework;
        name = App.xcframework;
        path = [!"!]Flutter/[!$(CONFIGURATION)!]/App.xcframework[!"!];
        sourceTree = "<group>";
      };
      ```

1. Update the search paths.

   1. Click the **Build Settings** tab.

   1. Navigate to **Search Paths**

   1. Double-click to the right of **Framework Search Paths**.

   1. In the combo box, click **+** (plus sign).

   1. Type `$(inherited)`.
      and press <kbd>Enter</kbd>.

   1. Click **+** (plus sign).

   1. Type `$(PROJECT_DIR)/Flutter/$(CONFIGURATION)/`
      and press <kbd>Enter</kbd>.

      {% render docs/captioned-image.liquid, image:"development/add-to-app/ios/project-setup/framework-search-paths.png", caption:"Update **Framework Search Paths** in Xcode" %}

After linking the frameworks, they should display in the
**Frameworks, Libraries, and Embedded Content**
section of your target's **General** settings.

##### Embed the dynamic frameworks

To embed your dynamic frameworks, complete the following procedure.

1. Navigate to **General** <span aria-label="and then">></span>
   **Frameworks, Libraries, and Embedded Content**.

1. Click on each of your dynamic frameworks and select **Embed & Sign**.

   {% render docs/captioned-image.liquid,
   image:"development/add-to-app/ios/project-setup/choose-to-embed.png",
   caption:"Select **Embed & Sign** for each of your frameworks in Xcode" %}

   Don't include any static frameworks,
   including `FlutterPluginRegistrant.xcframework`.

1. Click the **Build Phases** tab.

1. Expand **Embed Frameworks**.
   Your dynamic frameworks should display in that section.

   {% render docs/captioned-image.liquid,
   image:"development/add-to-app/ios/project-setup/embed-xcode.png",
   caption:"The expanded **Embed Frameworks** build phase in Xcode" %}

1. Build the project.

   1. Open `MyApp.xcworkspace` in Xcode.

      Verify that you're opening `MyApp.xcworkspace` and
      not opening `MyApp.xcodeproj`.
      The `.xcworkspace` file has the CocoaPod dependencies,
      the `.xcodeproj` doesn't.

   1. Select **Product** <span aria-label="and then">></span>
      **Build** or press <kbd>Cmd</kbd> + <kbd>B</kbd>.

[static or dynamic frameworks]: https://stackoverflow.com/questions/32591878/ios-is-it-a-static-or-a-dynamic-framework
[static-framework]: https://developer.apple.com/library/archive/technotes/tn2435/_index.html
