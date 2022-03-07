import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/global_widgets.dart';
import 'package:self_check_3/resource/values/colors.dart';

import 'set_password_bottom_controller.dart';

class SetPasswordBottomSheet extends GetView<SetPasswordBottomController> {
  SetPasswordBottomSheet({Key? key}) : super(key: key);

  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [' ', '0', '<']
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(24),
              topRight: const Radius.circular(24)),
          child: Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                    padding: EdgeInsets.fromLTRB(24, 32, 24, 32),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlobalWidgets.alignText(tr("check_pw_induction"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          InkWell(
                            onTap: Get.back,
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.clear, size: 24),
                            ),
                          )
                        ],
                      ),
                      GlobalWidgets.alignText(tr("secondary_check_pw_induction"),
                          style: TextStyle(fontSize: 11)),
                      const SizedBox(height: 24),
                      Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _passwordBox(
                                    controller.getPasswordWithIndex(0)),
                                const SizedBox(width: 12),
                                _passwordBox(
                                    controller.getPasswordWithIndex(1)),
                                const SizedBox(width: 12),
                                _passwordBox(
                                    controller.getPasswordWithIndex(2)),
                                const SizedBox(width: 12),
                                _passwordBox(
                                    controller.getPasswordWithIndex(3)),
                              ])),
                      const SizedBox(height: 24),
                      Column(
                          children: keys
                              .map((x) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: x.map((y) {
                                    return Expanded(
                                        child: InkWell(
                                            onTap: y == "<"
                                                ? controller.remove
                                                : () => controller.add(y),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Text(y,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20),
                                                    textAlign:
                                                        TextAlign.center))));
                                  }).toList()))
                              .toList())
                    ])),
              ])))
    ]);
  }

  Widget _passwordBox(String number) => Expanded(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Color(0xFFE8E8E8),
              child: Obx(()=>Text(number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(!controller.isRed.value ? 0xFF7B7B7B : ColorPalette.redDark.value),
                      fontSize: 32,
                      fontWeight: FontWeight.w400))))));
}
