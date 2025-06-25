import 'package:chatapp/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themecontroller extends GetxController {
  RxBool isDarkMode = false.obs;

  ThemeData get theme => isDarkMode.value ? darkMode : lightMode;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
