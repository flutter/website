import 'package:adaptive_app_demos/global/device_type.dart';
import 'package:flutter/material.dart';

class AppModel with ChangeNotifier {
  bool getDefaultTouchMode() => DeviceType.isMobile == true;

  // Main menu, selected page
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) => notify(() => _selectedIndex = value);

  // Touch mode, determines density of views
  late bool _touchMode = getDefaultTouchMode();
  bool get touchMode => _touchMode;
  set touchMode(bool value) => notify(() => _touchMode = value);

  void toggleTouchMode() => touchMode = !touchMode;

  // Indicates whether a user is logged in or not
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    if (value == false) {
      reset();
    }
    notify(() => _isLoggedIn = value);
  }

  void login() => notify(() => _isLoggedIn = true);
  void logout() {
    _selectedIndex = 0;
    notify(() => _isLoggedIn = false);
  }

  void reset() {
    _selectedIndex = 0;
    _touchMode = getDefaultTouchMode();
  }

  // Helper method for single-line state changes
  void notify(VoidCallback stateChange) {
    stateChange.call();
    notifyListeners();
  }
}
