import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/presentation/welcome/set_password/bottom_sheet/set_passsword_bottom_sheet.dart';
import 'package:self_check_3/presentation/welcome/set_password/bottom_sheet/set_password_bottom_controller.dart';
import 'package:self_check_3/presentation/welcome/set_password/set_password_controller.dart';
import 'package:self_check_3/resource/theme/app_color.dart';

class SetPasswordPage extends GetView<SetPasswordController> {
  const SetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 28, right: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 4, child: _titleSection()),
                    Expanded(flex: 5, child: _inputSection()),
                    Expanded(flex: 4, child: _btnSection()),
                  ],
                ))));
  }

  Widget _titleSection() =>
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        GlobalWidgets.alignText(tr("self_check"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
        GlobalWidgets.alignText(tr("pw_input_induction"),
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
        Padding(padding: const EdgeInsets.only(top: 2)),
        GlobalWidgets.alignText(tr("secondary_pw_input_induction"),
            style: TextStyle())
      ]);

  Widget _inputSection() =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.white,
                child: TextField(
                    obscureText: true,
                    controller: controller.passwordInputController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: tr("pw_input_hint"),
                        counterText: ''),
                    maxLength: 4,
                    cursorColor: AppColor.primary,
                    keyboardType: TextInputType.number)))
      ]);

  Widget _btnSection() => Column(children: [
        Obx(() => GlobalWidgets.roundedButtonWithShadow(tr("to_complete"),
            controller.isEndWrite.value ? _checkPassword : () => null,
            backColor: controller.isEndWrite.value
                ? AppColor.primary
                : AppColor.primary.withOpacity(0.84),
            textColor:
                controller.isEndWrite.value ? Colors.black : Color(0xFFD2B33F)))
      ]);

  _checkPassword() {
    showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              Get.put(SetPasswordBottomController());
              return SetPasswordBottomSheet();
            },
            routeSettings: RouteSettings())
        .whenComplete(() {
      if (Get.find<SetPasswordBottomController>().initialized) {
        Get.find<SetPasswordBottomController>().onClose();
      }
    });
  }
}
