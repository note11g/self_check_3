import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  String password = "";
  final isEndWrite = false.obs;

  final passwordInputController = TextEditingController();

  @override
  void onInit() {
    passwordInputController.addListener(() {
      password = passwordInputController.text;

      FocusScopeNode currentFocus = FocusScope.of(Get.context!);
      if (password.length == 4 && !currentFocus.hasPrimaryFocus)
        currentFocus.unfocus();
      isEndWrite(password.length == 4);
    });

    super.onInit();
  }
}
