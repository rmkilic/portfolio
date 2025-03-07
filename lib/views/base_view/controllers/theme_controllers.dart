import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isLightMode = true.obs; // <-- .obs ekledik, artık reaktif!

  void toggleTheme() {
    isLightMode.value = !isLightMode.value;
    Get.changeThemeMode(isLightMode.value ? ThemeMode.light : ThemeMode.dark);
  }
}
