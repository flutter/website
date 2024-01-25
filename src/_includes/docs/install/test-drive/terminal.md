<div class="tab-pane" id="terminal" role="tabpanel" aria-labelledby="terminal-tab" markdown="1">

### Create your sample Flutter app {#create-app}

To create a new Flutter app, run the following commands in your shell or Terminal.

1. Run the `flutter create` command.

   ```terminal
   flutter create test_drive
   ```

   The command creates a Flutter project directory called `test_drive`
   that contains a simple demo app that uses [Material Components][].

1. Change to the Flutter project directory.

   ```terminal
   cd test_drive
   ```

### Run your sample Flutter app

1. To verify that you have a running target device,
   run the following command.

   ```terminal
   flutter devices
   ```

   You created your target device in the **Install** section.

2. To run your app, run the following command.

   ```terminal
   flutter run
   ```

{% capture save_changes -%}
.

1. Type <kbd>r</kbd> in the terminal window.
{% endcapture %}

{% include docs/install/test-drive/try-hot-reload.md save_changes=save_changes  ide="VS Code" %}

</div>
