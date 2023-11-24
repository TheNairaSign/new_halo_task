import 'package:flutter/material.dart';

class ToggleScreenProvider extends ChangeNotifier {
  bool _showLoginPage = true;

  bool get showLoginPage => _showLoginPage;

  void toggleScreens() {
    _showLoginPage = !showLoginPage;
    notifyListeners();
  }
}