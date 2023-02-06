import 'package:flutter/material.dart';

class VisibilityModel with ChangeNotifier {
  bool isVisible = false;
  void changeVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
