import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snack {
  static const short = Duration(seconds: 2);
  static const long = Duration(milliseconds: 3500);

  static show(String text,
      {Duration duration = short, Color? color, Color? backgroundColor}) {
    final snackBar = GetSnackBar(
      messageText: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: 'spoqa'),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(
          bottom: kBottomNavigationBarHeight, left: 28, right: 28),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      borderRadius: 20,
      backgroundColor: const Color(0xd6ffffff),
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeOutCirc,
      duration: duration,
      animationDuration: const Duration(milliseconds: 800),
      isDismissible: true,
      barBlur: 2.0,
    );

    Get.showSnackbar(snackBar);
  }
}
