import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUtil {
  static bool isUltraWide() {
    final screenSize = MediaQuery.of(Get.context!).size;
    final screenRatio = screenSize.height / screenSize.width;
    return screenRatio > 1.78;
  }

  static T selectByRatio<T>(T u, T n) {
    return isUltraWide() ? u : n;
  }
}