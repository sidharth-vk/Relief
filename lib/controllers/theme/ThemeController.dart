import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  // Observable variable for theme mode (light/dark)
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  // Function to toggle the theme mode
  void toggleTheme() {
    themeMode.value =
        (themeMode.value == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
  }
}
